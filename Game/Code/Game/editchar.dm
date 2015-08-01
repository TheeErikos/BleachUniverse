item

	nextbutton
		icon = 'buildings.dmi'
		overlay_icon = 'buildings.dmi'
		map_icon = 'buildings.dmi'
		name = "Next Button"
		icon_state = "nextbutton"
		description = "Next Button"
		overlay_state = "nextbutton"
		overlay_layer = 1
		map_state = "nextbutton"

		slot = HAIR

		Click()
			usr.client.eye = usr
			usr.loc = locate(36, 93, 3)
			usr << usr.sound_effect('boop.wav')

		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)

	edittxt
		icon = 'buildings.dmi'
		overlay_icon = 'buildings.dmi'
		map_icon = 'buildings.dmi'
		name = "Next Button"
		icon_state = "edityourchar"
		description = "Next Button"
		overlay_state = "edityourchar"
		overlay_layer = 1
		map_state = "edityourchar"

		slot = HAIR

		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)