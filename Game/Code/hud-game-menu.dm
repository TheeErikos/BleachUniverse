
// File:    hud-game-menu.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the game menu that appears when you
//   press escape while in the game. It contains, among
//   other things, an option to return to the title screen.

GameMenu
	parent_type = /HudBox

	var
		index = 0
		HudObject/cursor

	New(mob/m)
		..(m)

		box(6, 6)

		owner = m

		// add the background for the slot
		add(48, 16, "inventory-back", width = 4, height = 4, layer = layer + 1)

		// add the icons and captions
		var/list/icons = list("return-to-title-screen", "chat-options", "game-options", "return-to-game")
		var/list/captions = list("Return to Title Screen", "Chat Options", "Game Options", "Return to Game")

		for(var/i = 1 to icons.len)
			add(54, -16 + i * Constants.ICON_HEIGHT, "", layer = layer + 2, maptext_width = 128, maptext = "<text align=middle>[captions[i]]</text>", maptext_height = 32)
			add(16, -16 + i * Constants.ICON_HEIGHT, icon_state = icons[i], layer = layer + 2)

		cursor = add(16, 16, "inventory-cursor", layer = layer + 5)

		// Add the title on the window:
		add(16, 5 * Constants.ICON_HEIGHT, "", maptext_width = 160, maptext = "<text align=center><b>Game Menu</b></text>", layer = layer + 2)

		set_index(4)

		pos(160, 112)
		hide()


	key_down(k)
		if(k == Constants.KEY_UP)
			set_index(index + 1)
		else if(k == Constants.KEY_DOWN)
			set_index(index - 1)
		else if(k == Constants.KEY_SELECT)

			// return to the game
			if(index == 4)
				hide()
				owner.client.focus = owner

			// game options
			else if(index == 3)
				owner.game_options.show()
				owner.client.focus = owner.game_options

			// chat options
			else if(index == 2)
				hide()
				owner.client.focus = owner
				world << "'Chat Options' isn't implemented yet"

			// return to the title screen
			else if(index == 1)
				owner.client.save()
				owner.client.connect(new /mob/temporary())

		else if(k == Constants.KEY_CANCEL)
			hide()
			owner.client.focus = owner

	show()
		set_index(4)
		..()

	proc
		set_index(i)
			if(i > 4) i = 4
			if(i < 1) i = 1

			index = i
			cursor.pos(16, -16 + 32 * index)

GameOptions
	parent_type = /HudBox

	var
		index = 0
		HudObject/cursor
		list/labels = list()

	New(mob/m)
		layer += 10

		..(m)

		box(6, 6)

		owner = m

		// add the background for the slot
		add(48, 16, "inventory-back", width = 4, height = 4, layer = layer + 1)

		// add the icons and captions
		var/list/icons = list("return-to-game", "music-volume", "sound-volume", "screen-size")
		for(var/i = 1 to icons.len)
			labels += add(54, -16 + i * Constants.ICON_HEIGHT, "", layer = layer + 2, maptext_width = 128, maptext_height = 32)
			add(16, -16 + i * Constants.ICON_HEIGHT, icon_state = icons[i], layer = layer + 2)

		cursor = add(16, 16, "inventory-cursor", layer = layer + 5)

		// Add the title on the window:
		add(16, 5 * Constants.ICON_HEIGHT, "", maptext_width = 160, maptext = "<text align=center><b>Game Options</b></text>", layer = layer + 2)

		set_index(4)

		pos(168, 120)
		hide()

	key_down(k)
		if(k == Constants.KEY_UP)
			set_index(index + 1)
		else if(k == Constants.KEY_DOWN)
			set_index(index - 1)
		else if(k == Constants.KEY_SELECT)

			// return to the game menu
			if(index == 1)
				hide()
				owner.client.focus = owner.game_menu

		else if(k == Constants.KEY_RIGHT || k == Constants.KEY_LEFT)

			// screen size
			if(index == 4)
				if(k == Constants.KEY_RIGHT)
					owner.client.screen_size(owner.client.screen_size + 0.25)
				else if(k == Constants.KEY_LEFT)
					owner.client.screen_size(owner.client.screen_size - 0.25)

			// sound volume
			else if(index == 3)
				if(k == Constants.KEY_RIGHT)
					owner.client.sound_volume(owner.client.sound_volume + 0.25)
				else if(k == Constants.KEY_LEFT)
					owner.client.sound_volume(owner.client.sound_volume - 0.25)

			// music volume
			else if(index == 2)
				if(k == Constants.KEY_RIGHT)
					owner.client.music_volume(owner.client.music_volume + 0.25)
				else if(k == Constants.KEY_LEFT)
					owner.client.music_volume(owner.client.music_volume - 0.25)

			refresh()

		else if(k == Constants.KEY_CANCEL)
			hide()
			owner.client.focus = owner.game_menu

	show()
		set_index(4)
		refresh()
		..()

	proc
		set_index(i)
			if(i > 4) i = 4
			if(i < 1) i = 1

			index = i
			cursor.pos(16, -16 + 32 * index)

		refresh()
			var/HudObject/back_caption = labels[1]
			var/HudObject/music_caption = labels[2]
			var/HudObject/sound_caption = labels[3]
			var/HudObject/screen_caption = labels[4]

			back_caption.maptext = "<text align=middle>Back</text>"
			music_caption.maptext = "<text align=middle>Music Volume: [percent(owner.client.music_volume)]</text>"
			sound_caption.maptext = "<text align=middle>Sound Volume: [percent(owner.client.sound_volume)]</text>"
			screen_caption.maptext = "<text align=middle>Screen Size: [percent(owner.client.screen_size)]</text>"


		percent(p)
			return "[round(p * 100)]%"

mob
	var
		tmp/GameMenu/game_menu
		tmp/GameOptions/game_options

	init_hud()
		..()

		if(client && Constants.USE_GAME_MENU)
			game_menu = new(src)
			game_options = new(src)

	clear_hud()
		..()

		if(Constants.USE_GAME_MENU)
			if(game_menu)
				game_menu.hide()
				del game_menu

			if(game_options)
				game_options.hide()
				del game_options

