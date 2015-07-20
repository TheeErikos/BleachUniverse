atom

	mouse_over_pointer='cursor.dmi'

	MouseDown()
		if(!game_started || !players.Find(usr)) return
		if(istype(src,/mob/))
			var/mob/m=src
			if(usr.weapon=="laser")
				if(usr.l_ammo)
					if(usr != m)
						missile(/obj/projectiles/laser,usr,m)
						if(prob(70))
							m.health-=rand(10,20)
							m.update_health()
							m.check_death(usr)
					usr.l_ammo--
				else usr<<{"<tt><span style="color:rgb(255,100,0);">Your laser battery is dead, let it recharge!</span></tt>"}
			if(usr.weapon=="rocket")
				if(usr.r_ammo)
					if(usr != m)
						missile(/obj/projectiles/rocket,usr,m)
						if(prob(90))
							m.health-=rand(30,40)
							m.update_health()
							m.check_death(usr)
					usr.r_ammo--
				else
					usr<<{"<tt><span style="color:rgb(255,100,0);">You are out of rocket ammo!</span></tt>"}
					usr<<{"<tt><span style="color:rgb(255,100,0);">Weapon set to laser.</span></tt>"}
					usr.weapon="laser"
		else
			if(usr.weapon=="laser")
				if(usr.l_ammo)
					missile(/obj/projectiles/laser,usr,src)
					usr.l_ammo--
				else usr<<{"<tt><span style="color:rgb(255,100,0);">Your laser battery is dead, let it recharge!</span></tt>"}
			if(usr.weapon=="rocket")
				if(usr.r_ammo)
					missile(/obj/projectiles/rocket,usr,src)
					usr.r_ammo--
				else
					usr<<{"<tt><span style="color:rgb(255,100,0);">You are out of rocket ammo!</span></tt>"}
					usr<<{"<tt><span style="color:rgb(255,100,0);">Weapon set to laser.</span></tt>"}
					usr.weapon="laser"