
// File:    demo\help.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file shows how to use the info bar to display
//   on-screen tips to the player.

area
	help
		var
			message = ""

		// show the message when they enter the help area
		Entered(mob/m)
			if(m.info_bar)
				m.info_bar.add_message(message)

			return ..()

		// remove the message when they leave
		Exited(mob/m)
			if(m.info_bar)
				m.info_bar.remove_message(message)

			return ..()

		banker
			message = "This is the bank. Interact with the banker to open the banking screen."

		shopkeeper
			message = "This is a shop. Interact with the shopkeeper to see what items you can buy."

		enemies
			message = "Get ready for battle. Press A to change what abilities are available."

Quest
	KillThreeBlueOozes
		acquired()
			..()

			if(owner.info_bar)
				owner.info_bar.add_message("Talk to this NPC again when you have completed this quest.")

		update()
			..()

			if(owner && owner.info_bar)
				if(is_complete())
					owner.info_bar.add_message("Good job! Go talk to the NPC that gave you this quest.")

		completed()
			..()

			// if you still have the messages about the quest we can remove them now.
			if(owner.info_bar)
				owner.info_bar.remove_message("Talk to this NPC again when you have completed this quest.")
				owner.info_bar.remove_message("Good job! Go talk to the NPC that gave you this quest.")
