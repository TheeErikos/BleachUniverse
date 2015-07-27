
// File:    player-interaction.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the code for player interaction.
//   When the player presses the select key (space bar by
//   default) they interact with an object. First it checks
//   for objects in front of them that they can interact
//   with. Next it checks for corpses to loot. Lastly, it
//   opens the inventory window.

mob
	key_down(k)
		..()

		// when you press space we find the first atom
		// in front of you that you can interact with.
		if(k == Constants.KEY_SELECT)

			var/did_something = 0

			for(var/atom/a in obounds(8, src))
				if(a.interact(src) != "interact did nothing")
					did_something = 1
					break

			for(var/item/item in obounds(2, src))
				if(item.pickup == item.INTERACT)
					if(get_item(item))
						did_something = 1
						break

			// if there were no atoms to interact with, check
			// if there are any corpses to loot.
			if(!did_something)
				if(!loot_window())
					if(Options.space_opens_inventory)
						inventory()

atom
	proc
		// the reason this returns this string is so when
		// you override an atom's interact() proc to make
		// it do something, you *won't* return this string
		// so the library can detect when you did override
		// the proc and only interact with one object when
		// you press the space bar.
		interact(mob/m)
			return "interact did nothing"
