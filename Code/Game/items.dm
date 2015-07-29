
// File:    demo\items.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines items and shows how to:
//    * create items that give stat bonuses
//    * create items that can be used and consumed
//    * create stackable items
//    * create equippable items

// we define the equipment slots we'll have
var
	const
		MAIN_HAND = "main-hand"
		BODY = "body"
		HEAD = "head"
		RELEASE = "release"
		HAIR = "hair"
		UPPER_BODY = "ubody"
		LOWER_BODY = "lbody"

item
	icon = 'items.dmi'
	overlay_icon = 'clothes.dmi'
	map_icon = 'items.dmi'

	iron_bar
		name = "Iron Bar"
		icon_state = "iron-bar"
		map_state = "iron-bar-map"

		stack_size = 20
		count = 5
		description = "Used for crafting\nThis\nis\na long\ndescription"

	shirt1
		name = "Short Length Shirt"
		icon_state = "shirt1"
		description = "A generic shirt for everyone to use!"
		overlay_state = "shirt1"
		overlay_layer = 1
		map_state = "shirt1"

		slot = UPPER_BODY

		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)

	zangetsuShikai
		name = "Zangetsu"
		icon_state = "sword"
		description = "None"
		overlay_state = "zangetsu"
		overlay_layer = 5
		map_state = "sword-map"
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
		icon_state = "sword"
		description = "Bankai"
		overlay_state = "zangetsubankai"
		overlay_layer = 6
		map_state = "sword-map"

		slot = RELEASE

		equipped(mob/m)
			m.erel = 1
			m.bamult += 2.5
			m.bdmult += 1.5
			m.bfmult += 2.0
			m.bcmult += 1.5
			m.bsmult += 2.0
			view() << "<b>Bankai!</b>"
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)
			m.erel = 0
			m.bamult -= 2.5
			m.bdmult -= 1.5
			m.bfmult -= 2.0
			m.bcmult -= 1.5
			m.bsmult -= 2.0

/*	CustomSword
		name = usr.swordname
		icon_state = usr.swordname
		description = "None"
		overlay_state = usr.swordname
		overlay_layer = 1
		map_state = "[usr.swordname]-map"

		slot = MAIN_HAND

		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)
*/
	dagger
		name = "Dagger"
		icon_state = "dagger"
		description = "+3 Power, +5 effectivespeed"
		map_state = "dagger-map"

		slot = MAIN_HAND

		equipped(mob/m)
			m.effectiveattack += 3
			m.effectivespeed += 5

		unequipped(mob/m)
			m.effectiveattack -= 3
			m.effectivespeed -= 5

	helmet
		name = "Helmet"
		icon_state = "helmet"
		description = "+2 Defense"
		overlay_state = "helmet"
		map_state = "helmet-map"

		slot = HEAD
		cost = 5

		// make the helmet actually give you +2 effectivedefense
		equipped(mob/m)
			m.overlay(src)
			m.effectivedefense += 2

		unequipped(mob/m)
			m.remove(src)
			m.effectivedefense -= 2

	hollowmask1
		name = "Vaizard Mask"
		icon_state = "mask1"
		description = "+lots Power Put this on and go crazy!"
		overlay_state = "mask1"
		map_state = "mask1-map"

		slot = HEAD
		cost = 500

		//Makes your stats go skoogly woogly
		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)

	armor
		name = "Armor"
		icon_state = "armor"
		description = "+4 Defense"
		overlay_state = "armor"
		map_state = "armor-map"

		slot = BODY
		cost = 8

		// make the armor actually give you +4 effectivedefense
		equipped(mob/m)
			m.overlay(src)
			m.effectivedefense += 4

		unequipped(mob/m)
			m.remove(src)
			m.effectivedefense -= 4

	AfroHair
		name = "Afro Hair"
		icon_state = ""
		overlay_icon = 'hairs.dmi'
		description = "Simon likes it"
		overlay_state = "shinigamihair2"
		map_state = ""

		slot = HAIR
		cost = 0

		// make the helmet actually give you +2 effectivedefense
		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)


	ShinigamiRobe
		name = "Shinigami Robe"
		icon_state = "shinirobe"
		description = "Worn by shinigami"
		overlay_state = "shinirobe"
		map_state = "shinirobe-map"

		slot = BODY
		cost = 8

		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)

	health_potion
		name = "Health Potion"
		icon_state = "health-potion"
		description = "Restores 15 health"
		map_state = "health-potion-map"

		count = 1
		stack_size = 5
		cost = 3

		use(mob/m)
			m.gain_health(15)

			// consume one potion
			consume(1)

mob
	// we play this sound effect when a player loots or buys an item
	got_item()
		..()
		sound_effect('boop.wav')
