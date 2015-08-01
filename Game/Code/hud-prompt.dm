
// File:    hud-prompt.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the on-screen alert box and the
//   mob's prompt() proc, which automatically creates an
//   on-screen prompt and waits for the user to make a
//   selection.

Prompt
	parent_type = /HudBox

	width = 6
	height = 4

	layer = Constants.HUD_LAYER + 10

	var
		list/options = list()
		choice = null
		index = 1

		input_text = ""
		HudObject/text

		HudObject/highlight_left
		HudObject/highlight_right

		button_x
		button_y

		const
			BUTTONS = 1
			TEXT = 2
			NUMBER = 3

		mode = BUTTONS

	Text
		mode = TEXT

	Number
		mode = NUMBER

	New()
		owner = args[1]

		var/message = ""
		if(args.len >= 2)
			message = args[2]

		var/is_width = 1
		for(var/i = 3 to args.len)
			if(isnum(args[i]))

				// positive values are interpreted as dimensions
				if(args[i] > 0)
					if(is_width)
						width = args[i]
						is_width = 0
					else
						height = args[i]

			else
				options += args[i]

		if(!options.len)
			options += "Ok"

		if(options.len && options[1] == null)
			options.Cut()

		..(owner)
		box(width, height)

		var/left = (Constants.VIEW_WIDTH * Constants.ICON_WIDTH) / 2 - (width * Constants.ICON_WIDTH) / 2
		var/top = (Constants.VIEW_HEIGHT - height) * Constants.ICON_HEIGHT - 48
		pos(left, top)

		// show the message
		add(16, 48, maptext = "<text align=top>[message]", maptext_width = width * Constants.ICON_WIDTH - Constants.ICON_WIDTH, maptext_height = height * Constants.ICON_HEIGHT - 56, layer = layer + 1)

		// if it's a text or number prompt, show the input area:
		if(mode == TEXT || mode == NUMBER)
			add(16, 16, "text-prompt", width = width - 1, layer = layer + 1)
			text = add(18, 16, "", maptext = "<text align=middle><font color=#000>[input_text]_</font></text>", maptext_height = 16, maptext_width = width * Constants.ICON_WIDTH - 36, layer = layer + 2)

		// otherwise, show buttons:
		else

			// figure out where to position the buttons
			button_x = (width * 32) / 2 - (48 * options.len + 16 * ((options.len > 1) ? options.len - 1 : 0)) / 2
			button_y = 16

			// create the buttons
			for(var/i = 1 to options.len)
				add(button_x + i * 64 - 64, button_y, "button-left", layer = layer + 1)
				add(button_x + i * 64 - 32, button_y, "button-right", layer = layer + 1)
				add(button_x + i * 64 - 64, button_y + 4, "", layer = layer + 2, maptext = "<text align=center>[options[i]]", maptext_width = 48)

			// create the button highlight
			if(options.len)
				highlight_left = add(button_x - 1, button_y - 1, "button-highlight-left", layer = layer + 1)
				highlight_right = add(button_x + 31, button_y - 1, "button-highlight-right", layer = layer + 1)

			// if there are no buttons, check if there's a message we should write at the bottom
			else if(Options.prompt_continue_message)
				add(0, 4, "", maptext_width = width * Constants.ICON_WIDTH, maptext = Options.prompt_continue_message, layer = layer + 2)

		hide()

	key_down(k, client/c)

		// if it's a text prompt:
		if(mode == TEXT)
			// if they pressed enter, submit the input
			if(k == Constants.KEY_CHAT)
				choice = input_text

			// if they pressed backspace, erase a letter
			else if(k == "back")
				if(length(input_text) > 0)
					input_text = copytext(input_text, 1, length(input_text))
					text.maptext = "<text align=middle><font color=#000>[input_text]_</font></text>"

			// otherwise, check if they hit a printable symbol
			else
				var/symbol = k
				var/symbols = "|1|2|3|4|5|6|7|8|9|0|-|q|w|e|r|t|y|u|i|o|p|a|s|d|f|g|h|j|k|l|z|x|c|v|b|n|m|space|"

				// if the typed one of those symbols:
				if(findtext(symbols, "|[symbol]|"))

					if(symbol == "space")
						symbol = " "

					if(c.keys["shift"])
						symbol = uppertext(symbol)

						if(symbol == "-")
							symbol = "_"

					input_text += symbol
					text.maptext = "<text align=middle><font color=#000>[input_text]_</font></text>"

		// if it's a number prompt:
		else if(mode == NUMBER)

			if(k == Constants.KEY_CHAT)
				choice = text2num(input_text)

			// if they pressed backspace, erase a letter
			else if(k == "back")
				if(length(input_text) > 0)
					input_text = copytext(input_text, 1, length(input_text))
					text.maptext = "<text align=middle><font color=#000>[input_text]_</font></text>"

			// otherwise, check if they hit a number
			else
				var/symbol = k
				var/symbols = "|1|2|3|4|5|6|7|8|9|0|"

				// if the typed one of those symbols:
				if(findtext(symbols, "|[symbol]|"))
					input_text += symbol
					text.maptext = "<text align=middle><font color=#000>[input_text]_</font></text>"

		else
			if(k == Constants.KEY_SELECT)
				if(options.len)
					if(isnull(choice))
						choice = options[index]
				else
					choice = 1

			else if(options.len)
				if(k == Constants.KEY_RIGHT)
					if(index < options.len)
						index += 1
						highlight_left.pos(button_x - 1 + 64 * index - 64, button_y - 1)
						highlight_right.pos(button_x + 31 + 64 * index - 64, button_y - 1)

				else if(k == Constants.KEY_LEFT)
					if(index > 1)
						index -= 1
						highlight_left.pos(button_x - 1 + 64 * index - 64, button_y - 1)
						highlight_right.pos(button_x + 31 + 64 * index - 64, button_y - 1)

	proc
		prompt()
			show()
			choice = null

			var/old_focus = owner.client.focus
			owner.client.focus = src

			while(isnull(choice))
				sleep(1)

			hide()
			owner.client.focus = old_focus

			return choice

mob
	proc
		prompt()
			if(!client)
				CRASH("The mob '[src]' has no client.")

			// create the HudAlert object
			var/Prompt/p = new(arglist(list(src) + args))

			return p.prompt()

		text_prompt()
			if(!client)
				CRASH("The mob '[src]' has no client.")

			// create the HudAlert object
			var/Prompt/p = new /Prompt/Text(arglist(list(src) + args))
			p.mode = p.TEXT

			return p.prompt()

		number_prompt()
			if(!client)
				CRASH("The mob '[src]' has no client.")

			// create the HudAlert object
			var/Prompt/p = new /Prompt/Number(arglist(list(src) + args))
			p.mode = p.NUMBER

			return p.prompt()


	key_down(k)
		..()

		if(k == "n")
			var/n = number_prompt()

			world << "[n] + 1 = [n + 1]"