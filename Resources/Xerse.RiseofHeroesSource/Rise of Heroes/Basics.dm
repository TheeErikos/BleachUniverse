/*

Alright.  After much use of opensource software, I've decided that I'm an opensource kind of guy.
I wrote this game a long time ago.  The code is pretty ugly and inefficient, but it is what it is.
Lots of code snippets were taken from samples.  They may retain their original comments.
Feel free to use anything here for your own use, and do whatever you want with this.
I'm done programming in BYOND.  I've moved on to bigger and better things, and I'm much better at programming now.
Have fun and take it easy, everyone!

-Xerse,  Phil BoBo

P.S.  Most of the comments were added by me on October 23rd, 2004, the code was mostly written around June '03 to September '03

*/



world/hub = "Xerse.RiseOfHeroes" // used to make the hubentry work

client // huttah for macros
	command_text = ".alt "
obj/overlay // the borders around the hp/mp/exp meters
	fancy
		icon = 'overlay.dmi'
		icon_state="fancy"
		layer = MOB_LAYER+10
	woodsy
		icon = 'overlay.dmi'
		icon_state="woodsy"
		layer = MOB_LAYER+10
	stone
		icon = 'overlay.dmi'
		icon_state="stone"
		layer = MOB_LAYER+10
obj
	var/num = 0 // current unrounded icon_state number
	var/width
	meter1 // hud health meter, more frames, larger, and much better detail
		name = "HP"
		icon = 'hpglobe.dmi'
		screen_loc = "1,1"
		icon_state = "0"
		layer = MOB_LAYER+10
		width = 16
		var/counter = 1
		Click() // haha. so inefficient and ugly. good times.  switch between the different borders by clicking meters
			if(counter==1)
				overlays += /obj/overlay/stone
			if(counter==2)
				overlays -= /obj/overlay/stone
				overlays += /obj/overlay/woodsy
			if(counter==3)
				overlays -= /obj/overlay/woodsy
				overlays += /obj/overlay/fancy
			if(counter==4)
				overlays -= /obj/overlay/fancy
			counter++
			if(counter>4)
				counter=1
	mmeter1 // hud mana meter
		name = "MP"
		icon = 'mpglobe.dmi'
		screen_loc = "2,1"
		icon_state = "0"
		layer = MOB_LAYER+10
		width = 16
		var/counter = 1
		Click() // haha. just like above, but on the mana meter
			if(counter==1)
				overlays += /obj/overlay/stone
			if(counter==2)
				overlays -= /obj/overlay/stone
				overlays += /obj/overlay/woodsy
			if(counter==3)
				overlays -= /obj/overlay/woodsy
				overlays += /obj/overlay/fancy
			if(counter==4)
				overlays -= /obj/overlay/fancy
			counter++
			if(counter>4)
				counter=1
	xmeter1 // hud mana meter
		name = "XP"
		icon = 'xpglobe.dmi'
		screen_loc = "3,1"
		icon_state = "0"
		layer = MOB_LAYER+10
		width = 16
		var/counter = 1
		Click() // haha. just like above, but on the exp meter
			if(counter==1)
				overlays += /obj/overlay/stone
			if(counter==2)
				overlays -= /obj/overlay/stone
				overlays += /obj/overlay/woodsy
			if(counter==3)
				overlays -= /obj/overlay/woodsy
				overlays += /obj/overlay/fancy
			if(counter==4)
				overlays -= /obj/overlay/fancy
			counter++
			if(counter>4)
				counter=1
	proc/Update()// NOTE: this is the only part of the code made by Spuzzum, I would change it but I see no point in doing this.
				 // NOTE: it also has the original commenting from Spuzzum.
		if(num < 0) //if the meter is negative
			num = 0 //set it to zero
		else if(num > width) //if the meter is over 100%
			num = width //set it to 100%
		src.icon_state = "[round(src.num)]" // this sets the icon state of the meter to its rounded off number

var
	bans[10] // global variables for banning people
	partycounter=1 // and counting the number of parties
client/New()
	..()
	if(bans.Find(src.ckey)) // obviously I didn't want you in my game if you are in that array of banned people
		usr << "You've been banned by Xerse, GET OUT!"
		bans.len++
		del(src) // get out! =]
