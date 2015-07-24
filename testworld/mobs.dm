
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
	icon = 'mobs.dmi'
	base_state = "human2"

	pwidth = 16
	pheight = 16
	pixel_x = -8

	health = 100
	max_health = 100

	reiatsu = 2000
	max_reiatsu = 2000

	Stat()
		..()
		if(statpanel("Stats"))
			stat("Level:", "[src.playerlevel]")
			stat("Health:","[src.health]/[src.max_health]")
			stat("Reiatsu:","[src.reiatsu]/[src.max_reiatsu]")
			stat("Power:", "[src.effectivepower]")
			stat("Speed:", "[src.effectivespeed]")
			stat("Defense:", "[src.effectivedefense]")
			stat("Attack:", "[src.effectiveattack]")
			stat("Agility:", "[src.effectiveagility]")
			stat("Accuracy:", "[src.effectiveaccuracy]")
			stat("Race:", "[src.class]")
			stat("injury", "[src.injury]/100")
			stat("Souls", "[src.souls]")
			stat("Talent Points:", "[src.talentpoint]")
			stat("Alive Status: [src.deadstatus]")


	var
		class = ""
		spritegender = ""
		release = ""
		base_effectivespeed = 6
		playerlevel = 1
		talentpoint = 0

		effectivepower = 10
		effectivespeed = 10
		mind = 1
		effectivedefense = 10
		resistance = 1
		effectiveattack = 10
		effectiveagility = 10
		effectiveaccuracy = 10
		injury = 0
		isdead = 0
		deadstatus = "Alive"

		boostedpower = 0
		boostedspeed = 0
		boostedmind = 0
		boosteddefense = 0
		boostedresistance = 0
		boostedattack = 0

		normalpower = 0
		normalspeed = 0
		normalmind = 0
		normaldefense = 0
		normalresistance = 0
		normalattack = 0

		tmp/slowed = 0
		tmp/statup = ""

		tmp/Overlay/weapon
		tmp/Overlay/armor

	description(full_description = 0)
		if(full_description)
			return "<b>[name]</b>\nLevel [level] [class]"
		else
			return "Level [level] [class]"

	reiatsu_regen()
		gain_reiatsu(50)

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
		music('music.xm')
		if (src.base_state == "")
			src.base_state = "human2"

	Logout()
		world<<"[src.name] has Logged out"
		client.save()
		del src

	action()
		if(slowed)
			move_speed = base_effectivespeed * 0.5
		else
			move_speed = base_effectivespeed

		..()

	died()
		..()

		// when a player dies, make them wait two seconds and respawn.
		if(client)
			injury += 25
			InjuryCalc()
			src << "You died! You'll respawn in two seconds."

			spawn(20)
				respawn()

	// after the player respawns, move them back to the starting location
	respawned()
		..()
		if (isdead == 1)
			deadstatus = "Dead"
		else
			deadstatus = "Alive"
		//loc = locate()//locate(17, 35, 1)

	verb
		SpendTalent()
			statup = input("Which stat do you want to upgrade?", "Stats", statup) in list ("Power", "Defense", "Attack")

client
	Click(mob/m)
		if(m == usr) return

		if(istype(m))
			if(!usr.party)
				usr.party = new(usr)

			if(m in usr.party.mobs)
				usr.party.remove_player(m)
			else
				usr.party.add_player(m)
