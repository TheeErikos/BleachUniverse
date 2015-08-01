var

		list/developers = list("dagilbert")

		bug_reports as text

		DevVerbList = list(/mob/proc/view_bugs, /mob/proc/SetExp, /mob/proc/KillMob, /mob/proc/GiveSkillPoints)

mob/proc

	DeveloperCommands()
		if(ckey in developers)
			src.verbs += DevVerbList
		else
			return

	PlayerChangeRace(raceto as text)
		if (raceto == "Shinigami")
			usr.class = "Shinigami"
			usr.Activated_Skills += list("Shikai Release")
			usr.isdead = 0
			usr.deadstatus = "Alive"
			usr.normalspeed += 1
			usr.normalattack += 25
			usr.normaldefense += 20
			usr.normalfocus += 25
			usr.normalcontrol += 15
			usr.shikaiat = rand(50, 120)
			usr.bankaiat = rand(400, 750)
		return

	PlayerZanCreate()
		usr.scallout = input("What is your zanpakuto's callout?", "Text", scallout)
		usr.sname = input("What do you want your zanpakuto's name to be?", "Name", sname)
		usr.zstyle = "zangetsu"
		usr.haszan = 1


	CalcStats()
		usr.boostedattack = round(usr.normalattack * usr.bamult)
		usr.boosteddefense = round(usr.normaldefense * usr.bdmult)
		usr.boostedcontrol = round(usr.normalcontrol * usr.bcmult)
		usr.boostedfocus = round(usr.normalfocus * usr.bfmult)
		usr.boostedspeed = round(usr.normalspeed * usr.bsmult)
		usr.effectivespeed = round(normalspeed + boostedspeed)
		usr.effectiveattack = round(normalattack + boostedattack)
		usr.effectivedefense = round(normaldefense + boosteddefense)
		usr.effectivefocus = round(normalfocus + boostedfocus)
		usr.effectivecontrol = round(normalcontrol + boostedcontrol)
		usr.setmaxhp()
		usr.setmaxrei()

	Refresh_Skilltree()
		for(var/image/I in client.images) if(I && I.tag == "Skilltree")
			del I
		for(var/Skilltree/S in oview(client.eye) )
			if( ! (S.name in src.Activated_Skills) )
				var/image/I = new('framework-hud.dmi',S.loc,"Unavailable",FLY_LAYER)
				I.tag = "Skilltree"
				client.images += I

	setmaxhp()
		usr.max_health = round(effectiveattack+effectivespeed+effectivedefense*1.5+effectiveattack+effectiveagility+effectiveaccuracy,1)

	setmaxrei()
		usr.max_reiatsu = round(effectivecontrol*2+effectivefocus*2+level*5)

	SkillsCheck()
		switch(x == usr.class)
			if ("Shinigami")
				if (usr.zstyle == "zangetsu" && usr.haszan == 1 && src.level >= 75)
					usr << "Zangetsu has taught you Getsuga Tenshou!"
			if ("Human")
				if (usr.class == "Human" && src.level >= 50)
					usr << "You feel your soul fluctuate"

	view_bugs()

		// Only developers can view bugs.
		if(!(ckey in developers))
			return

		// If no bugs were reported then there's\
		nothing to download.
		if(length(bug_reports) < 1)
			usr << "No bugs were reported during this session."
			return

		usr << browse("[bug_reports]","window=BugReports")

	download_bugs()
		if(!(ckey in developers))
			return

		if(length(bug_reports) < 1)
			usr << "No bugs were reported during this session."
			return

			// Send a .txt file with the bug report to \
			the developer.
		text2file(bug_reports,"bug reports.txt")
		var/timestamp = time2text(world.realtime,"DD-MM-YYYY")
		var/filetitle = "bug reports [timestamp].txt"
		usr << ftp("bug reports.txt",filetitle)

	SetExp(mob/m)
		var/gmnumber
		input("What level do you want to set to?", "GM WINDOW", gmnumber)
		m.gain_experience(gmnumber)

	KillMob(mob/m)
		m.injury = m.max_injury
		m.died()
		m.respawned()

	GiveSkillPoints(mob/m)
		m.Skill_Points += input("How many skill points does this mob want?", "Number", m.Skill_Points)

	TargetPaneUpdate()
		usr <<  output(null, "targetpane")
		if (usr.target)
			usr << output("Name: [usr.target.name]", "targetpane")
			usr << output("Spirit Power: [usr.target.health]", "targetpane")
			usr << output("Reiatsu: [usr.target.reiatsu]", "targetpane")
			usr << output("Attack: [usr.target.effectiveattack]", "targetpane")
			usr << output("Defense: [usr.target.effectivedefense]", "targetpane")
			usr << output("Focus: [usr.target.effectivefocus]", "targetpane")
			usr << output("Control: [usr.target.effectivecontrol]", "targetpane")
			usr << output("Speed: [usr.target.effectivespeed]", "targetpane")
		else
			return

	InjuryCalc()
		if (src.injury >= src.max_injury && src.class == "Human")
			world << "[src.name] has just died!"
			src.injury = 0
			src.class = "Soul"
			src.isdead = 1
