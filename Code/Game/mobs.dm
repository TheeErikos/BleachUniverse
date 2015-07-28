
// File:    demo\mobs.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file initializes the player's mob and gives
//   them some items and abilities.

#define DEBUG

world
	map_format = SIDE_MAP

// Uncomment this line to change the title screen image.
Options/title_screen = 'title-screen.jpg'


HealthMeter
	show_caption = 1

ManaMeter
	show_caption = 1

AbilityMenu
	size = 4


mob
	icon = 'player.dmi'
	base_state = "player-human"

	pwidth = 16
	pheight = 16
	pixel_x = -8

	health = 0
	max_health = 0

	reiatsu = 0
	max_reiatsu = 0

	Stat()
		..()
		if (statpanel("Stats"))
			stat("Level:", "[src.level]")
			stat("Experience:", "[src.experience]/[experience_needed]")
			stat("Spirit Power:","[src.health]/[src.max_health]")
			stat("Reiatsu:","[src.reiatsu]/[src.max_reiatsu]")
			stat("Speed:", "[src.effectivespeed]")
			stat("Attack:", "[src.normalattack] ([src.effectiveattack])")
			stat("Defense:", "[src.normaldefense] ([src.effectivedefense])")
			stat("Focus:", "[src.normalfocus] ([src.effectivefocus])")
			stat("Control:", "[src.normalcontrol] ([src.effectivecontrol])")
			stat("Race:", "[src.class]")
			stat("injury", "[src.injury]/[src.max_injury]")
			stat("Souls", "[src.souls]")
			stat("Talent Points:", "[src.talentpoint]")
			stat("Skill Points:", "[src.Skill_Points]")
			stat("Soul Status: [src.deadstatus]")
			setmaxhp()
			setmaxrei()
			CalcStats()


	var
		class = ""
		spritegender = ""

		Activated_Skills = list()
		Learned_Skills = list()
		tmp/Skill_Tree = 0


		haszan = 0
		hasres = 0
		hasmask = 0
		erel = 0
		emask = 0
		zstyle = "zangetsu"
		scallout = ""
		sname = ""
		rstyle = ""
		rcallout = ""
		rname = ""

		base_effectivespeed = 6
		talentpoint = 0
		Skill_Points = 0

		effectiveattack = 0
		effectivespeed = 0
		effectivefocus = 0
		effectivedefense = 0
		effectivecontrol = 0
		effectiveagility = 0
		effectiveaccuracy = 0
		injury = 0
		max_injury = 100
		isdead = 0
		deadstatus = "Alive"
		hairstyle = ""
		haircolor as color

		tmp/boostedattack = 0
		tmp/boostedspeed = 0
		tmp/boostedfocus = 0
		tmp/boosteddefense = 0
		tmp/boostedcontrol = 0

		tmp/bamult = 0
		tmp/bsmult = 0
		tmp/bdmult = 0
		tmp/bcmult = 0
		tmp/bfmult = 0

		normalspeed = 5
		normalfocus = 25
		normaldefense = 25
		normalcontrol = 25
		normalattack = 25

		tmp/slowed = 0
		tmp/statup = ""
		tmp/statupamount = 0
		tmp/gmnumber = 0

		tmp/hpregen = 0
		tmp/reiregen = 0

		tmp/Overlay/weapon
		tmp/Overlay/armor

	description(full_description = 0)
		if(full_description)
			return "<b>[name]</b>\nLevel [level] [class]"
		else
			return "Level [level] [class]"

	reiatsu_regen()
		reiregen = round(max_reiatsu/100*1,1)
		gain_reiatsu(reiregen)

	health_regen()
		hpregen = round(max_health/100*1,1)
		gain_health(hpregen)

	new_character()
		loc = null
		name = text_prompt("What do you want your name to be?")
		class = "Human"//prompt("What character class would you like to be?", "Human")
		spritegender = "Male"

		loc = locate(10, 10, 2)
		camera.pixel_x = 24

		// give the player some souls
		set_souls(20)

		// give them two health potions, these will appear
		// in a single stack in their inventory
		get_item(new /item/health_potion())
		get_item(new /item/health_potion())

		// give the player some attacks
		abilities += new /Ability/Cleave()

	Login()
		..()
		if (src.base_state == "")
			src.base_state = "human2"

	Logout()
		world << "[src.name] has Logged out"
		client.save()
		del src

	action()
		if(slowed)
			move_speed = base_effectivespeed * 0.5
		else
			move_speed = base_effectivespeed

		..()

	died()
		// when a player dies, make them wait two seconds and respawn.
		if(client)
			injury += 25
			InjuryCalc()
			src << "You were knocked out! You'll revive in two seconds."

			spawn(20)
				respawn()

	// after the player respawns, move them back to the starting location
	respawned()
		..()
		if (isdead == 1)
			deadstatus = "Dead"
		else
			deadstatus = "Alive"
		//loc = locate(25, 25, 1)

	verb

		Levelup2(mob/m)
			gmnumber = input("What level do you want to set to?", "GM WINDOW", gmnumber)
			src.level = gmnumber
			m.level_up()

		KillMob(mob/m)
			m.injury = m.max_injury
			m.died()
			respawned()

		GiveSkillPoints(mob/m)
			m.Skill_Points += input("How many skill points does this mob want?", "Number", m.Skill_Points)


client

	perspective = EDGE_PERSPECTIVE | EYE_PERSPECTIVE

	Click(mob/m)
		if(m == usr) return

		if(istype(m))
			if(!usr.party)
				usr.party = new(usr)

			if(m in usr.party.mobs)
				usr.party.remove_player(m)
			else
				usr.party.add_player(m)
		..()