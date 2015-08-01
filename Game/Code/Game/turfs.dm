
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
	icon_state = "blackwall"

	sand_01
		density = 0
		icon_state = "sand1"

	Floors
		icon_state = "floor-01"

	Walls
		icon_state = "wall01"
		density = 1

Constructs
	parent_type = /turf
	icon = 'buildings.dmi'
	Buildings
		density = 1
		icon_state = "piller1"
	Furniture
		density = 1

