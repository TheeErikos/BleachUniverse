
// File:    hud-info.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the HUD object for the info box,
//   which displays the player's level, souls, and
//   experience.

InfoBox
	parent_type = /HudBox

	var
		HudObject/title
		HudObject/souls
		HudObject/experience
		HudObject/effectiveattack
		HudObject/reiatsu

	New(mob/m)
		..(m)

		box(4, 2)

		owner = m

		// display your level, class, souls, and experience
		title = add(12, 48, maptext_width = width * 32 - 24, layer = layer + 1)
		souls = add(12, 38, maptext_width = width * 32 - 24, layer = layer + 1)
		experience = add(12, 26, maptext_width = width * 32 - 24, layer = layer + 1)
		effectiveattack = add(12,16, maptext_width = width * 32 - 24, layer = layer + 1)
		reiatsu = add(12,6, maptext_width = width * 32 - 24, layer = layer + 1)

		refresh()

		pos(Constants.VIEW_WIDTH * Constants.ICON_WIDTH - 128 - 16, 16)

	proc
		refresh()
			title.maptext = "<b>[owner.description()]</b>"
			souls.maptext = "souls: $[owner.souls]"
			experience.maptext = "XP: [owner.experience] / [owner.experience_needed]"
			effectiveattack.maptext = "Power: [owner.effectiveattack]"
			reiatsu.maptext = "Reiatsu: [owner.reiatsu] / [owner.max_reiatsu]"
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
				info_box.refresh()
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
