#define DEBUG
/*

   *****************
   * Combat System *
   *****************

   Welcome to my (Scizzees) Combat System. Please note, this is a FREE demo, and FREE use.
   if you paid for this, you got ripped off! Now this may not be a good demo in Coding "Gurus" eyes
   but in my opinion it gets the job done and can be edited as people want.Thanks.

   Stuff:
   - level up proc
   - death proc
   - attack verb
   - variables
   - ready-stat panel
   - respawn verb
   - **FULLY COMMENTED CODE** =)

   notes:
   - icons are place holders, you may not use them in your game.

   enjoy!

   www.x4network.com - anime games, demos, graphics and programming! check us out!

*/

mob
	Login()
		src.icon='Base.dmi'
		src.loc=locate(1,1,1)
		src<<"[src] has joined"
		alert("Welcome to Scizzees' combat system v0.1","Welcome","Let Me Play!")


// Ok, let's make the variables firstly.

mob
	var
		hp=500 // Health var, define it to 100
		mhp=500 /// as above except the MAX hp.
		str=40// strength var
		mstr=40//max strength
		def=100//defence
		mdef=100/// max defence
		npc=0//npc var for npc mobs
		exp=0//exp for lvling
		mexp=10//max exp.
		level=1///level var
/// variables finished.

// just a grass turf & dirt turf here lol

turf/grass
	icon='grass.dmi'
turf/dirt
	icon='dirt.dmi'

/// onto the verbs!

mob
	verb
		Attack(mob/M as mob in get_step(src,src.dir)) // the mob has to be facing you to attack
			set category="Fighting"/// you all know wut this is.
			if(istype(M,/mob/)) // if it a Mob they we're attacking continue.
				var/damage=round(usr.str-M.def/2) /// define a damage var. user's str vs. M's defence divided by two. you can edit this to your liking.
				if(damage <= 0)// if the damage is less or equal to 0 make it 1 damage.
					damage = 1//change it :P
				M.hp-=damage//remove the damage from M's HP.
				range()<<"[usr] slashed [M] with his sword inflicting <font color=red>[damage]</font> damage!"/// tell the people in ranged M's being attacked.
				usr.DeathCheck(M)//see if M is dead.
			else
				return
// thats the attack verb. now onto the death proc and level proc.

mob
	proc
		DeathCheck(mob/M)
			if(M.hp<=0&&M.npc)// if the hp's 0 and its a NPC.
				world<<"[src] has killed [M]"/// say theyve killed M
				del(M)///delete the npc frm the world cuz its dead
				src.exp+=rand(10,30)/// give exp :)
				src.Level()// call the lvl proc
				return/// stop runtime errors =D
			if(M.hp<=0&&M.client) // if hp 0 and its a client.
				world<<"[src] has killed [M]"// same as before
				M.hp=M.mhp//give them full hp back.
				M.loc=locate(1,1,1)//take them to spawn point, dont DEL them.
				src.exp+=rand(10,30)// give them exp!!
				src.Level()/// call lvl proc

		Level()
			if(src.exp >= src.mexp)
				src.level+=1
				src.mstr+=rand(1,3)
				src.mdef+=rand(1,3)
				src.mhp+=rand(10,15)
				src.mexp+=rand(10,20)
				src.exp=src.mexp
				src.exp=0
				src.hp=src.mhp
				src.def=src.mdef
				src.str=src.mstr
				src<<"You gained a level and are now level [src.level]!"

/// okay procs done, now the stat panel.

mob
	Stat()
		statpanel("Stats")
		stat("Name: [usr]")
		stat("Level: [level]")
		stat("Health: [hp]/[mhp]")
		stat("Str: [str]/[mstr]")
		stat("Def: [def]/[mdef]")
		stat("EXP: [exp]/[mexp]")

/// AND NOW THE ACTUAL NPC TO ATTACK!

mob
	npc
		rat
			icon='Enemy.dmi'
			name="{NPC} Rat"
			npc=1
			hp=100
			def=23

/// Optional Respawn verb.
	verb
		Respawn()
			world.Repop()