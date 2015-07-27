mob/verb
	HelpButton()
		set hidden = 1
		usr << "[usr.name], clicked the help button (Yet to be made)"

	BugButton()
		set hidden = 1
		usr << "[usr.name], clicked the bug button (Yet to be made)"

	RestButton()
		set hidden = 1
		usr << "You begin to rest (Yet to be made)"

	SpendTalent()
		set hidden = 0
		statup = input("Which stat do you want to upgrade?", "Stats", statup) in list ("Attack", "Defense", "Focus", "Control")
		statupamount = input("How many points to spend?", "[src.talentpoint] Talent points remaining", statupamount)
		if (statupamount > usr.talentpoint)
			src << "You don't have this much!"
		else if (statup == "Attack")
			usr.normalattack += statupamount
			usr.talentpoint -= statupamount
		else if (statup == "Defense")
			usr.normaldefense += statupamount
			usr.talentpoint -= statupamount
		else if (statup == "Focus")
			usr.normalfocus += statupamount
			usr.talentpoint -= statupamount
		else if (statup == "Control")
			usr.normalcontrol += statupamount
			usr.talentpoint -= statupamount