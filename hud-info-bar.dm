
InfoBar
	parent_type = /HudGroup

	layer = Constants.HUD_LAYER

	var
		mob/owner
		HudObject/background
		HudObject/caption
		HudObject/counter
		list/messages
		index

		// 1 if the bar is on the bottom of the screen,
		// 0 if it's on the top.
		bottom = 0

	New(mob/m)
		..(m)
		owner = m

		background = add(0, 0, "info-bar-[bottom ? "bottom" : "top"]", width = Constants.VIEW_WIDTH)
		caption = add(4, 16, "", maptext_width = Constants.VIEW_WIDTH * Constants.ICON_WIDTH - 8, maptext_height = 16, layer = layer + 1)
		counter = add(4, 16, "", maptext_width = Constants.VIEW_WIDTH * Constants.ICON_WIDTH - 8, maptext_height = 16, layer = layer + 1)

		if(bottom)
			pos(0, 0)
		else
			pos(0, (Constants.VIEW_HEIGHT - 1) * Constants.ICON_HEIGHT)

		// after the whole interface is initialized, call show()
		// to update the position of whatever other HUD elements
		// need to be shifted to make room for the info bar.
		spawn(0)
			show()

	hide()
		..()

		if(owner)

			// bottom of the screen
			if(bottom)
				if(owner.ability_bar)
					owner.ability_bar.pos(8, 8)

				if(owner.info_box)
					owner.info_box.pos(Constants.VIEW_WIDTH * Constants.ICON_WIDTH - 128 - 8, 8)

			// top of the screen
			else
				if(owner.health_meter)
					owner.health_meter.pos(8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 24)

				if(owner.mana_meter)
					owner.mana_meter.pos(8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 40)

				if(owner.conditions_bar)
					owner.conditions_bar.pos(0, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 62)

	show()
		..()

		if(owner)

			// bottom of the screen
			if(bottom)
				if(owner.ability_bar)
					owner.ability_bar.pos(8, 24)

				if(owner.info_box)
					owner.info_box.pos(Constants.VIEW_WIDTH * Constants.ICON_WIDTH - 128 - 8, 24)

			// top of the screen
			else
				if(owner.health_meter)
					owner.health_meter.pos(8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 40)

				if(owner.mana_meter)
					owner.mana_meter.pos(8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 56)

				if(owner.conditions_bar)
					owner.conditions_bar.pos(0, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 78)

	key_down(k)
		if(k == Constants.KEY_CANCEL || k == Constants.KEY_INFO_BAR)
			owner.client.focus = owner

			if(bottom)
				background.icon_state = "info-bar-bottom"
			else
				background.icon_state = "info-bar-top"

		else if(k == Constants.KEY_UP)
			if(messages && index < messages.len)
				set_index(index + 1)
		else if(k == Constants.KEY_DOWN)
			if(index > 1)
				set_index(index - 1)

		else if(k == Constants.KEY_DELETE)
			if(messages)
				if(index >= 1 && index <= messages.len)
					remove_message(messages[index])

	focus()
		owner.client.focus = src

		if(bottom)
			background.icon_state = "info-bar-bottom-selected"
		else
			background.icon_state = "info-bar-top-selected"

	proc
		add_message(m)
			// if it's text, add the message
			if(istext(m))
				if(!messages)
					messages = list()

				// check if the message is already being displayed
				var/i = messages.Find(m)

				// if it is, show that message
				if(i)
					set_index(i)

				// otherwise we have to add it.
				else
					messages += list(m)
					set_index(messages.len)

			// otherwise run the default behavior to add an object
			else
				return ..()

		remove_message(m)

			// try to remove the specified message
			if(messages)
				var/i = messages.Find(m)

				// if the message being removed was before the
				// message you're currently viewing, decrement
				// the index you're viewing.
				if(i <= index)
					index -= 1

				// remove the message
				messages.Cut(i, i + 1)

			// refresh the display
			set_index(index)

		set_index(i)

			// if there are any messages to show
			if(messages && messages.len)

				index = i

				// let the indexes wrap around at the end but not the front.
				if(index < 1 || index > messages.len)
					index = 1

				caption.maptext = messages[index]

				// update the counter display
				if(messages.len > 1)
					counter.maptext = "<text align=right>[index] / [messages.len]</text>"
				else
					counter.maptext = ""

			// if there are no messages, clear the display
			else
				index = 0
				caption.maptext = ""
				counter.maptext = ""

mob
	var
		tmp/InfoBar/info_bar

	init_hud()
		..()

		if(Constants.USE_INFO_BAR)
			if(info_bar)
				info_bar.hide()
				del info_bar

			info_bar = new(src)

	clear_hud()
		..()

		if(info_bar)
			info_bar.hide()
			del info_bar

	key_down(k)
		..()

		if(Constants.USE_INFO_BAR)
			if(k == Constants.KEY_INFO_BAR)
				info_bar.focus()
