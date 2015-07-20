
proc/MonMake(M,X,Y,Z) // this function gets called to respawn a new monster
	spawn(1600) // just wait a while
		new M(locate(X,Y,Z)) // and then make another one at the location passed in
proc/Drop(J) // this function gets called a ton to say what dropped, so I moved it out here
	usr << "<font color = purple>The enemy just dropped a <b>[J]!"
proc/itemdrop(var/mob/enemies/Q,X,Y,Z)
	if(Q.type==/mob/enemies/evilzombie) // evilzombies drop cheesy poofs
		for(var/mob/players/m as mob in view(20)) // for each thing nearby
			if(istype(m,/mob/players)) // if its a player
				var/obj/items/cheesypoofs/J = new (locate(X,Y,Z)) // drop a cheesypoofs
				m << "<font color = purple>The enemy just dropped <b>[J]!"

	//these are based on the enemy's level

	if (Q.level>0 && Q.level<5) // if the enemy is between level 1 and 4, chance to get a potion
		var B = rand(1,100) // roll a 1d100, 2% chance to get something
		switch(B)
			if (1) // 1% chance
				var/obj/items/healingpot/J = new (locate(X,Y,Z)); Drop(J)
			if (100) // 1% chance
				var/obj/items/manapot/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>1 && Q.level<5) // levels 2-4 for a chance to get a book
		var B = rand(1,600) // roll 1d600, 0.1667% chance to get each of these
		switch(B)
			if (100)
				var/obj/books/firebolt/J = new (locate(X,Y,Z)); Drop(J)
			if (200)
				var/obj/books/icebolt/J = new (locate(X,Y,Z)); Drop(J)
			if (300)
				var/obj/books/lightningbolt/J = new (locate(X,Y,Z)); Drop(J)
			if (400)
				var/obj/books/healing/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>1 && Q.level<5) // levels 2-4, another chance to get an item also
		var C = rand(1,100) // roll 1d100
		if(Q.Unique==1) // if its unique
			C = rand(1,10) // roll 1d10 instead
		if (C==1) // 10% chance to get an item from a unique, 1% chance from a regular enemy
			var D = rand(1,13) // you'll get one of the 13 different types of items listed below
			var E = rand(1,30) // and you have a 1/30  (3.33%) chance that it will be unique
			switch(D)
				if(1)
					if(E>1)
						var/obj/weapons/magicknife/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueknife/J = new (locate(X,Y,Z)); Drop(J)
				if(2)
					if(E>1)
						var/obj/weapons/magicshortsword/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueshortsword/J = new (locate(X,Y,Z)); Drop(J)
				if(3)
					if(E>1)
						var/obj/weapons/magicsmallaxe/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquesmallaxe/J = new (locate(X,Y,Z)); Drop(J)
				if(4)
					if(E>1)
						var/obj/weapons/magicwoodwand/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquewoodwand/J = new (locate(X,Y,Z)); Drop(J)
				if(5)
					if(E>1)
						var/obj/weapons/magicshortstaff/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueshortstaff/J = new (locate(X,Y,Z)); Drop(J)
				if(6)
					if(E>1)
						var/obj/weapons/magiclongstaff/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquelongstaff/J = new (locate(X,Y,Z)); Drop(J)
				if(7)
					if(E>1)
						var/obj/weapons/magicblade/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueblade/J = new (locate(X,Y,Z)); Drop(J)
				if(8)
					if(E>1)
						var/obj/weapons/magiclongsword/J = new (locate(X,Y,Z)); Drop(J)
				if(9)
					if(E>1)
						var/obj/weapons/magicclothes/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueclothes/J = new (locate(X,Y,Z)); Drop(J)
				if(10)
					if(E>1)
						var/obj/weapons/magicdarkclothes/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquedarkclothes/J = new (locate(X,Y,Z)); Drop(J)
				if(11)
					if(E>1)
						var/obj/weapons/magicleatherarmor/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueleatherarmor/J = new (locate(X,Y,Z)); Drop(J)
				if(12)
					if(E>1)
						var/obj/weapons/magicsmallshield/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquesmallshield/J = new (locate(X,Y,Z)); Drop(J)
				if(13)
					if(E>1)
						var/obj/weapons/magicheavyshield/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueheavyshield/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>2&&Q.level<7) // levels 3-6 chance to drop potions
		var B = rand(1,100) // 1% chance, 2% chance to get a potion in general
		switch(B)
			if (1)
				var/obj/items/greaterhealingpot/J = new (locate(X,Y,Z)); Drop(J)
			if (100)
				var/obj/items/greatermanapot/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>4&&Q.level<8) // levels 5-7 chance to drop books
		var B = rand(1,600) // 0.1667% chance for each, 0.6667% to just get a book in general here
		switch(B)
			if (100)
				var/obj/books/flame/J = new (locate(X,Y,Z)); Drop(J)
			if (200)
				var/obj/books/arcticwind/J = new (locate(X,Y,Z)); Drop(J)
			if (300)
				var/obj/books/chainlightning/J = new (locate(X,Y,Z)); Drop(J)
			if (400)
				var/obj/books/telekinesis/J = new (locate(X,Y,Z)); Drop(J)
			if (500)
				var/obj/books/warp/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>3 && Q.level<9) // levels 4-8 for items
		var C = rand(1,100)
		if(Q.Unique==1)
			C = rand(1,10)
		if (C==1)
			var D = rand(1,11)
			var E = rand(1,30)
			switch(D)
				if(1)
					if(E>1)
						var/obj/weapons/magicbroadblade/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquebroadblade/J = new (locate(X,Y,Z)); Drop(J)
				if(2)
					if(E>1)
						var/obj/weapons/magiclargeaxe/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquelargeaxe/J = new (locate(X,Y,Z)); Drop(J)
				if(3)
					if(E>1)
						var/obj/weapons/magicwand/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquewand/J = new (locate(X,Y,Z)); Drop(J)
				if(4)
					if(E>1)
						var/obj/weapons/magicpowerstaff/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquepowerstaff/J = new (locate(X,Y,Z)); Drop(J)
				if(5)
					if(E>1)
						var/obj/weapons/magicbroadsword/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquebroadsword/J = new (locate(X,Y,Z)); Drop(J)
				if(6)
					if(E>1)
						var/obj/weapons/magicbattleaxe/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquebattleaxe/J = new (locate(X,Y,Z)); Drop(J)
				if(7)
					if(E>1)
						var/obj/weapons/magicchainmail/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquechainmail/J = new (locate(X,Y,Z)); Drop(J)
				if(8)
					if(E>1)
						var/obj/weapons/magicplatemail/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueplatemail/J = new (locate(X,Y,Z)); Drop(J)
				if(9)
					if(E>1)
						var/obj/weapons/magicbuckler/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquebuckler/J = new (locate(X,Y,Z)); Drop(J)
				if(10)
					if(E>1)
						var/obj/weapons/magicbulwark/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquebulwark/J = new (locate(X,Y,Z)); Drop(J)
				if(11)
					if(E>1)
						var/obj/weapons/magicescutcheon/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueescutcheon/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>4&&Q.level<9) // levels 5-8 for potions
		var B = rand(1,100)
		switch(B)
			if (1)
				var/obj/items/healingtonic/J = new (locate(X,Y,Z)); Drop(J)
			if (100)
				var/obj/items/manatonic/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>7&&Q.level<11) // levels 8-10 for books
		var B = rand(1,600)
		switch(B)
			if (100)
				var/obj/books/osmosis/J = new (locate(X,Y,Z)); Drop(J)
			if (200)
				var/obj/books/feedback/J = new (locate(X,Y,Z)); Drop(J)
			if (300)
				var/obj/books/poison/J = new (locate(X,Y,Z)); Drop(J)
			if (400)
				var/obj/books/dark/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>6&&Q.level<11) // levels 7-10 for potions
		var B = rand(1,100)
		switch(B)
			if (1)
				var/obj/items/greaterhealingtonic/J = new (locate(X,Y,Z)); Drop(J)
			if (100)
				var/obj/items/greatermanatonic/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>8 && Q.level<12) // 9-11 for items
		var C = rand(1,100)
		if(Q.Unique==1)
			C = rand(1,10)
		if (C==1)
			var D = rand(1,10)
			var E = rand(1,30)
			switch(D)
				if(1)
					if(E>1)
						var/obj/weapons/magicrapier/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquerapier/J = new (locate(X,Y,Z)); Drop(J)
				if(2)
					if(E>1)
						var/obj/weapons/magicbatblade/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquebatblade/J = new (locate(X,Y,Z)); Drop(J)
				if(3)
					if(E>1)
						var/obj/weapons/magicjadestaff/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquejadestaff/J = new (locate(X,Y,Z)); Drop(J)
				if(4)
					if(E>1)
						var/obj/weapons/magictriadicorb/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquetriadicorb/J = new (locate(X,Y,Z)); Drop(J)
				if(5)
					if(E>1)
						var/obj/weapons/magicicicleblade/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueicicleblade/J = new (locate(X,Y,Z)); Drop(J)
				if(6)
					if(E>1)
						var/obj/weapons/magicscorchingsword/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquescorchingsword/J = new (locate(X,Y,Z)); Drop(J)
				if(7)
					if(E>1)
						var/obj/weapons/magicfrostmail/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquefrostmail/J = new (locate(X,Y,Z)); Drop(J)
				if(8)
					if(E>1)
						var/obj/weapons/magicobsidianplate/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueobsidianplate/J = new (locate(X,Y,Z)); Drop(J)
				if(9)
					if(E>1)
						var/obj/weapons/magiceyeshield/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniqueeyeshield/J = new (locate(X,Y,Z)); Drop(J)
				if(10)
					if(E>1)
						var/obj/weapons/magicdecussated/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquedecussated/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>8&&Q.level<13) // levels 9-12 for potions
		var B = rand(1,100)
		switch(B)
			if (1)
				var/obj/items/healingremedy/J = new (locate(X,Y,Z)); Drop(J)
			if (50)
				var/obj/items/antidote/J = new (locate(X,Y,Z)); Drop(J)
			if (100)
				var/obj/items/manaremedy/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>10&&Q.level<14) // 11-13 for books
		var B = rand(1,600)
		switch(B)
			if (100)
				var/obj/books/demi/J = new (locate(X,Y,Z)); Drop(J)
			if (200)
				var/obj/books/ameliorate/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>10&&Q.level<15) // 11-14 for potions
		var B = rand(1,100)
		switch(B)
			if (1)
				var/obj/items/greaterhealingremedy/J = new (locate(X,Y,Z)); Drop(J)
			if (100)
				var/obj/items/greatermanaremedy/J = new (locate(X,Y,Z)); Drop(J)
	if (Q.level>11 && Q.level<15) // 12-14 for items
		var C = rand(1,100)
		if(Q.Unique==1)
			C = rand(1,10)
		if (C==1)
			var D = rand(1,10)
			var E = rand(1,30)
			switch(D)
				if(1)
					if(E>1)
						var/obj/weapons/magicsteelsword/J = new (locate(X,Y,Z)); Drop(J)
					else
						var/obj/weapons/uniquesteelsword/J = new (locate(X,Y,Z)); Drop(J)
				if(2)
					if(E>1)
						var/obj/weapons/magicgoldsword/J = new (locate(X,Y,Z)); Drop(J)
				if(3)
					if(E>1)
						var/obj/weapons/magicgoldwand/J = new (locate(X,Y,Z)); Drop(J)
				if(4)
					if(E>1)
						var/obj/weapons/magicgoldstaff/J = new (locate(X,Y,Z)); Drop(J)
				if(5)
					if(E>1)
						var/obj/weapons/magicgoldaxe/J = new (locate(X,Y,Z)); Drop(J)
				if(6)
					if(E>1)
						var/obj/weapons/magicironarmor/J = new (locate(X,Y,Z)); Drop(J)
				if(7)
					if(E>1)
						var/obj/weapons/magicgoldarmor/J = new (locate(X,Y,Z)); Drop(J)
				if(8)
					if(E>1)
						var/obj/weapons/magicironshield/J = new (locate(X,Y,Z)); Drop(J)
				if(9)
					if(E>1)
						var/obj/weapons/magicgoldshield/J = new (locate(X,Y,Z)); Drop(J)

