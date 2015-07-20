//the way this works is just weird.  this was one of the first things I wrote with byond.  i wouldn't suggest using this method for equipping, calculating damage, and stuff.
//i'm not even going to comment this much; it's just too ugly.

mob
	var
		Wequipped = 0
		Aequipped = 0
		Sequipped = 0
		tempdefense = 0
		tempevade = 0
		tempdamagemin = 1
		tempdamagemax = 2
		tempstr = 1

obj
	var/sellvalue
	//the books aren't so bad, use a book, gain a level in that spell, each one has a calculated intelligence requirement
	//pretty simple
	books
		icon = 'books.dmi'
		var
			intreq
		verb
			Get()
				set category = "Temporary"
				set src in oview(0)
				src.Move(usr)
			Drop()
				set category = null
				set src in usr
				if(src.suffix == "Equipped")
					usr << "Un-equip [src] first!"
				else
					src.Move(usr.loc)
		firebolt
			name = "Book of FireBolt"
			icon_state = "red"
			sellvalue = 200
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.fireboltlevel*3)+2
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/FireBolt
					M.fireboltlevel+=1
					usr << "\green<b>You learned FireBolt Level [M.fireboltlevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of FireBolt, you need [(M.fireboltlevel*3)+2] intelligence."
		icebolt
			name = "Book of IceBolt"
			icon_state = "blue"
			sellvalue = 250
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = round(((M.iceboltlevel*3.2)+1),1)
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/IceBolt
					M.iceboltlevel+=1
					usr << "\green<b>You learned IceBolt Level [M.iceboltlevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of IceBolt, you need [round(((M.iceboltlevel*3.2)+1),1)] intelligence."
		lightningbolt
			name = "Book of LightningBolt"
			icon_state = "yellow"
			sellvalue = 300
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = round(((M.lightningboltlevel*3.7)+3),1)
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/LightningBolt
					M.lightningboltlevel+=1
					usr << "\green<b>You learned LightningBolt Level [M.lightningboltlevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of LightningBolt, you need [round(((M.lightningboltlevel*3.7)+3),1)] intelligence."
		healing
			name = "Book of Healing"
			icon_state = "heal"
			sellvalue = 200
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.healinglevel*3)+2
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/clespells/verb/Healing
					M.healinglevel+=1
					usr << "\green<b>You learned Healing Level [M.healinglevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Healing, you need [(M.healinglevel*3)+2] intelligence."
		telekinesis
			name = "Book of Telekinesis"
			icon_state = "gray"
			sellvalue = 500
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.telekinesislevel*4)+4
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/clespells/verb/Telekinesis
					M.telekinesislevel+=1
					usr << "\green<b>You learned Telekinesis Level [M.telekinesislevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Telekinesis, you need [(M.telekinesislevel*4)+4] intelligence."
		warp
			name = "Book of Warp"
			icon_state = "gray"
			sellvalue = 1000
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.warplevel*5)+5
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/clespells/verb/Warp
					M.warplevel+=1
					usr << "\green<b>You learned Warp Level [M.warplevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Warp, you need [(M.warplevel*5)+5] intelligence."
		ameliorate
			name = "Book of Ameliorate"
			icon_state = "heal"
			sellvalue = 4000
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.amelioratelevel*12)+8
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/clespells/verb/Ameliorate
					M.amelioratelevel+=1
					usr << "\green<b>You learned Ameliorate Level [M.amelioratelevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Ameliorate, you need [(M.amelioratelevel*12)+8] intelligence."


		flame
			name = "Book of Flame"
			icon_state = "red"
			sellvalue = 1000
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.flamelevel*4)+8
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/Flame
					M.flamelevel+=1
					usr << "\green<b>You learned Flame Level [M.flamelevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Flame, you need [(M.flamelevel*4)+8] intelligence."
		arcticwind
			name = "Book of ArcticWind"
			icon_state = "blue"
			sellvalue = 1250
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.arcticwindlevel*4)+8
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/ArcticWind
					M.arcticwindlevel+=1
					usr << "\green<b>You learned ArcticWind Level [M.arcticwindlevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of ArcticWind, you need [(M.arcticwindlevel*4)+8] intelligence."
		chainlightning
			name = "Book of ChainLightning"
			icon_state = "yellow"
			sellvalue = 1500
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.chainlightninglevel*4)+8
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/ChainLightning
					M.chainlightninglevel+=1
					usr << "\green<b>You learned ChainLightning Level [M.chainlightninglevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of ChainLightning, you need [(M.chainlightninglevel*4)+8] intelligence."
		osmosis
			name = "Book of Osmosis"
			icon_state = "heal"
			sellvalue = 3000
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.osmosislevel*10)+10
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/Osmosis
					M.osmosislevel+=1
					usr << "\green<b>You learned Osmosis Level [M.osmosislevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Osmosis, you need [(M.osmosislevel*10)+10] intelligence."
		feedback
			name = "Book of FeedBack"
			icon_state = "gray"
			sellvalue = 3000
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.feedbacklevel*10)+10
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/FeedBack
					M.feedbacklevel+=1
					usr << "\green<b>You learned FeedBack Level [M.feedbacklevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of FeedBack, you need [(M.feedbacklevel*10)+10] intelligence."
		poison
			name = "Book of Poison"
			icon_state = "green"
			sellvalue = 2500
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = round(5*sqrt(M.poisonlevel),1)
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/Poison
					M.poisonlevel+=1
					usr << "\green<b>You learned Poison Level [M.poisonlevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Poison, you need [round(5*sqrt(M.poisonlevel),1)] intelligence."
		dark
			name = "Book of Dark"
			icon_state = "black"
			sellvalue = 2500
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = (M.darklevel*2)+10
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/Dark
					M.darklevel+=1
					usr << "\green<b>You learned Dark Level [M.darklevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Dark, you need [(M.darklevel*2)+10] intelligence."
		demi
			name = "Book of Demi"
			icon_state = "black"
			sellvalue = 5500
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/M = usr
				intreq = round(25*sqrt(M.demilevel),1)
				if (M.Intelligence >= intreq)
					usr.verbs+=new/mob/players/wizspells/verb/Demi
					M.demilevel+=1
					usr << "\green<b>You learned Demi Level [M.demilevel]!"
					del src
				else
					usr << "<font color = teal>To use this Book of Demi, you need [round(25*sqrt(M.demilevel),1)] intelligence."
	items
		//the items are also not so bad, the Get() has checks for cheesypoofs quest though
		icon = 'items.dmi'
		var
			amount
			description
		verb/Description()
			set category = null
			set src in usr
			usr << src.description
		verb
			Get()
				set category = "Temporary"
				set src in oview(0)
				var/mob/players/M = usr
				if(src.type==/obj/items/cheesypoofs)
					var/C=0
					var/obj/items/o
					if(M.cheesyquest==0)
						for(o as obj in M.contents)
							if(o.type==/obj/items/cheesypoofs&&C==0)
								C=1
							else if(o.type==/obj/items/cheesypoofs)
								M << "You don't need that"
						if(C==0)
							src.Move(usr)
					else
						M << "You don't need that"
				else
					src.Move(usr)
			Drop()
				set category = null
				set src in usr
				if(src.suffix == "Equipped")
					usr << "<font color = teal>Un-equip [src] first!"
				else
					src.Move(usr.loc)
		proc/usingheal(var/obj/items/J,amount)
			var/mob/players/M
			M = usr
			if (amount > (M.MAXHP-M.HP))
				amount = (M.MAXHP-M.HP)
			M.HP += amount
			usr << "You used a [J]; <b>[amount] HP restored"
			Del(src)
		proc/usingmana(var/obj/items/J,amount)
			var/mob/players/M
			M = usr
			if (amount > (M.MAXMP-M.MP))
				amount = (M.MAXMP-M.MP)
			M.MP += amount
			usr << "You used a [J]; <b>[amount] MP restored"
			Del(src)
		cheesypoofs
			name = "CHEESY POOFS"
			icon_state = "cheesypoofs"
			description = "<b>CHEESY POOFS</b>  I think Cartman wanted these..."
			sellvalue = 0
		antidote
			name = "Antidote"
			icon_state = "antidote"
			sellvalue = 2500
			description = "<b>Antidote</b>  Cures poison"
			verb/Use()
				set category = null
				set src in usr
				var/mob/players/P = usr
				P.poisonD=0
				P.poisoned=0
				P.poisonDMG=0
				P.overlays = null
				usr << "You used an Antidote; <b> Poison cured"
				Del(src)
		healingpot
			name = "Potion of Healing"
			icon_state = "healingpot"
			sellvalue = 25
			description = "<b>Potion of Healing</b>  Restores up to 50 HP"
			verb/Use()
				set category = null
				set src in usr
				usingheal(src,50)
		manapot
			name = "Potion of Mana"
			icon_state = "manapot"
			sellvalue = 25
			description = "<b>Potion of Mana</b>  Restores up to 50 MP"
			verb/Use()
				set category = null
				set src in usr
				usingmana(src,50)
		greaterhealingpot
			name = "Greater Potion of Healing"
			icon_state = "greaterhealingpot"
			sellvalue = 125
			description = "<b>Greater Potion of Healing</b>  Restores up to 250 HP"
			verb/Use()
				set category = null
				set src in usr
				usingheal(src,250)
		greatermanapot
			name = "Greater Potion of Mana"
			icon_state = "greatermanapot"
			sellvalue = 125
			description = "<b>Greater Potion of Mana</b>  Restores up to 250 MP"
			verb/Use()
				set category = null
				set src in usr
				usingmana(src,250)
		healingtonic
			name = "Healing Tonic"
			icon_state = "healingtonic"
			sellvalue = 250
			description = "<b>Healing Tonic</b>  Restores up to 500 HP"
			verb/Use()
				set category = null
				set src in usr
				usingheal(src,500)
		manatonic
			name = "Mana Tonic"
			icon_state = "manatonic"
			sellvalue = 250
			description = "<b>Mana Tonic</b>  Restores up to 500 MP"
			verb/Use()
				set category = null
				usingmana(src,500)
		greaterhealingtonic
			name = "Greater Healing Tonic"
			icon_state = "greaterhealingtonic"
			sellvalue = 1000
			description = "<b>Greater Healing Tonic</b>  Restores up to 2000 HP"
			verb/Use()
				set category = null
				set src in usr
				usingheal(src,2000)
		greatermanatonic
			name = "Greater Mana Tonic"
			icon_state = "greatermanatonic"
			sellvalue = 1000
			description = "<b>Greater Mana Tonic</b>  Restores up to 2000 MP"
			verb/Use()
				set category = null
				set src in usr
				usingmana(src,2000)
		healingremedy
			name = "Healing Remedy"
			icon_state = "healingremedy"
			sellvalue = 2500
			description = "<b>Healing Remedy</b>  Restores up to 5000 HP"
			verb/Use()
				set category = null
				set src in usr
				usingheal(src,5000)
		manaremedy
			name = "Mana Remedy"
			icon_state = "manaremedy"
			sellvalue = 2500
			description = "<b>Mana Remedy</b>  Restores up to 5000 MP"
			verb/Use()
				set category = null
				usingmana(src,5000)
		greaterhealingremedy
			name = "Greater Healing Remedy"
			icon_state = "greaterhealingremedy"
			sellvalue = 5000
			description = "<b>Greater Healing Remedy</b>  Restores up to 10000 HP"
			verb/Use()
				set category = null
				set src in usr
				usingheal(src,10000)
		greatermanaremedy
			name = "Greater Mana Remedy"
			icon_state = "greatermanaremedy"
			sellvalue = 5000
			description = "<b>Greater Mana Remedy</b>  Restores up to 10000 MP"
			verb/Use()
				set category = null
				set src in usr
				usingmana(src,10000)
	weapons
		//yeah, this gets pretty wild
		icon = 'weapons.dmi'
		var
			//these first vars are for the description of the item
			adds = ""
			adds2 = ""
			of = ""
			adj = ""
			color = ""
			add = 0
			add2 = 0
			description = ""
			typi = ""
			olditem = 0
			//these vars are for actual variables on the items that affect gameplay
			twohanded = 0
			strreq = 0
			wpnspd = 0
			Adefense
			Aevade
			DamageMin = 0
			DamageMax = 0
			STRbonus = 0
			INTbonus = 0
			HPbonus = 0
			MPbonus = 0
			FIREres = 0
			ICEres = 0
			LITres = 0
			POISres = 0
			DARKres = 0
			FIREBOLTbonus = 0
			ICEBOLTbonus = 0
			LIGHTNINGBOLTbonus = 0
			HEALINGbonus = 0
			POISONbonus = 0
			DARKbonus = 0
			FLAMEbonus = 0
			ARCTICWINDbonus = 0
			CHAINLIGHTNINGbonus = 0
			OSMOSISbonus = 0
			FEEDBACKbonus = 0
			DEMIbonus = 0
			wlvl
		New() //this is the wacked out logic that controls creating random items, this is pretty cool, this function is fired for magic items
			if(usr.contents!=null)
				src.sellvalue*=2 // magic items sell for twice as much
				//lots of switches and random number generations in order to pick based on weapon level (wlvl) and probabilities
				var
					A;B;C;
				A = rand(1,3)
				if(A==1||A==2)
					C = rand(1,3)
					if(C == 1)
						color = "red"
					if(C == 2)
						color = "blue"
					if(C == 3)
						color = "yellow"
					icon_state = "[color][icon_state]"
					if(color=="red")
						var/D = rand(1,2)
						switch(D)
							if(1)
								switch(wlvl)
									if(1)
										add = rand(1,5)
										src.of = " of Strength"
									if(2)
										add = rand(6,10)
										src.of = " of Might"
									if(3)
										add = rand(11,15)
										src.of = " of Power"
									if(4)
										add = rand(16,20)
										src.of = " of Vitality"
									if(5)
										add = rand(21,25)
										src.of = " of Vigor"
								src.adds = ", +[add] Strength"
								src.STRbonus = add
							if(2)
								switch(wlvl)
									if(1)
										add = rand(1,4)
										src.of = " of Firebolt"
										src.adds = ", +[add] Firebolt"
										src.FIREBOLTbonus = add
									if(2)
										add = rand(5,8)
										src.of = " of Firebolt"
										src.adds = ", +[add] Firebolt"
										src.FIREBOLTbonus = add
									if(3)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(9,16)
												src.of = " of Firebolt"
												src.adds = ", +[add] Firebolt"
												src.FIREBOLTbonus = add
											if(2)
												add = rand(5,8)
												src.of = " of Flame"
												src.adds = ", +[add] Flame"
												src.FLAMEbonus = add
									if(4)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(17,32)
												src.of = " of Firebolt"
												src.adds = ", +[add] Firebolt"
												src.FIREBOLTbonus = add
											if(2)
												add = rand(9,16)
												src.of = " of Flame"
												src.adds = ", +[add] Flame"
												src.FLAMEbonus = add
									if(5)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(33,64)
												src.of = " of Firebolt"
												src.adds = ", +[add] Firebolt"
												src.FIREBOLTbonus = add
											if(2)
												add = rand(17,32)
												src.of = " of Flame"
												src.adds = ", +[add] Flame"
												src.FLAMEbonus = add
					else if(color=="blue")
						var/D = rand(1,2)
						switch(D)
							if(1)
								switch(wlvl)
									if(1)
										add = rand(1,5)
										src.of = " of Intelligence"
									if(2)
										add = rand(6,10)
										src.of = " of Knowledge"
									if(3)
										add = rand(11,15)
										src.of = " of Learning"
									if(4)
										add = rand(16,20)
										src.of = " of Comprehension"
									if(5)
										add = rand(21,25)
										src.of = " of Understanding"
								src.adds = ", +[add] Intelligence"
								src.INTbonus = add
							if(2)
								switch(wlvl)
									if(1)
										add = rand(1,4)
										src.of = " of Icebolt"
										src.adds = ", +[add] Icebolt"
										src.ICEBOLTbonus = add
									if(2)
										add = rand(5,8)
										src.of = " of Icebolt"
										src.adds = ", +[add] Icebolt"
										src.ICEBOLTbonus = add
									if(3)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(9,16)
												src.of = " of Icebolt"
												src.adds = ", +[add] Icebolt"
												src.ICEBOLTbonus = add
											if(2)
												add = rand(5,8)
												src.of = " of ArcticWind"
												src.adds = ", +[add] ArcticWind"
												src.ARCTICWINDbonus = add
									if(4)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(17,32)
												src.of = " of Icebolt"
												src.adds = ", +[add] Icebolt"
												src.ICEBOLTbonus = add
											if(2)
												add = rand(9,16)
												src.of = " of ArcticWind"
												src.adds = ", +[add] ArcticWind"
												src.ARCTICWINDbonus = add
									if(5)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(33,64)
												src.of = " of Icebolt"
												src.adds = ", +[add] Icebolt"
												src.ICEBOLTbonus = add
											if(2)
												add = rand(17,32)
												src.of = " of ArcticWind"
												src.adds = ", +[add] ArcticWind"
												src.ARCTICWINDbonus = add
					else if(color=="yellow")
						var/D = rand(1,2)
						switch(D)
							if(1)
								switch(wlvl)
									if(1)
										add = rand(1,4)
										src.of = " of Light"
									if(2)
										add = rand(5,8)
										src.of = " of Dawn"
									if(3)
										add = rand(9,12)
										src.of = " of Day"
									if(4)
										add = rand(16,20)
										src.of = " of Twilight"
									if(5)
										add = rand(21,25)
										src.of = " of the Stars"
								src.adds = ", +[add] Intelligence, +[add] Strength"
								src.STRbonus = add
								src.INTbonus = add
							if(2)
								switch(wlvl)
									if(1)
										add = rand(1,4)
										src.of = " of LightningBolt"
										src.adds = ", +[add] LightningBolt"
										src.LIGHTNINGBOLTbonus = add
									if(2)
										add = rand(5,8)
										src.of = " of LightningBolt"
										src.adds = ", +[add] LightningBolt"
										src.LIGHTNINGBOLTbonus = add
									if(3)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(9,16)
												src.of = " of LightningBolt"
												src.adds = ", +[add] LightningBolt"
												src.LIGHTNINGBOLTbonus = add
											if(2)
												add = rand(5,8)
												src.of = " of ChainLightning"
												src.adds = ", +[add] ChainLightning"
												src.CHAINLIGHTNINGbonus = add
									if(4)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(17,32)
												src.of = " of LightningBolt"
												src.adds = ", +[add] LightningBolt"
												src.LIGHTNINGBOLTbonus = add
											if(2)
												add = rand(9,16)
												src.of = " of ChainLightning"
												src.adds = ", +[add] ChainLightning"
												src.CHAINLIGHTNINGbonus = add
									if(5)
										var/F = rand(1,2)
										switch(F)
											if(1)
												add = rand(33,64)
												src.of = " of LightningBolt"
												src.adds = ", +[add] LightningBolt"
												src.LIGHTNINGBOLTbonus = add
											if(2)
												add = rand(17,32)
												src.of = " of ChainLightning"
												src.adds = ", +[add] ChainLightning"
												src.CHAINLIGHTNINGbonus = add
				if(A==2||A==3)
					var/D = rand(1,2)
					switch(D)
						if(1)
							B = rand(1,6)
							switch(B)
								if(1)
									switch(wlvl)
										if(1)
											add2 = rand(1,4)
											adj = "Red "
										if(2)
											add2 = rand(5,8)
											adj = "Red "
										if(3)
											add2 = rand(9,12)
											adj = "Ruby "
										if(4)
											add2 = rand(13,16)
											adj = "Ruby "
										if(5)
											add2 = rand(17,20)
											adj = "Rose "
									src.adds2 = ", +[add2] Fire Resistance"
									src.FIREres = add2
								if(2)
									switch(wlvl)
										if(1)
											add2 = rand(1,4)
											adj = "Blue "
										if(2)
											add2 = rand(5,8)
											adj = "Blue "
										if(3)
											add2 = rand(9,12)
											adj = "Sapphire "
										if(4)
											add2 = rand(13,16)
											adj = "Sapphire "
										if(5)
											add2 = rand(17,20)
											adj = "Indigo "
									src.adds2 = ", +[add2] Ice Resistance"
									src.ICEres = add2
								if(3)
									switch(wlvl)
										if(1)
											add2 = rand(1,4)
											adj = "Yellow "
										if(2)
											add2 = rand(5,8)
											adj = "Yellow "
										if(3)
											add2 = rand(9,12)
											adj = "Amber "
										if(4)
											add2 = rand(13,16)
											adj = "Amber "
										if(5)
											add2 = rand(17,20)
											adj = "Lemon "
									src.adds2 = ", +[add2] Lightning Resistance"
									src.LITres = add2
								if(4)
									switch(wlvl)
										if(1)
											add2 = rand(1,4)
											adj = "Green "
										if(2)
											add2 = rand(5,8)
											adj = "Green "
										if(3)
											add2 = rand(9,12)
											adj = "Emerald "
										if(4)
											add2 = rand(13,16)
											adj = "Emerald "
										if(5)
											add2 = rand(17,20)
											adj = "Lime "
									src.adds2 = ", +[add2] Poison Resistance"
									src.POISres = add2
								if(5)
									switch(wlvl)
										if(1)
											add2 = rand(1,4)
											adj = "Black "
										if(2)
											add2 = rand(5,8)
											adj = "Black "
										if(3)
											add2 = rand(9,12)
											adj = "Ebony "
										if(4)
											add2 = rand(13,16)
											adj = "Ebony "
										if(5)
											add2 = rand(17,20)
											adj = "Coal "
									src.adds2 = ", +[add2] Dark Resistance"
									src.DARKres = add2
								if(6)
									switch(wlvl)
										if(1)
											add2 = rand(1,4)
											adj = "Sparkling "
										if(2)
											add2 = rand(5,8)
											adj = "Sparkling "
										if(3)
											add2 = rand(9,12)
											adj = "Twinkling "
										if(4)
											add2 = rand(13,16)
											adj = "Twinkling "
										if(5)
											add2 = rand(17,20)
											adj = "Shimmering "
									src.adds2 = ", +[add2] All Resistances"
									src.FIREres = add2
									src.ICEres = add2
									src.LITres = add2
									src.POISres = add2
									src.DARKres = add2
						if(2)
							var/E = rand(1,2)
							switch(E)
								if(1)
									switch(wlvl)
										if(1)
											add2 = rand(1,30)
											adj = "Fox's "
										if(2)
											add2 = rand(31,80)
											adj = "Wolf's "
										if(3)
											add2 = rand(81,150)
											adj = "Tiger's "
										if(4)
											add2 = rand(151,300)
											adj = "Bear's "
										if(5)
											add2 = rand(301,800)
											adj = "Mammoth's "
									src.adds2 = ", +[add2] HP"
									src.HPbonus = add2
								if(2)
									switch(wlvl)
										if(1)
											add2 = rand(1,30)
											adj = "Snake's "
										if(2)
											add2 = rand(31,80)
											adj = "Serpent's "
										if(3)
											add2 = rand(81,150)
											adj = "Drake's "
										if(4)
											add2 = rand(151,300)
											adj = "Dragon's "
										if(5)
											add2 = rand(301,800)
											adj = "Wyrm's "
									src.adds2 = ", +[add2] MP"
									src.MPbonus = add2

					src.adj = "[adj]"
				src.name = "[adj][name][src.of]"
				if (typi=="weapon"&&twohanded==0)
					src.description = "<font color = navy><b>[src.name]:</b> [src.DamageMin]-[src.DamageMax] Damage[adds][adds2], [src.strreq] strength required, SellValue: [src.sellvalue]"
				else if (typi=="weapon"&&twohanded==1)
					src.description = "<font color = navy><b>[src.name]:</b> [src.DamageMin]-[src.DamageMax] Damage, two-handed[adds][adds2], [src.strreq] strength required, SellValue: [src.sellvalue]"
				else if (typi=="armor" || typi=="shield")
					src.description = "<font color = navy><b>[src.name]:</b> [Adefense] Defense, [Aevade]% Evade[adds][adds2], [src.strreq] strength required, SellValue: [src.sellvalue]"

				//world << "[src.STRbonus] STR [src.INTbonus] INT [src.FIREres] FIRE [src.ICEres] ICE [src.LITres] LIT [src.POISres] POIS [src.DARKres] DARK"
		//verbs to get items, description, equipping, etc on right click
		//the way i handled the equipping and changing of variables is a little wacked out, i don't like it much, but here it is
		verb/Description()
			set category = null
			set src in usr
			usr << src.description
		verb/Get()
			set category = "Temporary"
			set src in oview(0)
			src.Move(usr)
		verb/Equip()
			set category = null
			set src in usr
			if(src.suffix=="Equipped")
				usr << "<font color = teal>That's already equipped!"
			else
				if ((typi=="weapon")&&(twohanded==0))
					if (usr.tempstr>=src.strreq)
						if(usr.Wequipped==0)
							src.suffix+="Equipped"
							usr.Wequipped = 1
							usr.tempdamagemin += src.DamageMin
							usr.tempdamagemax += src.DamageMax
							var/mob/players/M = usr
							M.attackspeed -= src.wpnspd
							M.Strength += src.STRbonus
							M.Intelligence += src.INTbonus
							M.HP += src.HPbonus
							M.MP += src.MPbonus
							M.MAXHP += src.HPbonus
							M.MAXMP += src.MPbonus
							M.Fireres += src.FIREres
							M.Iceres += src.ICEres
							M.Litres += src.LITres
							M.Poisres += src.POISres
							M.Darkres += src.DARKres
							M.fireboltlevel += src.FIREBOLTbonus
							M.iceboltlevel += src.ICEBOLTbonus
							M.lightningboltlevel += src.LIGHTNINGBOLTbonus
							M.healinglevel += src.HEALINGbonus
							M.poisonlevel += src.POISONbonus
							M.darklevel += src.DARKbonus
							M.flamelevel += src.FLAMEbonus
							M.arcticwindlevel += src.ARCTICWINDbonus
							M.chainlightninglevel += src.CHAINLIGHTNINGbonus
							M.osmosislevel += src.OSMOSISbonus
							M.feedbacklevel += src.FEEDBACKbonus
							M.demilevel += src.DEMIbonus
						else
							usr << "<font color = teal>You already have a weapon equipped!"
					else
						usr << "<font color = teal>You do not meet the strength requirement!"
				if ((typi=="weapon")&&(twohanded==1))
					if (usr.tempstr>=src.strreq)
						if(usr.Wequipped==0 && usr.Sequipped==0)
							src.suffix+="Equipped"
							usr.Wequipped = 1
							usr.Sequipped = 1
							usr.tempdamagemin += src.DamageMin
							usr.tempdamagemax += src.DamageMax
							var/mob/players/M = usr
							M.attackspeed -= src.wpnspd
							M.Strength += src.STRbonus
							M.Intelligence += src.INTbonus
							M.HP += src.HPbonus
							M.MP += src.MPbonus
							M.MAXHP += src.HPbonus
							M.MAXMP += src.MPbonus
							M.Fireres += src.FIREres
							M.Iceres += src.ICEres
							M.Litres += src.LITres
							M.Poisres += src.POISres
							M.Darkres += src.DARKres
							M.fireboltlevel += src.FIREBOLTbonus
							M.iceboltlevel += src.ICEBOLTbonus
							M.lightningboltlevel += src.LIGHTNINGBOLTbonus
							M.healinglevel += src.HEALINGbonus
							M.poisonlevel += src.POISONbonus
							M.darklevel += src.DARKbonus
							M.flamelevel += src.FLAMEbonus
							M.arcticwindlevel += src.ARCTICWINDbonus
							M.chainlightninglevel += src.CHAINLIGHTNINGbonus
							M.osmosislevel += src.OSMOSISbonus
							M.feedbacklevel += src.FEEDBACKbonus
							M.demilevel += src.DEMIbonus
						else
							usr << "<font color = teal>You must have both hands free to equip this!"
					else
						usr << "<font color = teal>You do not meet the strength requirement!"
				if (typi=="armor")
					if (usr.tempstr>=src.strreq)
						if(usr.Aequipped==0)
							src.suffix+="Equipped"
							usr.Aequipped = 1
							usr.tempdefense += src.Adefense
							usr.tempevade += src.Aevade
							var/mob/players/M = usr
							M.Strength += src.STRbonus
							M.Intelligence += src.INTbonus
							M.HP += src.HPbonus
							M.MP += src.MPbonus
							M.MAXHP += src.HPbonus
							M.MAXMP += src.MPbonus
							M.Fireres += src.FIREres
							M.Iceres += src.ICEres
							M.Litres += src.LITres
							M.Poisres += src.POISres
							M.Darkres += src.DARKres
							M.fireboltlevel += src.FIREBOLTbonus
							M.iceboltlevel += src.ICEBOLTbonus
							M.lightningboltlevel += src.LIGHTNINGBOLTbonus
							M.healinglevel += src.HEALINGbonus
							M.poisonlevel += src.POISONbonus
							M.darklevel += src.DARKbonus
							M.flamelevel += src.FLAMEbonus
							M.arcticwindlevel += src.ARCTICWINDbonus
							M.chainlightninglevel += src.CHAINLIGHTNINGbonus
							M.osmosislevel += src.OSMOSISbonus
							M.feedbacklevel += src.FEEDBACKbonus
							M.demilevel += src.DEMIbonus
						else
							usr << "<font color = teal>You already have an armor equipped!"
					else
						usr << "<font color = teal>You do not meet the strength requirement!"
				if (typi=="shield")
					if (usr.tempstr>=src.strreq)
						if(usr.Sequipped==0)
							src.suffix+="Equipped"
							usr.Sequipped = 1
							usr.tempdefense += src.Adefense
							usr.tempevade += src.Aevade
							var/mob/players/M = usr
							M.Strength += src.STRbonus
							M.Intelligence += src.INTbonus
							M.HP += src.HPbonus
							M.MP += src.MPbonus
							M.MAXHP += src.HPbonus
							M.MAXMP += src.MPbonus
							M.Fireres += src.FIREres
							M.Iceres += src.ICEres
							M.Litres += src.LITres
							M.Poisres += src.POISres
							M.Darkres += src.DARKres
							M.fireboltlevel += src.FIREBOLTbonus
							M.iceboltlevel += src.ICEBOLTbonus
							M.lightningboltlevel += src.LIGHTNINGBOLTbonus
							M.healinglevel += src.HEALINGbonus
							M.poisonlevel += src.POISONbonus
							M.darklevel += src.DARKbonus
							M.flamelevel += src.FLAMEbonus
							M.arcticwindlevel += src.ARCTICWINDbonus
							M.chainlightninglevel += src.CHAINLIGHTNINGbonus
							M.osmosislevel += src.OSMOSISbonus
							M.feedbacklevel += src.FEEDBACKbonus
							M.demilevel += src.DEMIbonus
						else
							usr << "<font color = teal>That hand is in use. You must unequip first!"
					else
						usr << "<font color = teal>You do not meet the strength requirement!"
		verb/Unequip()
			set category = null
			set src in usr
			if(src.suffix!="Equipped")
				usr << "<font color = teal>That's not equipped!"
			else
				if (typi=="weapon" && twohanded==0)
					if(usr.Wequipped==0)
						usr << "<font color = teal>You don't have anything equipped!"
					else
						//src.verbs-=/obj/weapons/proc/Unequip
						//src.verbs+=/obj/weapons/verb/Equip
						src.suffix = ""
						usr.Wequipped = 0
						usr.tempdamagemin -= src.DamageMin
						usr.tempdamagemax -= src.DamageMax
						var/mob/players/M = usr
						if(M.char_class=="Warrior")
							M.attackspeed = 5
						else if(M.char_class=="Monk")
							M.attackspeed = 6
						else if(M.char_class=="Mage")
							M.attackspeed = 7
						else if(M.char_class=="Wizard")
							M.attackspeed = 8
						else
							M.attackspeed = 5
						M.Strength -= src.STRbonus
						M.Intelligence -= src.INTbonus
						M.HP -= src.HPbonus
						M.MP -= src.MPbonus
						M.MAXHP -= src.HPbonus
						M.MAXMP -= src.MPbonus
						M.Fireres -= src.FIREres
						M.Iceres -= src.ICEres
						M.Litres -= src.LITres
						M.Poisres -= src.POISres
						M.Darkres -= src.DARKres
						M.fireboltlevel -= src.FIREBOLTbonus
						M.iceboltlevel -= src.ICEBOLTbonus
						M.lightningboltlevel -= src.LIGHTNINGBOLTbonus
						M.healinglevel -= src.HEALINGbonus
						M.poisonlevel -= src.POISONbonus
						M.darklevel -= src.DARKbonus
						M.flamelevel -= src.FLAMEbonus
						M.arcticwindlevel -= src.ARCTICWINDbonus
						M.chainlightninglevel -= src.CHAINLIGHTNINGbonus
						M.osmosislevel -= src.OSMOSISbonus
						M.feedbacklevel -= src.FEEDBACKbonus
						M.demilevel -= src.DEMIbonus
				if (typi=="weapon" && twohanded==1)
					if(usr.Wequipped==0)
						usr << "<font color = teal>You don't have anything equipped!"
					else
						src.suffix = ""
						usr.Wequipped = 0
						usr.Sequipped = 0
						usr.tempdamagemin -= src.DamageMin
						usr.tempdamagemax -= src.DamageMax
						var/mob/players/M = usr
						if(M.char_class=="Warrior")
							M.attackspeed = 5
						else if(M.char_class=="Monk")
							M.attackspeed = 6
						else if(M.char_class=="Mage")
							M.attackspeed = 7
						else if(M.char_class=="Wizard")
							M.attackspeed = 8
						else
							M.attackspeed = 5
						M.Strength -= src.STRbonus
						M.Intelligence -= src.INTbonus
						M.HP -= src.HPbonus
						M.MP -= src.MPbonus
						M.MAXHP -= src.HPbonus
						M.MAXMP -= src.MPbonus
						M.Fireres -= src.FIREres
						M.Iceres -= src.ICEres
						M.Litres -= src.LITres
						M.Poisres -= src.POISres
						M.Darkres -= src.DARKres
						M.fireboltlevel -= src.FIREBOLTbonus
						M.iceboltlevel -= src.ICEBOLTbonus
						M.lightningboltlevel -= src.LIGHTNINGBOLTbonus
						M.healinglevel -= src.HEALINGbonus
						M.poisonlevel -= src.POISONbonus
						M.darklevel -= src.DARKbonus
						M.flamelevel -= src.FLAMEbonus
						M.arcticwindlevel -= src.ARCTICWINDbonus
						M.chainlightninglevel -= src.CHAINLIGHTNINGbonus
						M.osmosislevel -= src.OSMOSISbonus
						M.feedbacklevel -= src.FEEDBACKbonus
						M.demilevel -= src.DEMIbonus
				if (typi=="armor")
					if(usr.Aequipped==0)
						usr << "<font color = teal>You don't have anything equipped!"
					else
						src.suffix = ""
						usr.Aequipped = 0
						usr.tempdefense -= src.Adefense
						usr.tempevade -= src.Aevade
						var/mob/players/M = usr
						M.Strength -= src.STRbonus
						M.Intelligence -= src.INTbonus
						M.HP -= src.HPbonus
						M.MP -= src.MPbonus
						M.MAXHP -= src.HPbonus
						M.MAXMP -= src.MPbonus
						M.Fireres -= src.FIREres
						M.Iceres -= src.ICEres
						M.Litres -= src.LITres
						M.Poisres -= src.POISres
						M.Darkres -= src.DARKres
						M.fireboltlevel -= src.FIREBOLTbonus
						M.iceboltlevel -= src.ICEBOLTbonus
						M.lightningboltlevel -= src.LIGHTNINGBOLTbonus
						M.healinglevel -= src.HEALINGbonus
						M.poisonlevel -= src.POISONbonus
						M.darklevel -= src.DARKbonus
						M.flamelevel -= src.FLAMEbonus
						M.arcticwindlevel -= src.ARCTICWINDbonus
						M.chainlightninglevel -= src.CHAINLIGHTNINGbonus
						M.osmosislevel -= src.OSMOSISbonus
						M.feedbacklevel -= src.FEEDBACKbonus
						M.demilevel -= src.DEMIbonus
				if (typi=="shield")
					if(usr.Sequipped==0)
						usr << "<font color = teal>You don't have anything equipped!"
					else
						src.suffix = ""
						usr.Sequipped = 0
						usr.tempdefense -= src.Adefense
						usr.tempevade -= src.Aevade
						var/mob/players/M = usr
						M.Strength -= src.STRbonus
						M.Intelligence -= src.INTbonus
						M.HP -= src.HPbonus
						M.MP -= src.MPbonus
						M.MAXHP -= src.HPbonus
						M.MAXMP -= src.MPbonus
						M.Fireres -= src.FIREres
						M.Iceres -= src.ICEres
						M.Litres -= src.LITres
						M.Poisres -= src.POISres
						M.Darkres -= src.DARKres
						M.fireboltlevel -= src.FIREBOLTbonus
						M.iceboltlevel -= src.ICEBOLTbonus
						M.lightningboltlevel -= src.LIGHTNINGBOLTbonus
						M.healinglevel -= src.HEALINGbonus
						M.poisonlevel -= src.POISONbonus
						M.darklevel -= src.DARKbonus
						M.flamelevel -= src.FLAMEbonus
						M.arcticwindlevel -= src.ARCTICWINDbonus
						M.chainlightninglevel -= src.CHAINLIGHTNINGbonus
						M.osmosislevel -= src.OSMOSISbonus
						M.feedbacklevel -= src.FEEDBACKbonus
						M.demilevel -= src.DEMIbonus
		verb
			Drop()
				set category = null
				set src in usr
				if(src.suffix == "Equipped")
					usr << "<font color = teal>Un-equip [src] first!"
				else
					src.Move(usr.loc)

		//here are all the items
		//the magic items do not have New() commands so that they will fire my New() proc instead of the default
		//each unique's New() command is overwritten locally to give each of them its special abilities
		knife
			name = "Knife"
			description = "<b>Knife:</b>  1-4 Damage, 1 strength required, SellValue: 1"
			icon_state = "knife"
			sellvalue = 1
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 0
			strreq = 1
			DamageMin = 1
			DamageMax = 4
			New()
		uniqueknife
			name = "Aurora"
			description = "<font color = maroon><b>Aurora (Knife):</b>  2-8 Damage, +6 Str, +5 Int, 1 strength required"
			icon_state = "Aurora"
			sellvalue = 40
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 0
			strreq = 1
			DamageMin = 2
			DamageMax = 8
			STRbonus = 6
			INTbonus = 5
			New()
				if(usr.contents!=null)
					HEALINGbonus = rand(1,3)
					var/addd = ", +[HEALINGbonus] Healing"
					description = "<font color = maroon><b>Aurora (Knife):</b>  2-8 Damage, +6 Str, +5 Int[addd], 1 strength required"
		magicknife
			name = "Knife"
			description = ""
			icon_state = "knife"
			sellvalue = 1
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 0
			strreq = 1
			DamageMin = 1
			DamageMax = 4
		shortsword
			name = "Short Sword"
			description = "<b>Short Sword:</b>  3-6 damage, 5 strength required, SellValue: 25"
			icon_state = "shortsword"
			sellvalue = 25
			typi = "weapon"
			wpnspd = 1
			wlvl = 1
			twohanded = 0
			strreq = 5
			DamageMin = 3
			DamageMax = 6
			New()
		uniqueshortsword
			name = "Plague"
			description = "<font color = maroon><b>Plague (Short Sword):</b>  6-12 Damage, +9 Str, +2 Int, 5 strength required"
			icon_state = "Plague"
			sellvalue = 100
			typi = "weapon"
			wpnspd = 1
			wlvl = 1
			twohanded = 0
			strreq = 5
			DamageMin = 6
			DamageMax = 12
			STRbonus = 9
			INTbonus = 2
			New()
				if(usr.contents!=null)
					MPbonus = rand(15,35)
					var/addd = ", +[MPbonus] MP"
					description = "<font color = maroon><b>Plague (Short Sword):</b>  6-12 Damage, +9 Str, +2 Int[addd], 5 strength required"
		magicshortsword
			name = "Short Sword"
			description = ""
			icon_state = "shortsword"
			sellvalue = 25
			typi = "weapon"
			wpnspd = 1
			wlvl = 1
			twohanded = 0
			strreq = 5
			DamageMin = 3
			DamageMax = 6
		smallaxe
			name = "Small Axe"
			description = "<b>Small Axe:</b>  6-11 Damage, 10 strength required, SellValue: 50"
			icon_state = "smallaxe"
			sellvalue = 50
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 0
			strreq = 10
			DamageMin = 6
			DamageMax = 11
			New()
		uniquesmallaxe
			name = "Flare"
			description = "<font color = maroon><b>Flare (Small Axe):</b>  12-22 Damage, +11 Strength, 10 strength required"
			icon_state = "Flare"
			sellvalue = 200
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 0
			strreq = 10
			DamageMin = 12
			DamageMax = 22
			STRbonus = 11
			INTbonus = 0
			New()
				if(usr.contents!=null)
					HPbonus = rand(5,20)
					var/addd1 = ", +[HPbonus] HP"
					FIREBOLTbonus = rand(1,2)
					var/addd2 = ", +[FIREBOLTbonus] Firebolt"
					description = "<font color = maroon><b>Flare (Small Axe):</b>  12-22 Damage, +11 Strength[addd1][addd2], 10 strength required"
		magicsmallaxe
			name = "Small Axe"
			description = ""
			icon_state = "smallaxe"
			sellvalue = 50
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 0
			strreq = 10
			DamageMin = 6
			DamageMax = 11
		shortstaff
			name = "Short Staff"
			description = "<b>Short Staff:</b>  2-8 Damage, two-handed, 5 strength required, SellValue: 15"
			icon_state = "shortstaff"
			sellvalue = 15
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 1
			strreq = 5
			DamageMin = 2
			DamageMax = 8
			New()
		uniqueshortstaff
			name = "Spark"
			description = "<font color = maroon><b>Spark (Short Staff):</b>  4-16 Damage, two-handed, +11 Intelligence, 5 strength required"
			icon_state = "Spark"
			sellvalue = 60
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 1
			strreq = 5
			DamageMin = 4
			DamageMax = 16
			STRbonus = 0
			INTbonus = 11
			New()
				if(usr.contents!=null)
					MPbonus = rand(5,20)
					var/addd1 = ", +[MPbonus] MP"
					LIGHTNINGBOLTbonus = rand(1,6)
					var/addd2 = ", +[LIGHTNINGBOLTbonus] Lightningbolt"
					description = "<font color = maroon><b>Spark (Short Staff):</b>  4-16 Damage, two-handed, +11 Intelligence[addd1][addd2], 5 strength required"
		magicshortstaff
			name = "Short Staff"
			description = ""
			icon_state = "shortstaff"
			sellvalue = 15
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 1
			strreq = 5
			DamageMin = 2
			DamageMax = 8
		woodwand
			name = "Wooden Wand"
			description = "<b>Wooden Wand:</b>  4-5 Damage, 5 strength required, SellValue: 25"
			icon_state = "woodwand"
			sellvalue = 25
			typi = "weapon"
			wpnspd = 1
			wlvl = 1
			twohanded = 0
			strreq = 5
			DamageMin = 4
			DamageMax = 5
			New()
		uniquewoodwand
			name = "Lilac"
			description = "<font color = maroon><b>Lilac (Wooden Wand):</b>  8-10 Damage, +4 Str, +7 Int, 5 strength required"
			icon_state = "Lilac"
			sellvalue = 100
			typi = "weapon"
			wpnspd = 1
			wlvl = 1
			twohanded = 0
			strreq = 5
			DamageMin = 8
			DamageMax = 10
			STRbonus = 4
			INTbonus = 7
			New()
				if(usr.contents!=null)
					FIREres = rand(7,9)
					var/addd1 = ", +[FIREres] Fire Resistance"
					ICEres = rand(10,12)
					var/addd2 = ", +[ICEres] Ice Resistance"
					MPbonus = rand(3,8)
					var/addd3 = ", +[MPbonus] MP"
					description = "<font color = maroon><b>Lilac (Wooden Wand):</b>  8-10 Damage, +4 Str, +7 Int[addd3][addd1][addd2], 5 strength required"
		magicwoodwand
			name = "Wooden Wand"
			description = ""
			icon_state = "woodwand"
			sellvalue = 25
			typi = "weapon"
			wpnspd = 1
			wlvl = 1
			twohanded = 0
			strreq = 5
			DamageMin = 4
			DamageMax = 5
		longstaff
			name = "Long Staff"
			description = "<b>Long Staff:</b>  5-11 Damage, two-handed, 8 strength required, SellValue: 30"
			icon_state = "longstaff"
			sellvalue = 30
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 1
			strreq = 8
			DamageMin = 5
			DamageMax = 11
			New()
		uniquelongstaff
			name = "Frost"
			description = "<font color = maroon><b>Frost (Long Staff):</b>  10-22 Damage, two-handed, +2 Str, +9 Int, 8 strength required"
			icon_state = "Frost"
			sellvalue = 120
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 1
			strreq = 8
			DamageMin = 10
			DamageMax = 22
			STRbonus = 2
			INTbonus = 9
			New()
				if(usr.contents!=null)
					MPbonus = rand(5,20)
					var/addd1 = ", +[MPbonus] MP"
					ICEBOLTbonus = rand(1,6)
					var/addd2 = ", +[ICEBOLTbonus] Icebolt"
					ICEres = rand(1,10)
					var/addd3 = ", +[ICEres] Ice Resistance"
					description = "<font color = maroon><b>Frost (Long Staff):</b>  10-22 Damage, two-handed, +2 Str, +9 Int[addd1][addd2][addd3], 8 strength required"
		magiclongstaff
			name = "Long Staff"
			description = ""
			icon_state = "longstaff"
			sellvalue = 30
			typi = "weapon"
			wpnspd = 0
			wlvl = 1
			twohanded = 1
			strreq = 8
			DamageMin = 5
			DamageMax = 11
		blade
			name = "Blade"
			description = "<b>Blade:</b>  10-13 damage, 14 strength required, SellValue: 100"
			icon_state = "blade"
			sellvalue = 100
			typi = "weapon"
			wpnspd = 2
			wlvl = 1
			twohanded = 0
			strreq = 14
			DamageMin = 10
			DamageMax = 13
			New()
		uniqueblade
			name = "Prismatic"
			description = "<font color = maroon><b>Prismatic (Blade):</b>  20-26 Damage,+5 Str, +6 Int, 14 strength required"
			icon_state = "Prismatic"
			sellvalue = 400
			typi = "weapon"
			wpnspd = 2
			wlvl = 1
			twohanded = 0
			strreq = 14
			DamageMin = 20
			DamageMax = 26
			STRbonus = 5
			INTbonus = 6
			New()
				if(usr.contents!=null)
					var/blah = rand(10,30)
					FIREres = blah
					ICEres = blah
					LITres = blah
					POISres = blah
					DARKres = blah
					var/addd1 = ", +[blah] All Resistances"
					description = "<font color = maroon><b>Prismatic (Blade):</b>  20-26 Damage,+5 Str, +6 Int[addd1], 14 strength required"
		magicblade
			name = "Blade"
			description = ""
			icon_state = "blade"
			sellvalue = 100
			typi = "weapon"
			wpnspd = 2
			wlvl = 1
			twohanded = 0
			strreq = 14
			DamageMin = 10
			DamageMax = 13
		longsword
			name = "Long Sword"
			description = "<b>Long Sword:</b>  14-17 damage, 24 strength required, SellValue: 140"
			icon_state = "longsword"
			sellvalue = 140
			typi = "weapon"
			wpnspd = 1
			wlvl = 1
			twohanded = 0
			strreq = 24
			DamageMin = 14
			DamageMax = 17
			New()
		magiclongsword
			name = "Long Sword"
			description = ""
			icon_state = "longsword"
			sellvalue = 140
			typi = "weapon"
			wpnspd = 1
			wlvl = 1
			twohanded = 0
			strreq = 24
			DamageMin = 14
			DamageMax = 17
		broadblade
			name = "Broad Blade"
			description = "<b>Broad Blade:</b>  19-22 damage, 30 strength required, SellValue: 300"
			icon_state = "broadblade"
			sellvalue = 300
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 0
			strreq = 30
			DamageMin = 19
			DamageMax = 22
			New()
		uniquebroadblade
			name = "Pestilence"
			description = "<font color = maroon><b>Pestilence (Broad Blade):</b>  30-32 Damage, +20 Intelligence, 30 strength required"
			icon_state = "Pestilence"
			sellvalue = 1200
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 0
			strreq = 30
			DamageMin = 38
			DamageMax = 44
			STRbonus = 0
			INTbonus = 20
			New()
				if(usr.contents!=null)
					MPbonus = rand(50,100)
					var/addd1 = ", +[MPbonus] MP"
					POISONbonus = rand(1,2)
					var/addd2 = ", +[POISONbonus] Poison"
					description = "<font color = maroon><b>Pestilence (Broad Blade):</b>  30-32 Damage, +20 Intelligence[addd1][addd2], 30 strength required"
		magicbroadblade
			name = "Broad Blade"
			description = ""
			icon_state = "broadblade"
			sellvalue = 300
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 0
			strreq = 30
			DamageMin = 19
			DamageMax = 22
		broadsword
			name = "Broad Sword"
			description = "<b>Broad Sword:</b>  26-29 damage, two-handed, 42 strength required, SellValue: 490"
			icon_state = "broadsword"
			sellvalue = 490
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 1
			strreq = 42
			DamageMin = 26
			DamageMax = 29
			New()
		uniquebroadsword
			name = "Mithra's Edge"
			description = "<font color = maroon><b>Mithra's Edge (Broad Sword):</b>  52-58 Damage, two-handed, +17 Str, +3 Int, 42 strength required"
			icon_state = "Mithra's Edge"
			sellvalue = 1960
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 1
			strreq = 42
			DamageMin = 52
			DamageMax = 58
			STRbonus = 17
			INTbonus = 3
			New()
				if(usr.contents!=null)
					FIREres = rand(5,20)
					var/ad1 = ", +[FIREres] Fire Resistance"
					ICEres = rand(5,20)
					var/ad2 = ", +[ICEres] Ice Resistance"
					LITres = rand(5,20)
					var/ad3 = ", +[LITres] Lightning Resistance"
					POISres = rand(5,20)
					var/ad4 = ", +[POISres] Poison Resistance"
					DARKres = rand(5,20)
					var/ad5 = ", +[DARKres] Dark Resistance"
					description = "<font color = maroon><b>Mithra's Edge (Broad Sword):</b>  52-58 Damage, two-handed, +17 Str, +3 Int[ad1][ad2][ad3][ad4][ad5], 42 strength required"
		magicbroadsword
			name = "Broad Sword"
			description = ""
			icon_state = "broadsword"
			sellvalue = 490
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 1
			strreq = 42
			DamageMin = 26
			DamageMax = 29
		largeaxe
			name = "Large Axe"
			description = "<b>Large Axe:</b>  20-25 damage, 38 strength required, SellValue: 363"
			icon_state = "largeaxe"
			sellvalue = 363
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 0
			strreq = 38
			DamageMin = 20
			DamageMax = 25
			New()
		uniquelargeaxe
			name = "Amethyst"
			description = "<font color = maroon><b>Amethyst (Large Axe):</b>  40-50 Damage, +12 Str, +8 Int, 38 strength required"
			icon_state = "Amethyst"
			sellvalue = 1450
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 0
			strreq = 38
			DamageMin = 40
			DamageMax = 50
			STRbonus = 12
			INTbonus = 8
			New()
				if(usr.contents!=null)
					HPbonus = rand(30,90)
					var/ad1 = ", +[HPbonus] HP"
					MPbonus = rand(30,90)
					var/ad2 = ", +[MPbonus] MP"
					description = "<font color = maroon><b>Amethyst (Large Axe):</b>  40-50 Damage, +12 Str, +8 Int[ad1][ad2], 38 strength required"
		magiclargeaxe
			name = "Large Axe"
			description = ""
			icon_state = "largeaxe"
			sellvalue = 363
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 0
			strreq = 38
			DamageMin = 20
			DamageMax = 25
		battleaxe
			name = "Battle Axe"
			description = "<b>Battle Axe:</b>  34-39 damage, two-handed, 55 strength required, SellValue: 925"
			icon_state = "battleaxe"
			sellvalue = 925
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 1
			strreq = 55
			DamageMin = 34
			DamageMax = 39
			New()
		uniquebattleaxe
			name = "Soar"
			description = "<font color = maroon><b>Soar (Battle Axe):</b>  68-78 Damage, two-handed, +20 Strength, 55 strength required"
			icon_state = "Soar"
			sellvalue = 3700
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 1
			strreq = 55
			DamageMin = 68
			DamageMax = 78
			STRbonus = 20
			INTbonus = 0
			New()
				if(usr.contents!=null)
					HPbonus = rand(1,500)
					var/ad1 = ", +[HPbonus] HP"
					description = "<font color = maroon><b>Soar (Battle Axe):</b>  68-78 Damage, two-handed, +20 Strength[ad1], 55 strength required"
		magicbattleaxe
			name = "Battle Axe"
			description = ""
			icon_state = "battleaxe"
			sellvalue = 925
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 1
			strreq = 55
			DamageMin = 34
			DamageMax = 39
		wand
			name = "Wand"
			description = "<b>Wand:</b>  15-16 damage, 20 strength required, SellValue: 215"
			icon_state = "wand"
			sellvalue = 215
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 0
			strreq = 20
			DamageMin = 15
			DamageMax = 16
			New()
		uniquewand
			name = "Ruby"
			description = "<font color = maroon><b>Ruby (Wand):</b>  30-32 Damage,+3 Str, +17 Int, 20 strength required"
			icon_state = "Ruby"
			sellvalue = 860
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 0
			strreq = 20
			DamageMin = 30
			DamageMax = 32
			STRbonus = 3
			INTbonus = 17
			New()
				if(usr.contents!=null)
					FIREres = rand(20,30)
					var/ad1 = ", +[FIREres] Fire Resistance"
					HPbonus = rand(20,60)
					var/ad2 = ", +[HPbonus] HP"
					description = "<font color = maroon><b>Ruby (Wand):</b>  30-32 Damage,+3 Str, +17 Int[ad1][ad2], 20 strength required"
		magicwand
			name = "Wand"
			description = ""
			icon_state = "wand"
			sellvalue = 215
			typi = "weapon"
			wpnspd = 1
			wlvl = 2
			twohanded = 0
			strreq = 20
			DamageMin = 15
			DamageMax = 16
		powerstaff
			name = "Power Staff"
			description = "<b>Power Staff:</b>  16-22 damage, two-handed, 22 strength required, SellValue: 200"
			icon_state = "powerstaff"
			sellvalue = 200
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 1
			strreq = 22
			DamageMin = 16
			DamageMax = 22
			New()
		uniquepowerstaff
			name = "Conflagration"
			description = "<font color = maroon><b>Conflagration (Power Staff):</b>  32-44 Damage, two-handed, +6 Str, +14 Int, 22 strength required"
			icon_state = "Conflagration"
			sellvalue = 800
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 1
			strreq = 22
			DamageMin = 32
			DamageMax = 44
			STRbonus = 6
			INTbonus = 14
			New()
				if(usr.contents!=null)
					FIREres = rand(5,10)
					var/ad1 = ", +[FIREres] Fire Resistance"
					MPbonus = rand(1,500)
					var/ad2 = ", +[MPbonus] MP"
					description = "<font color = maroon><b>Conflagration (Power Staff):</b>  32-44 Damage, two-handed, +6 Str, +14 Int[ad1][ad2], 22 strength required"
		magicpowerstaff
			name = "Power Staff"
			description = ""
			icon_state = "powerstaff"
			sellvalue = 200
			typi = "weapon"
			wpnspd = 0
			wlvl = 2
			twohanded = 1
			strreq = 22
			DamageMin = 16
			DamageMax = 22
		rapier
			name = "Rapier"
			description = "<b>Rapier:</b>  48-51 damage, 70 strength required, SellValue: 1625"
			icon_state = "rapier"
			sellvalue = 1625
			typi = "weapon"
			wpnspd = 1
			wlvl = 3
			twohanded = 0
			strreq = 70
			DamageMin = 48
			DamageMax = 51
			New()
		uniquerapier
			name = "Element"
			description = "<font color = maroon><b>Element (Rapier):</b>  96-102 damage, +15 Str, +25 Int, 70 strength required"
			icon_state = "Element"
			sellvalue = 6500
			typi = "weapon"
			wpnspd = 1
			wlvl = 3
			twohanded = 0
			strreq = 70
			DamageMin = 96
			DamageMax = 102
			INTbonus = 25
			STRbonus = 15
			New()
				if(usr.contents!=null)
					FIREBOLTbonus = rand(15,25)
					var/ad1 = ", +[FIREBOLTbonus] Firebolt"
					ICEBOLTbonus = rand(15,25)
					var/ad2 = ", +[ICEBOLTbonus] Icebolt"
					LIGHTNINGBOLTbonus = rand(15,25)
					var/ad3 = ", +[LIGHTNINGBOLTbonus] Lightningbolt"
					FLAMEbonus = rand(5,15)
					var/ad4 = ", +[FLAMEbonus] Flame"
					ARCTICWINDbonus = rand(5,15)
					var/ad5 = ", +[ARCTICWINDbonus] ArcticWind"
					CHAINLIGHTNINGbonus = rand(5,15)
					var/ad6 = ", +[CHAINLIGHTNINGbonus] ChainLightning"
					description = "<font color = maroon><b>Element (Rapier):</b>  96-102 damage, +15 Str, +25 Int[ad1][ad2][ad3][ad4][ad5][ad6], 70 strength required"
		magicrapier
			name = "Rapier"
			description = ""
			icon_state = "rapier"
			sellvalue = 1625
			typi = "weapon"
			wpnspd = 1
			wlvl = 3
			twohanded = 0
			strreq = 70
			DamageMin = 48
			DamageMax = 51
		batblade
			name = "Batblade"
			description = "<b>Batblade:</b>  56-59 damage, 82 strength required, SellValue: 2250"
			icon_state = "batblade"
			sellvalue = 3250
			typi = "weapon"
			wpnspd = 2
			wlvl = 3
			twohanded = 0
			strreq = 82
			DamageMin = 56
			DamageMax = 59
			New()
		uniquebatblade
			name = "Bat's Seizure"
			description = "<font color = maroon><b>Bat's Seizure (Batblade):</b>  112-118 damage, +40 Strength, 82 strength required"
			icon_state = "Bat's Seizure"
			sellvalue = 13000
			typi = "weapon"
			wpnspd = 2
			wlvl = 3
			twohanded = 0
			strreq = 82
			DamageMin = 112
			DamageMax = 118
			INTbonus = 0
			STRbonus = 40
			New()
				if(usr.contents!=null)
					DARKres = rand(15,30)
					var/ad1 = ", +[DARKres] Dark Resistance"
					DARKbonus = rand(20,30)
					var/ad2 = ", +[DARKbonus] Dark"
					description = "<font color = maroon><b>Bat's Seizure (Batblade):</b>  112-118 damage, +40 Strength[ad1][ad2], 82 strength required"
		magicbatblade
			name = "Batblade"
			description = ""
			icon_state = "batblade"
			sellvalue = 3250
			typi = "weapon"
			wpnspd = 2
			wlvl = 3
			twohanded = 0
			strreq = 82
			DamageMin = 56
			DamageMax = 59
		jadestaff
			name = "Jade Staff"
			description = "<b>Jade Staff:</b>  61-65 damage, 63 strength required, SellValue: 3400"
			icon_state = "jadestaff"
			sellvalue = 3400
			typi = "weapon"
			wpnspd = 0
			wlvl = 3
			twohanded = 0
			strreq = 63
			DamageMin = 61
			DamageMax = 65
			New()
		uniquejadestaff
			name = "Jade Whirl"
			description = "<font color = maroon><b>Jade Whirl (Jade Staff):</b>  122-130 damage, 63 strength required"
			icon_state = "Jade Whirl"
			sellvalue = 13600
			typi = "weapon"
			wpnspd = 0
			wlvl = 3
			twohanded = 0
			strreq = 63
			DamageMin = 122
			DamageMax = 130
			INTbonus = 40
			New()
				if(usr.contents!=null)
					MPbonus = rand(50,150)
					var/ad1 = ", +[MPbonus] MP"
					ICEres = rand(15,30)
					var/ad2 = ", +[ICEres] Ice Resistance"
					POISres = rand(15,30)
					var/ad3 = ", +[POISres] Poison Resistance"
					description = "<font color = maroon><b>Jade Whirl (Jade Staff):</b>  122-130 damage, +40 Intelligence[ad1][ad2][ad3], 63 strength required"
		magicjadestaff
			name = "Jade Staff"
			description = ""
			icon_state = "jadestaff"
			sellvalue = 3400
			typi = "weapon"
			wpnspd = 0
			wlvl = 3
			twohanded = 0
			strreq = 63
			DamageMin = 61
			DamageMax = 65
		triadicorb
			name = "Triadic Orb"
			description = "<b>Triadic Orb:</b>  74-78 damage, two-handed, 77 strength required, SellValue: 3750"
			icon_state = "triadicorb"
			sellvalue = 3750
			typi = "weapon"
			wpnspd = 0
			wlvl = 3
			twohanded = 1
			strreq = 77
			DamageMin = 74
			DamageMax = 78
			New()
		uniquetriadicorb
			name = "Kaleidoscope"
			description = "<font color = maroon><b>Kaleidoscope (Triadic Orb):</b>  148-156 damage, two-handed, +7 Str, +33 Int, 77 strength required"
			icon_state = "Kaleidoscope"
			sellvalue = 15000
			typi = "weapon"
			wpnspd = 0
			wlvl = 3
			twohanded = 1
			strreq = 77
			DamageMin = 148
			DamageMax = 156
			INTbonus = 33
			STRbonus = 7
			New()
				if(usr.contents!=null)
					HPbonus = rand(150,250)
					var/ad1 = ", +[HPbonus] HP"
					var/blah = rand(20,30)
					FIREres = blah
					ICEres = blah
					LITres = blah
					POISres = blah
					DARKres = blah
					var/ad2 = ", +[blah] All Resistances"
					description = "<font color = maroon><b>Kaleidoscope (Triadic Orb):</b>  148-156 damage, two-handed, +7 Str, +33 Int[ad1][ad2], 77 strength required"
		magictriadicorb
			name = "Triadic Orb"
			description = ""
			icon_state = "triadicorb"
			sellvalue = 3750
			typi = "weapon"
			wpnspd = 0
			wlvl = 3
			twohanded = 1
			strreq = 77
			DamageMin = 74
			DamageMax = 78
		icicleblade
			name = "Icicle Blade"
			description = "<b>Icicle Blade:</b>  80-85 damage, two-handed, 118 strength required, SellValue: 7860"
			icon_state = "icicleblade"
			sellvalue = 7860
			typi = "weapon"
			wpnspd = 1
			wlvl = 3
			twohanded = 1
			strreq = 118
			DamageMin = 80
			DamageMax = 85
			New()
		uniqueicicleblade
			name = "Blade of Karim"
			description = "<font color = maroon><b>Blade of Karim (Icicle Blade):</b>  160-170 damage, two-handed, Increased Attack Speed, +35 Str, +5 Int, 118 strength required"
			icon_state = "Blade of Karim"
			sellvalue = 31440
			typi = "weapon"
			wpnspd = 4
			wlvl = 3
			twohanded = 1
			strreq = 118
			DamageMin = 160
			DamageMax = 170
			INTbonus = 5
			STRbonus = 35
			New()
				if(usr.contents!=null)
					MPbonus = rand(200,300)
					var/ad1 = ", +[MPbonus] MP"
					DARKbonus = rand(20,35)
					var/ad2 = ", +[DARKbonus] Dark"
					OSMOSISbonus = rand(5,10)
					var/ad3 = ", +[OSMOSISbonus] Osmosis"
					var/blah = rand(1,10)
					FIREres = blah
					ICEres = blah
					LITres = blah
					POISres = blah
					DARKres = blah
					var/ad4 = ", +[blah] All Resistances"
					description = "<font color = maroon><b>Blade of Karim (Icicle Blade):</b>  160-170 damage, two-handed, Increased Attack Speed, +35 Str, +5 Int[ad1][ad2][ad3][ad4], 118 strength required"
		magicicicleblade
			name = "Icicle Blade"
			description = ""
			icon_state = "icicleblade"
			sellvalue = 7860
			typi = "weapon"
			wpnspd = 1
			wlvl = 3
			twohanded = 1
			strreq = 118
			DamageMin = 80
			DamageMax = 85
		scorchingsword
			name = "Scorching Sword"
			description = "<b>Scorching Sword:</b>  94-97 damage, two-handed, 144 strength required, SellValue: 12000"
			icon_state = "scorchingsword"
			sellvalue = 12000
			typi = "weapon"
			wpnspd = 1
			wlvl = 3
			twohanded = 1
			strreq = 144
			DamageMin = 94
			DamageMax = 97
			New()
		uniquescorchingsword
			name = "Scourge"
			description = "<font color = maroon><b>Scourge (Scorching Sword):</b>  188-194 damage, two-handed, +24 Str, +16 Int, 144 strength required"
			icon_state = "Scourge"
			sellvalue = 48000
			typi = "weapon"
			wpnspd = 1
			wlvl = 3
			twohanded = 1
			strreq = 144
			DamageMin = 188
			DamageMax = 194
			INTbonus = 16
			STRbonus = 24
			New()
				if(usr.contents!=null)
					HPbonus = rand(250,350)
					var/ad1 = ", +[HPbonus] HP"
					MPbonus = rand(150,250)
					var/ad2 = ", +[MPbonus] MP"
					POISONbonus = rand(10,15)
					var/ad3 = ", +[POISONbonus] Poison"
					POISres = rand(20,30)
					var/ad4 = ", +[POISres] Poison Resistance"
					description = "<font color = maroon><b>Scourge (Scorching Sword):</b>  188-194 damage, two-handed, +24 Str, +16 Int[ad1][ad2][ad3][ad4], 144 strength required"
		magicscorchingsword
			name = "Scorching Sword"
			description = ""
			icon_state = "scorchingsword"
			sellvalue = 12000
			typi = "weapon"
			wpnspd = 1
			wlvl = 3
			twohanded = 1
			strreq = 144
			DamageMin = 94
			DamageMax = 97
		steelsword
			name = "Steel Sword"
			description = "<b>Steel Sword:</b>  174-195 damage, two-handed, 240 strength required, SellValue: 46000"
			icon_state = "steelsword"
			sellvalue = 46000
			typi = "weapon"
			wpnspd = 1
			wlvl = 4
			twohanded = 1
			strreq = 240
			DamageMin = 174
			DamageMax = 195
			New()
		uniquesteelsword
			name = "The Mmbahfather"
			description = "<font color = maroon><b>The Mmbahfather (Steel Sword):</b>  348-390 damage, one-handed, Increased Attack Speed, +60 Str, +20 Int,  240 strength required"
			icon_state = "The Mmbahfather"
			sellvalue = 184000
			typi = "weapon"
			wpnspd = 5
			wlvl = 4
			twohanded = 0
			strreq = 240
			DamageMin = 348
			DamageMax = 390
			INTbonus = 20
			STRbonus = 60
			New()
				if(usr.contents!=null)
					HPbonus = rand(600,1000)
					var/ad1 = ", +[HPbonus] HP"
					MPbonus = rand(600,1000)
					var/ad2 = ", +[MPbonus] MP"
					DEMIbonus = rand(5,10)
					var/ad3 = ", +[DEMIbonus] Demi"
					var/blah = rand(24,33)
					FIREres = blah
					ICEres = blah
					LITres = blah
					POISres = blah
					DARKres = blah
					var/ad4 = ", +[blah] All Resistances"
					description = "<font color = maroon><b>The Mmbahfather (Steel Sword):</b>  348-390 damage, one-handed, Increased Attack Speed, +60 Str, +20 Int[ad1][ad2][ad3][ad4], 240 strength required"
		magicsteelsword
			name = "Steel Sword"
			description = ""
			icon_state = "steelsword"
			sellvalue = 46000
			typi = "weapon"
			wpnspd = 1
			wlvl = 4
			twohanded = 1
			strreq = 240
			DamageMin = 174
			DamageMax = 195
		goldsword
			name = "Gold Sword"
			description = "<b>Gold Sword:</b>  170-178 damage, 195 strength required, SellValue: 60000"
			icon_state = "goldsword"
			sellvalue = 60000
			typi = "weapon"
			wpnspd = 2
			wlvl = 4
			twohanded = 0
			strreq = 195
			DamageMin = 170
			DamageMax = 178
			New()
		magicgoldsword
			name = "Gold Sword"
			description = ""
			icon_state = "goldsword"
			sellvalue = 60000
			typi = "weapon"
			wpnspd = 2
			wlvl = 4
			twohanded = 0
			strreq = 195
			DamageMin = 170
			DamageMax = 178
		goldwand
			name = "Gold Wand"
			description = "<b>Gold Wand:</b>  142-148 damage, 95 strength required, SellValue: 32000"
			icon_state = "goldwand"
			sellvalue = 32000
			typi = "weapon"
			wpnspd = 0
			wlvl = 4
			twohanded = 0
			strreq = 95
			DamageMin = 142
			DamageMax = 148
			New()
		magicgoldwand
			name = "Gold Wand"
			description = ""
			icon_state = "goldwand"
			sellvalue = 32000
			typi = "weapon"
			wpnspd = 0
			wlvl = 4
			twohanded = 0
			strreq = 95
			DamageMin = 142
			DamageMax = 148
		goldstaff
			name = "Gold Staff"
			description = "<b>Gold Staff:</b>  160-171 damage, two-handed, 112 strength required, SellValue: 35000"
			icon_state = "goldstaff"
			sellvalue = 35000
			typi = "weapon"
			wpnspd = 0
			wlvl = 4
			twohanded = 1
			strreq = 112
			DamageMin = 160
			DamageMax = 171
			New()
		magicgoldstaff
			name = "Gold Staff"
			description = ""
			icon_state = "goldstaff"
			sellvalue = 35000
			typi = "weapon"
			wpnspd = 0
			wlvl = 4
			twohanded = 1
			strreq = 112
			DamageMin = 160
			DamageMax = 171
		goldaxe
			name = "Gold Axe"
			description = "<b>Gold Axe:</b>  290-334 damage, two-handed, 380 strength required, SellValue: 98000"
			icon_state = "goldaxe"
			sellvalue = 98000
			typi = "weapon"
			wpnspd = 0
			wlvl = 4
			twohanded = 1
			strreq = 380
			DamageMin = 290
			DamageMax = 334
			New()
		magicgoldaxe
			name = "Gold Axe"
			description = ""
			icon_state = "goldaxe"
			sellvalue = 98000
			typi = "weapon"
			wpnspd = 0
			wlvl = 4
			twohanded = 1
			strreq = 380
			DamageMin = 290
			DamageMax = 334





		leatherarmor
			name = "Leather Armor"
			description = "<b>Leather Armor:</b>  35 Defense, 4% Evade, 10 strength required, SellValue: 50"
			icon_state = "leather"
			sellvalue = 50
			typi = "armor"
			wlvl = 1
			strreq = 10
			Adefense = 35
			Aevade = 4
			New()
		uniqueleatherarmor
			name = "Lifeleak"
			description = "<font color = maroon><b>Lifeleak (Leather Armor):</b>  70 Defense, 4% Evade, +18 Str, +8 Int, 10 strength required"
			icon_state = "Lifeleak"
			sellvalue = 200
			typi = "armor"
			wlvl = 1
			strreq = 10
			Adefense = 70
			Aevade = 4
			STRbonus = 18
			INTbonus = 8
			New()
				if(usr.contents!=null)
					HPbonus = rand(50,100)
					var/ad1 = ", +[HPbonus] HP"
					description = "<font color = maroon><b>Lifeleak (Leather Armor):</b>  70 Defense, 4% Evade, +18 Str, +8 Int[ad1], 10 strength required"
		magicleatherarmor
			name = "Leather Armor"
			description = ""
			icon_state = "leather"
			sellvalue = 50
			typi = "armor"
			wlvl = 1
			strreq = 10
			Adefense = 35
			Aevade = 4
		clothes
			name = "Clothes"
			description = "<b>Clothes:</b>  8 Defense, 1% Evade, 1 strength required, SellValue: 5"
			icon_state = "clothes"
			sellvalue = 5
			typi = "armor"
			wlvl = 1
			strreq = 1
			Adefense = 8
			Aevade = 1
			New()
		uniqueclothes
			name = "Soul Flesh"
			description = "<font color = maroon><b>Soul Flesh (Clothes):</b>  16 Defense, 1% Evade, +10 Str, +16 Int, 1 strength required"
			icon_state = "Soul Flesh"
			sellvalue = 20
			typi = "armor"
			wlvl = 1
			strreq = 1
			Adefense = 16
			Aevade = 1
			STRbonus = 10
			INTbonus = 16
			New()
				if(usr.contents!=null)
					POISres = rand(1,30)
					var/ad1 = ", +[POISres] Poison Resistance"
					description = "<font color = maroon><b>Soul Flesh (Clothes):</b>  16 Defense, 1% Evade, +10 Str, +16 Int[ad1], 1 strength required"
		magicclothes
			name = "Clothes"
			description = ""
			icon_state = "clothes"
			sellvalue = 5
			typi = "armor"
			wlvl = 1
			strreq = 1
			Adefense = 8
			Aevade = 1
		darkclothes
			name = "Dark Clothes"
			description = "<b>Dark Clothes:</b>  6 Defense, 2% Evade, 4 strength required, SellValue: 10"
			icon_state = "darkclothes"
			sellvalue = 10
			typi = "armor"
			wlvl = 1
			strreq = 4
			Adefense = 6
			Aevade = 2
			New()
		uniquedarkclothes
			name = "Blackened"
			description = "<font color = maroon><b>Blackened (Dark Clothes):</b>  12 Defense, 2% Evade, +6 Str, +20 Int, 4 strength required"
			icon_state = "Blackened"
			sellvalue = 40
			typi = "armor"
			wlvl = 1
			strreq = 4
			Adefense = 12
			Aevade = 2
			STRbonus = 6
			INTbonus = 20
			New()
				if(usr.contents!=null)
					DARKres = rand(1,30)
					var/ad1 = ", +[DARKres] Dark Resistance"
					description = "<font color = maroon><b>Blackened (Dark Clothes):</b>  12 Defense, 2% Evade, +6 Str, +20 Int[ad1], 4 strength required"

		magicdarkclothes
			name = "Dark Clothes"
			description = ""
			icon_state = "darkclothes"
			sellvalue = 10
			typi = "armor"
			wlvl = 1
			strreq = 4
			Adefense = 6
			Aevade = 2
		chainmail
			name = "Chainmail"
			description = "<b>Chainmail:</b>  50 Defense, 5% Evade, 24 strength required, SellValue: 500"
			icon_state = "chainmail"
			sellvalue = 500
			typi = "armor"
			wlvl = 2
			strreq = 24
			Adefense = 50
			Aevade = 5
			New()
		uniquechainmail
			name = "Glint"
			description = "<font color = maroon><b>Glint (Chainmail):</b>  100 Defense, 5% Evade, +8 Str, +8 Int, 24 strength required"
			icon_state = "Glint"
			sellvalue = 2000
			typi = "armor"
			wlvl = 2
			strreq = 24
			Adefense = 100
			Aevade = 5
			STRbonus = 8
			INTbonus = 8
			New()
				if(usr.contents!=null)
					LITres = rand(1,30)
					var/ad1 = ", +[LITres] Lightning Resistance"
					LIGHTNINGBOLTbonus = rand(5,20)
					var/ad2 = ", +[LIGHTNINGBOLTbonus] Lightningbolt"
					description = "<font color = maroon><b>Glint (Chainmail):</b>  100 Defense, 5% Evade, +8 Str, +8 Int[ad1][ad2], 24 strength required"
		magicchainmail
			name = "Chainmail"
			description = ""
			icon_state = "chainmail"
			sellvalue = 500
			typi = "armor"
			wlvl = 2
			strreq = 24
			Adefense = 50
			Aevade = 5
		platemail
			name = "Platemail"
			description = "<b>Platemail:</b>  75 Defense, 7% Evade, 60 strength required, SellValue: 1125"
			icon_state = "platemail"
			sellvalue = 1125
			typi = "armor"
			wlvl = 2
			strreq = 60
			Adefense = 75
			Aevade = 7
			New()
		uniqueplatemail
			name = "Cyrus' Tricks"
			description = "<font color = maroon><b>Cyrus' Tricks (Platemail):</b>  150 Defense, 7% Evade, +4 Str, +15 Int, 60 strength required"
			icon_state = "Cyrus' Tricks"
			sellvalue = 4500
			typi = "armor"
			wlvl = 2
			strreq = 60
			Adefense = 150
			Aevade = 7
			STRbonus = 4
			INTbonus = 15
			New()
				if(usr.contents!=null)
					MPbonus = rand(50,250)
					var/ad1 = ", +[MPbonus] MP"
					ICEres = rand(5,20)
					var/ad2 = ", +[ICEres] Ice Resistance"
					description = "<font color = maroon><b>Cyrus' Tricks (Platemail):</b>  150 Defense, 7% Evade, +4 Str, +15 Int[ad1][ad2], 60 strength required"
		magicplatemail
			name = "Platemail"
			description = ""
			icon_state = "platemail"
			sellvalue = 1125
			typi = "armor"
			wlvl = 2
			strreq = 60
			Adefense = 75
			Aevade = 7
		frostmail
			name = "Frostmail"
			description = "<b>Frostmail:</b>  120 Defense, 9% Evade, 100 strength required, SellValue: 2600"
			icon_state = "frostmail"
			sellvalue = 2600
			typi = "armor"
			wlvl = 3
			strreq = 100
			Adefense = 120
			Aevade = 9
			New()
		uniquefrostmail
			name = "Froststop"
			description = "<font color = maroon><b>Froststop (Frostmail):</b>  240 Defense, 9% Evade, +15 Str, +15 Int, 100 strength required"
			icon_state = "Froststop"
			sellvalue = 10400
			typi = "armor"
			wlvl = 3
			strreq = 100
			Adefense = 240
			Aevade = 9
			STRbonus = 15
			INTbonus = 15
			New()
				if(usr.contents!=null)
					ARCTICWINDbonus = rand(10,15)
					var/ad1 = ", +[ARCTICWINDbonus] ArcticWind"
					ICEres = rand(16,23)
					var/ad2 = ", +[ICEres] Ice Resistance"
					description = "<font color = maroon><b>Froststop (Frostmail):</b>  240 Defense, 9% Evade, +15 Str, +15 Int[ad1][ad2], 100 strength required"
		magicfrostmail
			name = "Frostmail"
			description = ""
			icon_state = "frostmail"
			sellvalue = 2600
			typi = "armor"
			wlvl = 3
			strreq = 100
			Adefense = 120
			Aevade = 9
		obsidianplate
			name = "Obsidian Plate"
			description = "<b>Obsidian Plate:</b>  155 Defense, 12% Evade, 180 strength required, SellValue: 6400"
			icon_state = "obsidianplate"
			sellvalue = 6400
			typi = "armor"
			wlvl = 3
			strreq = 180
			Adefense = 155
			Aevade = 12
			New()
		uniqueobsidianplate
			name = "Flamefeast"
			description = "<font color = maroon><b>Flamefeast (Obsidian Plate):</b>  310 Defense, 12% Evade, +22 Str, +8 Int, 180 strength required"
			icon_state = "Flamefeast"
			sellvalue = 25600
			typi = "armor"
			wlvl = 3
			strreq = 180
			Adefense = 310
			Aevade = 12
			STRbonus = 22
			INTbonus = 8
			New()
				if(usr.contents!=null)
					FLAMEbonus = rand(10,15)
					var/ad1 = ", +[FLAMEbonus] Flame"
					FIREres = rand(16,23)
					var/ad2 = ", +[FIREres] Fire Resistance"
					HPbonus = rand(150,400)
					var/ad3 = ", +[HPbonus] HP"
					description = "<font color = maroon><b>Flamefeast (Obsidian Plate):</b>  310 Defense, 12% Evade, +22 Str, +8 Int[ad1][ad2][ad3], 180 strength required"
		magicobsidianplate
			name = "Obsidian Plate"
			description = ""
			icon_state = "obsidianplate"
			sellvalue = 6400
			typi = "armor"
			wlvl = 3
			strreq = 180
			Adefense = 155
			Aevade = 12
		ironarmor
			name = "Iron Armor"
			description = "<b>Iron Armor:</b>  240 Defense, 14% Evade, 250 strength required, SellValue: 50000"
			icon_state = "ironarmor"
			sellvalue = 50000
			typi = "armor"
			wlvl = 4
			strreq = 250
			Adefense = 240
			Aevade = 14
			New()
		magicironarmor
			name = "Iron Armor"
			description = ""
			icon_state = "ironarmor"
			sellvalue = 50000
			typi = "armor"
			wlvl = 4
			strreq = 250
			Adefense = 240
			Aevade = 14
		goldarmor
			name = "Gold Armor"
			description = "<b>Gold Armor:</b>  370 Defense, 15% Evade, 290 strength required, SellValue: 110000"
			icon_state = "goldarmor"
			sellvalue = 110000
			typi = "armor"
			wlvl = 4
			strreq = 290
			Adefense = 370
			Aevade = 15
			New()
		magicgoldarmor
			name = "Gold Armor"
			description = ""
			icon_state = "goldarmor"
			sellvalue = 110000
			typi = "armor"
			wlvl = 4
			strreq = 290
			Adefense = 370
			Aevade = 15







		smallshield
			name = "Small Shield"
			description = "<b>Small Shield:</b>  18 Defense, 6% Evade, 8 strength required, SellValue: 50"
			icon_state = "smallshield"
			sellvalue = 50
			typi = "shield"
			wlvl = 1
			strreq = 8
			Adefense = 18
			Aevade = 6
			New()
		uniquesmallshield
			name = "Faerie"
			description = "<font color = maroon><b>Faerie (Small Shield):</b>  36 Defense, 6% Evade, +1 Str, +6 Int, 8 strength required"
			icon_state = "Faerie"
			sellvalue = 200
			typi = "shield"
			wlvl = 1
			strreq = 8
			Adefense = 36
			Aevade = 6
			STRbonus = 1
			INTbonus = 6
			New()
				if(usr.contents!=null)
					ICEBOLTbonus = rand(1,10)
					var/ad1 = ", +[ICEBOLTbonus] Icebolt"
					FIREBOLTbonus = rand(1,10)
					var/ad2 = ", +[FIREBOLTbonus] Firebolt"
					description = "<font color = maroon><b>Faerie (Small Shield):</b>  36 Defense, 6% Evade, +1 Str, +6 Int[ad1][ad2], 8 strength required"
		magicsmallshield
			name = "Small Shield"
			description = ""
			icon_state = "smallshield"
			sellvalue = 50
			typi = "shield"
			wlvl = 1
			strreq = 8
			Adefense = 18
			Aevade = 6
		heavyshield
			name = "Heavy Shield"
			description = "<b>Heavy Shield:</b>  30 Defense, 9% Evade, 16 strength required, SellValue: 125"
			icon_state = "heavyshield"
			sellvalue = 125
			typi = "shield"
			wlvl = 1
			strreq = 16
			Adefense = 30
			Aevade = 9
			New()
		uniqueheavyshield
			name = "Sapphire"
			description = "<font color = maroon><b>Sapphire (Heavy Shield):</b>  60 Defense, 9% Evade, +16 Str, +3 Int, 16 strength required"
			icon_state = "Sapphire"
			sellvalue = 500
			typi = "shield"
			wlvl = 1
			strreq = 16
			Adefense = 60
			Aevade = 9
			STRbonus = 16
			INTbonus = 3
			New()
				if(usr.contents!=null)
					ICEres = rand(20,30)
					var/ad1 = ", +[ICEres] Ice Resistance"
					ICEBOLTbonus = rand(1,4)
					var/ad2 = ", +[ICEBOLTbonus] Icebolt"
					description = "<font color = maroon><b>Sapphire (Heavy Shield):</b>  60 Defense, 9% Evade, +16 Str, +3 Int[ad1][ad2], 16 strength required"
		magicheavyshield
			name = "Heavy Shield"
			description = ""
			icon_state = "heavyshield"
			sellvalue = 125
			typi = "shield"
			wlvl = 1
			strreq = 16
			Adefense = 30
			Aevade = 9
		buckler
			name = "Buckler"
			description = "<b>Buckler:</b>  46 Defense, 7% Evade, 25 strength required, SellValue: 490"
			icon_state = "buckler"
			sellvalue = 490
			typi = "shield"
			wlvl = 2
			strreq = 25
			Adefense = 46
			Aevade = 7
			New()
		uniquebuckler
			name = "Luna"
			description = "<font color = maroon><b>Luna (Buckler):</b>  92 Defense, 7% Evade, +13 Str, +13 Int, 25 strength required"
			icon_state = "Luna"
			sellvalue = 1960
			typi = "shield"
			wlvl = 2
			strreq = 25
			Adefense = 92
			Aevade = 7
			STRbonus = 13
			INTbonus = 13
			New()
				if(usr.contents!=null)
					DARKbonus = rand(8,14)
					var/ad1 = ", +[DARKbonus] Dark"
					description = "<font color = maroon><b>Luna (Buckler):</b>  92 Defense, 7% Evade, +13 Str, +13 Int[ad1], 25 strength required"
		magicbuckler
			name = "Buckler"
			description = ""
			icon_state = "buckler"
			sellvalue = 490
			typi = "shield"
			wlvl = 2
			strreq = 25
			Adefense = 46
			Aevade = 7
		bulwark
			name = "Bulwark"
			description = "<b>Bulwark:</b>  38 Defense, 10% Evade, 28 strength required, SellValue: 600"
			icon_state = "bulwark"
			sellvalue = 600
			typi = "shield"
			wlvl = 2
			strreq = 28
			Adefense = 38
			Aevade = 10
			New()
		uniquebulwark
			name = "Illumine"
			description = "<font color = maroon><b>Illumine (Bulwark):</b>  76 Defense, 10% Evade, +8 Str, +18 Int, 28 strength required"
			icon_state = "Illumine"
			sellvalue = 2400
			typi = "shield"
			wlvl = 2
			strreq = 28
			Adefense = 76
			Aevade = 10
			STRbonus = 8
			INTbonus = 18
			New()
				if(usr.contents!=null)
					LITres = rand(25,30)
					var/ad1 = ", +[LITres] Lightning Resistance"
					description = "<font color = maroon><b>Illumine (Bulwark):</b>  76 Defense, 10% Evade, +8 Str, +18 Int[ad1], 28 strength required"
		magicbulwark
			name = "Bulwark"
			description = ""
			icon_state = "bulwark"
			sellvalue = 600
			typi = "shield"
			wlvl = 2
			strreq = 28
			Adefense = 38
			Aevade = 10
		escutcheon
			name = "Escutcheon"
			description = "<b>Escutcheon:</b>  60 Defense, 10% Evade, 40 strength required, SellValue: 1300"
			icon_state = "escutcheon"
			sellvalue = 1300
			typi = "shield"
			wlvl = 2
			strreq = 40
			Adefense = 60
			Aevade = 10
			New()
		uniqueescutcheon
			name = "Dravidian's Seal"
			description = "<font color = maroon><b>Dravidian's Seal (Escutcheon):</b>  120 Defense, 10% Evade, +14 Str, +10 Int, 40 strength required"
			icon_state = "Dravidian's Seal"
			sellvalue = 5200
			typi = "shield"
			wlvl = 2
			strreq = 40
			Adefense = 120
			Aevade = 10
			STRbonus = 14
			INTbonus = 10
			New()
				if(usr.contents!=null)
					HPbonus = rand(200,300)
					var/ad1 = ", +[HPbonus] HP"
					var/blah = rand(5,15)
					FIREres = blah
					ICEres = blah
					LITres = blah
					POISres = blah
					DARKres = blah
					var/ad2 = ", +[blah] All Resistances"
					description = "<font color = maroon><b>Dravidian's Seal (Escutcheon):</b>  120 Defense, 10% Evade, +14 Str, +10 Int[ad1][ad2], 40 strength required"
		magicescutcheon
			name = "Escutcheon"
			description = ""
			icon_state = "escutcheon"
			sellvalue = 1300
			typi = "shield"
			wlvl = 2
			strreq = 40
			Adefense = 60
			Aevade = 10
		eyeshield
			name = "Eye Shield"
			description = "<b>Eye Shield:</b>  95 Defense, 11% Evade, 72 strength required, SellValue: 2775"
			icon_state = "eyeshield"
			sellvalue = 2775
			typi = "shield"
			wlvl = 3
			strreq = 72
			Adefense = 95
			Aevade = 11
			New()
		uniqueeyeshield
			name = "Mesmerize"
			description = "<font color = maroon><b>Mesmerize (Eye Shield):</b>  190 Defense, 11% Evade, +20 Str, +20 Int, 72 strength required"
			icon_state = "Mesmerize"
			sellvalue = 11100
			typi = "shield"
			wlvl = 3
			strreq = 72
			Adefense = 190
			Aevade = 11
			STRbonus = 20
			INTbonus = 20
			New()
				if(usr.contents!=null)
					HPbonus = rand(200,300)
					var/ad1 = ", +[HPbonus] HP"
					MPbonus = rand(200,300)
					var/ad2 = ", +[MPbonus] MP"
					var/blah = rand(24,33)
					FIREres = blah
					ICEres = blah
					LITres = blah
					POISres = blah
					DARKres = blah
					var/ad3 = ", +[blah] All Resistances"
					description = "<font color = maroon><b>Mesmerize (Eye Shield):</b>  190 Defense, 11% Evade, +20 Str, +20 Int[ad1][ad2][ad3], 72 strength required"
		magiceyeshield
			name = "Eye Shield"
			description = ""
			icon_state = "eyeshield"
			sellvalue = 2775
			typi = "shield"
			wlvl = 3
			strreq = 72
			Adefense = 95
			Aevade = 11
		decussated
			name = "Decussated"
			description = "<b>Decussated:</b>  78 Defense, 16% Evade, 95 strength required, SellValue: 4880"
			icon_state = "decussated"
			sellvalue = 4880
			typi = "shield"
			wlvl = 3
			strreq = 95
			Adefense = 78
			Aevade = 16
			New()
		uniquedecussated
			name = "Raven's Guard"
			description = "<font color = maroon><b>Raven's Guard (Decussated):</b>  156 Defense, 16% Evade, +40 Strength, 95 strength required"
			icon_state = "Raven's Guard"
			sellvalue = 19520
			typi = "shield"
			wlvl = 3
			strreq = 95
			Adefense = 156
			Aevade = 16
			STRbonus = 40
			New()
				if(usr.contents!=null)
					HPbonus = rand(200,300)
					var/ad1 = ", +[HPbonus] HP"
					DARKbonus = rand(22,34)
					var/ad2 = ", +[DARKbonus] Dark"
					DEMIbonus = rand(3,6)
					var/ad3 = ", +[DEMIbonus] Demi"
					description = "<font color = maroon><b>Raven's Guard (Decussated):</b>  156 Defense, 16% Evade, +40 Strength[ad1][ad2][ad3], 95 strength required"
		magicdecussated
			name = "Decussated"
			description = ""
			icon_state = "decussated"
			sellvalue = 4880
			typi = "shield"
			wlvl = 3
			strreq = 95
			Adefense = 78
			Aevade = 16
		ironshield
			name = "Iron Shield"
			description = "<b>Iron Shield:</b>  155 Defense, 22% Evade, 105 strength required, SellValue: 38000"
			icon_state = "ironshield"
			sellvalue = 38000
			typi = "shield"
			wlvl = 4
			strreq = 105
			Adefense = 155
			Aevade = 22
			New()
		magicironshield
			name = "Iron Shield"
			description = ""
			icon_state = "ironshield"
			sellvalue = 38000
			typi = "shield"
			wlvl = 4
			strreq = 105
			Adefense = 155
			Aevade = 22
		goldshield
			name = "Gold Shield"
			description = "<b>Gold Shield:</b>  285 Defense, 15% Evade, 142 strength required, SellValue: 40000"
			icon_state = "goldshield"
			sellvalue = 40000
			typi = "shield"
			wlvl = 4
			strreq = 142
			Adefense = 285
			Aevade = 15
			New()
		magicgoldshield
			name = "Gold Shield"
			description = ""
			icon_state = "goldshield"
			sellvalue = 40000
			typi = "shield"
			wlvl = 4
			strreq = 142
			Adefense = 285
			Aevade = 15


		//these commented out ones used to be the items that did not have uniques, but i forgot to delete some of them from here apparently.
