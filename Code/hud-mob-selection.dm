
// File:    hud-mob-selection.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the title screen and character
//   selection interface used by the temporary mob you
//   first connect to when joining the game. It is used
//   to display your loaded mobs and give you the option
//   to select a character, delete a character, or create
//   a new character.

MobSelection
	parent_type = /HudBox

	var
		list/mobs
		list/mob_objects = list()

		index = 0
		HudObject/cursor

	New(mob/m, list/mobs)
		..(m)

		box(6, Constants.SAVE_SLOTS + 1)

		owner = m

		// add the background for the slots
		add(16, 16, "inventory-slot", height = Constants.SAVE_SLOTS, layer = layer + 1)
		add(48, 16, "inventory-back", width = 4, height = Constants.SAVE_SLOTS, layer = layer + 1)

		// Add the title on the window:
		add(56, (Constants.SAVE_SLOTS + 3) * 32, "", maptext_width = 160, maptext = "<text align=center><b>Character Selection</b></text>", layer = layer + 2)

		cursor = add(16, 16, "inventory-cursor", layer = layer + 5)
		set_index(Constants.SAVE_SLOTS)

		refresh(mobs)

		pos(160, 112)
		hide()

	proc
		refresh(list/mob_list)

			if(mob_list)
				mobs = mob_list

			if(!mobs)
				return

			for(var/HudObject/o in mob_objects)
				del o

			mob_objects.Cut()

			for(var/i = 1 to Constants.SAVE_SLOTS)

				// if there's a mob in this slot, select it
				var/mob/m = mobs[i]

				// if this slot contains a mob, show its icon and name:
				if(m)
					mob_objects += add(54, -16 + i * Constants.ICON_HEIGHT, "", layer = layer + 2, maptext_width = 128, maptext = "<text align=middle>[m.description(1)]</text>", maptext_height = 32)
					mob_objects += add(16, -16 + i * Constants.ICON_HEIGHT, icon = m.icon, icon_state = "[m.base_state]-standing", layer = layer + 2)

					for(var/slot in m.equipment)
						var/item/item = m.equipment[slot]

						if(!item)
							continue

						mob_objects += add(16, -16 + i * Constants.ICON_HEIGHT, icon = item.overlay_icon, icon_state = "[item.overlay_state]-standing", layer = layer + 2 + item.overlay_layer)

				// otherwise, show that its empty:
				else
					mob_objects += add(54, -16 + i * Constants.ICON_HEIGHT, "", layer = layer + 2, maptext_width = 128, maptext_height = 32, maptext = "<text align=middle>empty</text>")

	key_down(k)
		if(k == Constants.KEY_UP)
			set_index(index + 1)
		else if(k == Constants.KEY_DOWN)
			set_index(index - 1)
		else if(k == Constants.KEY_SELECT)
			select(mobs[index])

		else if(k == Constants.KEY_CANCEL)
			hide()
			owner.client.focus = owner

		else if(k == Constants.KEY_DELETE)
			if(mobs[index])
				var/choice = owner.prompt("Are you sure you want to delete this character?", "Delete", "Cancel")

				if(choice == "Delete")
					owner.client.delete_character(index)
					mobs[index] = null
					refresh()
					set_index(index)

	show()
		set_index(Constants.SAVE_SLOTS)
		..()

	proc
		set_index(i)
			if(i > Constants.SAVE_SLOTS) i = Constants.SAVE_SLOTS
			if(i < 1) i = 1

			index = i
			cursor.pos(16, -16 + 32 * index)

		select(mob/m)

			if(m == null)
				// new_character returns the mob that was created
				// or null if the user cannot create a new character.
				if(owner.client.new_character(index))
					hide()
				else
					owner.prompt("You cannot create any more new characters.")

			else
				owner.client.connect(m)
				hide()

TitleScreen
	parent_type = /HudGroup

	layer = MOB_LAYER + 2

	New(mob/m)
		..()

		var/icon/background = Options.title_screen
		if(isfile(background))
			background = icon(background)
		else if(istext(background))
			background = icon(Constants.HUD_ICON, background)

		// if the background image is small, tile it
		if(background.Width() <= Constants.ICON_WIDTH)
			add(0, 0, icon = background, width = Constants.VIEW_WIDTH, height = Constants.VIEW_HEIGHT)

		// otherwise center it in the screen
		else
			var/ix = Constants.ICON_WIDTH * Constants.VIEW_WIDTH * 0.5 - background.Width() * 0.5
			var/iy = Constants.ICON_HEIGHT * Constants.VIEW_HEIGHT * 0.5 - background.Height() * 0.5

			add(ix, iy, icon = background)


mob
	temporary
		var
			tmp/MobSelection/mob_selection
			tmp/TitleScreen/title_screen

		init_hud()
			clear_hud()
			mob_selection = new(src, client.mobs)
			title_screen = new(src)

		clear_hud()
			if(mob_selection)
				mob_selection.hide()
				del mob_selection

			if(title_screen)
				title_screen.hide()
				del title_screen
