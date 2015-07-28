
// File:    hud-meter.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the base HudMeter object which
//   is used to create the on-screen health and reiatsu
//   display.

HudMeter
	parent_type = /HudGroup

	var
		mob/owner
		var_name
		max_var_name

		show_caption = 0
		HudObject/caption
		HudObject/shadow1
		HudObject/shadow2
		HudObject/shadow3
		HudObject/shadow4

		list/dots = list()

	New(mob/m, var_name, max_var_name)
		..(m)

		owner = m
		src.var_name = var_name
		src.max_var_name = max_var_name

		update()

	proc
		update()

			// get the stat value and max value
			var/stat_max = owner.vars[max_var_name]
			var/stat_value = owner.vars[var_name]


			// old formula
			// var/num_dots = round((stat_max + dot_value - 1) / dot_value)

			// if we show the numerical caption
			if(show_caption)

				// create the objects if we need to
				if(!caption)
					caption = add(0, 0, "", maptext_width = 128, layer = layer + 1)
					shadow1 = add(0, 0, "", maptext_width = 128)
					shadow2 = add(0, 0, "", maptext_width = 128)
					shadow3 = add(0, 0, "", maptext_width = 128)
					shadow4 = add(0, 0, "", maptext_width = 128)

				// position them
				var/cx = 45
				var/cy = 5

				caption.pos(cx, cy)
				caption.maptext = "[stat_value] / [stat_max]"

				shadow1.pos(cx - 1, cy)
				shadow1.maptext = "<font color=#000>[caption.maptext]"
				shadow2.pos(cx + 1, cy)
				shadow2.maptext = "<font color=#000>[caption.maptext]"
				shadow3.pos(cx, cy - 1)
				shadow3.maptext = "<font color=#000>[caption.maptext]"
				shadow4.pos(cx, cy + 1)
				shadow4.maptext = "<font color=#000>[caption.maptext]"

			// if we don't need to show the caption but the object exists, delete it
			else if(caption)
				del caption
				del shadow1
				del shadow2
				del shadow3
				del shadow4

HealthMeter
	parent_type = /HudMeter

	New(mob/m)
		..(m, "health", "max_health")

		// create the label
		var/obj/o = add(0, 0, "health")
		o.overlays += hud_label("<text align=center>SP", layer = layer, pixel_y = 5)

		pos(8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 28)

ManaMeter
	parent_type = /HudMeter

	New(mob/m)
		..(m, "reiatsu", "max_reiatsu")

		// create the label
		var/obj/o = add(0, 0, "reiatsu")
		o.overlays += hud_label("<text align=center>Rei", layer = layer, pixel_y = 5)

		pos(8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 40)

mob
	var
		tmp/HealthMeter/health_meter
		tmp/ManaMeter/reiatsu_meter

	init_hud()
		..()

		if(client && Constants.USE_HEALTH_METER)
			health_meter = new(src)

		if(client && Constants.USE_MANA_METER)
			reiatsu_meter = new(src)

	clear_hud()
		..()

		if(Constants.USE_HEALTH_METER)
			if(health_meter)
				health_meter.hide()
				del health_meter

		if(Constants.USE_MANA_METER)
			if(reiatsu_meter)
				reiatsu_meter.hide()
				del reiatsu_meter
