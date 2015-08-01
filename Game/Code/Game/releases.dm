item
	zangetsuShikai
		name = "Zangetsu"
		icon_state = "zangetsu-shikai"
		description = "None"
		overlay_state = "zangetsu-shikai"
		overlay_layer = 7
		map_state = "zangetsu-shikai-standing"
		icon = 'releases.dmi'
		overlay_icon = 'releases.dmi'
		map_icon = 'releases.dmi'

		slot = RELEASE

		equipped(mob/m)
			m.bamult += 0.5
			m.erel = 1
			m.overlay(src)
			view() << "[m.scallout], [m.sname]"

		unequipped(mob/m)
			m.bamult -= 0.5
			m.erel = 0
			m.remove(src)

	zangetsuBankai
		name = "Zangetsu"
		icon_state = "zangetsu-bankai"
		description = "Bankai"
		overlay_state = "zangetsu-bankai"
		overlay_layer = 8
		map_state = "zangetsu-bankai-standing"
		icon = 'releases.dmi'
		overlay_icon = 'releases.dmi'
		map_icon = 'releases.dmi'

		slot = RELEASE

		equipped(mob/m)
			m.erel = 1
			m.bamult += 2.5
			m.bdmult += 1.5
			m.bfmult += 2.0
			m.bcmult += 1.5
			m.bsmult += 1.5
			view() << "<b>Bankai!</b>"
			spawn(30) view() << "<b><I>Tenza Zangetsu!</b></I>"
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)
			m.erel = 0
			m.bamult -= 2.5
			m.bdmult -= 1.5
			m.bfmult -= 2.0
			m.bcmult -= 1.5
			m.bsmult -= 1.5

	bringerlight
		name = "Bringer Light"
		icon_state = "bringerlight"
		description = "Bankai"
		overlay_state = "bringerlight"
		overlay_layer = 8
		map_state = "bringerlight-standing"
		icon = 'releases.dmi'
		overlay_icon = 'releases.dmi'
		map_icon = 'releases.dmi'

		slot = RELEASE

		equipped(mob/m)
			m.erel = 1
			m.bamult += 1.5
			m.bdmult += 1.2
			m.bfmult += 1.5
			m.bcmult += 2.5
			m.bsmult += 1.2
			view() << "<b>A green spark flashes!</b>"
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)
			m.erel = 0
			m.bamult -= 1.5
			m.bdmult -= 1.2
			m.bfmult -= 1.5
			m.bcmult -= 2.5
			m.bsmult -= 1.2
