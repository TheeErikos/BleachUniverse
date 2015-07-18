
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

item
	icon = 'items.dmi'
	overlay_icon = 'overlays.dmi'
	map_icon = 'items.dmi'

	iron_bar
		name = "Iron Bar"
		icon_state = "iron-bar"
		map_state = "iron-bar-map"

		stack_size = 20
		count = 5
		description = "Used for crafting\nThis\nis\na long\ndescription"

	sword
		name = "Sword"
		icon_state = "sword"
		description = "+5 Power"
		overlay_state = "sword"
		overlay_layer = 2
		map_state = "sword-map"

		slot = MAIN_HAND

		// make the sword actually give you +5 power
		equipped(mob/m)
			m.overlay(src)
			m.power += 5

		unequipped(mob/m)
			m.remove(src)
			m.power -= 5

	dagger
		name = "Dagger"
		icon_state = "dagger"
		description = "+3 Power, +5 speed"
		map_state = "dagger-map"

		slot = MAIN_HAND

		equipped(mob/m)
			m.power += 3
			m.speed += 5

		unequipped(mob/m)
			m.power -= 3
			m.speed -= 5

	helmet
		name = "Helmet"
		icon_state = "helmet"
		description = "+2 Defense"
		overlay_state = "helmet"
		map_state = "helmet-map"

		slot = HEAD
		cost = 5

		// make the helmet actually give you +2 defense
		equipped(mob/m)
			m.overlay(src)
			m.defense += 2

		unequipped(mob/m)
			m.remove(src)
			m.defense -= 2

	armor
		name = "Armor"
		icon_state = "armor"
		description = "+4 Defense"
		overlay_state = "armor"
		map_state = "armor-map"

		slot = BODY
		cost = 8

		// make the armor actually give you +4 defense
		equipped(mob/m)
			m.overlay(src)
			m.defense += 4

		unequipped(mob/m)
			m.remove(src)
			m.defense -= 4

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
