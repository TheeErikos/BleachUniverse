

//this is commented out because my BYOND is messed up on this computer, and this stuff won't compile.  I don't have deadon's character handling code anymore that this runs.  It isn't commented out in the real game.

/*#include <deadron/characterhandling>


client
	base_num_characters_allowed = 5

world

	mob = /mob/creating_character

mob/base_save_location = 0



mob/creating_character
	base_save_allowed = 0	// If player quits before choosing, don't want to save this mob.

	Login()
		// Spawn here to avoid problems with calling prompts during login.
		spawn()
			src.CreateCharacter()

	proc/CreateCharacter()

		var/prompt_title = "New Character"
		var/help_text = "What do you want to name the character?"
		var/default_value = key
		var/char_name = input(src, help_text, prompt_title, default_value) as null|text
		char_name = html_encode(char_name)
		if(length(char_name)>20)
			char_name = null
			alert("Names must be under 21 characters long.")
		if (!char_name)

			client.base_ChooseCharacter()
			return

		// Make sure there isn't already a character named that.
		// Character names are stored as ckey, so get the ckey version of the name.
		var/ckey_name = ckey(char_name)
		var/list/characters = client.base_CharacterNames()
		if (characters.Find(ckey_name))
			alert("You already have a character named that! Please choose another name.")
			src.CreateCharacter()
			return
		var/char_class
		switch(src.key)
			if("Xerse")
				char_class = "special1"
			/*if("Mmbah")
				char_class = "special2"
			if("ManeBass")
				char_class = "special3"*/
			if("Aquadramon")
				char_class = "special4"

			else
				var/list/classes = list("Warrior","Monk","Mage","Wizard")
				help_text = "What class?"
				default_value = "Warrior"
				char_class = input(src, help_text, prompt_title, default_value) in classes


		var/mob/new_mob



		// Okay we have enough information, so it's time to create the character and switch the player to it.

		switch(char_class)
			if ("Warrior")			new_mob = new /mob/players/Warrior()
			if ("Monk")				new_mob = new /mob/players/Monk()
			if ("Mage")				new_mob = new /mob/players/Mage()
			if ("Wizard")			new_mob = new /mob/players/Wizard()
			if ("special1")			new_mob = new /mob/players/Special1()

		// Set the attributes.
		new_mob.name = char_name


		// Now switch the player client over to the new mob and delete myself since I'm no longer needed.
		src.client.mob = new_mob
		var/turf/first_location = locate(/turf/start)
		new_mob.Move(first_location)
		del(src)

	mob
	Login()
		..()

		// This is just here for this sample, to make it clear which mob you've logged into.
		/*switch(src.key)
			if("Xerse", "ManeBass", "Mmbah")
				world << "\blue <b> [usr] has joined all; bow to \his mighty power!"*/

		// This is just here for this sample, to make it clear which mob you've logged into.


	Write(savefile/F)
		// This is sample code that keeps track of the player's last position on the map.
		// Their last position is stored when the mob is saved, then reinstated when the mob
		// is read in.

		// First, call the default Write() behavior for mobs.
		..()

		// Now, if we have a map, remember their last location.
		if (world.maxx)
			F["last_x"] << x
			F["last_y"] << y
			F["last_z"] << z

	Read(savefile/F)
		// Call the default Read() behavior for mobs.
		..()

		// Now, if we have a map, put them back on the map in their last location.
		if (world.maxx)
			var/last_x
			var/last_y
			var/last_z
			F["last_x"] >> last_x
			F["last_y"] >> last_y
			F["last_z"] >> last_z
			loc = locate(last_x, last_y, last_z)*/