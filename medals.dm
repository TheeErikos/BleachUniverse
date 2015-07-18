
// File:    medals.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the /Medal object and the mob
//   procs to manage the awarding of medals. This
//   proc uses the on-screen display defined in
//   hud-medals.dm to show medals when you earn one.

Medal
	var
		name = ""
		description = ""
		icon
		icon_state

		hub_name = ""

	proc
		// these are called when the medal is awarded
		// to or removed from a player.
		awarded(mob/m)
		removed(mob/m)

mob
	var
		list/medals

	proc
		sync_medals()

			if(!client)
				return 0

			spawn()
				if(medals)
					for(var/t in medals)
						var/Medal/medal = new t()
						client.AddMedal(medal.hub_name)

		award_medal(medal_type)

			if(!client)
				return 0

			var/Medal/medal

			// if the arg is a Medal object, use that
			if(istype(medal_type, /Medal))
				medal = medal_type

			// otherwise assume it was a type path.
			else
				medal = new medal_type()

			// make sure you don't already have it
			if(medals)
				if(medal.type in medals)
					return 1
			else
				medals = list()

			medals += medal.type

			medal_display.show_medal(medal)
			medal.awarded(src)

			// If the medal has a hub_name, try to contact the hub.
			if(medal.hub_name)
				spawn()
					var/result = client.AddMedal(medal.hub_name)

					// if the hub couldn't be reached
					if(!result)
						offline_notification()

			return 2

		has_medal(medal_type)

			if(!client)
				return 0

			var/Medal/medal

			// if the arg is a Medal object, use that
			if(istype(medal_type, /Medal))
				medal = medal_type

			// otherwise assume it was a type path.
			else
				medal = new medal_type()

			if(medal.name in medals)
				return 1

			return 0
