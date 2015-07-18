
// File:    hud-abilities.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the ability bar which is split
//   into the AbilityBar and AbilityMenu objects. The
//   bar shows what abilities are bound to keys, the
//   menu is used to select an ability to modify a key
//   binding.

AbilityBar
	parent_type = /HudGroup

	layer = Constants.HUD_LAYER

	var
		mob/owner
		size = 6
		index = 1
		HudObject/cursor
		HudObject/selected

	New(mob/m)
		..(m)

		owner = m

		for(var/i = 1 to size)
			var/obj/o = add(i * Constants.ICON_WIDTH - Constants.ICON_WIDTH, 0, "ability-button", value = "[i]")
			o.overlays += hud_label("<text align=center>[i]", layer = layer + 3, pixel_y = 22)

		cursor = add(0, 0, "", layer = layer + 1)

		pos(8, 8)
		refresh()

	proc
		set_index(i)
			if(i < 1) i = 1
			if(i > size) i = size

			index = i
			cursor.pos(index * Constants.ICON_WIDTH - Constants.ICON_WIDTH, 0)

		refresh()

			for(var/i = 1 to size)
				var/HudObject/o = objects[i]
				var/Ability/a = owner.key_bindings ? owner.key_bindings["[i]"] : null

				if(!a)
					o.icon = Constants.HUD_ICON
					o.icon_state = "ability-button"
					continue

				o.icon = a.icon
				o.icon_state = a.icon_state

	key_down(k, client/c)

		if(k == Constants.KEY_RIGHT)
			set_index(index + 1)
		else if(k == Constants.KEY_LEFT)
			set_index(index - 1)

		else if(k == "1")
			set_index(1)
			select()
		else if(k == "2")
			set_index(2)
			select()
		else if(k == "3")
			set_index(3)
			select()
		else if(k == "4")
			set_index(4)
			select()
		else if(k == "5")
			set_index(5)
			select()
		else if(k == "6")
			set_index(6)
			select()

		else if(k == Constants.KEY_CANCEL || k == Constants.KEY_ABILITIES)
			cursor.icon_state = ""
			owner.client.focus = owner

		else if(k == Constants.KEY_SELECT)
			select()

	proc
		// show the ability menu
		select()
			selected = objects[index]
			owner.ability_menu.show(selected)
			owner.client.focus = owner.ability_menu
			cursor.icon_state = ""

AbilityMenu
	parent_type = /HudGroup

	layer = Constants.HUD_LAYER

	var
		index = 1
		HudObject/cursor
		list/choices

		mob/owner
		Ability/value

		HudObject/caption
		HudObject/caption1
		HudObject/caption2
		HudObject/caption3
		HudObject/caption4

		size = 8

	New(mob/m)
		..(m)
		owner = m

		cursor = add(0, 0, "ability-cursor")

		caption = add(0, 0, "", maptext_width = 160, maptext_height = 64, layer = layer + 2)
		caption1 = add(0, 0, "", maptext_width = 160, maptext_height = 64, layer = layer + 1)
		caption2 = add(0, 0, "", maptext_width = 160, maptext_height = 64, layer = layer + 1)
		caption3 = add(0, 0, "", maptext_width = 160, maptext_height = 64, layer = layer + 1)
		caption4 = add(0, 0, "", maptext_width = 160, maptext_height = 64, layer = layer + 1)

		hide()
		refresh()

	show(HudObject/o)
		pos(o.sx + owner.ability_bar.sx, o.sy + Constants.ICON_HEIGHT + owner.ability_bar.sy)
		..()

	hide()
		if(owner.ability_bar)
			owner.client.focus = owner.ability_bar
			owner.ability_bar.cursor.icon_state = "ability-cursor"

		..()

	key_down(k)
		if(k == Constants.KEY_UP)
			set_index(index + 1)
		else if(k == Constants.KEY_DOWN)
			set_index(index - 1)

		else if(k == Constants.KEY_RIGHT)
			set_index(index + size)
		else if(k == Constants.KEY_LEFT)
			set_index(index - size)

		else if(k == Constants.KEY_SELECT)
			var/HudObject/o = choices[index]
			owner.bind_key(owner.ability_bar.selected.value, o.value)
			// owner.ability_bar.selected.icon_state = o.icon_state
			hide()

		else if(k == Constants.KEY_CANCEL)
			hide()

	proc
		set_index(i)
			if(i < 1) i = 1
			if(i > choices.len) i = choices.len

			index = i

			var/cx = round((index - 1) / size) * Constants.ICON_WIDTH
			var/cy = ((index - 1) % size) * Constants.ICON_HEIGHT

			cursor.pos(cx, cy)
			// cursor.pos(0, index * Constants.ICON_HEIGHT - Constants.ICON_HEIGHT)

			var/HudObject/o = choices[index]
			var/Ability/ability = o.value

			caption.pos(o.sx + 36, o.sy + 2)

			if(ability && istype(ability))
				caption.maptext = ability.description()
			else
				caption.maptext = "<b>No Ability</b>"

			// update the objects used to create the outline
			var/outline_text = "<font color=#000>[caption.maptext]"
			caption1.pos(caption.sx - 1, caption.sy)
			caption1.maptext = outline_text
			caption2.pos(caption.sx + 1, caption.sy)
			caption2.maptext = outline_text
			caption3.pos(caption.sx, caption.sy - 1)
			caption3.maptext = outline_text
			caption4.pos(caption.sx, caption.sy + 1)
			caption4.maptext = outline_text
			/*
			else
				caption.maptext = ""
				caption1.maptext = ""
				caption2.maptext = ""
				caption3.maptext = ""
				caption4.maptext = ""
			*/

		refresh()
			for(var/atom/a in choices)
				del a

			choices = list()

			var/cx = 0
			var/cy = 0
			var/i = 0

			for(var/Ability/a in owner.abilities)

				// filter which abilities are shown
				if(!show_ability(a)) continue

				choices += add(cx, cy, a.icon_state, value = a)

				cy += Constants.ICON_HEIGHT
				i += 1

				if(i >= size)
					cx += Constants.ICON_WIDTH
					cy = 0
					i = 0

			choices += add(cx, cy, "ability-button", value = null)

			set_index(index)

		// You can override this to create your own type of
		// filter. By default, all abilities are listed.
		show_ability(Ability/ability)
			return 1

mob
	var
		tmp/AbilityBar/ability_bar
		tmp/AbilityMenu/ability_menu

	init_hud()
		..()

		if(client && Constants.USE_ABILITY_BAR)
			ability_menu = new(src)
			ability_bar = new(src)

	clear_hud()
		if(Constants.USE_ABILITY_BAR)
			if(ability_menu)
				ability_menu.hide()
				del ability_menu

			if(ability_bar)
				ability_bar.hide()
				del ability_bar

	key_down(k)
		..()

		if(Constants.USE_ABILITY_BAR)
			if(k == Constants.KEY_ABILITIES)
				client.focus = ability_bar
				ability_bar.cursor.icon_state = "ability-cursor"
				ability_menu.refresh()
