mob/proc

	SetRaceShinigami()
		usr.class = "Shinigami"
		usr.get_item(new /item/shinigarb())
		usr.abilities += new /Ability/ShikaiRelease()
		usr.abilities += new /Ability/BankaiRelease()

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