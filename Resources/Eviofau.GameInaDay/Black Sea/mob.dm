mob

	Stat()
		if(src in players)
			statpanel("Stats:")
			stat("Plunder:",src.plunder)
			stat("Ship Health:",src.health)
			stat("Laser Charge:","[round(src.l_ammo*100/30)]%")
			stat("Rocket Ammo:",src.r_ammo)
		if(players.len)
			statpanel("Players")
			for(var/mob/m in players)
				stat("[m]:","[m.COLOR]")
		statpanel("Who")
		for(var/mob/m in world)
			stat("[m]")

	Move()
		if(src.can_move) ..()
		else return