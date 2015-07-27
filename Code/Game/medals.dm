
// File:    demo\medals.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains two medals and the procs
//   that check for when the medals should be awarded.

world
	// this is a hub entry I set up for testing medals. You can go to this URL:
	//
	//    http://www.byond.com/games/Forum_account/TestGame#tab=scores
	//
	// To check what medals you have.
	hub = "Forumaccount.TestGame"
	hub_password = "BE9YTsqX1m859duH"

// To add medals just create new types of the /Medal object.
// You are responsible for checking the conditions to determine
// when the medal should be awarded.
//
// Note: Medals are tracked per-player. If you give medals a
//       hub_name they'll be awarded on the BYOND hub too.

Medal
	icon = 'medals.dmi'

	OozeKiller
		name = "Ooze Killer"
		description = "You killed a blue or green ooze."
		icon_state = "ooze-killer"
		hub_name = "Ooze Killer"

	QuestCompleted
		name = "Quest Completed"
		description = "You completed a quest."
		icon_state = "quest-completed"
		hub_name = "Quest Completed"

mob
	// we use events to check for conditions that satisfy the medals
	killed(mob/m)
		..()

		// When you kill an ooze we award this medal. If you already
		// have the medal, nothing will be shown on the screen. It'll
		// only show the medal on the screen if you didn't already have it.
		if(istype(m, /mob/enemy/blue_ooze) || istype(m, /mob/enemy/green_ooze))
			award_medal(/Medal/OozeKiller)

	completed_quest()
		..()

		// we award this medal when a quest is completed, it doesn't
		// matter what quest it is.
		award_medal(/Medal/QuestCompleted)
