mob
	var
		SkillList[]

	proc
		setmaxhp()
			usr.max_health = round(effectiveattack+effectivespeed+effectivedefense+effectiveattack+effectiveagility+effectiveaccuracy,1)

		setmaxrei()
			usr.max_reiatsu = 1000

	verb
		ShowAvailableSkills()
			SkillList["One"] = 1
			src << SkillList["One"]