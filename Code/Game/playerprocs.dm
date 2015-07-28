mob/proc

	SetRaceShinigami()
		usr.class = "Shinigami"
		usr.get_item(new /item/ShinigamiRobe())
		usr.Activated_Skills += list("Shikai Release")

	PlayerZanCreate()
		usr.zcallout = input("What is your zanpakuto's callout?", "Text", zcallout)
		usr.zname = input("What do you want your zanpakuto's name to be?", "Name", zname)
		usr.haszan = 1


	CalcStats()
		usr.boostedattack = round(usr.normalattack * usr.bamult)
		usr.effectivespeed = round(normalspeed + boostedspeed)
		usr.effectiveattack = round(normalattack + boostedattack)
		usr.effectivedefense = round(normaldefense + boosteddefense)
		usr.effectivefocus = round(normalfocus + boostedfocus)
		usr.effectivecontrol = round(normalcontrol + boostedcontrol)

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
		usr.max_reiatsu = 1000

	UnlockSkills()