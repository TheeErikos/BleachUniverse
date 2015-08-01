
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
			CalcStats()


	var
		list/class = list()
		spritegender = ""

		Activated_Skills = list()
		Learned_Skills = list()
		tmp/Skill_Tree = 0


		haszan = 0
		hasres = 0
		hasmask = 0
		erel = 0
		emask = 0
		zstyle = ""
		scallout = ""
		sname = ""
		rstyle = ""
		rcallout = ""
		rname = ""
		shikaiat = null
		bankaiat = null

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

		boostedattack = 0
		boostedspeed = 0
		boostedfocus = 0
		boosteddefense = 0
		boostedcontrol = 0

		bamult = 0
		bsmult = 0
		bdmult = 0
		bcmult = 0
		bfmult = 0

		normalspeed = 3
		normalfocus = 25
		normaldefense = 25
		normalcontrol = 25
		normalattack = 25

		tmp/slowed = 0
		tmp/statup = ""
		tmp/statupamount = 0

		tmp/hpregen = 0
		tmp/reiregen = 0
		injuryregen
		tmp/isresting

		tmp/Overlay/weapon
		tmp/Overlay/armor

	description(full_description = 0)
		if(full_description)
			return "<b>[name]</b>\nLevel [level] [class]"
		else
			return "Level [level] [class]"

	new_character()
		loc = null
		name = text_prompt("What do you want your name to be?")
		class = "Human"//prompt("What character class would you like to be?", "Human")
		spritegender = "Male"
		client.perspective = EYE_PERSPECTIVE
		client.eye = locate(10,95,1)

		loc = locate(14, 90, 1)
		camera.pixel_x = 24


		// give the player some souls
		set_souls(20)

		// give them two health potions, these will appear
		// in a single stack in their inventory

		// give the player some attacks
		abilities += new /Ability/MeleeAttack()
		abilities += new /Ability/ShikaiRelease()
		abilities += new /Ability/BankaiRelease()
		abilities += new /Ability/FullbringRelease()
		abilities += new /Ability/GetsugaTenshou()
		health = max_health
		reiatsu = max_reiatsu

	Login()
		..()
		if (src.base_state == "")
			src.base_state = "player-human"
		music(SOUND_MUTE)
		DeveloperCommands()

	action()
		if(slowed)
			move_speed = effectivespeed * 0.5
		else
			move_speed = effectivespeed

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

client

	perspective = MOB_PERSPECTIVE

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