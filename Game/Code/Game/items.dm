
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
	icon = 'clothes.dmi'
	overlay_icon = 'clothes.dmi'
	map_icon = 'clothes.dmi'

	hair1
		name = "Afro"
		icon_state = "hair1-standing"
		description = "Afro Hair"
		overlay_state = "hair1"
		overlay_layer = 6
		map_state = "hair1-standing"
		icon = 'hairs.dmi'
		overlay_icon = 'hairs.dmi'
		map_icon = 'hairs.dmi'

		slot = HAIR

		Click()
			usr.equip(new /item/hair1())
			usr << usr.sound_effect('boop.wav')

		equipped(mob/m)
			m.overlay(src)
			src.icon += rgb(120,0,0)

		unequipped(mob/m)
			m.remove(src)

	shihakusho
		name = "Shihakusho"
		icon_state = "shihakusho-item"
		description = "A Shihakusho worn my shinigami."
		overlay_state = "shihakusho"
		overlay_layer = 6
		map_state = "shihakusho-item-map"

		slot = BODY

		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)

	classyshirts
		name = "Classy Shirts"
		icon_state = "classyshirts-item"
		description = "Some nice clothing for you lot."
		overlay_state = "classyshirts"
		overlay_layer = 4
		map_state = "classyshirts-item-map"

		slot = UPPER_BODY

		equipped(mob/m)
			m.overlay(src)

		unequipped(mob/m)
			m.remove(src)

	bluetrousers
		name = "Blue Genes"
		icon_state = "btrousers-item"
		description = "Some stury leggings for your fleshy ass."
		overlay_state = "btrousers"
		overlay_layer = 3
		map_state = "btrousers-item-map"

		slot = LOWER_BODY

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
