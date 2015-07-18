
// File:    hud-inventory.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the on-screen inventory object.

client
	var
		// the client is what actually stores your bank since
		// its shared between all of your characters.
		mob/bank/bank

mob
	var
		// every mob has a reference to their bank
		tmp/mob/bank/bank

	// your bank is really just a mob, this lets us use the get_item()
	// and drop_item() procs to transfer items to and from it.
	bank
		inventory_size = Constants.BANK_SIZE

Inventory
	parent_type = /HudBox

	var
		mob/container

		slots = Constants.INVENTORY_DISPLAY_SIZE
		slot_width
		slot_height

		HudObject/cursor
		HudObject/description
		HudObject/shadow1
		HudObject/shadow2
		HudObject/shadow3
		HudObject/shadow4

		// these are used to store the caption/title at compile
		// time and store the objects used to display them at runtime.
		HudObject/title
		HudObject/caption

		cursor_x = 1
		cursor_y = 1

		list/slot_objects = list()
		list/slot_captions = list()

		const
			NORMAL = 1
			SELECT = 2
			BANKING = 3

		mode = NORMAL
		choice = null
		can_cancel = 0

		// these determine how much extra space is given
		// around the edges of the inventory screen.
		padding_sides = 1
		padding_top = 2

	New(mob/m)

		owner = m
		container = m

		// parse the inventory size
		var/list/parts = split(slots, "x")
		slot_width = text2num(parts[1])
		slot_height = text2num(parts[2])

		..(m)

		box(slot_width + padding_sides, slot_height + padding_top)

		// create the inventory slots
		for(var/i = 1 to slot_width)
			for(var/j = 1 to slot_height)
				slot_objects += add(i * 32 - 16, j * 32, "inventory-slot", layer = layer + 1)
				slot_captions += add(i * 32 - 16, j * 32, layer = layer + 5)

		// create the cursor
		cursor = add(0, 0, "inventory-cursor", layer = layer + 2)

		// create the caption and title
		caption = add(0, 10, maptext = "<text align=center>[caption]</text>", maptext_width = (slot_width + 1) * Constants.ICON_WIDTH, layer = layer + 2)
		title = add(0, slot_height * Constants.ICON_HEIGHT + 40, maptext = "<text align=center><b>[title]</b></text>", maptext_width = (slot_width + 1) * Constants.ICON_WIDTH, layer = layer + 2)

		description = add(0, 0, "", maptext_width = 128, maptext_height = 128, layer = layer + 3)
		shadow1 = add(0, 0, "", maptext_width = 128, maptext_height = 128, layer = layer + 2)
		shadow2 = add(0, 0, "", maptext_width = 128, maptext_height = 128, layer = layer + 2)
		shadow3 = add(0, 0, "", maptext_width = 128, maptext_height = 128, layer = layer + 2)
		shadow4 = add(0, 0, "", maptext_width = 128, maptext_height = 128, layer = layer + 2)

		pos(16, 112)
		hide()
		refresh()

	proc
		caption(c)
			caption.maptext = "<text align=center>[c]</text>"

		title(t)
			title.maptext = "<text align=center><b>[t]</b></text>"

	key_down(k)
		if(k == Constants.KEY_CANCEL || k == Constants.KEY_INVENTORY)
			if(mode == NORMAL)
				hide()
				owner.client.focus = owner

			else if(mode == SELECT)
				if(can_cancel)
					hide()
					owner.client.focus = owner

			else if(mode == BANKING)
				hide()
				owner.bank_display.hide()
				owner.client.focus = owner

		else if(k == Constants.KEY_UP)
			set_cursor(cursor_x, cursor_y + 1)
		else if(k == Constants.KEY_DOWN)
			set_cursor(cursor_x, cursor_y - 1)
		else if(k == Constants.KEY_RIGHT)
			set_cursor(cursor_x + 1, cursor_y)
		else if(k == Constants.KEY_LEFT)
			set_cursor(cursor_x - 1, cursor_y)

		else if(k == Constants.KEY_SELECT)

			var/item/item = current_item()

			if(item)
				if(mode == NORMAL)
					// if the item is equipped, remove it
					if(item.in_slot)
						owner.unequip(item)

					// if the item is equippable, equip it
					else if(item.slot)
						owner.equip(item)

					// otherwise, we just use it
					else
						owner.use(item)

				else if(mode == SELECT)
					choice = item

				else if(mode == BANKING)
					if(owner.bank.get_item(item))
						owner.bank_display.refresh()

		else if(k == Constants.KEY_DROP)
			var/item/item = current_item()

			// you can only drop items in normal mode
			if(item && mode == NORMAL)
				container.drop_item(item)

		else if(k == Constants.KEY_DELETE)
			var/item/item = current_item()

			if(item && mode != SELECT)
				var/choice = owner.prompt("Are you sure you want to destroy '[item.name]'?", "Destroy", "Cancel")

				if(choice == "Destroy")
					container.remove_item(item)
					del item

	show()

		// we change the caption of the inventory window based on the mode.
		if(src == owner.inventory)

			title("Inventory")

			if(mode == NORMAL)
				caption("Space Bar = Equip / Use")
			else if(mode == SELECT)
				caption("Space Bar = Select Item")
			else if(mode == BANKING)
				caption("Space Bar = Move Item to Bank")

		set_cursor(1, 1)
		..()

	focus(cx = 0, cy = 0)
		if(cx)
			set_cursor(cx, cy)

		// hide the cursor of the other interface
		if(owner.bank_display)
			if(owner.bank_display != src)
				owner.bank_display.hide_cursor()

		if(owner.inventory)
			if(owner.inventory != src)
				owner.inventory.hide_cursor()

		// show the cursor for this panel and set focus to it
		show_cursor()
		owner.client.focus = src

	proc
		hide_cursor()
			remove(cursor)
			remove(description)
			remove(shadow1)
			remove(shadow2)
			remove(shadow3)
			remove(shadow4)

		show_cursor()
			add(cursor)
			add(description)
			add(shadow1)
			add(shadow2)
			add(shadow3)
			add(shadow4)

		// update the cursor's position.
		set_cursor(cx, cy)

			// if you're banking and you move the cursor off the right
			// side, we shift focus to the bank display.
			if(mode == BANKING)
				if(cx > slot_width)
					return owner.bank_display.focus(1, cy)

			if(cx < 1) cx = 1
			if(cy < 1) cy = 1
			if(cx > slot_width) cx = slot_width
			if(cy > slot_height) cy = slot_height

			cursor_x = cx
			cursor_y = cy

			cursor.pos(cursor_x * Constants.ICON_WIDTH - 16, cursor_y * Constants.ICON_HEIGHT)

			var/HudObject/slot = current_slot()
			var/item/item = slot.value

			if(item && istype(item))
				description.pos(slot.sx + Constants.ICON_WIDTH + 2, slot.sy)
				shadow1.pos(description.sx - 1, description.sy)
				shadow2.pos(description.sx + 1, description.sy)
				shadow3.pos(description.sx, description.sy - 1)
				shadow4.pos(description.sx, description.sy + 1)

				description.maptext = "<text align=bottom>[item.description()]</text>"
				shadow1.maptext = "<font color=#000>[description.maptext]</font>"
				shadow2.maptext = shadow1.maptext
				shadow3.maptext = shadow1.maptext
				shadow4.maptext = shadow1.maptext
			else
				description.maptext = ""
				shadow1.maptext = ""
				shadow2.maptext = ""
				shadow3.maptext = ""
				shadow4.maptext = ""

		// find the index based on the cursor x/y
		current_slot()

			var/index = (cursor_x - 1) * slot_height + cursor_y

			if(index < 1) return null
			if(index > slot_objects.len) return null

			// find the slot at this index
			var/HudObject/slot = slot_objects[index]

			return slot

		// find the item referenced by the current slot.
		current_item()

			var/HudObject/h = current_slot()

			if(h.value && istype(h.value, /item))
				return h.value
			else
				return null

		// update the inventory's display. this one proc handles
		// all kinds of updates whether it's an item being removed,
		// added, equipped, or unequipped.
		refresh()

			var/list/in_contents = list()
			for(var/item/i in container.contents)
				in_contents[i] = 1

			var/list/open_slots = list()
			var/list/already_shown = list()

			// find the slots that aren't used and the items already being shown.
			for(var/HudObject/s in slot_objects)

				// if the slot is showing an item from your inventory, mark
				// that item as being already shown.
				if(s.value && in_contents[s.value])
					already_shown[s.value] = 1

				// otherwise the slot is available
				else
					open_slots += s
					s.value = null

			// find the items not shown in the inventory and display them
			for(var/item/item in container.contents)

				// if this item is shown already, skip it
				if(already_shown[item]) continue

				// if there are no more slots, we have a problem
				if(!open_slots.len)
					CRASH("Out of inventory slots.")

				// otherwise we put this item in the next available slot
				var/HudObject/s = open_slots[1]
				open_slots.Cut(1, 2)

				s.value = item
				s.overlays = null
				s.overlays += icon(item.icon, item.icon_state)

			// udpate the display of each slot
			for(var/HudObject/s in slot_objects)

				var/item/i = s.value

				if(i)
					if(i.in_slot)
						s.icon_state = "inventory-slot-equipped"
					else
						s.icon_state = "inventory-slot"
				else
					s.icon_state = "inventory-slot"
					s.overlays = null

			set_cursor(cursor_x, cursor_y)

