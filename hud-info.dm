
// File:    hud-info.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the HUD object for the info box,
//   which displays the player's level, money, and
//   experience.

InfoBox
	parent_type = /HudBox

	var
		HudObject/title
		HudObject/money
		HudObject/experience

	New(mob/m)
		..(m)

		box(4, 2)

		owner = m

		// display your level, class, money, and experience
		title = add(12, 40, maptext_width = width * 32 - 24, layer = layer + 1)
		money = add(12, 24, maptext_width = width * 32 - 24, layer = layer + 1)
		experience = add(12, 8, maptext_width = width * 32 - 24, layer = layer + 1)

		refresh()

		pos(Constants.VIEW_WIDTH * Constants.ICON_WIDTH - 128 - 16, 16)

	proc
		refresh()
			title.maptext = "<b>[owner.description()]</b>"
			money.maptext = "Money: $[owner.money]"
			experience.maptext = "XP: [owner.experience] / [owner.experience_needed]"
mob
	var
		tmp/InfoBox/info_box
		tmp/last_move_time = 0

	movement()
		..()

		if(info_box)
			if(moved)
				last_move_time = world.time

			if(world.time > last_move_time + Constants.INFO_BOX_DELAY)
				info_box.show()
			else
				info_box.hide()

	init_hud()
		..()

		if(client && Constants.USE_INFO_BOX)
			info_box = new(src)

	clear_hud()
		..()

		if(Constants.USE_INFO_BOX)
			if(info_box)
				info_box.hide()
				del info_box
