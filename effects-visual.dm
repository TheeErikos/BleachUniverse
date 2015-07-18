
// File:    effects-visual.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains procs used to create graphical
//   effects.

mob
	var
		tmp/list/attached_effects

	set_pos()
		. = ..()

		if(attached_effects)
			for(var/obj/o in attached_effects)
				o.loc = loc
				o.step_x = step_x
				o.step_y = step_y

atom
	proc
		// create an object to show an animation at the src atom
		effect(state, dir = null, duration = 30, layer = layer + 10, attached = 0)
			var/obj/o = new()
			o.layer = layer

			// if it's a turf's effect() proc being called, place the effect there
			if(isturf(src))
				o.loc = src

			// otherwise place it at the atom's loc
			else if(istype(src, /atom/movable))
				var/atom/movable/a = src

				o.loc = a.loc
				o.step_x = a.step_x
				o.step_y = a.step_y

				if(attached)
					var/mob/m = a

					if(istype(m))
						if(m.attached_effects)
							m.attached_effects += o
						else
							m.attached_effects = list(o)

			o.pixel_x = pixel_x
			o.pixel_y = pixel_y
			o.pixel_z = pixel_z

			o.icon = Constants.EFFECTS_ICON

			flick(state, o)

			// as long as there's no unnamed state, this will make the
			// object have no appearance when the animation ends.
			o.icon_state = ""

			spawn(duration * world.tick_lag)
				del o

		// display a number, outlined in black, next to the src atom
		damage_number(number, color = "#fff", layer = MOB_LAYER + 1, duration = 15)

			var/obj/number_obj = map_label(number, color, bold = 1, width = 64, layer = layer)

			if(isturf(src))
				number_obj.loc = src
			else if(istype(src, /atom/movable))
				var/atom/movable/m = src

				number_obj.loc = m.loc
				number_obj.step_x = m.step_x
				number_obj.step_y = m.step_y

			number_obj.pixel_x = pixel_x
			number_obj.pixel_y = pixel_y - 1
			number_obj.pixel_z = pixel_z

			spawn()
				sleep(duration * world.tick_lag)

				for(var/i = 1 to 10)
					number_obj.pixel_z += 1
					sleep(world.tick_lag)

				del number_obj

mob
	var
		tmp/rumble = 0
		tmp/rumble_time = 0
		tmp/rumble_duration = 0

	proc
		rumble(r, d = 20)
			rumble = r
			rumble_time = d
			rumble_duration = d

	set_camera()
		..()

		if(rumble > 0)

			rumble_time -= 1

			if(rumble_time <= 0)
				rumble -= 1
				rumble_time = rumble_duration

			camera.px += rand(-rumble, rumble)
			camera.py += rand(-rumble, rumble)

proc
	hud_label(maptext, color = "#fff", bold = 0, layer = MOB_LAYER, width = 32, pixel_x = 0, pixel_y = 0)

		var/plain_text = maptext
		var/pos = findtext(plain_text, "<font")
		while(pos > 0)

			var/end = findtext(plain_text, ">", pos)

			plain_text = copytext(plain_text, 1, pos) + copytext(plain_text, end + 1)

			pos = findtext(plain_text, "<font")

		if(isnull(plain_text))
			plain_text = maptext

		if(bold)
			bold = "<b>"
		else
			bold = ""

		var/obj/o = new()
		o.maptext_width = width
		o.maptext = "<font color=[color]>[bold][maptext]"
		o.layer = layer + 0.1
		o.pixel_x = pixel_x
		o.pixel_y = pixel_y

		var/obj/o1 = new()
		o1.maptext = "<font color=#000>[bold][plain_text]"
		o1.maptext_width = width
		o1.layer = FLOAT_LAYER
		o1.pixel_x = 1

		var/obj/o2 = new()
		o2.maptext = "<font color=#000>[bold][plain_text]"
		o2.maptext_width = width
		o2.layer = FLOAT_LAYER
		o2.pixel_x = -1

		var/obj/o3 = new()
		o3.maptext = "<font color=#000>[bold][plain_text]"
		o3.maptext_width = width
		o3.layer = FLOAT_LAYER
		o3.pixel_y = 1

		var/obj/o4 = new()
		o4.maptext = "<font color=#000>[bold][plain_text]"
		o4.maptext_width = width
		o4.layer = FLOAT_LAYER
		o4.pixel_y = -1

		o.underlays += o1
		o.underlays += o2
		o.underlays += o3
		o.underlays += o4

		return o

	map_label(maptext, color = "#fff", bold = 0, layer = MOB_LAYER, width = 32, pixel_x = 0, pixel_y = 0)

		var/plain_text = maptext
		var/pos = findtext(plain_text, "<font")
		while(pos > 0)

			var/end = findtext(plain_text, ">", pos)

			plain_text = copytext(plain_text, 1, pos) + copytext(plain_text, end + 1)

			pos = findtext(plain_text, "<font")

		if(isnull(plain_text))
			plain_text = maptext

		if(bold)
			bold = "<b>"
		else
			bold = ""

		var/obj/o = new()
		o.maptext_width = width
		o.maptext = "<font color=[color]>[bold][maptext]"
		o.layer = layer + 0.1
		o.pixel_x = pixel_x
		o.pixel_y = pixel_y

		var/obj/o1 = new()
		o1.maptext = "<font color=#000>[bold][plain_text]"
		o1.maptext_width = width
		o1.layer = layer
		o1.pixel_x = 1
		o1.pixel_y = pixel_y

		var/obj/o2 = new()
		o2.maptext = "<font color=#000>[bold][plain_text]"
		o2.maptext_width = width
		o2.layer = layer
		o2.pixel_x = -1
		o2.pixel_y = pixel_y

		var/obj/o3 = new()
		o3.maptext = "<font color=#000>[bold][plain_text]"
		o3.maptext_width = width
		o3.layer = layer
		o3.pixel_y = pixel_y
		o3.pixel_z = 1

		var/obj/o4 = new()
		o4.maptext = "<font color=#000>[bold][plain_text]"
		o4.maptext_width = width
		o4.layer = layer
		o4.pixel_y = pixel_y
		o4.pixel_z = -1

		o.underlays += o1
		o.underlays += o2
		o.underlays += o3
		o.underlays += o4

		return o
