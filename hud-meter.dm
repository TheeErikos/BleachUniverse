
// File:    hud-meter.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the base HudMeter object which
//   is used to create the on-screen health and mana
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
		dot_value = 4
		dot_size = 13

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

			// figure out how many dots are needed
			var/num_dots = 1
			if(stat_max > 0)
				num_dots = round(log(2, stat_max))

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
				var/cx = num_dots * 13 + 40
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

			// if that doesn't match the number of dots we have
			if(num_dots != dots.len)

				// delete all existing dots
				for(var/atom/a in dots)
					del a

				dots.Cut()

				// and create new ones
				for(var/i = 1 to num_dots)
					dots += add(24 + i * dot_size - dot_size, -3, "")

			// figure out how many bubbles should be filled
			var/value = 0
			if(stat_max > 0)
				value = round((stat_value / stat_max) * (dots.len * dot_value))

			// and fill them
			for(var/i = 1 to dots.len)

				// get the value for this bubble
				var/v = value
				if(v > dot_value)
					v = dot_value
				else if(v < 0)
					v = 0

				// and set its icon state
				var/HudObject/o = dots[i]
				o.icon_state = "[var_name]-[v]"

				value -= dot_value

HealthMeter
	parent_type = /HudMeter

	New(mob/m)
		..(m, "health", "max_health")

		// create the label
		var/obj/o = add(0, 0, "health")
		o.overlays += hud_label("<text align=right>health", layer = layer, pixel_y = 5)

		pos(8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 24)

ManaMeter
	parent_type = /HudMeter

	New(mob/m)
		..(m, "mana", "max_mana")

		// create the label
		var/obj/o = add(0, 0, "")
		o.overlays += hud_label("<text align=right>mana", layer = layer, pixel_y = 5)

		pos(8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 40)

mob
	var
		tmp/HealthMeter/health_meter
		tmp/ManaMeter/mana_meter

	init_hud()
		..()

		if(client && Constants.USE_HEALTH_METER)
			health_meter = new(src)

		if(client && Constants.USE_MANA_METER)
			mana_meter = new(src)

	clear_hud()
		..()

		if(Constants.USE_HEALTH_METER)
			if(health_meter)
				health_meter.hide()
				del health_meter

		if(Constants.USE_MANA_METER)
			if(mana_meter)
				mana_meter.hide()
				del mana_meter
