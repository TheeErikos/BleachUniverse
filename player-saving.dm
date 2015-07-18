
// File:    player-saving.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains procs to manage the player's
//   saved characters. It also manages the loading of
//   characters and the ability to select a character,
//   making it easy to develop a character selection
//   screen.

mob
	var
		// this is the mob's loc, but we store it
		// separate from the loc var because when
		// a mob is loaded, we don't want them to
		// be placed on the map but we do want to
		// know their loc so we can place them on
		// the map when the player picks that mob
		saved_x = 0
		saved_y = 0
		saved_z = 0

client
	var
		list/mobs
		save = 0

	proc
		save()

			// you can only save if you've loaded, otherwise
			// you'll overwrite your savefile.
			if(!save)
				return 0

			if(!mobs)
				mobs = new /list(Constants.SAVE_SLOTS)

			for(var/mob/m in mobs)
				// if the mob has a loc, update its saved loc
				if(m.loc)
					m.saved_x = m.x
					m.saved_y = m.y
					m.saved_z = m.z
					// m.saved_loc = m.loc

			var/savefile/f
			if(Constants.CLIENT_SIDE_SAVING)
				f = new()
			else
				f = new("saves\\[ckey]")

			// save the player's characters
			f << mobs
			f << ignore_list
			f << sound_volume
			f << music_volume
			f << screen_size
			f << bank

			if(Constants.CLIENT_SIDE_SAVING)
				Export(f)

			return 1

		load()

			save = 1

			if(!mobs)
				mobs = new /list(Constants.SAVE_SLOTS)

			var/savefile/f

			// load the savefile from the client
			if(Constants.CLIENT_SIDE_SAVING)
				var/client_file = Import()
				if(!client_file)
					return 0

				f = new(client_file)

			// otherwise we load it from the server
			else
				if(!fexists("saves\\[ckey]"))
					return 0

				f = new("saves\\[ckey]")

			// load the player's characters
			f >> mobs
			f >> ignore_list

			var/sv, mv, ss
			f >> sv
			f >> mv
			f >> ss
			f >> bank

			sound_volume(sv)
			music_volume(mv)
			screen_size(ss)

			for(var/mob/m in mobs)
				m.loc = null
				m.overlays = null
				m.bank = bank

				for(var/slot in m.equipment)
					var/item/i = m.equipment[slot]

					if(i)
						m.unequip(i)
						m.equip(i)

			return 1

		clear()
			Export()
			fdel("saves\\[ckey]")
			save = 1
			mobs = new /list(Constants.SAVE_SLOTS)

		delete_character(index)
			if(!mobs)
				mobs = new /list(Constants.SAVE_SLOTS)

			var/mob/m = mobs[index]
			mobs[index] = null

			if(m)
				m.deactivate()
				m.clear_hud()
				del m

		new_character(index)

			if(!mobs)
				mobs = new /list(Constants.SAVE_SLOTS)

			var/mob_count = 0
			for(var/mob/m in mobs)
				mob_count += 1

			if(mob_count >= Constants.SAVE_SLOTS)
				return null

			var/mob/m = new /mob()
			connect(m)

			m.new_character()
			mobs[index] = m

			return m

		// connect the client to the specified mob and perform
		// whatever operations are necessary to make this work
		connect(mob/m)

			// deactivate and clean up the old mob:
			if(mob)
				// if the mob was on the map, update their
				// saved loc and remove them from the map.
				if(mob.loc)
					mob.saved_x = mob.x
					mob.saved_y = mob.y
					mob.saved_z = mob.z
					mob.loc = null

				mob.clear_hud()
				mob.deactivate()

			m.client = src

			if(!bank)
				bank = new()

			m.bank = bank

			// activate and initialize the new mob
			m.activate()
			m.clear_hud()
			m.init_hud()
			statobj = m
			focus = m

			if(m.saved_x)
				var/turf/t = locate(m.saved_x, m.saved_y, m.saved_z)
				m.loc = t

			if(m.dead)
				m.respawn()

			mob = m

			var/turf/t = m.loc
			if(t)
				m.set_pos(t.px, t.py)

mob
	proc
		// you can override this to change how a new mob
		// gets initialized (stats, items, abilities, etc.)
		new_character()

client
	New()
		// clear()
		load()

		// connect the client to a temporary mob, this is the
		// mob they're connected to while they select a character
		connect(new /mob/temporary())

		..()

	Del()
		save()
		..()

mob
	// the temporary mob is what's created for the client
	// when they first connect to the game. We use it here
	// to create a character selection menu.
	temporary
		Login()
		Logout()

		key_down(k)
			if(k == Constants.KEY_SELECT)
				// mob_selection.mobs = client.mobs
				mob_selection.refresh(client.mobs)
				mob_selection.show()
				client.focus = mob_selection

			// temporary mobs can chat too
			if(k == Constants.KEY_CHAT)
				winset(src, "default.chat-input", "focus=true")