// The bank display is a child type of the inventory display.
BankDisplay
	parent_type = /Inventory

	mode = BANKING
	slots = Constants.BANK_DISPLAY_SIZE

	title = "Bank"
	caption = "Space Bar = Move Item to Inventory"

	New(mob/m)
		..(m, 9, 6)
		pos(240, 112)

	refresh()
		container = owner.bank
		..()

	hide()
		..()
		if(owner && owner.inventory)
			owner.inventory.hide()

	set_cursor(cx, cy)

		// when you move the cursor off the left side
		// we shift focus to your inventory.
		if(cx < 1)
			return owner.inventory.focus(owner.inventory.slot_width, cy)

		if(cx > slot_width) cx = slot_width

		..()

	key_down(k)
		if(k == Constants.KEY_CANCEL || k == Constants.KEY_INVENTORY)
			hide()
			owner.inventory.hide()
			owner.client.focus = owner

		else if(k == Constants.KEY_UP)
			set_cursor(cursor_x, cursor_y + 1)
		else if(k == Constants.KEY_DOWN)
			set_cursor(cursor_x, cursor_y - 1)
		else if(k == Constants.KEY_RIGHT)
			set_cursor(cursor_x + 1, cursor_y)
		else if(k == Constants.KEY_LEFT)
			set_cursor(cursor_x - 1, cursor_y)

		else if(k == Constants.KEY_SELECT)

			var/item/item = current_item()

			if(item)
				if(owner.get_item(item))
					refresh()

		else if(k == Constants.KEY_DELETE)
			var/item/item = current_item()

			if(item && mode != SELECT)
				var/choice = owner.prompt("Are you sure you want to destroy '[item.name]'?", "Destroy", "Cancel")

				if(choice == "Destroy")
					container.remove_item(item)
					del item
					refresh()

