Skilltree
	parent_type = /obj
	icon = 'framework-hud.dmi'

	var
		reqpoints = 0
		reqlevel = 0
		unlocked_skills = list("Shikai Release")

	Click()

		if( (name in usr.Learned_Skills) )
			usr << "You have already learned this!"

		else if( !(name in usr.Activated_Skills) )
			usr <<"This skill is not available at this time."

		else if(usr.Skill_Points < reqpoints || usr.level < reqlevel)
			usr << "You don't have the requirements for this."

		else if( alert("Obtain [name] for [reqpoints] points?","Skill Obtain","Yes","No") == "Yes")
			usr << "You have obtained [name]!"
			usr.Learned_Skills += name
			for(var/A in unlocked_skills)
				if( !(A in usr.Activated_Skills) )
					usr.Activated_Skills += A
			usr.Skill_Points = max(0, usr.Skill_Points - reqpoints)
			usr.Refresh_Skilltree()


	Attack
		name = "Attack"
		icon_state = "Attack"
		reqpoints = 0

	Defend
		name = "Defend"
		icon_state = "Defence"
		reqpoints = 0

	Shikai
		name = "Shikai Release"
		icon_state = "ShikaiRelease"
		reqpoints = 25
		reqlevel = 100
		unlocked_skills = list("Bankai Release")

	Bankai
		name = "Bankai Release"
		icon_state = "BankaiRelease"
		reqpoints = 150
		reqlevel = 300

	Ress
		name = "Resurrecci�n"
		icon_state = "Ress"
		reqpoints = 0

	SRess
		name = "Segunda De Resurrecci�n Etapa"
		icon_state = "SRess"
		reqpoints = 0

turf
	Skilltree
		icon = 'framework-hud.dmi'
		Background
			icon_state = "Background"
		Left_Right
			icon_state = "Left - Right"
		Up_Down
			icon_state = "Up - Down"
