StatBox
	parent_type = /HudBox

	var
		HudObject/title
		HudObject/souls
		HudObject/experience
		HudObject/effectiveattack
		HudObject/reiatsu

	New(mob/m)
		..(m)

		box(6, 8)

		owner = m

		// display your level, class, souls, and experience
		title = add(12, 48, maptext_width = width * 32 - 24, layer = layer + 1)
		souls = add(12, 38, maptext_width = width * 32 - 24, layer = layer + 1)
		experience = add(12, 26, maptext_width = width * 32 - 24, layer = layer + 1)
		effectiveattack = add(12,16, maptext_width = width * 32 - 24, layer = layer + 1)
		reiatsu = add(12,6, maptext_width = width * 32 - 24, layer = layer + 1)

		refresh()

		pos(Constants.VIEW_WIDTH * Constants.ICON_WIDTH - 128 - 12, 12)

	proc
		refresh()
			title.maptext = "<b>[owner.description()]</b>"
			souls.maptext = "souls: $[owner.souls]"
			experience.maptext = "XP: [owner.experience] / [owner.experience_needed]"
			effectiveattack.maptext = "Power: [owner.effectiveattack]"
			reiatsu.maptext = "Reiatsu: [owner.reiatsu] / [owner.max_reiatsu]"
