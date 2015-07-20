obj/spells // these are the actual spell icons that get created and moved around
	icon = 'spells.dmi'
	firebolt
		icon_state = "firebolt"
		layer = MOB_LAYER+1
	icebolt
		icon_state = "icebolt"
		layer = MOB_LAYER+1
	lightningbolt
		icon_state = "lightningbolt"
		layer = MOB_LAYER+1
	poisonbolt
		icon_state = "poisonbolt"
		layer = MOB_LAYER+1
	healing
		icon_state = "heal"
		layer = MOB_LAYER+1
	ghealing
		icon_state = "gheal"
		layer = MOB_LAYER+1
	manahealing
		icon_state = "manaheal"
		layer = MOB_LAYER+1
	gmanahealing
		icon_state = "gmanaheal"
		layer = MOB_LAYER+1
	bolt
		icon_state = "bolt"
		layer = MOB_LAYER+1
	warp
		icon_state = "warp"
		layer = MOB_LAYER+1
	boltboom
		icon_state = "boltboom"
		layer = MOB_LAYER+1
	poison
		icon_state = "poison"
		layer = MOB_LAYER+1
	darkbolt
		icon_state = "darkbolt"
		layer = MOB_LAYER+1
	demi
		icon_state = "demi"
		layer = MOB_LAYER+1
	ameliorate
		icon_state = "ameliorate"
		layer = MOB_LAYER+1

