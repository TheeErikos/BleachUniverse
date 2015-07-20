mob
	Bump(obj/planet/p)
		if(!game_started || !players.Find(usr) || !istype(p,/obj/planet/)) return
		if(p.wealth)
			if(prob(10))
				var/damage=rand(20,30)
				src.loc=p.loc; src.can_move=0
				src<<{"<tt><span style="color:rgb(255,0,0);">You and your crew land on the planet, and are met with a hail of laser fire! The local military won't stand for piracy! Your ship has lost [damage] health!</span></tt><br>"}
				src.health-=damage; src.update_health(); src.check_death(); sleep(20)
				src<<{"<tt><span style="color:rgb(100,200,0);">Retreat!</span></tt><br>"}
				src.can_move=1
			else
				src.loc=p.loc; src.can_move=0
				src<<{"<tt><span style="color:rgb(50,100,200);">You and your crew land on the planet, plundering and burning every small village you come upon. Your crew has collected [p.wealth] plunder!</span></tt><br>"}
				src.plunder+=p.wealth; p.wealth=0; sleep(30)
				src<<{"<tt><span style="color:rgb(100,200,0);">Your ship is prepped and ready for takeoff!</span></tt><br>"}
				src.can_move=1
				p.rewealth()
		else
			src.loc=p.loc; src.can_move=0
			src<<{"<tt><span style="color:rgb(255,100,0);">You and your crew land on the planet, but find only ashes where settlements once stood! Someone has beaten you here!</span></tt><br>"}
			sleep(30)
			src<<{"<tt><span style="color:rgb(100,200,0);">Your ship is prepped and ready for takeoff!</span></tt><br>"}
			src.can_move=1