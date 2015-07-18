
// File:    demo\turfs.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the turfs used in the project.
//   There's nothing special here, it's the same kind
//   of definitions you'd see in any project.

turf
	icon = 'turfs.dmi'
	icon_state = "grass-01"

	New()
		..()
		dir = dir8()

		if(!density)
			var/n = autojoin47("density")
			if(n > 0)
				overlays += icon('shadow-47.dmi', "[n]")

		else
			var/n = autojoin16("density")
			if(n < 15)
				overlays += icon('walls.dmi', "outline-[n]")

	wall_01
		icon = 'walls.dmi'
		density = 1
		icon_state = "wall-01"

	stone_01
		icon = 'walls.dmi'
		density = 1
		icon_state = "stone-01"

	wood_01
		icon = 'walls.dmi'
		density = 1
		icon_state = "wood-01"

	/*
	wall_01
		icon = 'walls.dmi'
		icon_state = "wall-01"
		density = 1

	wall_02
		icon = 'walls.dmi'
		icon_state = "wall-02"
		density = 1

	wall_03
		icon = 'walls.dmi'
		icon_state = "wall-03"
		density = 1
	*/

	floor_01
		icon_state = "floor-01"
