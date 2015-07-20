
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
Options/title_screen = 'title-screen.png'

HealthMeter
	show_caption = 1

ManaMeter
	show_caption = 1

AbilityMenu
	size = 4


mob
	icon = 'player-human.dmi'
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
			stat("Level:", "[src.level]")
			stat("Health:","[src.health]/[src.max_health]")
			stat("Reiatsu:","[src.reiatsu]/[src.max_reiatsu]")
			stat("Power:", "[src.power]")
			stat("Speed:", "[src.speed]")
			stat("Defense:", "[src.defense]")
			stat("Attack:", "[src.attack]")
			stat("Agility:", "[src.agility]")
			stat("Accuracy:", "[src.accuracy]")
			stat("Race:", "[src.class]")
			stat("Souls", "[src.souls]")


	var
		class = ""
		base_speed = 4

		power = 5
		speed = 5
		mind = 5
		defense = 5
		resistance = 5
		attack = 5
		agility = 5
		accuracy = 5
		T = 0

		tmp/slowed = 0

		tmp/Overlay/weapon
		tmp/Overlay/armor

	description(full_description = 0)
		if(full_description)
			return "<b>[name]</b>\nLevel [level] [class]"
		else
			return "Level [level] [class]"

	reiatsu_regen()
		gain_reiatsu(5)

	new_character()
		loc = null

		src << "Welcome to bleach universe!"
		src << ""
		src << "Press \[I] to open your inventory."
		src << "Press \[F] to customize your abilities."
		src << "Press \[Space Bar] to interact with NPCs."
		src << "Press \[Esc] to exit menus, close windows, or bring up the game menu."
		src << "Press \[L] or \[Space Bar] to loot corpses."
		src << "Press \[1] and \[2] to attack."
		src << "Press \[Tab] to select a hostile target."
		src << "Press \[Shift] + \[Tab] to select a friendly target."
		src << "Press \[Q] to switch input focus to the quest tracker."

		name = text_prompt("What do you want your name to be?")
		class = "Human"//prompt("What character class would you like to be?", "Human")

		loc = locate(25, 25, 1)
		camera.pixel_x = 24

		// give the player some souls
		set_souls(20)

		// give the player a sword and equip it
		equip(get_item(new /item/sword()))

		// give them armor, a helmet, and a dagger but don't equip them
		get_item(new /item/armor())
		get_item(new /item/helmet())
		get_item(new /item/dagger())
		get_item(new /item/hollowmask1())

		// give them two health potions, these will appear
		// in a single stack in their inventory
		get_item(new /item/health_potion())
		get_item(new /item/health_potion())

		// give the player 15 iron bars
		get_item(new /item/iron_bar(15))

		// give the player some attacks
		abilities += new /Ability/Cleave()
		abilities += new /Ability/Poison()
		abilities += new /Ability/Fireball()
		abilities += new /Ability/ShootArrow()

		// and a crafting ability
		abilities += new /CraftingAbility/MakeSword()


	Login()
		if(T==0)
			..()
			music('mainmenu.wav')
			T=1
		else
			..()
			music('mainmenu.wav', 0)


	action()
		if(slowed)
			move_speed = base_speed * 0.5
		else
			move_speed = base_speed

		..()

	died()
		..()

		// when a player dies, make them wait two seconds and respawn.
		if(client)
			src << "You died! You'll respawn in two seconds."

			spawn(20)
				respawn()

	// after the player respawns, move them back to the starting location
	respawned()
		..()
		//loc = locate()//locate(17, 35, 1)

mob
	var
		shadow_state = "shadow"

	// regular mobs have shadows
	Read()
		..()
		underlays = null
		underlays += image(icon, icon_state = shadow_state, layer = layer - 0.5)

	New()
		..()
		underlays = null
		underlays += image(icon, icon_state = shadow_state, layer = layer - 0.5)

// you can click on mobs to add or remove them from your party.
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
