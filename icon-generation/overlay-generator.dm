
// File:    icon-generation\overlay-generation.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   To generate overlays, include this file and run
//   the library. The generate_overlays() proc defined
//   in this file will be called automatically. You
//   can modify it to change the colors, patterns, and
//   type (armor or helmet) of overlay that gets created.

var
	const
		// these are the patterns you can use
		PLAIN = 0			// a solid color
		CHECKERBOARD = 1	// a 2x2 checkerboard pattern
		STRIPES = 2			// 2-pixel wide stripes that run down and right
		OTHER_STRIPES = 3	// 2-pixel wide stripes that run down and left

		// these are some colors I defined for you, but
		// feel free to use your own
		BROWN = "#404030"
		DARK_BROWN = "#373729"

		DARK_BLUE = "#404060"
		DARK_GRAY = "#303030"

		DEFAULT_BODY = "#505048"
		DEFAULT_FEET = "#303028"
		DEFAULT_SKIN = "#E0E090"

		ARMOR_ICON = 'base-armor.dmi'
		HELMET_ICON = 'base-helmet.dmi'

proc
	generate_overlays()
		var/ArmorGenerator/armor = new()

		// We pass each of these procs a color
		// and a pattern (you can specify one
		// or both). This will make brown armor
		// with stripes.
		armor.hands(DEFAULT_SKIN)
		armor.chest(BROWN, OTHER_STRIPES)
		armor.feet(DARK_GRAY)

		armor.helmet(DARK_GRAY)

		var/icon/result = armor.process(HELMET_ICON) // ARMOR_ICON or HELMET_ICON

		world << ftp(result, "output.dmi")

world
	New()
		..()

		spawn(1)
			generate_overlays()

ArmorGenerator
	parent_type = /IconProcessor

	var
		Color/chest_color = new(DEFAULT_BODY)
		Color/hands_color = new(DEFAULT_SKIN)
		Color/feet_color = new(DEFAULT_FEET)
		Color/helmet_color = new(DEFAULT_BODY)

		chest_pattern = PLAIN
		hands_pattern = PLAIN
		feet_pattern = PLAIN
		helmet_pattern = PLAIN

	state()
		per_pixel()
		show_progress()

	pixel()
		var/Color/c = get()

		// if this pixel is part of the helmet:
		if(c.r > 0 && c.g > 0 && c.b > 0)
			var/p = multiplier(helmet_pattern, x, y)
			return new /Color(helmet_color.r * c.r * p, helmet_color.g * c.r * p, helmet_color.b * c.r * p, 1)

		// if this pixel is part of the chest:
		else if(c.r > 0)
			var/p = multiplier(chest_pattern, x, y)
			return new /Color(chest_color.r * c.r * p, chest_color.g * c.r * p, chest_color.b * c.r * p, 1)

		// if this pixel is part of the hands:
		else if(c.g > 0)
			var/p = multiplier(hands_pattern, x, y)
			return new /Color(hands_color.r * c.g * p, hands_color.g * c.g * p, hands_color.b * c.g * p, 1)

		// if this pixel is part of the feet:
		else if(c.b > 0)
			var/p = multiplier(feet_pattern, x, y)
			return new /Color(feet_color.r * c.b * p, feet_color.g * c.b * p, feet_color.b * c.b * p, 1)

		else
			return c

	proc
		hands()
			for(var/a in args)
				if(isnum(a))
					hands_pattern = a
				else if(istext(a))
					hands_color = new(a)

		feet()
			for(var/a in args)
				if(isnum(a))
					feet_pattern = a
				else if(istext(a))
					feet_color = new(a)

		chest()
			for(var/a in args)
				if(isnum(a))
					chest_pattern = a
				else if(istext(a))
					chest_color = new(a)

		helmet()
			for(var/a in args)
				if(isnum(a))
					helmet_pattern = a
				else if(istext(a))
					helmet_color = new(a)

		multiplier(pattern, x, y)

			var/p = 1

			if(pattern == CHECKERBOARD)
				if((round(x / 2) + round(y / 2)) % 2 == 0)
					p = 1
				else
					p = 0.5

			else if(pattern == STRIPES)
				p = (round(x / 2 + y / 2) % 2) ? 0.5 : 1.0

			else if(pattern == OTHER_STRIPES)
				p = (round(x / 2 - y / 2) % 2) ? 0.5 : 1.0

			return p

