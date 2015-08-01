
// File:    hud-loot-window.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the on-screen loot window object.

LootWindow
	parent_type = /HudBox

	var
		size = 5
		list/slots = list()
		list/captions = list()

		HudObject/cursor
		index = 1

	New(mob/m)
		..(m)

		box(5, size + 1)

		owner = m

		// create the slots and captions
		for(var/i = size to 1 step -1)
			slots += add(16, i * Constants.ICON_HEIGHT - 16, "inventory-slot", layer = layer + 2)
			captions += add(48, i * Constants.ICON_HEIGHT - 16, maptext = "", maptext_width = 96, maptext_height = 32, layer = layer + 3)

		// create the background
		add(16, 16, "inventory-back", layer = layer + 1, width = 4, height = size)

		// create the cursor
		cursor = add(16, size * Constants.ICON_HEIGHT - 16, "inventory-cursor", layer = layer + 4)

		hide()
		pos((Constants.VIEW_WIDTH - 5) * Constants.ICON_WIDTH - 16, 176)

	show(list/items)

		set_cursor(1)

		for(var/i = 1 to slots.len)
			var/HudObject/slot = slots[i]
			var/HudObject/caption = captions[i]

			if(i <= items.len)
				var/item/item = items[i]
				slot.value = item

				slot.overlays = null
				slot.overlays += icon(item.icon, item.icon_state)
				caption.maptext = "<text align=middle>[item.name]</text>"

			else
				slot.value = null
				slot.overlays = null
				slot.icon_state = "inventory-slot"
				caption.maptext = ""

		owner.client.focus = src
		..()

	key_down(k)
		if(k == Constants.KEY_UP)
			set_cursor(index - 1)
		else if(k == Constants.KEY_DOWN)
			set_cursor(index + 1)
		else if(k == Constants.KEY_SELECT)

			// if the window is empty, close it
			var/empty = 1
			for(var/HudObject/s in slots)
				if(s.value)
					empty = 0
					break

			if(empty)
				hide()
				owner.client.focus = owner
				return

			// otherwise, loots the item from the selected slot.
			var/HudObject/slot = slots[index]
			var/HudObject/caption = captions[index]

			var/item/item = slot.value

			// if there's an item at the selected slot
			if(item && istype(item))

				// and if the player can loot the item
				if(owner.get_item(item))

					// remove it from the loot window
					slot.value = null
					slot.overlays = null
					caption.maptext = ""

				else
					owner.cannot_hold_item(item)

		else if(k == Constants.KEY_CANCEL || k == Constants.KEY_LOOT)
			hide()
			owner.client.focus = owner

	proc
		set_cursor(i)
			if(i > size) i = size
			if(i < 1) i = 1

			index = i
			cursor.pos(16, (size - index) * Constants.ICON_HEIGHT + 16)

mob
	var
		tmp/LootWindow/loot_window

	init_hud()
		..()

		if(client && Constants.USE_LOOT_WINDOW)
			loot_window = new(src)

	clear_hud()
		..()

		if(Constants.USE_LOOT_WINDOW)
			if(loot_window)
				loot_window.hide()
				del loot_window

	key_down(k)
		..()

		if(Constants.USE_LOOT_WINDOW)
			if(k == Constants.KEY_LOOT)
				loot_window()

	proc
		loot_window()

			// you can loot mobs and objs - people might use objs for treasure
			// chests that can be looted using the same loot window interface.
			for(var/atom/movable/a in inside())
				var/mob/m = a

				if(istype(m))
					if(m.dead && m.lootable && m.contents.len)
						loot_window.show(m.contents)
						return 1
				else
					if(a.lootable && a.contents.len)
						loot_window.show(a.contents)
						return 1

			return 0
