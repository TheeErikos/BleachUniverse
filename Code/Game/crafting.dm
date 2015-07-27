
// File:    demo\crafting.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file shows how to define a crafting ability.
//   They inherit from the Ability object but they have
//   some additional variables that make them appropriate
//   for creating crafting abilities.

obj
	anvil
		icon = 'turfs.dmi'
		icon_state = "anvil"

// crafting abilities consume items in the player's
// inventory and create a new item. here's an example:
CraftingAbility
	MakeSword
		name = "Make Sword"
		icon_state = "ability-button-make-sword"

		// this requires 4 iron bars and it requires that
		// the player be near an anvil
		materials = list(/item/iron_bar = 4)
		required_object = /obj/anvil

		// it turns the iron bars into a sword
		product = /item/sword