mob/players
	clespells // healing spells (cle is short for cleric, a class that was removed as rise of heroes progressed further along and I redid the character structure.)
		verb
			Healing()
				set category = "Spells"
				HealinG()
			Telekinesis()//obj/M as obj in oview(5) //this no longer uses that parameter, it gets whatever it feels like getting so that there is no GUI
				set category = "Spells"
				TelekinesiS()
			Warp(var/M in cities)
				set category = "Spells"
				WarP(M)
			Transform()
				set category = "Spells"
				var/transcost = 100-transformlevel
				if(transcost<0)
					transcost = 0
				if ( MP < transcost )
					usr << "Not enough MP"
				else
					MP -= transcost
					//here is where you pick your new icon
					src.icon = input("Choose an icon from your system","Your Icon") as icon
					src.icon_state = input("Type an icon state from that file","Your Icon State") as text
			Ameliorate()
				set category = "Spells"
				AmelioratE()


	proc/HealinG()
		if (MP <1+(healinglevel*2)) // make sure you have enough mp
			usr << "Not enough MP"
		else
			MP -= 1+(healinglevel*2) // take the mp cost
			//this J list, C var, and M reference counter stuff is to find the people who can be targets of this spell
			var/list/J[1]
			var/C = 1
			var/mob/players/M
			for(M as mob in view(5))
				if(istype(M,/mob/players))
					J[C] = M
					C++
					J.len++
			M = (input("Healing","Who") as mob in J) // pick one of those people
			if(healinglevel<25)
				missile(/obj/spells/healing,usr,M)
			else if(healinglevel>24) // use a cooler spell icon if healing is 25+
				missile(/obj/spells/ghealing,usr,M)
			sleep(get_dist(usr,M)) // wait the distance traveled before displaying the amount healed
			var/amount = round(((rand(2+(healinglevel*2),4+(healinglevel*3)))*((Intelligence/100)+1)),1) // healing amount calculations
			if (amount > (M.MAXHP-M.HP))
				amount = (M.MAXHP-M.HP) // only heal them to their maxhp, do not give them more.
			M.HP += amount // bam! you are healed.
			s_damage(M, amount, "yellow") // and now you know how much you were healed
			//this next line is deprecated by the above line
			//view(usr) << "[usr] cast Healing on [M]; <b>[amount] HP restored"
	proc/TelekinesiS()
		var/telecost = (30-telekinesislevel)
		if (telecost < 0)
			telecost = 0
		if (MP < telecost)
			usr << "Not enough MP"
		else
			MP -= telecost
			//this stuff is to find the nearby items to pick from
			var/list/J[1]
			var/C = 1
			var/obj/M
			for(M as obj in oview(5))
				if (istype(M,/obj/books) || istype(M,/obj/weapons) ||istype(M,/obj/items))
					J[C] = M
					C++
					J.len++
			M = (input("Telekinesis","Item") as obj in J) // pick one
			var/mob/players/P = usr
			if(M.type==/obj/items/cheesypoofs) // if its cheesypoofs
				var/D=0 // used to only check your inventory until you find cheesypoofs, this logic is poorly written and inefficient
				var/obj/items/o
				if(P.cheesyquest==0)
					for(o as obj in P.contents)
						if(o.type==/obj/items/cheesypoofs&&D==0)
							D=1
						else if(o.type==/obj/items/cheesypoofs)
							P << "You don't need that"
					if(D==0)
						M.Move(usr)
				else
					P << "You don't need that"
			else
				M.Move(usr)
	proc/WarP(M)
		var/warpcost = 50-(warplevel*2)
		if (warpcost < 0)
			warpcost = 0
		if (MP < warpcost)
			usr << "Not enough MP"
		else
			MP -= warpcost
			overlays += /obj/spells/warp // add the cool little color sparkles
			sleep(3) // wait a while
			//move based on which place was specified
			if(M=="Kishkan")
				usr.loc = locate(/turf/townin3)
				var/mob/players/A = usr
				A.location = "Kishkan"
			if(M=="Terrash")
				usr.loc = locate(/turf/townin21)
				var/mob/players/A = usr
				A.location = "Terrash"
			if(M=="Zenith")
				usr.loc = locate(/turf/townin31)
				var/mob/players/A = usr
				A.location = "Zenith"
			if(M=="Everwood")
				usr.loc = locate(/turf/townin004)
				var/mob/players/A = usr
				A.location = "Everwood"
			spawn(3) overlays -= /obj/spells/warp // get rid of the cool sparkles
			usr << sound('q5.mid',1,0,0) // change to town music
	proc/AmelioratE()
		if (MP <95+(amelioratelevel*5))
			usr << "Not enough MP"
		else
			MP -= 95+(amelioratelevel*5)
			var/mob/players/M
			for(M as mob in view(5)) // cast on everyone nearby
				if(istype(M,/mob/players)) // atleast just the players anyway
					missile(/obj/spells/ameliorate,usr,M) // visuals
					sleep(get_dist(usr,M)) // wait until the visual gets to them
					var/lifeleft = M.MAXHP-M.HP // used for calculation
					var/perc = round(((amelioratelevel)*((Intelligence/100)+1)),1) // calculate %
					if(perc>70) perc = 70 // only heal up to 70%
					var/amount = round(lifeleft*(perc/100),1) // set the number amount
					if (amount > (M.MAXHP-M.HP)) // make sure it isn't more than they need
						amount = (M.MAXHP-M.HP) // set it to what they need if it is
					M.HP += amount // healing time
					s_damage(M, amount, "yellow") // lovely numbers
					//no more poison either!
					M.poisonD=0
					M.poisoned=0
					M.poisonDMG=0
					M.overlays = null


	wizspells // other spells, evil damaging spells, bwahahahahahaha
		verb
			FireBolt()
				set category = "Spells"
				FireBolT()
			IceBolt()
				set category = "Spells"
				IceBolT()
			LightningBolt()
				set category = "Spells"
				LightningBolT()
			Flame()
				set category = "Spells"
				FlamE()
			ArcticWind()
				set category = "Spells"
				ArcticWinD()
			ChainLightning()
				set category = "Spells"
				ChainLightninG()
			Osmosis()
				set category = "Spells"
				OsmosiS()
			FeedBack()
				set category = "Spells"
				FeedBacK()
			Poison()
				set category = "Spells"
				PoisoN()
			Demi()
				set category = "Spells"
				DemI()
			Dark()
				set category = "Spells"
				DarK()


	proc/FireBolT()
		if (MP < 1+(fireboltlevel*2))
			usr << "Not enough MP"
		else // if you have enough MP
			//find the closest enemy
			var/list/J[1]
			var/C = 1
			var/mob/enemies/M
			for(M as mob in oview(3))
				if (istype(M,/mob/enemies))
					J[C] = M
					C++
					J.len++
			if(J[1]!=null) // if you found one
				MP -= 1+(fireboltlevel*2) // decrement MP by cost
				M = J[1] // reference to the enemy
				missile(/obj/spells/firebolt,usr,M) // visuals
				sleep(get_dist(usr,M)) // wait until the spell reaches the enemy
				var/damage = round(((rand(2+(fireboltlevel*2),4+(fireboltlevel*3)))*((Intelligence/100)+1)),1) // calculate dmg
				if(M) // exception catching, have to make sure that the enemy is still there
					if (M.firewk>0) // if it is weak against fire
						damage = round(damage*(1+(M.firewk/100)),1) // do more damage
					if (M.fireres>0) // if it has resistance to fire
						damage -= round(damage*(M.fireres/100),1) // do less damage
					M.HP -= damage // actually deal the damage
					s_damage(M, damage, "red") // and show it
					//usr << "You cast FireBolt for \blue[damage] damage"
					DeadEnemy(M) // checks to see if the enemy is dead

	proc/IceBolT()
		if (MP < 3+(iceboltlevel*2))
			usr << "Not enough MP"
		else
			var/list/J[1]
			var/C = 1
			var/mob/enemies/M
			for(M as mob in oview(4))
				if (istype(M,/mob/enemies))
					J[C] = M
					C++
					J.len++
			if(J[1]!=null)
				MP -= 3+(iceboltlevel*2)
				M = J[1]
				missile(/obj/spells/icebolt,usr,M)
				sleep(get_dist(usr,M))
				var/damage = round(((rand(1+(iceboltlevel*3),3+(iceboltlevel*3)))*((Intelligence/100)+1)),1)
				if(M)
					if (M.icewk>0)
						damage = round(damage*(1+(M.icewk/100)),1)
					if (M.iceres>0)
						damage -= round(damage*(M.iceres/100),1)
					M.HP -= damage
					s_damage(M, damage, "red")
					//usr << "You cast IceBolt for \blue[damage] damage"
					DeadEnemy(M)

	proc/LightningBolT()
		if (MP < 5+(lightningboltlevel*2))
			usr << "Not enough MP"
		else
			var/list/J[1]
			var/C = 1
			var/mob/enemies/M
			for(M as mob in oview(5))
				if (istype(M,/mob/enemies))
					J[C] = M
					C++
					J.len++
			if(J[1]!=null)
				MP -= 5+(lightningboltlevel*2)
				M = J[1]
				missile(/obj/spells/lightningbolt,usr,M)
				sleep(get_dist(usr,M))
				var/damage = round(((rand(1,round((10+(lightningboltlevel*10.72)),1)))*((Intelligence/100)+1)),1)
				if(M)
					if (M.litwk>0)
						damage = round(damage*(1+(M.litwk/100)),1)
					if (M.litres>0)
						damage -= round(damage*(M.litres/100),1)
					M.HP -= damage
					s_damage(M, damage, "red")
					//usr << "You cast LightningBolt for \blue[damage] damage"
					DeadEnemy(M)

	proc/FlamE()
		if (MP < 17+(flamelevel*3))
			usr << "Not enough MP"
		else
			var/testmonsters=0
			var/mob/enemies/M
			//check to make sure there is an enemy nearby
			for (M as mob in view(5))
				if (istype(M,/mob/enemies))
					testmonsters=1
			if(testmonsters==1) // if there is an enemy nearby
				MP -= 17+(flamelevel*3) // decrement MP by cost
				for (M as mob in view(4)) // visually shoot every enemy within 4
					if (istype(M,/mob/enemies))
						missile(/obj/spells/firebolt,usr,M)
				sleep(5) // wait for 5
				for (M as mob in view(4)) // for each of those enemies just shot
					if (istype(M,/mob/enemies)) // making sure it is an enemy to be sure
						var/damage = round(((rand(2+(flamelevel*2),4+(flamelevel*3)))*((Intelligence/100)+1)),1) // calculate the dmg
						if(M) // making sure it is still there to be sure
							//adjusting damage based on weaknesses and resistances
							if (M.firewk>0)
								damage = round(damage*(1+(M.firewk/100)),1)
							if (M.fireres>0)
								damage -= round(damage*(M.fireres/100),1)
							//deal the damage and show it
							M.HP -= damage
							s_damage(M, damage, "red")
							var/mob/enemies/J
							sleep(1)
							//everything within 2 of the hit enemy...
							for (J as mob in oview(M,2))
								if (istype(J,/mob/enemies))
									missile(/obj/spells/firebolt,M,J) // shoot at them too visually
							//everything within 2 of the hit enemy...
							//hit them with the fire spell as well
							for (J as mob in oview(M,2))
								if (istype(J,/mob/enemies))
									damage = round(((rand(2+(flamelevel*2),4+(flamelevel*3)))*((Intelligence/100)+1)),1)
									if(J)
										if (J.firewk>0)
											damage = round(damage*(1+(J.firewk/100)),1)
											J.HP -= damage
										else if (J.fireres>0)
											damage -= round(damage*(J.fireres/100),1)
											J.HP -= damage
										else
											J.HP -= damage
										s_damage(J, damage, "red")
										DeadEnemy(J) // checking each enemy in the second round
							DeadEnemy(M) // checking the original enemies
	proc/ArcticWinD()
		if (MP < 20+(arcticwindlevel*3))
			usr << "Not enough MP"
		else
			var/testmonsters=0
			var/mob/enemies/M
			for (M as mob in view(5))
				if (istype(M,/mob/enemies))
					testmonsters=1
			if(testmonsters==1) // making sure that there is atleast 1 monster nearby
				MP -= 20+(arcticwindlevel*3) // decrement MP by cost

				//lots of visual junk =]
				missile(/obj/spells/icebolt,usr,locate(usr.x,usr.y+5,usr.z))
				missile(/obj/spells/icebolt,usr,locate(usr.x,usr.y-5,usr.z))
				missile(/obj/spells/icebolt,usr,locate(usr.x+5,usr.y,usr.z))
				missile(/obj/spells/icebolt,usr,locate(usr.x-5,usr.y,usr.z))
				missile(/obj/spells/icebolt,usr,locate(usr.x+5,usr.y+5,usr.z))
				missile(/obj/spells/icebolt,usr,locate(usr.x-5,usr.y-5,usr.z))
				missile(/obj/spells/icebolt,usr,locate(usr.x+5,usr.y-5,usr.z))
				missile(/obj/spells/icebolt,usr,locate(usr.x-5,usr.y+5,usr.z))
				sleep(2)
				missile(/obj/spells/icebolt,locate(usr.x+5,usr.y,usr.z),locate(usr.x+3,usr.y+5,usr.z))
				missile(/obj/spells/icebolt,locate(usr.x-5,usr.y,usr.z),locate(usr.x-3,usr.y-5,usr.z))
				missile(/obj/spells/icebolt,locate(usr.x,usr.y-5,usr.z),locate(usr.x+5,usr.y-3,usr.z))
				missile(/obj/spells/icebolt,locate(usr.x,usr.y+5,usr.z),locate(usr.x-5,usr.y+3,usr.z))
				missile(/obj/spells/icebolt,locate(usr.x+1,usr.y-2,usr.z),locate(usr.x+2,usr.y+1,usr.z))
				missile(/obj/spells/icebolt,locate(usr.x-2,usr.y-1,usr.z),locate(usr.x+1,usr.y-2,usr.z))
				missile(/obj/spells/icebolt,locate(usr.x-1,usr.y+2,usr.z),locate(usr.x-2,usr.y-1,usr.z))
				missile(/obj/spells/icebolt,locate(usr.x+2,usr.y+1,usr.z),locate(usr.x-1,usr.y+2,usr.z))
				sleep(1)
				//for each enemy nearby
				for (M as mob in view(5))
					if (istype(M,/mob/enemies))
						//deal the calculated damage to it
						var/damage = round(((rand(3+(arcticwindlevel*3),4+(arcticwindlevel*3)))*((Intelligence/100)+1)),1)
						if(M)
							//change damage according to weakness/resistance
							if (M.icewk>0)
								damage = round(damage*(1+(M.icewk/100)),1)
							if (M.iceres>0)
								damage -= round(damage*(M.iceres/100),1)
							//deal the damage, show the damage, and check to see if the enemy is dead
							M.HP -= damage
							s_damage(M, damage, "red")
							DeadEnemy(M)
	proc/ChainLightninG()
		if (MP < 23+(chainlightninglevel*3))
			usr << "Not enough MP"
		else
			var/mob/enemies/M
			//make a list of all the nearby enemies
			var/K = 0
			var/list/J[24]
			for (M as mob in oview(6,usr))
				if(istype(M,/mob/enemies))
					K++
					J[K] = M
			if(K>0) // if theres atleast 1 enemy in that list
				var/mob/enemies/U = J[1] // reference it with U
				if(J[1]!=null&&istype(U,/mob/enemies)) // making sure it exists and is an enemy
					MP -= 23+(chainlightninglevel*3) // decrement MP by cost
					missile(/obj/spells/lightningbolt,usr,J[1]) // visually shoot it
					sleep(get_dist(usr,J[1])) // and wait until it gets there
					var/mob/enemies // references to the next enemies to attack
						U2;U3;U4;U5;
					var/damage = round(((rand(1,round((10+(chainlightninglevel*10.72)),1)))*((Intelligence/100)+1)),1) // damage calculation
					if(U) // if the enemy still exists
						//change dmg according to weaknesses/resistances
						if (U.litwk>0)
							damage = round(damage*(1+(U.litwk/100)),1)
						if (U.litres>0)
							damage -= round(damage*(U.litres/100),1)
						U.HP -= damage
						s_damage(U, damage, "red")
					//find the next enemy within 6 of the enemy just shot
					K=0
					for (M as mob in oview(6,U))
						if(istype(M,/mob/enemies))
							K++
							J[K] = M
					if(K>0) // if you found one
						//do the same thing to that one as well
						U2 = J[1]
						if(istype(U2,/mob/enemies))
							missile(/obj/spells/lightningbolt,U,J[1])
							sleep(get_dist(usr,J[1]))
							//calculate the damage for that one as well, the way this is done and then weaknesses applied in chain lightning could be a lot more efficient, oh well
							damage = round(((rand(1,round((10+(chainlightninglevel*10.72)),1)))*((Intelligence/100)+1)),1)
							if(U2)
								if (U2.litwk>0)
									damage = round(damage*(1+(U2.litwk/100)),1)
								if (U2.litres>0)
									damage -= round(damage*(U2.litres/100),1)
								U2.HP -= damage
								s_damage(U2, damage, "red")
							if(U)
								DeadEnemy(U)
						//keep finding the next enemy and so forth
						K=0
						for (M as mob in oview(6,U2))
							if(istype(M,/mob/enemies))
								K++
								J[K] = M
						if(K>0)
							U3 = J[1]
							if(istype(U3,/mob/enemies))
								missile(/obj/spells/lightningbolt,U2,J[1])
								sleep(get_dist(usr,J[1]))
								damage = round(((rand(1,round((10+(chainlightninglevel*10.72)),1)))*((Intelligence/100)+1)),1)
								if(U3)
									if (U3.litwk>0)
										damage = round(damage*(1+(U3.litwk/100)),1)
									if (U3.litres>0)
										damage -= round(damage*(U3.litres/100),1)
									U3.HP -= damage
									s_damage(U3, damage, "red")
								if(U2)
									DeadEnemy(U2)
							K=0
							for (M as mob in oview(6,U3))
								if(istype(M,/mob/enemies))
									K++
									J[K] = M
							if(K>0)
								U4 = J[1]
								if(istype(U4,/mob/enemies))
									missile(/obj/spells/lightningbolt,U3,J[1])
									sleep(get_dist(usr,J[1]))
									damage = round(((rand(1,round((10+(chainlightninglevel*10.72)),1)))*((Intelligence/100)+1)),1)
									if(U4)
										if (U4.litwk>0)
											damage = round(damage*(1+(U4.litwk/100)),1)
										if (U4.litres>0)
											damage -= round(damage*(U4.litres/100),1)
										U4.HP -= damage
										s_damage(U4, damage, "red")
									if(U3)
										DeadEnemy(U3)
								K=0
								for (M as mob in oview(6,U4))
									if(istype(M,/mob/enemies))
										K++
										J[K] = M
								if(K>0)
									U5 = J[1]
									if(istype(U5,/mob/enemies))
										missile(/obj/spells/lightningbolt,U4,J[1])
										sleep(get_dist(usr,J[1]))
										damage = round(((rand(1,round((10+(chainlightninglevel*10.72)),1)))*((Intelligence/100)+1)),1)
										if(U5)
											if (U5.litwk>0)
												damage = round(damage*(1+(U5.litwk/100)),1)
											if (U5.litres>0)
												damage -= round(damage*(U5.litres/100),1)
											U5.HP -= damage
											s_damage(U5, damage, "red")
											DeadEnemy(U5)
										if(U4)
											DeadEnemy(U4)
								else
									if(U4)
										DeadEnemy(U4)
							else
								if(U3)
									DeadEnemy(U3)
						else
							if(U2)
								DeadEnemy(U2)
					else
						if(U)
							DeadEnemy(U)
	proc/OsmosiS()
		if (HP < 15+(osmosislevel*5))
			usr << "Not enough HP"
		else
			//find the closes enemy
			var/list/J[1]
			var/C = 1
			var/mob/enemies/M
			for(M as mob in oview(5))
				if (istype(M,/mob/enemies))
					J[C] = M
					C++
					J.len++
			if(J[1]!=null) // if there is an enemy nearby
				HP-=15+(osmosislevel*5)
				s_damage(usr, 15+(osmosislevel*5), "red")
				M = J[1]
				var/amount = round(((rand(5+(osmosislevel*3),10+(osmosislevel*5)))*((Intelligence/100)+1)),1) // calculate amount
				if (amount > (M.MP))
					amount = (M.MP)
				if (amount < 0)
					amount = 0
				missile(/obj/spells/bolt,usr,M) // visual
				sleep(get_dist(usr,M)) // wait for the visual to get there
				s_damage(M, amount, "blue")
				M.MP -= amount // YOINK!
				var/damage = round((amount*(0.049*osmosislevel)),1) // calculate the damage you'll take from doing this
				if (damage < 0)
					damage = 0
				missile(/obj/spells/manahealing,M,usr) //visual
				sleep(get_dist(M,usr)) // wait for the visual to get there
				if (damage > (MAXMP-MP))
					amount = (MAXMP-MP)
				if (damage < 0)
					damage = 0
				MP += damage // ahhhhhh more mp!
				s_damage(usr, damage, "greenyellow")
				if (MP > MAXMP)
					MP = MAXMP
	proc/FeedBacK()
		if (MP < 15+(feedbacklevel*5))
			usr << "Not enough MP"
		else
			var/list/J[1]
			var/C = 1
			var/mob/enemies/M
			for(M as mob in oview(5))
				if (istype(M,/mob/enemies))
					J[C] = M
					C++
					J.len++
			if(J[1]!=null)
				MP-=15+(feedbacklevel*5)
				M = J[1]
				var/amount = round(((rand(5+(feedbacklevel*3),10+(feedbacklevel*5)))*((Intelligence/100)+1)),1)
				if (amount > (M.MP))
					amount = (M.MP)
				if (amount < 0)
					amount = 0
				missile(/obj/spells/bolt,usr,M)
				sleep(get_dist(usr,M))
				s_damage(M, amount, "blue")
				M.MP -= amount
				var/damage = round((amount*(0.092*feedbacklevel)),1)
				if (damage < 0)
					damage = 0
				M.overlays += /obj/spells/boltboom
				spawn(5)
					M.overlays = null
					M.HP -= damage
					s_damage(M, damage, "red")
					DeadEnemy(M)
	proc/PoisoN()
		if (MP < round(14*sqrt(poisonlevel),1))
			usr << "Not enough MP"
		else
			var/list/J[1]
			var/C = 1
			var/mob/enemies/M
			for(M as mob in oview(5))
				if (istype(M,/mob/enemies))
					J[C] = M
					C++
					J.len++
			if(J[1]!=null)
				MP -= round(14*sqrt(poisonlevel),1)
				M = J[1]
				missile(/obj/spells/poisonbolt,usr,M)
				sleep(get_dist(usr,M))
				M.overlays += /obj/spells/poison
				var/D = round(4+(poisonlevel/2),1) // duration
				while(D>0)
					//this damage calculation should probably be outside of the loop, meh, inefficient, whatever. it is what it is.
					var/damage = round( rand(10*(sqrt(poisonlevel*((Intelligence/100)+1))),13*(sqrt(poisonlevel*((Intelligence/100)+1)))) , 1)
					if (M.poiswk>0)
						damage = round(damage*(1+(M.poiswk/100)),1)
					if (M.poisres>0)
						damage -= round(damage*(M.poisres/100),1)
					M.HP -= damage
					s_damage(M, damage, "red")
					sleep(10)
					DeadEnemy(M)
					D--
				if(M)
					M.overlays = null
	proc/DarK() // just like the other bolts, but strength based
		if (MP < 9+(darklevel*2))
			usr << "Not enough MP"
		else
			var/list/J[1]
			var/C = 1
			var/mob/enemies/M
			for(M as mob in oview(4))
				if (istype(M,/mob/enemies))
					J[C] = M
					C++
					J.len++
			if(J[1]!=null)
				MP -= 9+(darklevel*2)
				M = J[1]
				missile(/obj/spells/darkbolt,usr,M)
				sleep(get_dist(usr,M))
				var/damage = round(((rand(10+(darklevel*2),16+(darklevel*3)))*((Strength/100)+1)),1) // calculation based on strength
				if(M)
					if (M.darkwk>0)
						damage = round(damage*(1+(M.darkwk/100)),1)
					if (M.darkres>0)
						damage -= round(damage*(M.darkres/100),1)
					M.HP -= damage
					s_damage(M, damage, "red")
					DeadEnemy(M)
	proc/DemI()
		if (MP < round(24*(sqrt(demilevel)),1))
			usr << "Not enough MP"
		else
			var/list/J[1]
			var/C = 1
			var/mob/enemies/M
			for(M as mob in oview(5))
				if (istype(M,/mob/enemies))
					J[C] = M
					C++
					J.len++
			if(J[1]!=null) // making sure that there is an enemy nearby
				MP -= round(24*(sqrt(demilevel)),1) // decrementing mp according to cost
				for(M as mob in oview(5)) // casting demi on everything within 5
					if (istype(M,/mob/enemies)) // if it is an enemy of course
						missile(/obj/spells/demi,usr,M) // visuals
						sleep(get_dist(usr,M))
						var/perc = round(rand(((sqrt(demilevel*Strength))/2),((sqrt(demilevel*Strength))/1.4)),1) // calculate percent
						if(perc>70)
							perc=70
						var/damage = M.HP * (perc/100) // calculate the damage
						if(M) // gotta make sure that it is still there
							if (M.darkwk>0)
								damage = round(damage*(1+(M.darkwk/100)),1)
							if (M.darkres>0)
								damage -= round(damage*(M.darkres/100),1)
							if(damage<0)
								damage = 0
							if(damage>M.MAXHP)
								damage = M.MAXHP-1
							var/reduced = round(M.MAXHP*((75-(0.5*demilevel))/100),1)
							if(reduced<=round(M.MAXMP*0.1,1))
								reduced = round(M.MAXMP*0.1,1)
							if(M.HP<=reduced)
								damage = 0
							M.HP -= damage
							s_damage(M, damage, "red")
							DeadEnemy(M)