mob/players
	Login() // logging on in...
		// let us tell the world and the new user what is happening!
		world << "<font color = purple><b>[usr]([usr.ckey]) has joined our world"
		usr << "<font color = purple>Be sure to check for the TEMPORARY panel to see new commands such as talking to shopkeepers.  Bump enemies or use NumPad5 to attack.  Go to HELP for more help."
		usr << "<b>PUSH TAB TO SEE THE LIST OF HOTKEYS!!"
		usr << "Visit <b>http://www.oddworldz.com/fuxuroh/Main.html </b>for additional game information!"
		usr.loc = locate(/turf/start) // back to the beginning with you!
		src.client.screen += new/obj/meter1 // Add new objects to client.screen.
		src.client.screen += new/obj/mmeter1
		src.client.screen += new/obj/xmeter1
		//variables to be initialized on entry to the game, a few of em
		inparty=0
		partynumber=0
		nomotion = 0
		muted = 0
		waiter = 1
		poisonD=0
		poisoned=0
		poisonDMG=0
		overlays = null
		location = "Kishkan"
		usr << sound('q5.mid',1) // let the music begin!
		var/mob/players/M = usr // happy local variable
		if(!(M.cities.Find("Kishkan"))) // used for warp
			M.cities+="Kishkan"
		if (level<2) // give noobs lots of knives that sell for 1 if they're bad enough to need to log in a ton instead of killing slimes
			var/obj/weapons/knife/J = new(usr)
			usr << "You got a [J] to start your quest...Go to your inventory and right click it to equip and use it."
		if (char_class == "Wizard" && fireboltlevel < 1) // start wizards with firebolt lvl 2, also inefficient. HA!
			usr.verbs+=new/mob/players/wizspells/verb/FireBolt
			fireboltlevel+=1
			usr << "\green<b>You learned FireBolt Level [fireboltlevel]!"
			fireboltlevel+=1
			usr << "\green<b>You learned FireBolt Level [fireboltlevel]!"
		if (char_class == "Mage" && fireboltlevel < 1) // we'll give mages some firebolt action too
			usr.verbs+=new/mob/players/wizspells/verb/FireBolt
			fireboltlevel+=1
			usr << "\green<b>You learned FireBolt Level [fireboltlevel]!"
	Logout() // YOU'RE LEAVING US?!?! GAHUH!
		leaveparty(usr)
		world << "<font color = purple><b>[usr] has abandoned us all"
	Move()
		if(nomotion==0) // this is used so that you can't talk to shopkeepers a ton and then run around with their GUIs open
			if(away != 0) // if you are away
				away = 0 // now you aren't!
				usr << "You are no longer marked as away"
			if(poisonDMG<=0) // not poisoned anymore?
				overlays = null // i guess we can take those poison things off your icon then
			// problems with lag making me need to be sure that their hp and mp are within acceptable ranges
			// so this lets them cast a few extra spells by spamming, but whatever...
			if(HP>MAXHP)
				HP=MAXHP
			if(MP>MAXMP)
				MP=MAXMP
			if(MP<0)
				MP=0
			..() // oh yeah.. let them move too.  do the default move() proc stuff
		if(nomotion==1)
			return // don't even think about moving, chump!
	//give em a nice picture
	icon = 'players.dmi'
	Warrior
		char_class = "Warrior"
		icon_state = "Warrior"
		attackspeed = 5
	Monk
		char_class = "Monk"
		icon_state = "Monk"
		attackspeed = 6
	Mage
		char_class = "Mage"
		icon_state = "Mage"
		attackspeed = 7
	Wizard
		char_class = "Wizard"
		icon_state = "Wizard"
		attackspeed = 8
	// MY BLACK MAGE DUDE BWAHAHAHAHAAHAHAHAHA!
	Special1
		char_class = "GameMaster"
		icon = 'uniques.dmi'
		icon_state = "xerse"
		attackspeed = 5
		// oh yes...let the abilities roll forth!
		verb
			AVATAR_TEMP() // i used this verb for debugging alot, mostly making books and items from nothing
				var/obj/weapons/uniquedecussated/J = new(usr)
				usr << "You created a [J] from thin air (whatever that means)."
			AVATAR_GIVEPOWERS(var/mob/players/m in world) // to give people some GM powers
				m.verbs+=new/mob/players/gmspells/verb/GM_REBOOT
				m.verbs+=new/mob/players/gmspells/verb/GM_KICK
				m.verbs+=new/mob/players/gmspells/verb/GM_RESTART
			AVATAR_TAKEPOWERS(var/mob/players/m in world) // and to take them away
				m.verbs-=new/mob/players/gmspells/verb/GM_REBOOT
				m.verbs-=new/mob/players/gmspells/verb/GM_KICK
				m.verbs-=new/mob/players/gmspells/verb/GM_RESTART
				m.verbs-=new/mob/players/Special1/verb/AVATAR_TEMP
				m.verbs-=new/mob/players/Special1/verb/AVATAR_GIVEPOWERS
				m.verbs-=new/mob/players/Special1/verb/AVATAR_TAKEPOWERS
				m.verbs-=new/mob/players/Special1/verb/AVATAR_REBOOT
				m.verbs-=new/mob/players/Special1/verb/AVATAR_MUTE
				m.verbs-=new/mob/players/Special1/verb/AVATAR_UNMUTE
				m.verbs-=new/mob/players/Special1/verb/AVATAR_KICK
				m.verbs-=new/mob/players/Special1/verb/AVATAR_RESTART
				m.verbs-=new/mob/players/Special1/verb/AVATAR_GOLD
				m.verbs-=new/mob/players/Special1/verb/AVATAR_BAN
				m.verbs-=new/mob/players/Special1/verb/AVATAR_UNBAN
				m.verbs-=new/mob/players/Special1/verb/AVATAR_LEVELUP
			AVATAR_REBOOT() // sometimes it just needs to happen.
				world.Reboot()
			AVATAR_MUTE(var/mob/players/m in world) // quit talking.  now.
				if (istype(m,/mob/players))
					world << "<font color = purple>[usr], the Avatar, has muted [m]!"
					m.muted = 1 // you can no longer say things to us
					m.away = 0 // not even say stupid stuff in an away message
				else
					usr << "sheesh man....you can't mute that, fool." // yell at myself for trying to mute an enemy
			AVATAR_UNMUTE(var/mob/players/m in world) // ok you can talk now

				if (istype(m,/mob/players))
					world << "<font color = purple>[usr], the Avatar, has unmuted [m]!"
					m.muted = 0 // speak.  you can be heard.
				else
					usr << "sheesh man....you can't unmute that, fool."
			AVATAR_KICK(var/mob/players/m in world) // this is a threat. you can come back, but quit being stupid
				if (istype(m,/mob/players))
					world << "<font color = purple>[usr], the Avatar, has kicked [m] into the Void!"
					m.muted = 1 // no speak for you!
					m.loc = null // HA! you just get to sit in the game until you relog, everythings black and no one hears you
					m.location = "The Void" // so we can all get a good laugh at your location
				else
					usr << "sheesh man....you can't kick that, fool."
			AVATAR_RESTART(var/mob/players/m in world) // very useful, move people back to the beginning
				if (istype(m,/mob/players))
					world << "<font color = purple>[usr], the Avatar, moved [m] back to the beginning!"
					m.loc = locate(/turf/start)
					m.location = "Kishkan"
					m.nomotion = 0
					m << sound('q5.mid',1,0,0)
				else
					usr << "sheesh man....you can't move that, fool."
			AVATAR_GOLD(var/mob/players/m in world, numb as num) // HAXOR!!
				if (istype(m,/mob/players))
					m.gold = numb
					m << "<font color = purple>[usr], the Avatar, has set your gold to [numb]!"
					usr << "<font color = purple>You set [m]'s gold to [numb]!"
				else
					usr << "sheesh man....you can't do that, fool."
			AVATAR_BAN(mob/players/M in world,why_quest as message|null) // yep yep. get out.
				if(M == usr) // what are you thinking?!
					usr << "<b>You can't ban yourself!"
					return
				//lots of if crap to make sure that you want to ban them and send them a message saying why
				if((input("Are you sure about banning [M]?") in list("Yes","No")) != "Yes")
					return
				if(M.key)
					if(why_quest)
						M << "<b>[src.name] has banned you from the program because:\n[why_quest]."
					else
						M << "<b>[src.name] has banned you!"
					bans += M.ckey
					world << "<b>[src.name] has banned [M] ([why_quest])"
					del(M)
				else
					usr << "sheesh man....you can't do that, fool."
			AVATAR_UNBAN(key as text) // does this really need explanation? i think not
				if(!bans.Find(ckey(key)))
					usr << "<b>There is no person banned with the key '[key]'."
				else
					usr << "<b>User: [key] has been removed from the banned list."
					bans -= ckey(key) // take em off the banned list
			AVATAR_LEVELUP(mob/players/M in world) // more cheating for me.  leveling with a verb is helpful.  this originated for just debugging purposes and then served many uses
				if (istype(M,/mob/players))
					M.exp+=(M.expneeded-M.exp) // give em the exp they need to level
					checklevel(M) // and then run the function that checks to see if they've leveled yet
					//and tell the involved people what happened
					M << "<font color = purple>[usr], the Avatar, has given you a free level!"
					usr << "<font color = purple>You gave [M] a free level!"
				else
					usr << "sheesh man....you can't do that, fool."
	gmspells // yepyep.  sometimes others need to have some of my cool abilities
		verb
			GM_REBOOT()
				world.Reboot()
			GM_KICK(var/mob/players/m in world)
				if (istype(m,/mob/players))
					world << "<font color = purple>[usr], the Avatar, has kicked [m] into the Void!"
					m.muted = 1
					m.loc = null
					m.location = "The Void"
				else
					usr << "sheesh man....you can't kick that, fool."
			GM_RESTART(var/mob/players/m in world)
				if (istype(m,/mob/players))
					world << "<font color = purple>[usr], the Avatar, moved [m] back to the beginning!"
					m.loc = locate(/turf/start)
					m.location = "Kishkan"
					m.nomotion = 0
					m << sound('q5.mid',1,0,0)
				else
					usr << "sheesh man....you can't move that, fool."

	var // player variables
		char_class // your class, duh
		nomotion = 0 // talking to a shopkeeper?  you can't move. this lets us know when you shouldn't be able to.
		muted = 0 // angered me?  no speaking for you.
		ok = 0 // used for accepting icons, boolean
		level = 1 // your level?  most likely =] my code isnt that obfuscated
		HP = 20 // life
		MAXHP = 20 // maxlife
		MP = 10 // yadda
		MAXMP = 10 // yadda yadda
		exp = 0 // yep
		expneeded = 10 // yep yep
		expgive = 0 // hrmm. never implimented pvp experience.  guess this just stuck around from before i made seperate mob classes for players and enemies
		oldexp = 0 // i think this might be used in the exp meter for calculations, better to make it a variable here than calculate every time
		gold = 0 // mmmmm souls.  buy stuff.
		attackspeed // used in calculating the delay between attacks, affected by weapons
		poisoned = 0 // are you poisoned?  this is boolean
		poisonD // this has to do with how long you were poisoned for
		poisonDMG // this has to do with the damage done each time you are damaged
		inparty=0 // if you are in a party, boolean
		partynumber=0 // which party number are you in?
		awaymessage = "" // your away message
		away = 0 // if you are away, boolean
		location = "" // where you are for the Who tab
		cities[10] // array holding the names of cities you've visited for Warping
		terrashtp = 0 // i have no clue what this was for anymore
		Strength = 1 // strength variable
		Intelligence = 1 // intelligence
		//resistances
		Fireres = 0
		Iceres = 0
		Litres = 0
		Poisres = 0
		Darkres = 0
		warpbookgrave = 0; cheesyquest = 0; // quest booleans so that you only do them once
		//spell levels
		fireboltlevel = 0
		iceboltlevel = 0
		lightningboltlevel = 0
		healinglevel = 0
		flamelevel = 0
		arcticwindlevel = 0
		chainlightninglevel = 0
		telekinesislevel = 0
		warplevel = 0
		transformlevel = 0
		osmosislevel = 0
		feedbacklevel = 0
		poisonlevel = 0
		darklevel = 0
		demilevel = 0
		amelioratelevel = 0
	proc/poisoned(mob/players/P as mob) // you are poisoned dude, this function fires because of that to HURT YOU!
		if(poisoned==1) // gotta make sure that you are poisoned
			P.poisoned=0 // and make it so that this only fired once for you each time you get poisoned
			while(poisonD>0) // yep, we gonna hurt you now
				P.HP -= poisonDMG // take some damage
				s_damage(P, poisonDMG, "red") //show the damage on the screen.  s_damage rules.  thank spuzzum.
				poisonD-- // counting down to 0
				if(P.HP <= 0) // you are dead now dude
					P.poisonD=0 // lets not overkill you
					P.poisoned=0 // you aren't poisoned after death anymore
					P.poisonDMG=0 // just for kicks and checks
					P.overlays = null // no more poison icon thing over you now
					world << "<font color = purple><b>[P] died to poison" // let everyone know how much you suck
					var/G = round((P.gold/4),1) // you lose gold for dying.  shame on you.
					P << "<font color = red>You lost [G] gold" // we'll tell you how much you lost too so you will learn and not do it again
					P.gold-=G // YOINK!
					P.loc = locate(/turf/start) // back to the beginning
					P.location = "Kishkan" // yep. you are in the first town now, sucka.
					usr << sound('q5.mid',1,0,0) // town music
					P.HP = P.MAXHP // i guess we'll give you your life back too, man i am so gracious
					CRASH() // break from this loop and function and everything. i'm done with it if you are dead
				sleep(10) // gotta wait a sec before we damage you again in this loop
			P.poisonD=0 // i guess your poison time has expired
			P.poisoned=0 // we'll stop the pain now
			P.poisonDMG=0 // no more damage
			P.overlays = null // good job. we'll take away those green bubbles too
	proc/Update(mob/M as mob) // calculations for the meters' visuals
		for(var/obj/meter1/N in M.client.screen)
			N.num = (src.HP/src.MAXHP)*N.width
			N.Update()
		for(var/obj/mmeter1/MM in M.client.screen)
			MM.num = (src.MP/src.MAXMP)*MM.width
			MM.Update()
		for(var/obj/xmeter1/MM in M.client.screen)
			MM.num = (src.exp-src.oldexp)/(src.expneeded-src.oldexp)*MM.width
			MM.Update()
	proc/JoinParty(var/mob/players/U,var/mob/players/M) // forming a party, eh?
		var/R = (input(M,"Party Formation","Join [U]([U.ckey])'s party?") in list("Yes","No"))
		switch(R) // depends on the input from the invited person
			if("Yes") // yay. lets go kill stuff together
				if(U.inparty==1) // go on into the party now dude, someone already in a party is inviting you
					M << "\red<b>You joined [U]([U.ckey])'s party"
					U << "\red<b>[M]([M.ckey]) joined your party"
					M.inparty=1 // yep. you in a party now.
					M.partynumber = U.partynumber // in fact. you are in HIS (U) party!
				else // you are trying to form a party of your own with another dude, first time, excellent!
					M << "\red<b>You joined [U]([U.ckey])'s party"
					U << "\red<b>[M]([M.ckey]) joined your party"
					U.inparty=1 // now you both are kicking it together
					M.inparty=1 // aren't we having fun?
					var/X = partycounter // gotta know what party# we're on
					U.partynumber = X // yep. you in it.
					M.partynumber = X // so are you.
					partycounter++ // and now the next party gets the next number. wonderful.
			if("No") // DENIED!
				M << "\red<b>You rejected [U]([U.ckey])'s invitation to party"
				U << "\red<b>[M]([M.ckey]) rejected your invitation to party"
	proc/leaveparty(var/mob/players/M) // gotta go?  that's cool too.... chump.
		if(M.inparty==1)
			var/mob/players/J
			for(J as mob in world) // lets go through everyone in the world
				if (istype(J,/mob/players)) // and if its a player
					if(J.partynumber==M.partynumber) // and they're in your party
						J << "\red<b>[M]([M.ckey]) left the party." // let them know that you left the party
			M.inparty=0 // no more party
			M.partynumber=0 // yep. no party for you.
		else // you can't leave a party if you aren't in one
			M << "\red<b>You aren't in a party."


	var/ratelimit=0 // quit spamming!!!!!!! this is used to keep you from typing too much too fast i think
	verb
		//heh. this variable used to be for everyone, now its just for me, the gamemaster
		/*Temp()
			var/obj/weapons/magicknife/J = new(usr)
			usr << "You got a [J]"*/
		Party() // party time!
			//this J list, C var, and M reference looping is so that all the enemies in the world are not in your list to pick from
			//i hate games that don't do this.  ...like i want to party with a spider, sheesh.  i don't want to see that crap on my list.
			var/list/J[1]
			var/C = 1
			var/mob/players/M
			for(M as mob in world)
				if(istype(M,/mob/players))
					J[C] = M
					C++
					J.len++
			M = (input("Party Formation","Invite...") as mob in J) // which one you want to invite?
			if(M!=usr) // making sure it isn't yourself...
				if(M.inparty==0) // making sure they aren't already in a party
					JoinParty(usr,M) // lets run our happy function with the inviter (usr) and invitee (M selected from list J)
				else
					usr << "[M]([M.ckey]) is already in a party."
			else
				usr << "You can't invite yourself."
		LeaveParty() //verb to call the function to get you on out of there.
			leaveparty(usr)
		Say(msg as text) // i guess we'll let you speak to people nearby
			var/mob/players/M
			if(muted==0) // if you aren't muted, of course
				if(length(msg)<=255) // we don't want to read your long spam messages, sheesh.
					if(ratelimit<=5) // gotta make sure that you don't flame us with a ton of messages too quickly too
						for(M as mob in view(20)) // tell everyone nearby your message without your html formatting crap too
							M << "<font color = red><b>[usr]([usr.ckey]) <font color = red>says: [html_encode(msg)]"
						ratelimit++ // counting how much you've been yacking in a period of time
					else // SPAMMER!!!!!
						usr << "<b>You are over the rate limit.  Please wait..."
						ratelimit=10 // you've got to wait now, chump.
				else
					usr << "<b>Don't spam, the limit is 255 characters." // gotta let them know not to spam
			else
				usr << "<font color = purple>The Avatar has muted you!  No one hears you." //  =]
		WSay(msg as text) // yeah, we'll let you talk to the entire world this time. same spamming protection as Say
			if(muted==0)
				if(length(msg)<=255)
					if(ratelimit<=5)
						world << "<font color = blue><b>[usr]([usr.ckey]) <font color = blue>wsays: [html_encode(msg)]"
						ratelimit++
					else
						usr << "<b>You are over the rate limit.  Please wait..."
						ratelimit=10
				else
					usr << "<b>Don't spam, the limit is 255 characters."
			else
				usr << "<font color = purple>The Avatar has muted you!  No one hears you."
		Whisper() // oh goodness. we even let you whisper a single person.  same spamming protection junk as Say
			var/list/J[1]
			var/C = 1
			var/mob/players/M
			for(M as mob in world)
				if(istype(M,/mob/players))
					J[C] = M
					C++
					J.len++
			M = (input("Whisper","Who") as mob in J)
			var/msg = input("Whisper","Message") as text
			if (istype(M,/mob/players))
				if(muted==0)
					if(length(msg)<=255)
						if(ratelimit<=5)
							M << "<font color = green><b>[usr]([usr.ckey]) <font color = green>whispers: [html_encode(msg)]"
							usr << "<font color = green><b>You whisper [M]([M.ckey])<font color = green>: [html_encode(msg)]"
							ratelimit++
						else
							usr << "<b>You are over the rate limit.  Please wait..."
							ratelimit=10
					else
						usr << "<b>Don't spam, the limit is 255 characters."
				else
					usr << "<font color = purple>The Avatar has muted you!  No one hears you."
			else
				usr << "You can't whisper that"
		ToggleAcceptIcon() // i like you to be able to choose to tell people to not bug you with this junk
			if(ok==0) // gotta check your variable
				ok=1 // ok, i guess you want to accept them now, so we'll change your variable accordingly
				usr << "You are now accepting icon transfers." // and let you know that we did
			else // otherwise you were already
				ok=0 // and now you arent
				usr << "You no longer accept icon transfers."
		SendIcon(I as icon) // so you want to send an icon?  we can accomodate that.
			set desc = "Swap an icon file with anyone in the Game."
			//this J list, C var, and M reference looping is so that all the enemies in the world are not in your list to pick from
			//i hate games that don't do this.  ...like i want to send an icon to a slug, sheesh.  i don't want to see that crap on my list.
			var/list/J[1]
			var/C = 1
			var/mob/players/M
			for(M as mob in world)
				if(istype(M,/mob/players))
					J[C] = M
					C++
					J.len++
			M = (input("Send Icon","Who") as mob in J)
			if(M.ok==1) // if they are accepting icons
				M << I // give it to them
				usr << "[M] received the icon [I]." // and let you know that you did
			else // otherwise
				//let everyone know what is happening.
				M << "[usr] tried to send you an icon, but you are not accepting icon transfers."
				usr << "[M] is not accepting icon transfers."
		GiveGold() // awe...isn't that nice of you?
			//this J list, C var, and M reference looping is so that all the enemies in the world are not in your list to pick from
			//i hate games that don't do this.  ...like i want to give gold to a cheesecake, sheesh.  i don't want to see that crap on my list.
			var/list/J[1]
			var/C = 1
			var/mob/players/M
			for(M as mob in view(5)) // only people you can SEE
				if(istype(M,/mob/players)) // PEOPLE you can see
					J[C] = M
					C++
					J.len++
			M = (input("Give Gold","Who") as mob in J) // who??
			var/numb = input("Give Gold","Amount") as num // how much?!
			if (istype(M,/mob/players)&&numb>0) // gotta check and be sure it is a player, and that you aren't trying to steal their gold with a negative value
				if(M==usr) // you can't give gold to yourself
					return // we'll just leave this function without even the grace of telling yourself that (seeing as we don't have a cancel button i think this is a good thing
				if (gold >= numb) // gotta make sure you have the gold you want to give
					M.gold+=numb // let em have it
					gold-=numb // and take it from you
					//tell everyone what just happened
					M << "\green<b>[usr]([usr.ckey]) gives you [numb] gold"
					usr << "\green<b>You gave [M]([M.ckey]) [numb] gold"
				else
					usr << "Not enough gold" // a bit excessive there
		GiveItem() // im sure the recipient will be pleased
			var/list/U[1] // making a lovely list to choose from again
			var/I = 1 // counter
			var/mob/players/M
			for(M as mob in view(5)) // people in your viewrange
				if(istype(M,/mob/players)) // only people allowed
					U[I] = M
					I++
					U.len++
			M = (input("Give Item","Who") as mob in U) // pick one dude
			var/list/J[1]
			var/C = 1
			var/obj/K
			for(K as obj in view(1)) // you can only pick items in your inventory to give
				if (istype(K,/obj/books) || istype(K,/obj/weapons) ||istype(K,/obj/items)) // make sure that it is something i'll let you give away
					J[C] = K
					C++
					J.len++
			K = (input("Give Item","Item") as obj in J) // pick one of em
			if (istype(M,/mob/players)&&( istype(K,/obj/weapons) || istype(K,/obj/books) || istype(K,/obj/items) )) // gotta keep making extra checks incase some stupid exception comes up
				if(M==usr) // trying to give to yourself?
					return // do nothing
				if(K.suffix == "Equipped") // you can't give people stuff you have equipped
					usr << "<font color = teal>Un-equip [K] first!"
				else // here you go.... have it
					K.Move(M) // theirs now
					//tell everyone what happened
					M << "\green<b>[usr]([usr.ckey]) gives you [K]"
					usr << "\green<b>You gave [M]([M.ckey]) [K]"
			else
				usr << "You can't do that" // an exception was caught and something bad happened.
		Away() // let everyone know that you are away, because we all really care.... riiiiiiiiiight...
			if(muted==0) // we don't let mutes set away messages
				if(away==0) // set the message
					var/J = input("[usr] is away...","Your Away Message") as text
					awaymessage = J
					away = 1
					usr << "You are now away ([awaymessage])"
				else // no longer away if you click this button and you were away
					away = 0
					usr << "You are no longer marked as away"
			else // YOU CANT TELL US ANYTHING, MUTE!
				away = 0
				usr << "<font color = purple>The Avatar has muted you!  No away message for you."
		HotKeys() // help for my premade macros for speed
			usr << "<font color = purple>X = Talk\nC = Get<font color = black>\nSpace = WSay\nV = Say\nM = Whisper\n<font color = green>B = Use Item"
		Help() // help for newbs
			usr << "Run into enemies or use NumPad5 to attack them.  There is a TIME LIMIT to how quickly you can attack between each attack.  Different weapons attack at different speeds.  Cast spells using the Spells menu if you have any or set macros for them in Option/Preferences.  Watch for the Temporary menu to see if you can use any commands at certain times.  Direct any other questions to users in the game using the WSay command.  Right click items in your inventory to drop,equip,use,etc."
			usr << "Visit <b>http://www.oddworldz.com/fuxuroh/Main.html </b>for additional game information!"
		Credits() // letting everyone know the little people involved, not much credit given to myself here... whatever.
			usr << "<b>Created by Xerse\nMusic by:\n<font color = olive>Town, Mmbah\nLearner's Cave, Mmbah\nWorld Map, Xerse\nForests, Chekapazel\nGraveyard & Undead Tower, Mmbah\nIce & Snow Caves, Mmbah\n<font color = black>Special Thanks to:\n<font color = fuchsia>Mmbah, lead tester and graphics\nVermolius, lead tester, graphics, and coding help\n<font color = aqua>RPGMaker2000, and the graphics taken from it\nDeadron's character handling\nSpuzzum's damage numbers\n<font color=black>Awesome looking early icons created by <font color=red>Karlor<font color=black>, \nif he will finish the rest of the enemies, I'll impliment them..."

	proc/GainLevel(var/mob/players/M) // isn't it a great feeling when this fires?
		M << "\green<b>YOU GAINED A LEVEL!!" // There's the message that inspires the good feeling
		M.oldexp = M.expneeded // used for the green exp meter
		M.expneeded+=(13*(M.level*M.level)) // my algorithm for computing experience required per level, no longer a secret
		M.level+=1 // yep.  increment that sucker.

		//this should be an if-else chain or a switch or something, pretty inefficient checks, but whatever...
		if (M.char_class=="Warrior") // so you are a warrior eh?
			var/Hp = (rand(M.level)+(M.level)*7) // well thats how much we increment your HP
			M.MAXHP+=Hp
			M.HP+=Hp
			M << "\green<b>You gained [Hp] HP!"
			var/Mp = (rand(M.level)+(M.level)*2) // and your MP
			M.MAXMP+=Mp
			M.MP+=Mp
			M << "\green<b>You gained [Mp] MP!"
			var/St = rand(4,8) // you get 4-8 strength, isn't that great? tough as nails.
			M.Strength+=St
			M << "\green<b>You gained [St] Strength!"
			var/It = rand(1,2) // 1-2 intelligence for you....warriors, dumber than a bag of hammers
			M.Intelligence+=It
			M << "\green<b>You gained [It] Intelligence!"
			// yep yep... you changed your icon if you are within those levels
			if (M.level>9&&M.level<25&&M.icon_state!="Warrior2")
				M.icon_state = "Warrior2"
				M << "\green<b>Your look has changed!"
			if (M.level>24&&M.level<40&&M.icon_state!="Warrior3")
				M.icon_state = "Warrior3"
				M << "\green<b>Your look has changed!"
			if (M.level>39&&M.level<55&&M.icon_state!="Warrior4")
				M.icon_state = "Warrior4"
				M << "\green<b>Your look has changed!"
			if (M.level>54&&M.level<90&&M.icon_state!="Warrior5")
				M.icon_state = "Warrior5"
				M << "\green<b>Your look has changed!"
			if (M.level>89) // YOU GET TRANSFORM SPELL !!!  good job for going above 90
				M.verbs+=new/mob/players/clespells/verb/Transform
				M.transformlevel+=1
				M << "\green<b>You learned Transform Level [M.transformlevel]!"

		if (M.char_class=="Wizard") // mmmmm magic!power!bwaha! kill! EEEVIL!!!!did i mention MAGIC?!?! ...and power...
			var/Hp = (rand(M.level)+(M.level)*2) // some HP for you
			M.MAXHP+=Hp
			M.HP+=Hp
			M << "\green<b>You gained [Hp] HP!"
			var/Mp = (rand(M.level)+(M.level)*7) // lots of MP for you
			M.MAXMP+=Mp
			M.MP+=Mp
			M << "\green<b>You gained [Mp] MP!"
			var/St = rand(1,2) // can you equip a good armor yet?  probably NOT.
			M.Strength+=St
			M << "\green<b>You gained [St] Strength!"
			var/It = rand(4,8) // but with that physical weakness comes mad magic skillzzzz
			M.Intelligence+=It
			M << "\green<b>You gained [It] Intelligence!"
			// yep yep... more icon changing for the wizards too
			if (M.level>9&&M.level<25&&M.icon_state!="Wizard2")
				M.icon_state = "Wizard2"
				M << "\green<b>Your look has changed!"
			if (M.level>24&&M.level<40&&M.icon_state!="Wizard3")
				M.icon_state = "Wizard3"
				M << "\green<b>Your look has changed!"
			if (M.level>39&&M.level<55&&M.icon_state!="Wizard4")
				M.icon_state = "Wizard4"
				M << "\green<b>Your look has changed!"
			if (M.level>54&&M.level<90&&M.icon_state!="Wizard5")
				M.icon_state = "Wizard5"
				M << "\green<b>Your look has changed!"
			if (M.level>89) // i guess we'll let them transform too... good job for hitting 90
				M.verbs+=new/mob/players/clespells/verb/Transform
				M.transformlevel+=1
				M << "\green<b>You learned Transform Level [M.transformlevel]!"


		if (M.char_class=="Mage")
			var/Hp = (rand(M.level)+(M.level)*4) // a bit more than the wizard
			M.MAXHP+=Hp
			M.HP+=Hp
			M << "\green<b>You gained [Hp] HP!"
			var/Mp = (rand(M.level)+(M.level)*6) // and a bit less than the wizard
			M.MAXMP+=Mp
			M.MP+=Mp
			M << "\green<b>You gained [Mp] MP!"
			var/St = rand(2,4) // yeah yeah... more than wiz
			M.Strength+=St
			M << "\green<b>You gained [St] Strength!"
			var/It = rand(3,6) // less than the wizard, what a shocker!
			M.Intelligence+=It
			M << "\green<b>You gained [It] Intelligence!"
			// new icons for the mage chick at certain levels
			if (M.level>9&&M.level<25&&M.icon_state!="Mage2")
				M.icon_state = "Mage2"
				M << "\green<b>Your look has changed!"
			if (M.level>24&&M.level<40&&M.icon_state!="Mage3")
				M.icon_state = "Mage3"
				M << "\green<b>Your look has changed!"
			if (M.level>39&&M.level<55&&M.icon_state!="Mage4")
				M.icon_state = "Mage4"
				M << "\green<b>Your look has changed!"
			if (M.level>54&&M.level<90&&M.icon_state!="Mage5")
				M.icon_state = "Mage5"
				M << "\green<b>Your look has changed!"
			if (M.level>89)
				M.verbs+=new/mob/players/clespells/verb/Transform
				M.transformlevel+=1
				M << "\green<b>You learned Transform Level [M.transformlevel]!"


		if (M.char_class=="Monk")
			var/Hp = (rand(M.level)+(M.level)*6) // a bit less than the warrior
			M.MAXHP+=Hp
			M.HP+=Hp
			M << "\green<b>You gained [Hp] HP!"
			var/Mp = (rand(M.level)+(M.level)*4) // and a bit more than that uneducated fool
			M.MAXMP+=Mp
			M.MP+=Mp
			M << "\green<b>You gained [Mp] MP!"
			var/St = rand(3,6) // give me my strength so i can kick some people in the head... harder.
			M.Strength+=St
			M << "\green<b>You gained [St] Strength!"
			var/It = rand(2,4) // im decently intelligent too, carazy.
			M.Intelligence+=It
			// just like everyone else, i get new icons
			M << "\green<b>You gained [It] Intelligence!"
			if (M.level>9&&M.level<25&&M.icon_state!="Monk2")
				M.icon_state = "Monk2"
				M << "\green<b>Your look has changed!"
			if (M.level>24&&M.level<40&&M.icon_state!="Monk3")
				M.icon_state = "Monk3"
				M << "\green<b>Your look has changed!"
			if (M.level>39&&M.level<55&&M.icon_state!="Monk4")
				M.icon_state = "Monk4"
				M << "\green<b>Your look has changed!"
			if (M.level>54&&M.level<90&&M.icon_state!="Monk5")
				M.icon_state = "Monk5"
				M << "\green<b>Your look has changed!"
			if (M.level>89) // and transform
				M.verbs+=new/mob/players/clespells/verb/Transform
				M.transformlevel+=1
				M << "\green<b>You learned Transform Level [M.transformlevel]!"


		if (M.char_class=="GameMaster") // XERSE!!!!!!!!!!!!!!!!!
			var/Hp = (rand(M.level)+(M.level)*3) // i might as well give myself some more life
			M.MAXHP+=Hp
			M.HP+=Hp
			M << "\green<b>You gained [Hp] HP!"
			var/Mp = (rand(M.level)+(M.level)*7) // and lots of mana.  mind over matter.
			M.MAXMP+=Mp
			M.MP+=Mp
			M << "\green<b>You gained [Mp] MP!"
			var/St = rand(2,4) // i suppose i can equip some stuff with this much strength, enough to suit my tastes
			M.Strength+=St
			M << "\green<b>You gained [St] Strength!"
			var/It = rand(4,8) // i own you.  my mind controls allllll.
			M.Intelligence+=It
			M << "\green<b>You gained [It] Intelligence!"
			if (M.level>89) // i like this spell too, at level 90+ just like everyone else.
				M.verbs+=new/mob/players/clespells/verb/Transform
				M.transformlevel+=1
				M << "\green<b>You learned Transform Level [M.transformlevel]!"
		//i think i added this to save your character when you leveled, incase the program crashes, dunno why its commented out now, old version maybe?
		//M.client.base_SaveMob()


	proc/checklevel(var/mob/players/M) // can i level?
		if (M.expneeded<=M.exp) GainLevel(M) // sure you can.  if your experience is greater than or equal to how much you need
	var/waiter = 1 // used for delaying attacks, boolean
	verb/attack() // the verb to attack enemies, called with the 5 key on the numpad
		for(var/mob/enemies/M in get_step(src,src.dir)) // the enemy you are looking at.
			if(istype(M,/mob/enemies)&&(waiter>0)) // if it is an enemy and you are allowed to fight now
				Attack(M) // hit em
			else // otherwise
				sleep(attackspeed) // delay based on your attack speed
	Bump(mob/enemies/M)       //When the mob bumps into another mob
		if (istype(M,/mob/enemies)&&(waiter>0))    //If the mob is an enemy...
			Attack(M)
		else
			//haha. my old code (this stupid message) for making people stop massively bumping into things when they were out of time, this was replaced by the speed delay
			//usr << "You missed....Do not hold the arrow keys..."
			sleep(attackspeed)
	proc/Attack(mob/enemies/M) // hit that enemy
		waiter=0 // you can't attack again yet
		var/damage = round(((rand(usr.tempdamagemin,usr.tempdamagemax))*((Strength/100)+1)),1) // calculate the damage
		s_damage(M, damage, "red") // show the damage on the enemy
		M.HP -= damage // deal the actual damage to their variable
		//this was replaced by spuzzum's s_damage,  thank goodness. these messages were ridiculous
		//usr << "You attack [M] for \blue[damage] damage"
		DeadEnemy(M) // checking to see if the enemy is dead, and doing things about it
		sleep(attackspeed) // wait a time period based on your attack speed
		waiter=1 // you can fight again
	proc/DeadEnemy(mob/enemies/M)
		if(M.HP <= 0) // if the enemy is dead
			var/mob/players/J = usr // get a reference to the player
			if(J.inparty==1) // if the player is in a party, we're going to split the exp up
				//this list stuff finds the people in the party who are nearby to share with
				var/list/V[2]
				var/C = 2
				V[1] = J
				var/plevelsum = level
				for(var/mob/players/U as mob in oview(20)) // they have to be within 20 squares
					if(istype(U,/mob/players)) // and be a player
						if(U.partynumber==J.partynumber) // and be in your party
							plevelsum+=U.level
							V[C] = U
							C++
							V.len++
							M.expgive*=1.1 // for each added player. increase the total exp given by 10%
							M.goldgive*=1.1 // and increase the total gold given by 10% as well
				var/Q
				//now we go through all those players, distributing the experience and gold accordingly
				for(Q=1, Q<V.len, Q++) // give everyone their fair share of the loot
					var/mob/players/L = V[Q]
					var/Lperc = (L.level/plevelsum)
					L.exp += round((M.expgive * Lperc),1)
					L.gold += round((M.goldgive *Lperc),1)
					//this line was used by me when checking how much was being distributed in what way, now its gone because it works correctly
					//world << "[L] is getting [round((M.expgive * Lperc),1)]exp and [round((M.goldgive *Lperc),1)]gold"
					checklevel(L) // see if they've leveled up yet
				itemdrop(M,M.x,M.y,M.z) // this is the function with the %s to drop certain items from killing monsters
				//this stuff makes the monster respawn later in this spot where it died
				var
					X;Y;Z;
				X=M.x; Y=M.y; Z=M.z; // the spot where it died, why aren't these an array?!
				MonMake(M.type,X,Y,Z) // call the respawning function
				del(M) // get rid of that dead one
			else // you aren't in a party
				exp += M.expgive // give you the experience
				gold += M.goldgive // and the gold
				checklevel(usr) // see if you leveled
				itemdrop(M,M.x,M.y,M.z) // check to see what the enemy dropped, if anything
				var
					X;Y;Z;
				X=M.x; Y=M.y; Z=M.z;
				MonMake(M.type,X,Y,Z) // respawns the monster in this location at a later point in time
				del(M) // you are a dead monster now, get lost.

	Stat() // these things get called ALOT in order to update stuff
		..()
		var/mob/players/M = usr
		//if your rate limit is between 5 and 10, you can't talk, if it is over 0, you decrement it in time
		//this controls the spamming.
		if(ratelimit>0)
			sleep(10) // we'll decrement this counter every 10
			M.ratelimit--
			if(ratelimit==5) // ill give you a warning before i slap you down
				M << "<b>You are near the rate limit.  Please slow down."
			else if(ratelimit>5) // if you cant speak, we're going to wait until you are below 5 before you can again, this tells the time before you can speak again
				M << "<b>Ratelimit: [(M.ratelimit-5)]"
	Stat()
		..()
		var/mob/players/M = usr
		if(M.poisoned==1) // if you recently got poisoned
			spawn(0) poisoned(M) // call the poison function
	Stat() // these ones are actual statistics
		..()
		var/mob/players/M = usr
		M.tempstr = M.Strength
		statpanel("Stats")
		stat("Name:          ",name)
		stat("Class:         ",char_class)
		stat("Gold:          ",gold)
		stat("Level:         ",level)
		stat("EXP:           ","[exp] / [expneeded]")
		stat("EXP NEEDED:    ",(expneeded-exp))
		stat("HP:            ","[HP] / [MAXHP]")
		stat("MP:            ","[MP] / [MAXMP]")
		stat("Strength:      ",Strength)
		stat("Intelligence:  ",Intelligence)
		stat("Damage:        ","[round((usr.tempdamagemin*((Strength/100)+1)),1)]-[round((usr.tempdamagemax*((Strength/100)+1)),1)]")
		stat("Defense:       ",tempdefense)
		stat("Evade:         ","[tempevade]%")
		stat("Resistances:   ","")
		stat("Fire:          ","[Fireres]%")
		stat("Ice:           ","[Iceres]%")
		stat("Lightning:     ","[Litres]%")
		stat("Poison:        ","[Poisres]%")
		stat("Dark:          ","[Darkres]%")
		src.Update(src)
	Stat() // i think we all know what this does
		..()
		statpanel("Who")
		var
			mob/players/m
			mob/players/M = usr
			X
		X=0
		for(m as mob in world)
			if (istype(m,/mob/players))
				X++
		stat("[X] users in game:")
		for(m as mob in world)
			if (istype(m,/mob/players))
				var/blah
				if(m.inparty==1)
					blah = ",  Party:[m.partynumber]"
					if(m.partynumber==M.partynumber)
						blah = ",  Party:[m.partynumber],  [m.location]"
				else
					blah = ",  Unpartied"
				stat("[m.name] ([m.ckey]),  [m.char_class],  Level [m.level][blah]")
				if(m.away==1)
					stat("[m.name] is away [m.awaymessage]")
	Stat() // inventory contents shown here
		..()
		statpanel("Inventory",contents)
	Stat() // spells
		..()
		statpanel("Spellbook")
		stat("Spell Name:     ","*Damages include Stat bonuses*")
		var/trmp = 100-transformlevel // the amount of MP that transform takes cannot be less than 0 and this is its calculation
		if (trmp<0)
			trmp=0
		//if its level is greater than 0, show it and info about it, including the calculations with strength/intelligence
		if (transformlevel > 0)
			stat("Transform:     ","Level:[transformlevel]     MP:[trmp]     Changes your icon")
		if (fireboltlevel > 0)
			stat("FireBolt:     ","Level:[fireboltlevel]     MP:[(fireboltlevel*2)+1]     Dmg:[round(((2+(fireboltlevel*2))*((Intelligence/100)+1)),1)]-[round(((4+(fireboltlevel*3))*((Intelligence/100)+1)),1)]")
		if (iceboltlevel > 0)
			stat("IceBolt:     ","Level:[iceboltlevel]     MP:[(iceboltlevel*2)+3]     Dmg:[round(((1+(iceboltlevel*3))*((Intelligence/100)+1)),1)]-[round(((3+(iceboltlevel*3))*((Intelligence/100)+1)),1)]")
		if (lightningboltlevel > 0)
			stat("LightningBolt:     ","Level:[lightningboltlevel]     MP:[(lightningboltlevel*2)+5]     Dmg:[1]-[round(((10+(lightningboltlevel*10.72))*((Intelligence/100)+1)),1)]")
		if (healinglevel > 0)
			stat("Healing:     ","Level:[healinglevel]     MP:[(healinglevel*2)+1]     Amt:[round(((2+(healinglevel*2))*((Intelligence/100)+1)),1)]-[round(((4+(healinglevel*3))*((Intelligence/100)+1)),1)]")
		if (flamelevel > 0)
			stat("Flame:     ","Level:[flamelevel]     MP:[(flamelevel*3)+17]     Dmg:[round(((2+(flamelevel*2))*((Intelligence/100)+1)),1)]-[round(((4+(flamelevel*3))*((Intelligence/100)+1)),1)]")
		if (arcticwindlevel > 0)
			stat("ArcticWind:     ","Level:[arcticwindlevel]     MP:[(arcticwindlevel*3)+20]     Dmg:[round(((3+(arcticwindlevel*3))*((Intelligence/100)+1)),1)]-[round(((4+(arcticwindlevel*3))*((Intelligence/100)+1)),1)]")
		if (chainlightninglevel > 0)
			stat("ChainLightning:     ","Level:[chainlightninglevel]     MP:[(chainlightninglevel*3)+23]     Dmg:[1]-[round(((10+(chainlightninglevel*10.72))*((Intelligence/100)+1)),1)]")
		var/telemp = 30-(telekinesislevel)
		if (telemp<0) // telekinesis shouldn't show a negative MP cost as well, because it doesnt give you MP =]
			telemp=0
		if (telekinesislevel > 0)
			stat("Telekinesis:     ","Level:[telekinesislevel]     MP:[telemp]     Picks up target item")
		var/wmp = 50-(warplevel*2)
		if (wmp<0) // nor should warp show negative MP cost
			wmp=0
		if (warplevel > 0)
			stat("Warp:     ","Level:[warplevel]     MP:[wmp]     Warps you to a city")
		if (osmosislevel > 0)
			stat("Osmosis:     ","Level:[osmosislevel]     HP:[15+(osmosislevel*5)]     MP:[round(((5+(osmosislevel*3))*((Intelligence/100)+1)),1)]-[round(((10+(osmosislevel*5))*((Intelligence/100)+1)),1)]        +MP:[round(osmosislevel*4.9,1)]%")
		if (feedbacklevel > 0)
			stat("Feedback:     ","Level:[feedbacklevel]     MP:[15+(feedbacklevel*5)]     MP:[round(((5+(feedbacklevel*3))*((Intelligence/100)+1)),1)]-[round(((10+(feedbacklevel*5))*((Intelligence/100)+1)),1)]        Dmg:[round(feedbacklevel*9.2,1)]%")
		if (poisonlevel > 0)
			stat("Poison:     ","Level:[poisonlevel]     MP:[round(14*sqrt(poisonlevel),1)]     Dmg:[round(10*(sqrt(poisonlevel*((Intelligence/100)+1))),1)]-[round(13*(sqrt(poisonlevel*((Intelligence/100)+1))),1)]          Lasts:[round(4+(poisonlevel/2),1)] seconds")
		if (darklevel > 0)
			stat("Dark:     ","Level:[darklevel]     MP:[(darklevel*2)+9]     Dmg:[round(((10+(darklevel*2))*((Strength/100)+1)),1)]-[round(((16+(darklevel*3))*((Strength/100)+1)),1)]")
		//demi calculations are pretty weird, it has lots of restrictions and stuff
		var/demil = round(((sqrt(demilevel*Strength))/2),1)
		var/demih = round(((sqrt(demilevel*Strength))/1.4),1)
		if(demil>70) demil = 70
		if(demih>70) demih = 70
		var/dmgred = round(25+(0.5*demilevel),1)
		if (dmgred>90) dmgred = 90
		if (demilevel > 0)
			stat("Demi:     ","Level:[demilevel]     MP:[round(24*(sqrt(demilevel)),1)]     Dmg:[demil]-[demih]%          Max Reduction:[dmgred]%")
		var/dmghealed = round(((amelioratelevel)*((Intelligence/100)+1)),1)
		if (dmghealed>70) dmghealed=70
		if (amelioratelevel > 0)
			stat("Ameliorate:     ","Level:[amelioratelevel]     MP:[95+(amelioratelevel*5)]     Amt:[dmghealed]%          Cures Poison")

