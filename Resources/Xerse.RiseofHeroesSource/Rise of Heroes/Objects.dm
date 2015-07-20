obj
	proc
		NoGold() // this function get called alot, so it is defined up here
			usr << "<font color = teal>You do not have enough gold."
		Selling(var/obj/J in usr) // so does this one
			var/mob/players/M = usr
			if ( istype(J,/obj/weapons) || istype(J,/obj/books) || istype(J,/obj/items) ) // gotta check to be sure it is the right type of item
				if(J.suffix == "Equipped") // you can't sell equipped stuff
					usr << "<font color = teal>Un-equip [J] first!"
				else
					if((input("Are you sure about selling [J] for [J.sellvalue] gold?") in list("Yes","No")) != "Yes")
						return // leave this function if you said no
					//otherwise...
					M.gold+=J.sellvalue // sell the item
					usr << "\green<b>You sold [J] for [J.sellvalue] gold."
					del J
			else
				usr << "You can't sell that"

	//These are all pretty self-explanatory.  Define what the object is, how it works, and protect from letting the player do anything stupid.


	Inn1
		name = "Innkeeper"
		density = 1 // cant walk through him
		icon = 'people.dmi'
		icon_state = "man1"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/amount = round(((M.MAXHP-M.HP)+(M.MAXMP-M.MP))/7,1) // calculation for cost based on your HP and MP
				src.verbs-=new/obj/Inn1/verb/Talk() // protection against talking multiple times
				M.nomotion=1 // protection against opening the dialog and moving around
				var/I = input("Would you like to stay for [amount] gold?","INN") in list ("Yes","No")
				switch(I)
					if ("Yes") // taking a rest
						if (M.gold>=amount) // if you can afford it
							M.HP = M.MAXHP
							M.MP = M.MAXMP
							M.poisonD=0
							M.poisoned=0
							M.poisonDMG=0
							M.overlays = null
							M.gold-=amount
							usr << "Thank you. Have a nice day."
							M.nomotion=0
							src.verbs+=new/obj/Inn1/verb/Talk()
						else // poor bum
							NoGold()
							M.nomotion=0
							src.verbs+=new/obj/Inn1/verb/Talk()
					else
						usr << "<font color = teal>Maybe next time."
						M.nomotion=0
						src.verbs+=new/obj/Inn1/verb/Talk()
	Inn2
		name = "Kenny"
		density = 1
		icon = 'people.dmi'
		icon_state = "kenny"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/amount = round(((M.MAXHP-M.HP)+(M.MAXMP-M.MP))/7,1)
				src.verbs-=new/obj/Inn2/verb/Talk()
				M.nomotion=1
				var/I = input("Would you like to stay for [amount] gold?","INN") in list ("Yes","No")
				switch(I)
					if ("Yes")
						if (M.gold>=amount)
							M.HP = M.MAXHP
							M.MP = M.MAXMP
							M.poisonD=0
							M.poisoned=0
							M.poisonDMG=0
							M.overlays = null
							M.gold-=amount
							usr << "Mmmm MNn. Nnmm mnmnN MmmNm."
							M.nomotion=0
							src.verbs+=new/obj/Inn2/verb/Talk()
						else
							NoGold()
							M.nomotion=0
							src.verbs+=new/obj/Inn2/verb/Talk()
					else
						usr << "<font color = teal>Mmmnm Mnnm Nnnmm."
						M.nomotion=0
						src.verbs+=new/obj/Inn2/verb/Talk()
	Weapons1
		name = "Weapon Seller"
		density = 1
		icon = 'people.dmi'
		icon_state = "man2"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(2)
				M = usr
				var/K = (input("Welcome","WEAPONS") in list("Buy","Sell","Leave"))
				switch(K)
					if("Buy")
						var
							I
							const
								temp1 = "Short Sword: 3-6 dmg, 5 str req::50 gold"
								temp2 = "Small Axe: 6-11 dmg, 10 str req::100 gold"
								temp3 = "Wooden Wand: 4-5 dmg, 5 str req::50 gold"
								temp4 = "Short Staff(2handed): 2-8 dmg, 5 str req::30 gold"
								temp5 = "Long Staff(2handed): 5-11 dmg, 8 str req::60 gold"
								temp6 = "Blade: 10-13 dmg, 14 str req::200 gold"
								temp7 = "Long Sword: 14-17 dmg, 24 str req::280 gold"
						I = input("What would you like to buy?","WEAPONS",I) in list (temp1,temp2,temp3,temp4,temp5,temp6,temp7,"Leave")
						switch(I)
							if(temp1)
								if (M.gold>=50)
									M.gold-=50
									var/obj/weapons/shortsword/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp2)
								if (M.gold>=100)
									M.gold-=100
									var/obj/weapons/smallaxe/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp3)
								if (M.gold>=50)
									M.gold-=50
									var/obj/weapons/woodwand/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp4)
								if (M.gold>=30)
									M.gold-=30
									var/obj/weapons/shortstaff/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp5)
								if (M.gold>=60)
									M.gold-=60
									var/obj/weapons/longstaff/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp6)
								if (M.gold>=200)
									M.gold-=200
									var/obj/weapons/blade/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp7)
								if (M.gold>=280)
									M.gold-=280
									var/obj/weapons/longsword/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							else
								usr << "<font color = teal>Maybe next time."
					if("Sell")
						Selling(input("What would you like to sell") in usr)
					else
						usr << "<font color = teal>Maybe next time."
	Weapons2
		name = "Weapon Seller"
		density = 1
		icon = 'people.dmi'
		icon_state = "man5"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/K = (input("Welcome","WEAPONS") in list("Buy","Sell","Leave"))
				switch(K)
					if("Buy")
						var
							I
							const
								temp1 = "Broad Blade: 19-22 dmg, 30 str req::600 gold"
								temp2 = "Large Axe: 20-25 dmg, 38 str req::725 gold"
								temp3 = "Wand: 15-16 dmg, 20 str req::430 gold"
								temp4 = "Power Staff(2handed): 16-22 dmg, 22 str req::400 gold"
								temp5 = "Battle Axe(2handed): 34-39 dmg, 55 str req::1850 gold"
								temp6 = "Broad Sword(2handed): 26-29 dmg, 42 str req::980 gold"
						I = input("What would you like to buy?","WEAPONS",I) in list (temp1,temp2,temp3,temp4,temp5,temp6,"Leave")
						switch(I)
							if(temp1)
								if (M.gold>=600)
									M.gold-=600
									var/obj/weapons/broadblade/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp2)
								if (M.gold>=725)
									M.gold-=725
									var/obj/weapons/largeaxe/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp3)
								if (M.gold>=430)
									M.gold-=430
									var/obj/weapons/wand/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp4)
								if (M.gold>=400)
									M.gold-=400
									var/obj/weapons/powerstaff/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp5)
								if (M.gold>=1850)
									M.gold-=1850
									var/obj/weapons/battleaxe/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp6)
								if (M.gold>=980)
									M.gold-=980
									var/obj/weapons/broadsword/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							else
								usr << "<font color = teal>Maybe next time."
					if("Sell")
						Selling(input("What would you like to sell") in usr)
					else
						usr << "<font color = teal>Maybe next time."
	Weapons3
		name = "Weapon Seller"
		density = 1
		icon = 'people.dmi'
		icon_state = "man8"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/K = (input("Welcome","WEAPONS") in list("Buy","Sell","Leave"))
				switch(K)
					if("Buy")
						var
							I
							const
								temp1 = "Rapier: 48-51 dmg, 70 str req::3250 gold"
								temp2 = "Batblade: 56-59 dmg, 82 str req::6500 gold"
								temp3 = "Jade Staff: 61-65 dmg, 63 str req::6800 gold"
								temp4 = "Triadic Orb(2hand): 74-78 dmg, 77 str req::7500 gold"
								temp5 = "Icicle Blade(2hand): 80-85 dmg, 118 str req::15720 gold"
								temp6 = "Scorching Sword(2hand): 94-97 dmg, 144 str req::24000 gold"
						I = input("What would you like to buy?","WEAPONS",I) in list (temp1,temp2,temp3,temp4,temp5,temp6,"Leave")
						switch(I)
							if(temp1)
								if (M.gold>=3250)
									M.gold-=3250
									var/obj/weapons/rapier/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp2)
								if (M.gold>=6500)
									M.gold-=6500
									var/obj/weapons/batblade/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp3)
								if (M.gold>=6800)
									M.gold-=6800
									var/obj/weapons/jadestaff/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp4)
								if (M.gold>=7500)
									M.gold-=7500
									var/obj/weapons/triadicorb/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp5)
								if (M.gold>=15720)
									M.gold-=15720
									var/obj/weapons/icicleblade/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp6)
								if (M.gold>=24000)
									M.gold-=24000
									var/obj/weapons/scorchingsword/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							else
								usr << "<font color = teal>Maybe next time."
					if("Sell")
						Selling(input("What would you like to sell") in usr)
					else
						usr << "<font color = teal>Maybe next time."
	Weapons4
		name = "Stan"
		density = 1
		icon = 'people.dmi'
		icon_state = "stan"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/K = (input("What do you want?","WEAPONS") in list("Buy","Sell","Leave"))
				switch(K)
					if("Buy")
						var
							I
							const
								temp1 = "Gold Sword: 170-178 dmg, 195 str req::120000 gold"
								temp3 = "Gold Wand: 142-148 dmg, 95 str req::64000 gold"
								temp4 = "Gold Staff(2hand): 160-171 dmg, 112 str req::70000 gold"
								temp5 = "Gold Axe(2hand): 290-334 dmg, 380 str req::196000 gold"
								temp6 = "Steel Sword(2hand): 174-195 dmg, 240 str req::92000 gold"
						I = input("What do you want to buy?","WEAPONS",I) in list (temp1,temp3,temp4,temp5,temp6,"Leave")
						switch(I)
							if(temp1)
								if (M.gold>=120000)
									M.gold-=120000
									var/obj/weapons/goldsword/J = new(M)
									usr << "[J]. That's cool."
								else
									NoGold()
							if(temp3)
								if (M.gold>=64000)
									M.gold-=64000
									var/obj/weapons/goldwand/J = new(M)
									usr << "[J]. That's cool."
								else
									NoGold()
							if(temp4)
								if (M.gold>=70000)
									M.gold-=70000
									var/obj/weapons/goldstaff/J = new(M)
									usr << "[J]. That's cool."
								else
									NoGold()
							if(temp5)
								if (M.gold>=196000)
									M.gold-=196000
									var/obj/weapons/goldaxe/J = new(M)
									usr << "[J]. That's cool."
								else
									NoGold()
							if(temp6)
								if (M.gold>=92000)
									M.gold-=92000
									var/obj/weapons/steelsword/J = new(M)
									usr << "[J]. That's cool."
								else
									NoGold()
							else
								usr << "<font color = teal>Aww. Too bad."
					if("Sell")
						Selling(input("What do you want to sell") in usr)
					else
						usr << "<font color = teal>Aww. Too bad."
	WeaponsX
		name = "Invisoman"
		density = 1
		icon = 'people.dmi'
		icon_state = ""
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/I
				I = input("5,000,000 Gold:: The Mmbahfather (Steel Sword):  348-390 damage, one-handed, Increased Attack Speed, +60 Str, +20 Int, +600-1000 HP(varies), +600-1000 MP(varies), +5-10 Demi(varies), +24-33 Resist All(varies), 240 strength required","INVISOMAN",I) in list ("Yes","No")
				switch(I)
					if("Yes")
						if (M.gold>=5000000)
							M.gold-=5000000
							var/obj/weapons/uniquesteelsword/J = new(M)
							usr << "Thank you for buying [J]."
						else
							NoGold()
					else
						usr << "<font color = teal>Too bad."
	Armors1
		name = "Armor Seller"
		density = 1
		icon = 'people.dmi'
		icon_state = "man3"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(2)
				M = usr
				var/K = (input("Welcome","ARMORS") in list("Buy","Sell","Leave"))
				switch(K)
					if("Buy")
						var
							I
							const
								temp1 = "Clothes: 8 def, 1% eva, 1 str req::10 gold"
								temp2 = "Dark Clothes: 6 def, 2% eva, 4 str req::20 gold"
								temp3 = "Leather Armor: 35 def, 4% eva, 10 str req::100 gold"
								temp4 = "Small Shield: 18 def, 6% eva, 8 str req::100 gold"
								temp5 = "Heavy Shield: 30 def, 9% eva, 16 str req::250 gold"
						I = input("What would you like to buy?","ARMORS",I) in list (temp1,temp2,temp3,temp4,temp5,"Leave")
						switch(I)
							if(temp1)
								if (M.gold>=10)
									M.gold-=10
									var/obj/weapons/clothes/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp2)
								if (M.gold>=20)
									M.gold-=20
									var/obj/weapons/darkclothes/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp3)
								if (M.gold>=100)
									M.gold-=100
									var/obj/weapons/leatherarmor/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp4)
								if (M.gold>=100)
									M.gold-=100
									var/obj/weapons/smallshield/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp5)
								if (M.gold>=250)
									M.gold-=250
									var/obj/weapons/heavyshield/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							else
								usr << "<font color = teal>Maybe next time."
					if("Sell")
						Selling(input("What would you like to sell") in usr)
					else
						usr << "<font color = teal>Maybe next time."
	Armors2
		name = "Armor Seller"
		density = 1
		icon = 'people.dmi'
		icon_state = "man7"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/K = (input("Welcome","ARMORS") in list("Buy","Sell","Leave"))
				switch(K)
					if("Buy")
						var
							I
							const
								temp1 = "Chainmail: 50 def, 5% eva, 24 str req::1000 gold"
								temp2 = "Platemail: 75 def, 7% eva, 60 str req::2250 gold"
								temp3 = "Buckler: 46 def, 7% eva, 25 str req::980 gold"
								temp4 = "Bulwark: 38 def, 10% eva, 28 str req::1200 gold"
								temp5 = "Escutcheon: 60 def, 10% eva, 40 str req::2600 gold"
						I = input("What would you like to buy?","ARMORS",I) in list (temp1,temp2,temp3,temp4,temp5,"Leave")
						switch(I)
							if(temp1)
								if (M.gold>=1000)
									M.gold-=1000
									var/obj/weapons/chainmail/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp2)
								if (M.gold>=2250)
									M.gold-=2250
									var/obj/weapons/platemail/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp3)
								if (M.gold>=980)
									M.gold-=980
									var/obj/weapons/buckler/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp4)
								if (M.gold>=1200)
									M.gold-=1200
									var/obj/weapons/bulwark/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp5)
								if (M.gold>=2600)
									M.gold-=2600
									var/obj/weapons/escutcheon/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							else
								usr << "<font color = teal>Maybe next time."
					if("Sell")
						Selling(input("What would you like to sell") in usr)
					else
						usr << "<font color = teal>Maybe next time."
	Armors3
		name = "Armor Seller"
		density = 1
		icon = 'people.dmi'
		icon_state = "man6"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/K = (input("Welcome","ARMORS") in list("Buy","Sell","Leave"))
				switch(K)
					if("Buy")
						var
							I
							const
								temp1 = "Frostmail: 120 def, 9% eva, 100 str req::5200 gold"
								temp2 = "Obsidian Plate: 155 def, 12% eva, 180 str req::12800 gold"
								temp3 = "Eye Shield: 95 def, 11% eva, 72 str req::5550 gold"
								temp4 = "Decussated: 78 def, 16% eva, 95 str req::9760 gold"
						I = input("What would you like to buy?","ARMORS",I) in list (temp1,temp2,temp3,temp4,"Leave")
						switch(I)
							if(temp1)
								if (M.gold>=5200)
									M.gold-=5200
									var/obj/weapons/frostmail/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp2)
								if (M.gold>=12800)
									M.gold-=12800
									var/obj/weapons/obsidianplate/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp3)
								if (M.gold>=5550)
									M.gold-=5550
									var/obj/weapons/eyeshield/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							if(temp4)
								if (M.gold>=9760)
									M.gold-=9760
									var/obj/weapons/decussated/J = new(M)
									usr << "Thank you for buying [J]."
								else
									NoGold()
							else
								usr << "<font color = teal>Maybe next time."
					if("Sell")
						Selling(input("What would you like to sell") in usr)
					else
						usr << "<font color = teal>Maybe next time."
	Armors4
		name = "Kyle"
		density = 1
		icon = 'people.dmi'
		icon_state = "kyle"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var/K = (input("Don't make fun of my mom","ARMORS") in list("Buy","Sell","Leave"))
				switch(K)
					if("Buy")
						var
							I
							const
								temp1 = "Iron Armor: 240 def, 14% eva, 250 str req::100000 gold"
								temp2 = "Gold Armor: 370 def, 15% eva, 290 str req::220000 gold"
								temp3 = "Iron Shield: 155 def, 22% eva, 105 str req::76000 gold"
								temp4 = "Gold Shield: 285 def, 15% eva, 142 str req::80000 gold"
						I = input("What did I tell you?","ARMORS",I) in list (temp1,temp2,temp3,temp4,"Leave")
						switch(I)
							if(temp1)
								if (M.gold>=100000)
									M.gold-=100000
									var/obj/weapons/ironarmor/J = new(M)
									usr << "My Christmas Poo likes [J]"
								else
									NoGold()
							if(temp2)
								if (M.gold>=220000)
									M.gold-=220000
									var/obj/weapons/goldarmor/J = new(M)
									usr << "My Christmas Poo likes [J]"
								else
									NoGold()
							if(temp3)
								if (M.gold>=76000)
									M.gold-=76000
									var/obj/weapons/ironshield/J = new(M)
									usr << "My Christmas Poo likes [J]"
								else
									NoGold()
							if(temp4)
								if (M.gold>=80000)
									M.gold-=80000
									var/obj/weapons/goldshield/J = new(M)
									usr << "My Christmas Poo likes [J]"
								else
									NoGold()
							else
								usr << "<font color = teal>Don't call my mom a @#$%!."
					if("Sell")
						Selling(input("What would you like to sell") in usr)
					else
						usr << "<font color = teal>Don't call my mom a @#$%!."
	Items1
		name = "Moogle"
		density = 1
		icon = 'people.dmi'
		icon_state = "moogle"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var
					I
					const
						temp1 = "Potion of Healing: restores up to 50 HP::50 gold"
						temp2 = "Potion of Mana: restores up to 50 MP::50 gold"
						temp3 = "Greater Potion of Healing: restores up to 250 HP::250 gold"
						temp4 = "Greater Potion of Mana: restores up to 250 MP::250 gold"
				I = input("Kupo?","ITEMS",I) in list (temp1,temp2,temp3,temp4,"Leave")
				var/N
				if(I!="Leave")
					N = input("How many?","ITEMS") as num
				if(N>0)
					switch(I)
						if(temp1)
							if (M.gold>=50*N)
								M.gold-=50*N
								while(N>0)
									var/obj/items/healingpot/J = new(M)
									usr << "Thank you for buying [J]. KUPO!"
									N--
							else
								usr << "<font color = teal>Kupo gold."
						if(temp2)
							if (M.gold>=50*N)
								M.gold-=50*N
								while(N>0)
									var/obj/items/manapot/J = new(M)
									usr << "Thank you for buying [J]. KUPO!"
									N--
							else
								usr << "<font color = teal>Kupo gold."
						if(temp3)
							if (M.gold>=250*N)
								M.gold-=250*N
								while(N>0)
									var/obj/items/greaterhealingpot/J = new(M)
									usr << "Thank you for buying [J]. KUPO!"
									N--
							else
								usr << "<font color = teal>Kupo gold."
						if(temp4)
							if (M.gold>=250*N)
								M.gold-=250*N
								while(N>0)
									var/obj/items/greatermanapot/J = new(M)
									usr << "Thank you for buying [J]. KUPO!"
									N--
							else
								usr << "<font color = teal>Kupo gold."
						else
							usr << "<font color = teal>KUPO?!"
	Items2
		name = "Pot-man"
		density = 1
		icon = 'people.dmi'
		icon_state = "man3"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var
					I
					const
						temp1 = "Greater Potion of Healing: restores up to 250 HP::250 gold"
						temp2 = "Greater Potion of Mana: restores up to 250 MP::250 gold"
						temp3 = "Healing Tonic: restores up to 500 HP::500 gold"
						temp4 = "Mana Tonic: restores up to 500 MP::500 gold"
				I = input("What would you like to buy?","ITEMS",I) in list (temp1,temp2,temp3,temp4,"Leave")
				var/N
				if(I!="Leave")
					N = input("How many?","ITEMS") as num
				if(N>0)
					switch(I)
						if(temp1)
							if (M.gold>=250*N)
								M.gold-=250*N
								while(N>0)
									var/obj/items/greaterhealingpot/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp2)
							if (M.gold>=250*N)
								M.gold-=250*N
								while(N>0)
									var/obj/items/greatermanapot/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp3)
							if (M.gold>=500*N)
								M.gold-=500*N
								while(N>0)
									var/obj/items/healingtonic/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp4)
							if (M.gold>=500*N)
								M.gold-=500*N
								while(N>0)
									var/obj/items/manatonic/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						else
							usr << "<font color = teal>Maybe next time."
	Items3
		name = "Mr. Vermolius Tonic"
		density = 1
		icon = 'people.dmi'
		icon_state = "man4"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var
					I
					const
						temp1 = "Greater Healing Tonic: restores up to 2000 HP::2000 gold"
						temp2 = "Greater Mana Tonic: restores up to 2000 MP::2000 gold"
						temp3 = "Healing Tonic: restores up to 500 HP::500 gold"
						temp4 = "Mana Tonic: restores up to 500 MP::500 gold"
						temp5 = "Antidote: cures poison::5000 gold"
				I = input("What would you like to buy?","ITEMS",I) in list (temp1,temp2,temp3,temp4,temp5,"Leave")
				var/N
				if(I!="Leave")
					N = input("How many?","ITEMS") as num
				if(N>0)
					switch(I)
						if(temp1)
							if (M.gold>=2000*N)
								M.gold-=2000*N
								while(N>0)
									var/obj/items/greaterhealingtonic/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp2)
							if (M.gold>=2000*N)
								M.gold-=2000*N
								while(N>0)
									var/obj/items/greatermanatonic/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp3)
							if (M.gold>=500*N)
								M.gold-=500*N
								while(N>0)
									var/obj/items/healingtonic/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp4)
							if (M.gold>=500*N)
								M.gold-=500*N
								while(N>0)
									var/obj/items/manatonic/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp5)
							if (M.gold>=5000*N)
								M.gold-=5000*N
								while(N>0)
									var/obj/items/antidote/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						else
							usr << "<font color = teal>Maybe next time."
	Items4
		name = "Lost Moogle"
		density = 1
		icon = 'people.dmi'
		icon_state = "moogle"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var
					I
					const
						temp1 = "Healing Remedy: restores up to 5000 HP::5000 gold"
						temp2 = "Mana Remedy: restores up to 5000 MP::5000 gold"
						temp3 = "Greater Healing Remedy: restores up to 10000 HP::10000 gold"
						temp4 = "Greater Mana Remedy: restores up to 10000 MP::10000 gold"
						temp5 = "Antidote: cures poison::5000 gold"
				I = input("Kupo South Park?","ITEMS",I) in list (temp1,temp2,temp3,temp4,temp5,"Leave")
				var/N
				if(I!="Leave")
					N = input("How many?","ITEMS") as num
				if(N>0)
					switch(I)
						if(temp1)
							if (M.gold>=5000*N)
								M.gold-=5000*N
								while(N>0)
									var/obj/items/healingremedy/J = new(M)
									usr << "Thank you for buying [J]. KUPO!"
									N--
							else
								usr << "<font color = teal>Kupo gold."
						if(temp2)
							if (M.gold>=5000*N)
								M.gold-=5000*N
								while(N>0)
									var/obj/items/manaremedy/J = new(M)
									usr << "Thank you for buying [J]. KUPO!"
									N--
							else
								usr << "<font color = teal>Kupo gold."
						if(temp3)
							if (M.gold>=10000*N)
								M.gold-=10000*N
								while(N>0)
									var/obj/items/greaterhealingremedy/J = new(M)
									usr << "Thank you for buying [J]. KUPO!"
									N--
							else
								usr << "<font color = teal>Kupo gold."
						if(temp4)
							if (M.gold>=10000*N)
								M.gold-=10000*N
								while(N>0)
									var/obj/items/greatermanaremedy/J = new(M)
									usr << "Thank you for buying [J]. KUPO!"
									N--
							else
								usr << "<font color = teal>Kupo gold."
						if(temp5)
							if (M.gold>=5000*N)
								M.gold-=5000*N
								while(N>0)
									var/obj/items/antidote/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								usr << "<font color = teal>Kupo gold."
						else
							usr << "<font color = teal>KUPO?!"
	Books1
		name = "Kain"
		density = 1
		icon = 'people.dmi'
		icon_state = "man2"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var
					I
					const
						temp1 = "Book of Firebolt::400 gold"
						temp2 = "Book of Icebolt::500 gold"
						temp3 = "Book of Lightningbolt::600 gold"
						temp4 = "Book of Healing::400 gold"
				I = input("What can I do ye for?","BOOKS",I) in list (temp1,temp2,temp3,temp4,"Leave")
				var/N
				if(I!="Leave")
					N = input("How many?","BOOKS") as num
				if(N>0)
					switch(I)
						if(temp1)
							if (M.gold>=400*N)
								M.gold-=400*N
								while(N>0)
									var/obj/books/firebolt/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp2)
							if (M.gold>=500*N)
								M.gold-=500*N
								while(N>0)
									var/obj/books/icebolt/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp3)
							if (M.gold>=600*N)
								M.gold-=600*N
								while(N>0)
									var/obj/books/lightningbolt/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp4)
							if (M.gold>=400*N)
								M.gold-=400*N
								while(N>0)
									var/obj/books/healing/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						else
							usr << "<font color = teal>Maybe next time."
	Books2
		name = "Acara"
		density = 1
		icon = 'people.dmi'
		icon_state = "man6"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var
					I
					const
						temp1 = "Book of Flame::2000 gold"
						temp2 = "Book of ArcticWind::2500 gold"
						temp3 = "Book of ChainLightning::3000 gold"
						temp4 = "Book of Telekinesis::1000 gold"
				I = input("Yes?","BOOKS",I) in list (temp1,temp2,temp3,temp4,"Leave")
				var/N
				if(I!="Leave")
					N = input("How many?","BOOKS") as num
				if(N>0)
					switch(I)
						if(temp1)
							if (M.gold>=2000*N)
								M.gold-=2000*N
								while(N>0)
									var/obj/books/flame/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp2)
							if (M.gold>=2500*N)
								M.gold-=2500*N
								while(N>0)
									var/obj/books/arcticwind/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp3)
							if (M.gold>=3000*N)
								M.gold-=3000*N
								while(N>0)
									var/obj/books/chainlightning/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp4)
							if (M.gold>=1000*N)
								M.gold-=1000*N
								while(N>0)
									var/obj/books/telekinesis/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						else
							usr << "<font color = teal>Maybe next time."
	Books3
		name = "Acara"
		density = 1
		icon = 'people.dmi'
		icon_state = "man6"
		verb
			Talk()
				set category = "Temporary"
				var/mob/players/M
				set src in oview(1)
				M = usr
				var
					I
					const
						temp1 = "Book of Dark::5000 gold"
						temp2 = "Book of Poison::5000 gold"
						temp3 = "Book of Osmosis::6000 gold"
						temp4 = "Book of Feedback::6000 gold"
				I = input("Yes?","BOOKS",I) in list (temp1,temp2,temp3,temp4,"Leave")
				var/N
				if(I!="Leave")
					N = input("How many?","BOOKS") as num
				if(N>0)
					switch(I)
						if(temp1)
							if (M.gold>=5000*N)
								M.gold-=5000*N
								while(N>0)
									var/obj/books/dark/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp2)
							if (M.gold>=5000*N)
								M.gold-=5000*N
								while(N>0)
									var/obj/books/poison/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp3)
							if (M.gold>=6000*N)
								M.gold-=6000*N
								while(N>0)
									var/obj/books/osmosis/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						if(temp4)
							if (M.gold>=6000*N)
								M.gold-=6000*N
								while(N>0)
									var/obj/books/feedback/J = new(M)
									N--
									usr << "Thank you for buying [J]."
							else
								NoGold()
						else
							usr << "<font color = teal>Maybe next time."

	Column2
		density = 1
		name = "column"
		icon = 'wall.dmi'
		icon_state = "column2"
	Bed
		density = 1
		icon = 'building.dmi'
		icon_state = "bed"
	Well
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "well"
	Table8
		name = "Table"
		density = 1
		icon = 'building.dmi'
		icon_state = "table8"
	Table5
		name = "Table"
		density = 1
		icon = 'building.dmi'
		icon_state = "table5"
	Table2
		name = "Table"
		density = 1
		icon = 'building.dmi'
		icon_state = "table2"
	Fence1
		name = "Fence"
		density = 1
		icon = 'building.dmi'
		icon_state = "f1"
	Fence3
		name = "Fence"
		density = 1
		icon = 'building.dmi'
		icon_state = "f3"
	Fence4
		name = "Fence"
		density = 1
		icon = 'building.dmi'
		icon_state = "f4"
	Fence5
		name = "Fence"
		density = 1
		icon = 'building.dmi'
		icon_state = "f5"
	Fence6
		name = "Fence"
		density = 1
		icon = 'building.dmi'
		icon_state = "f6"
	Fence7
		name = "Fence"
		density = 1
		icon = 'building.dmi'
		icon_state = "f7"
	Fence8
		name = "Fence"
		density = 1
		icon = 'building.dmi'
		icon_state = "f8"
	Fence9
		name = "Fence"
		density = 1
		icon = 'building.dmi'
		icon_state = "f9"
	FlowerBush
		name = "Bush"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "flowerbush"
	Bush
		name = "Bush"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "bush"
	Tree2
		name = "Tree"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "tree2"
	Tree4
		name = "Tree"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "tree4"
	DeadTree2
		name = "Dead Tree"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "deadtree2"
	DeadTree4
		name = "Dead Tree"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "deadtree4"
	Rock
		name = "Rock"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "rock"
	Pot
		name = "Pot"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "pot"
	BigTree1
		name = "Tree"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "bigtree1"
	BigTree2
		name = "Tree"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "bigtree2"
	BigTree4
		name = "Tree"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "bigtree4"
	BigTree5
		name = "Tree"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "bigtree5"
	Sign
		name = "Sign"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "sign"
	InnSign
		name = "Sign"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "innsign"
	PubSign
		name = "Sign"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "pubsign"
	WeaponSign
		name = "Sign"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "weaponsign"
	ArmorSign
		name = "Sign"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "armorsign"
	ItemSign
		name = "Sign"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "itemsign"
	statue2
		name = "Statue"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "statue2"
	statue5
		name = "Statue"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "statue5"
	column1
		name = "Column"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "column1"
	column4
		name = "Column"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "column4"
	bones
		name = "Bones"
		icon = 'building.dmi'
		icon_state = "bones"
	torch
		name = "Torch"
		icon = 'building.dmi'
		density = 1
		icon_state = "torch"
	stainedglass
		name = "Window"
		icon = 'building.dmi'
		icon_state = "stainedglass"
	candelabra
		name = "Candelabra"
		icon = 'building.dmi'
		density = 1
		icon_state = "candelabra"
	tablet
		name = "Tablet"
		icon = 'building.dmi'
		icon_state = "tablet"
	grave1
		name = "Grave"
		icon = 'building.dmi'
		density = 1
		icon_state = "grave1"
	grave2
		name = "Grave"
		icon = 'building.dmi'
		density = 1
		icon_state = "grave2"
	grave31
		name = "Grave"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "grave31"
	Grave34
		name = "Grave"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "grave34"
	grave41
		name = "Grave"
		density = 1
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "grave41"
	Grave44
		name = "Grave"
		layer = MOB_LAYER+1
		icon = 'building.dmi'
		icon_state = "grave44"
	snowman
		name = "Snowman"
		icon = 'snow.dmi'
		density = 1
		icon_state = "snowman"
	snowyrock
		name = "Snowy Rock"
		icon = 'snow.dmi'
		density = 1
		icon_state = "snowyrock"
	ices1
		name = "Ice"
		icon = 'snow.dmi'
		density = 1
		icon_state = "ices1"
	ices2
		name = "Ice"
		icon = 'snow.dmi'
		density = 1
		icon_state = "ices2"
	icecolumn1
		name = "Ice Column"
		density = 1
		icon = 'snow.dmi'
		icon_state = "icecolumn1"
	icecolumn4
		name = "Ice Column"
		density = 1
		icon = 'snow.dmi'
		icon_state = "icecolumn4"
	crystal1
		name = "Ice Crystal"
		density = 1
		layer = MOB_LAYER+1
		icon = 'snow.dmi'
		icon_state = "crystal1"
	crystal4
		name = "Ice Crystal"
		layer = MOB_LAYER+1
		icon = 'snow.dmi'
		icon_state = "crystal4"
	crystal
		name = "Ice Crystal"
		icon = 'snow.dmi'
		density = 1
		icon_state = "crystal"
	cartman
		name = "Cartman"
		icon = 'people.dmi'
		icon_state = "cartman"
		density = 1