mob
	var
		tmp/Inventory/inventory
		tmp/BankDisplay/bank_display

	init_hud()
		..()

		if(client)
			if(Constants.USE_INVENTORY)
				inventory = new(src)

			if(Constants.USE_BANK)
				bank_display = new(src)

	clear_hud()
		..()

		if(Constants.USE_INVENTORY)
			if(inventory)
				inventory.hide()
				del inventory

		if(Constants.USE_BANK)
			if(bank_display)
				bank_display.hide()
				del bank_display

	key_down(k)
		..()

		if(Constants.USE_INVENTORY)
			if(k == Constants.KEY_INVENTORY)
				inventory()

	proc
		inventory()
			inventory.mode = inventory.NORMAL
			inventory.show()
			inventory.focus(1, 1)

		banking()
			inventory.mode = inventory.BANKING
			inventory.hide_cursor()
			inventory.show()

			bank_display.show()
			bank_display.focus(1, 1)

		item_prompt(select = 1, can_cancel = 0)

			if(!client)
				CRASH("[src] has no client")

			var/old_focus = client.focus

			inventory.can_cancel = can_cancel
			inventory.choice = null
			inventory.mode = inventory.SELECT
			inventory.show()

			client.focus = inventory

			while(isnull(inventory.choice))
				sleep(1)

			var/c = inventory.choice
			inventory.choice = null

			inventory.hide()
			client.focus = old_focus

			return c

