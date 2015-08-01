

mob/verb
	HelpButton()
		set hidden = 1
		usr << "[usr.name], clicked the help button (Yet to be made)"

	RestButton()
		set hidden = 1
		if (isresting==null)
			isresting = 1
			reiregen = round(max_reiatsu/100*1,1)
			hpregen = round(max_health/100*1,1)
			usr << "You begin to regenerate your soul"
			do
				gain_reiatsu(reiregen)
				gain_health(hpregen)
				sleep(10)
				if(src.moved)
					usr << "You stop resting"
					isresting = null
			while(isresting == 1)



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

	SkillTree()
		if(Skill_Tree)
			for(var/I in client.images) if(I)
				del I
			client.eye = usr
			client.perspective = MOB_PERSPECTIVE
			Skill_Tree = 0
			return
		src << "Your view has changed, but you are still in the same spot."
		Skill_Tree = 1
		client.eye = locate(25,25,1)
		client.perspective = EYE_PERSPECTIVE
		Refresh_Skilltree()


/*	PlayerHairChange()
		var/list/Hairs = list("Normal"='Hairs.dmi')
		var/hairChoice = input("Choose your hair!","hair type") in Hairs
		var/color=input("Please select a color.") as color
		var/hairer = Hairs[hairChoice]
		hairer += color
*/
	report_bug(bug as message)
		// Bad players could easily write long and nasty bug reports\
		which can make the bug reports file too long. This stops them\
		by limiting their report's length to 3000 characters.
		if(length(bug) > 100)
			bug = copytext(bug,1,100)
		bug_reports += "* [html_encode(bug)] (reported by [ckey]) <br>"