/*
		longsword
			name = "Long Sword"
			description = "<b>Long Sword:</b>  14-17 damage, 24 strength required"
			icon_state = "longsword"
			sellvalue = 140
			typi = "weapon"
			twohanded = 0
			strreq = 24
			DamageMin = 14
			DamageMax = 17
		leatherarmor
			name = "Leather Armor"
			description = "<b>Leather Armor:</b>  35 Defense, 4% Evade, 10 strength required"
			icon_state = "leather"
			sellvalue = 50
			typi = "armor"
			strreq = 10
			Adefense = 35
			Aevade = 4
		darkclothes
			name = "Dark Clothes"
			description = "<b>Dark Clothes:</b>  6 Defense, 2% Evade, 4 strength required"
			icon_state = "darkclothes"
			sellvalue = 10
			typi = "armor"
			strreq = 4
			Adefense = 6
			Aevade = 2
		frostmail
			name = "Frostmail"
			description = "<b>Frostmail:</b>  120 Defense, 9% Evade, 100 strength required"
			icon_state = "frostmail"
			sellvalue = 2600
			typi = "armor"
			strreq = 100
			Adefense = 120
			Aevade = 9
		obsidianplate
			name = "Obsidian Plate"
			description = "<b>Obsidian Plate:</b>  155 Defense, 12% Evade, 180 strength required"
			icon_state = "obsidianplate"
			sellvalue = 6400
			typi = "armor"
			strreq = 180
			Adefense = 155
			Aevade = 12






		eyeshield
			name = "Eye Shield"
			description = "<b>Eye Shield:</b>  95 Defense, 11% Evade, 72 strength required"
			icon_state = "eyeshield"
			sellvalue = 2775
			typi = "shield"
			strreq = 55
			Adefense = 95
			Aevade = 11
		decussated
			name = "Decussated"
			description = "<b>Decussated:</b>  78 Defense, 16% Evade, 95 strength required"
			icon_state = "decussated"
			sellvalue = 4880
			typi = "shield"
			strreq = 95
			Adefense = 78
			Aevade = 16

*/
