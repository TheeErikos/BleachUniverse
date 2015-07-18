
// File:    hud-medals.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file manages the on-screen display of medals
//   that's used when you earn one.

MedalDisplay
	parent_type = /HudGroup

	layer = Constants.HUD_LAYER - 10

	var
		list/positions = list()

	New(mob/m)
		..()

		var/width = 6
		pos(Constants.ICON_WIDTH * Constants.VIEW_WIDTH * 0.5 - (width + 1) * Constants.ICON_WIDTH * 0.5, 16)

	proc
		show_medal(Medal/m)

			// find the first available medal position
			var/index = 0
			for(var/i = 1 to positions.len)
				if(!positions[i])
					index = i
					break

			// if we don't have an index, expand the list
			if(!index)
				positions += 1
				index = positions.len

			var/y = 40 + (index - 1) * (Constants.ICON_HEIGHT + 8)
			positions[index] = 1

			var/width = 6

			var/medal_icon = add(0, y, icon = m.icon, icon_state = m.icon_state, layer = layer + 1)
			var/background = add(Constants.ICON_WIDTH, y, "medal-background", width = width)
			var/caption = add(Constants.ICON_WIDTH + 4, y, "", maptext_width = width * Constants.ICON_WIDTH - 8, maptext_height = Constants.ICON_HEIGHT, maptext = "<text align=middle><b>[m.name]</b>\n[m.description]<text>", layer = layer + 1)

			spawn(Options.medal_display_time)
				remove(medal_icon)
				remove(background)
				remove(caption)
				positions[index] = 0

mob
	var
		MedalDisplay/medal_display

	init_hud()
		..()

		if(Constants.USE_MEDAL_DISPLAY)
			if(medal_display)
				medal_display.hide()
				del medal_display

			medal_display = new(src)

	clear_hud()
		..()

		if(medal_display)
			medal_display.hide()
			del medal_display