mob/enemies
	icon = 'enemies.dmi'
	var // enemy variables
		HP; MAXHP; MP; MAXMP; expgive; goldgive; Strength; Intelligence; level=0; Speed; Unique=0;
		fireres=0; iceres=0; litres=0; poisres=0; darkres=0;
		firewk=0; icewk=0; litwk=0; poiswk=0; darkwk=0;
		hasspells=0; // the spell casters have different fighting logic
		fireboltlevel; iceboltlevel; lightningboltlevel; feedbacklevel; poisonlevel;
		darklevel;

	var/mob/players/P

	//this Wander thing is what I based my enemy logic on, this function doesn't get called anymore, it was replaced by Unique(speed)
	proc/Wander(speed)
		while(src)     //while its still there, and not deleted..
			if (P in oview(5))    //If a PC is in 5 spaces of it...
				step_towards(src,P)   //Step towards the PC
			else
				sleep(speed)
				step_rand(src)   //step random
				for(P in view(src))  //but if a PC comes nearby...
					break     //stop walking random
			sleep(speed)
		spawn(40)   //Keep the infinit loop in action, and tell it to wait for 4 seconds
			Wander(speed)



	//these procedures get called by the main logic loop in order to cast spells if the enemy has the mp to do it, otherwise they just step towards you
	proc/FIREbolt()
		if (MP < 1+(fireboltlevel*2))
			step_towards(src,P)
		else
			MP -= 1+(fireboltlevel*2)
			missile(/obj/spells/firebolt,usr,P)
			sleep(get_dist(usr,P))
			var/damage = round(((rand(2+(fireboltlevel*2),4+(fireboltlevel*3)))*((Intelligence/100)+1)),1)
			if (P.Fireres>0)
				damage -= round(damage*(P.Fireres/100),1)
			P.HP -= damage
			s_damage(P, damage, "red")
			checkdeadplayer(P,src)
			step_towards(src,P)
	proc/ICEbolt()
		if (MP < 3+(iceboltlevel*2))
			step_towards(src,P)
		else
			MP -= 3+(iceboltlevel*2)
			missile(/obj/spells/icebolt,usr,P)
			sleep(get_dist(usr,P))
			var/damage = round(((rand(1+(iceboltlevel*3),3+(iceboltlevel*3)))*((Intelligence/100)+1)),1)
			if (P.Iceres>0)
				damage -= round(damage*(P.Iceres/100),1)
			P.HP -= damage
			s_damage(P, damage, "red")
			checkdeadplayer(P,src)
			step_towards(src,P)
	proc/LITbolt()
		if (MP < 5+(lightningboltlevel*2))
			usr << "Not enough MP"
		else
			MP -= 5+(lightningboltlevel*2)
			missile(/obj/spells/lightningbolt,usr,P)
			sleep(get_dist(usr,P))
			var/damage = round(((rand(1,round((10+(lightningboltlevel*10.72)),1)))*((Intelligence/100)+1)),1)
			if (P.Litres>0)
				damage -= round(damage*(P.Litres/100),1)
			P.HP -= damage
			s_damage(P, damage, "red")
			checkdeadplayer(P,src)
			step_towards(src,P)
	proc/FEEDBACK()
		if (MP < 15+(feedbacklevel*5))
			step_towards(src,P)
		else
			MP -= 15+(feedbacklevel*5)
			var/amount = round(((rand(5+(feedbacklevel*3),10+(feedbacklevel*5)))*((Intelligence/100)+1)),1)
			if (amount > (P.MP))
				amount = (P.MP)
			if (amount < 0)
				amount = 0
			missile(/obj/spells/bolt,usr,P)
			sleep(get_dist(usr,P))
			s_damage(P, amount, "blue")
			P.MP -= amount
			var/damage = round((amount*(0.092*feedbacklevel)),1)
			if (damage < 0)
				damage = 0
			P.overlays += /obj/spells/boltboom
			spawn(5)
				P.overlays = null
				P.HP -= damage
				s_damage(P, damage, "red")
				checkdeadplayer(P,src)
			step_away(src,P)
	proc/POISON()
		if (MP < round(14*sqrt(poisonlevel),1))
			step_towards(src,P)
		else
			MP -= round(14*sqrt(poisonlevel),1)
			missile(/obj/spells/poisonbolt,usr,P)
			sleep(get_dist(usr,P))
			P.overlays += /obj/spells/poison
			P.poisoned = 1
			P.poisonD = round(4+(poisonlevel/2),1)
			P.poisonDMG = round( rand(10*(sqrt(poisonlevel*((Intelligence/100)+1))),13*(sqrt(poisonlevel*((Intelligence/100)+1)))) , 1)
			step_away(src,P)
	proc/DARK()
		if (MP < 9+(darklevel*2))
			step_towards(src,P)
		else
			MP -= 9+(darklevel*2)
			missile(/obj/spells/darkbolt,usr,P)
			sleep(get_dist(usr,P))
			var/damage = round(((rand(10+(darklevel*2),16+(darklevel*3)))*((Strength/100)+1)),1)
			if (P.Darkres>0)
				damage -= round(damage*(P.Darkres/100),1)
			P.HP -= damage
			s_damage(P, damage, "red")
			checkdeadplayer(P,src)
			step_towards(src,P)

	proc/Unique(speed) //this is the main enemy logic
		while(src) // while its alive
			if (P in oview(5)) // if theres something in sight
				if(hasspells==0) // if this enemy doesn't cast spells
					step_towards(src,P) // step towards the player
					if(Unique==1) // if its a unique
						step_towards(src,P) // step twice
						step_towards(src,P) // this causes uniques to attack twice and move faster
				else // spell caster
					var/V = rand(1,6) // 1 in 6 chance to do something
					//if the enemy has all 6 of these spells, it wont attack regularly until it is out of MP
					//if the enemy has 2 of these spells, it has a 1/6 chance to cast either of them and a 4/6 chance to attack
					switch(V)
						if(1)
							if(fireboltlevel>0)
								FIREbolt()
							else
								step_towards(src,P)
						if(2)
							if(iceboltlevel>0)
								ICEbolt()
							else
								step_towards(src,P)
						if(3)
							if(lightningboltlevel>0)
								LITbolt()
							else
								step_towards(src,P)
						if(4)
							if(feedbacklevel>0)
								FEEDBACK()
							else
								step_towards(src,P)
						if(5)
							if(poisonlevel>0)
								POISON()
							else
								step_towards(src,P)
						if(6)
							if(darklevel>0)
								DARK()
							else
								step_towards(src,P)
			else
				sleep(speed) // pause based on speed
				step_rand(src) // then step randomly
				for(P in view(src)) // if something comes nearby
					break // break out to start taking fighting actions
			sleep(speed) // pause based on speed
		spawn(speed) // infinite loop based on speed before next calling
			Unique(speed) // this is the call again
	proc/HitPlayer(mob/players/M) // hitting the player
		var/dmgreduced // you reduce your damage based on defense
		if(M.tempdefense<=1050)
			dmgreduced = (((M.tempdefense)/10 * (1.05-(0.0005*(M.tempdefense))))/100) // calculation for dmg reduced
		else if(M.tempdefense>1050)
			var/blah = M.tempdefense-1050
			dmgreduced = 0.55 + 0.55*(((blah)/10 * (1.05-(0.0005*(blah))))/100) // another calculation for dmg reduced because the first one is negative parabolic, and we dont want the dmg reduced to be decreased with high defense ratings
		var/damage = round(((rand(Strength/2,Strength))*(1-dmgreduced)),1) // calculate damage
		M.HP -= damage // take damage
		s_damage(M, damage, "red") // show the damage taken
		checkdeadplayer(M,src) // see if the enemy killed the player
	proc/checkdeadplayer(var/mob/players/M,var/mob/enemies/E)
		if(M.HP <= 0) // if you have less than or equal to 0 HP, you are dead
			world << "<font color = purple><b>[M] died to [E]"
			var/G = round((M.gold/4),1)
			M << "<font color = red>You lost [G] gold"
			M.gold-=G
			M.poisonD=0
			M.poisoned=0
			M.poisonDMG=0
			M.overlays = null
			M.loc = locate(/turf/start)
			M.location = "Kishkan"
			usr << sound('q5.mid',1,0,0)
			M.HP = M.MAXHP

	//these are all the different enemies and their variables and actions...
	slime
		icon_state = "slime"
		level = 1
		Speed = 20
		HP = 10
		MAXHP = 10
		MP = 5
		MAXMP = 5
		expgive = 2
		goldgive = 2
		Strength = 2
		Intelligence = 1
		firewk=20
		New()           //When this mob is created...
			.=..()
			spawn(1)   //start and infinite loop
				Unique(Speed)
		Bump(mob/players/M)       //When the mob bumps into another mob
			if (istype(M,/mob/players))    //If the mob is a PC...
				Attack(M)
		proc/Attack(mob/players/M)
			flick("slime_attack",src)
			sleep(2)  //This give the animation time to play, and sets the attack  delay for this mob.  Dont put this on PCs or evil little errors will keep popping up.  I can make it different though so just ask me how to make a more advanced attack verb for PCs.
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	spider
		icon_state = "spider"
		level = 1
		Speed = 18
		HP = 25
		MAXHP = 25
		MP = 10
		MAXMP = 10
		expgive = 4
		goldgive = 3
		Strength = 6
		Intelligence = 2
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("spider_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	muck
		icon_state = "muck"
		level = 2
		Speed = 18
		HP = 40
		MAXHP = 40
		MP = 15
		MAXMP = 15
		expgive = 6
		goldgive = 6
		Strength = 12
		Intelligence = 2
		icewk=35
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("muck_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	redslime
		icon_state = "redslime"
		level = 2
		Speed = 15
		HP = 60
		MAXHP = 60
		MP = 35
		MAXMP = 35
		expgive = 9
		goldgive = 12
		Strength = 16
		Intelligence = 12
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("redslime_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	evilslime
		icon_state = "evilslime"
		level = 3
		Speed = 12
		HP = 580
		MAXHP = 580
		MP = 430
		MAXMP = 430
		expgive = 34
		goldgive = 40
		Strength = 44
		Intelligence = 30
		Unique = 1
		hasspells = 1
		fireboltlevel = 4
		iceboltlevel = 2
		poisonlevel = 1
		fireres = 30
		litres = 30
		iceres = 30
		poisres = 30
		darkres = 30
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("evilslime_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	greenslime
		icon_state = "greenslime"
		level = 3
		Speed = 15
		HP = 120
		MAXHP = 120
		MP = 70
		MAXMP = 70
		expgive = 18
		goldgive = 24
		Strength = 32
		Intelligence = 24
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("greenslime_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	arachnid
		icon_state = "arachnid"
		level = 3
		Speed = 15
		HP = 140
		MAXHP = 140
		MP = 15
		MAXMP = 15
		expgive = 20
		goldgive = 16
		Strength = 20
		Intelligence = 8
		hasspells = 1
		poisonlevel = 1
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("arachnid_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	evilspider
		icon_state = "evilspider"
		level = 4
		Speed = 12
		HP = 720
		MAXHP = 720
		MP = 500
		MAXMP = 500
		expgive = 50
		goldgive = 42
		Strength = 50
		Intelligence = 32
		Unique = 1
		hasspells = 1
		poisonlevel = 3
		lightningboltlevel = 8
		darklevel = 2
		fireres = 35
		litres = 35
		iceres = 35
		poisres = 35
		darkres = 35
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("evilspider_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	ooze
		icon_state = "ooze"
		level = 3
		Speed = 16
		HP = 100
		MAXHP = 100
		MP = 24
		MAXMP = 24
		expgive = 18
		goldgive = 18
		Strength = 26
		Intelligence = 18
		icewk=40
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("ooze_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	metalslime
		icon_state = "metalslime"
		level = 4
		Speed = 15
		HP = 1000
		MAXHP = 1000
		MP = 0
		MAXMP = 0
		expgive = 100
		goldgive = 0
		Strength = 30
		Intelligence = 1
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("metalslime_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	goldslime
		icon_state = "goldslime"
		level = 4
		Speed = 15
		HP = 1000
		MAXHP = 1000
		MP = 0
		MAXMP = 0
		expgive = 0
		goldgive = 100
		Strength = 30
		Intelligence = 1
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("goldslime_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	snake
		icon_state = "snake"
		level = 3
		Speed = 14
		HP = 100
		MAXHP = 100
		MP = 25
		MAXMP = 25
		expgive = 15
		goldgive = 16
		Strength = 19
		Intelligence = 13
		litwk = 70
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("snake_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	cobra
		icon_state = "cobra"
		level = 4
		Speed = 14
		HP = 160
		MAXHP = 160
		MP = 55
		MAXMP = 55
		expgive = 22
		goldgive = 24
		Strength = 25
		Intelligence = 17
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("cobra_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	basilisk
		icon_state = "basilisk"
		level = 5
		Speed = 14
		HP = 250
		MAXHP = 250
		MP = 85
		MAXMP = 85
		expgive = 34
		goldgive = 37
		Strength = 38
		Intelligence = 25
		hasspells = 1
		fireboltlevel = 10
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("basilisk_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	evilbasilisk
		icon_state = "evilbasilisk"
		level = 5
		Speed = 12
		HP = 900
		MAXHP = 900
		MP = 850
		MAXMP = 850
		expgive = 74
		goldgive = 87
		Strength = 58
		Intelligence = 38
		Unique = 1
		hasspells = 1
		fireboltlevel = 14
		lightningboltlevel = 16
		poisonlevel = 4
		fireres = 40
		litres = 40
		iceres = 40
		poisres = 40
		darkres = 40
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("evilbasilisk_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	goblin
		icon_state = "goblin"
		level = 4
		Speed = 14
		HP = 200
		MAXHP = 200
		MP = 10
		MAXMP = 10
		expgive = 30
		goldgive = 26
		Strength = 40
		Intelligence = 8
		litwk = 45
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("goblin_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	fallenangel
		icon_state = "fallenangel"
		level = 6
		Speed = 14
		HP = 400
		MAXHP = 400
		MP = 100
		MAXMP = 100
		expgive = 46
		goldgive = 52
		Strength = 58
		Intelligence = 28
		icewk = 55
		litres = 35
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("fallenangel_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	ghost
		icon_state = "ghost"
		level = 5
		Speed = 14
		HP = 320
		MAXHP = 320
		MP = 170
		MAXMP = 170
		expgive = 44
		goldgive = 36
		Strength = 42
		Intelligence = 30
		litwk = 60
		fireres = 70
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("ghost_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	skeleton
		icon_state = "skeleton"
		level = 5
		Speed = 13
		HP = 300
		MAXHP = 300
		MP = 80
		MAXMP = 80
		expgive = 40
		goldgive = 40
		Strength = 54
		Intelligence = 25
		icewk = 70
		fireres = 50
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("skeleton_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	zombie
		icon_state = "zombie"
		level = 5
		Speed = 13
		HP = 270
		MAXHP = 270
		MP = 20
		MAXMP = 20
		expgive = 40
		goldgive = 48
		Strength = 62
		Intelligence = 12
		firewk = 75
		iceres = 60
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("zombie_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	wraith
		icon_state = "wraith"
		level = 6
		Speed = 14
		HP = 540
		MAXHP = 540
		MP = 500
		MAXMP = 500
		expgive = 50
		goldgive = 55
		Strength = 65
		Intelligence = 50
		hasspells = 1
		feedbacklevel = 8
		firewk = 40
		litres = 50
		iceres = 50
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("wraith_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	evilwraith
		icon_state = "evilwraith"
		level = 6
		Speed = 10
		HP = 2600
		MAXHP = 2600
		MP = 1260
		MAXMP = 1260
		expgive = 92
		goldgive = 100
		Strength = 105
		Intelligence = 73
		Unique = 1
		hasspells = 1
		feedbacklevel = 14
		lightningboltlevel = 32
		darklevel = 18
		fireres = 45
		litres = 45
		iceres = 45
		poisres = 45
		darkres = 45
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("evilwraith_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	ghoul
		icon_state = "ghoul"
		level = 6
		Speed = 13
		HP = 740
		MAXHP = 740
		MP = 100
		MAXMP = 100
		expgive = 58
		goldgive = 60
		Strength = 82
		Intelligence = 13
		litres = 70
		iceres = 30
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("ghoul_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	blight
		icon_state = "blight"
		level = 6
		Speed = 15
		HP = 800
		MAXHP = 800
		MP = 350
		MAXMP = 350
		expgive = 66
		goldgive = 50
		Strength = 75
		Intelligence = 48
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("blight_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	marshmallow
		icon_state = "marshmallow"
		level = 7
		Speed = 14
		HP = 999
		MAXHP = 999
		MP = 0
		MAXMP = 0
		expgive = 40
		goldgive = 95
		Strength = 105
		Intelligence = 0
		firewk = 100
		litres = 65
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("marshmallow_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	evilmarshmallow
		icon_state = "evilmarshmallow"
		level = 7
		Speed = 10
		HP = 3400
		MAXHP = 3400
		MP = 0
		MAXMP = 0
		expgive = 80
		goldgive = 215
		Strength = 430
		Intelligence = 0
		Unique = 1
		fireres = 50
		litres = 50
		iceres = 50
		poisres = 50
		darkres = 50
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("evilmarshmallow_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	goblinmarauder
		icon_state = "goblinmarauder"
		level = 7
		Speed = 13
		HP = 1020
		MAXHP = 1020
		MP = 150
		MAXMP = 150
		expgive = 74
		goldgive = 69
		Strength = 146
		Intelligence = 30
		litwk = 50
		iceres = 50
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("goblinmarauder_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	skeletor
		icon_state = "skeletor"
		level = 7
		Speed = 13
		HP = 1140
		MAXHP = 1140
		MP = 200
		MAXMP = 200
		expgive = 72
		goldgive = 72
		Strength = 135
		Intelligence = 77
		fireres = 50
		iceres = 40
		litres = 60
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("skeletor_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	gelidball
		icon_state = "gelidball"
		level = 7
		Speed = 14
		HP = 1080
		MAXHP = 1080
		MP = 600
		MAXMP = 600
		expgive = 76
		goldgive = 58
		Strength = 122
		Intelligence = 102
		firewk = 100
		iceres = 40
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("gelidball_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	evilgelidball
		icon_state = "evilgelidball"
		level = 7
		Speed = 10
		HP = 4100
		MAXHP = 4100
		MP = 3470
		MAXMP = 3470
		expgive = 210
		goldgive = 165
		Strength = 245
		Intelligence = 167
		Unique = 1
		hasspells = 1
		fireboltlevel = 62
		lightningboltlevel = 45
		iceboltlevel = 90
		fireres = 55
		litres = 55
		iceres = 55
		poisres = 55
		darkres = 55
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("evilgelidball_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	frostwolf
		icon_state = "frostwolf"
		level = 8
		Speed = 12
		HP = 1420
		MAXHP = 1420
		MP = 730
		MAXMP = 730
		expgive = 88
		goldgive = 76
		Strength = 165
		Intelligence = 130
		firewk = 110
		litres = 45
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("frostwolf_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	crabby
		icon_state = "crabby"
		level = 8
		Speed = 12
		HP = 1500
		MAXHP = 1500
		MP = 400
		MAXMP = 400
		expgive = 80
		goldgive = 92
		Strength = 188
		Intelligence = 95
		fireres = 60
		litwk = 60
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("crabby_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	icewhelp
		icon_state = "icewhelp"
		level = 8
		Speed = 12
		HP = 1830
		MAXHP = 1830
		MP = 720
		MAXMP = 720
		expgive = 104
		goldgive = 96
		Strength = 222
		Intelligence = 185
		hasspells = 1
		iceboltlevel = 20
		firewk = 75
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("icewhelp_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	bah
		icon_state = "bah"
		level = 9
		Speed = 12
		HP = 2450
		MAXHP = 2450
		MP = 650
		MAXMP = 650
		expgive = 119
		goldgive = 122
		Strength = 280
		Intelligence = 190
		hasspells = 1
		lightningboltlevel = 34
		fireres = 75
		iceres = 50
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("bah_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	floatinghead
		icon_state = "floatinghead"
		level = 9
		Speed = 12
		HP = 2700
		MAXHP = 2700
		MP = 910
		MAXMP = 910
		expgive = 130
		goldgive = 130
		Strength = 310
		Intelligence = 176
		hasspells = 1
		darklevel = 28
		iceres = 20
		litres = 80
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("floatinghead_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	icegiant
		icon_state = "icegiant"
		level = 9
		Speed = 12
		HP = 3220
		MAXHP = 3220
		MP = 0
		MAXMP = 0
		expgive = 145
		goldgive = 155
		Strength = 367
		Intelligence = 0
		iceres = 90
		fireres = 80
		darkres = 70
		litres = 60
		poiswk = 220
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("icegiant_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	arcticmarshmallow
		icon_state = "arcticmarshmallow"
		level = 9
		Speed = 11
		HP = 2800
		MAXHP = 2800
		MP = 0
		MAXMP = 0
		expgive = 88
		goldgive = 196
		Strength = 410
		Intelligence = 0
		firewk = 100
		iceres = 90
		litres = 50
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("arcticmarshmallow_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	evilwhelp
		icon_state = "evilwhelp"
		level = 9
		Speed = 10
		HP = 6400
		MAXHP = 6400
		MP = 2700
		MAXMP = 2700
		expgive = 380
		goldgive = 365
		Strength = 650
		Intelligence = 210
		Unique = 1
		hasspells = 1
		feedbacklevel = 22
		darklevel = 88
		iceboltlevel = 145
		fireres = 60
		litres = 60
		iceres = 60
		poisres = 60
		darkres = 60
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("evilwhelp_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	azureskull
		icon_state = "azureskull"
		level = 10
		Speed = 10
		HP = 4500
		MAXHP = 4500
		MP = 1130
		MAXMP = 1130
		expgive = 244
		goldgive = 244
		Strength = 540
		Intelligence = 380
		hasspells = 1
		darklevel = 62
		poisonlevel = 55
		firewk = 30
		iceres = 95
		litres = 80
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("azureskull_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	drudge
		icon_state = "drudge"
		level = 10
		Speed = 10
		HP = 7740
		MAXHP = 7740
		MP = 300
		MAXMP = 300
		expgive = 250
		goldgive = 270
		Strength = 990
		Intelligence = 45
		litres = 95
		iceres = 50
		poiswk = 340
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("drudge_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	undeadwhelp
		icon_state = "undeadwhelp"
		level = 10
		Speed = 9
		HP = 5200
		MAXHP = 5200
		MP = 2100
		MAXMP = 2100
		expgive = 294
		goldgive = 277
		Strength = 790
		Intelligence = 645
		hasspells = 1
		fireboltlevel = 110
		fireres = 95
		darkres = 80
		icewk = 40
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("undeadwhelp_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	wight
		icon_state = "wight"
		level = 10
		Speed = 9
		HP = 8540
		MAXHP = 8540
		MP = 3500
		MAXMP = 3500
		expgive = 310
		goldgive = 330
		Strength = 1065
		Intelligence = 950
		hasspells = 1
		feedbacklevel = 30
		firewk = 40
		litres = 70
		iceres = 70
		darkres = 80
		poisres = 95
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("wight_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	evilzombie
		icon_state = "evilzombie"
		level = 11
		Speed = 8
		HP = 62000
		MAXHP = 62000
		MP = 0
		MAXMP = 0
		expgive = 560
		goldgive = 600
		Strength = 1450
		Intelligence = 0
		Unique = 1
		fireres = 65
		litres = 65
		iceres = 65
		poisres = 65
		darkres = 65
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("evilzombie_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	snowsnake
		icon_state = "snowsnake"
		level = 11
		Speed = 9
		HP = 10000
		MAXHP = 10000
		MP = 200
		MAXMP = 200
		expgive = 340
		goldgive = 345
		Strength = 950
		Intelligence = 140
		firewk = 60
		litres = 90
		iceres = 99
		darkres = 50
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("snowsnake_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	toxin
		icon_state = "toxin"
		level = 11
		Speed = 9
		HP = 11590
		MAXHP = 11590
		MP = 16000
		MAXMP = 16000
		expgive = 367
		goldgive = 382
		Strength = 304
		Intelligence = 820
		hasspells = 1
		lightningboltlevel = 34
		poisonlevel = 60
		litwk = 60
		fireres = 99
		iceres = 90
		poisres = 50
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("toxin_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	gunk
		icon_state = "gunk"
		level = 11
		Speed = 9
		HP = 13000
		MAXHP = 13000
		MP = 1400
		MAXMP = 1400
		expgive = 318
		goldgive = 318
		Strength = 790
		Intelligence = 540
		icewk = 60
		litres = 99
		fireres = 90
		darkres = 25
		poisres = 25
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("ooze_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	rainbowslime
		icon_state = "rainbowslime"
		level = 11
		Speed = 9
		HP = 15000
		MAXHP = 15000
		MP = 2000
		MAXMP = 2000
		expgive = 418
		goldgive = 424
		Strength = 1132
		Intelligence = 240
		iceres = 99
		litres = 99
		fireres = 99
		poisres = 90
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("rainbowslime_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)
	goldmarshmallow
		icon_state = "goldmarshmallow"
		level = 11
		Speed = 9
		HP = 19999
		MAXHP = 19999
		MP = 0
		MAXMP = 0
		expgive = 0
		goldgive = 1195
		Strength = 1605
		Intelligence = 0
		firewk = 150
		litres = 85
		New()
			.=..()
			spawn(1)
				Unique(Speed)
		Bump(mob/players/M)
			if (istype(M,/mob/players))
				Attack(M)
		proc/Attack(mob/players/M)
			flick("goldmarshmallow_attack",src)
			sleep(2)
			if (prob(M.tempevade))
				view(src) << "[src] \red misses <font color = black>[M]"
			else
				HitPlayer(M)