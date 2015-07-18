
// File:    hud-party.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file creates the on-screen display of your
//   party members. It's automatically updated as
//   members are added or removed, and as they gain
//   or lose health/mana.

PartyMemberDisplay
	parent_type = /HudGroup

	layer = Constants.HUD_LAYER

	var
		mob/owner
		mob/mob

		HudObject/health
		HudObject/mana
		HudObject/player
		HudObject/caption
		HudObject/shadow

	New(mob/o, mob/m)
		..(o)

		owner = o
		mob = m

		health = add(-4, 16, "health-4")
		mana = add(36, 16, "mana-4")
		player = add(16, 16, icon = m.icon, icon_state = "[m.base_state]-standing")
		player.overlays += m.overlays
		caption = add(0, 0, "", maptext_width = 64, maptext = "<text align=\"center\">[m.name]</text>", layer = layer + 1)
		shadow = add(-1, -1, "", maptext_width = 64, maptext = "<text align=\"center\"><font color=#000>[m.name]</font></text>")
		refresh()

	proc
		refresh()

			var/h = 0
			if(mob.max_health)
				h = round(4 * mob.health / mob.max_health)

			if(h < 0) h = 0
			if(h > 4) h = 4

			health.icon_state = "health-[h]"

			var/m = 0
			if(mob.max_mana)
				h = round(4 * mob.mana / mob.max_mana)

			if(m < 0) m = 0
			if(m > 4) m = 4

			mana.icon_state = "mana-[m]"

PartyDisplay
	parent_type = /HudGroup

	var
		mob/owner
		list/mobs = list()

	New(mob/m)
		..()
		owner = m

		pos(Constants.VIEW_WIDTH * Constants.ICON_WIDTH - 8, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 56)

	Del()
		for(var/mob/m in mobs)
			var/PartyMemberDisplay/p = mobs[m]

			if(p)
				p.hide()
				del p

		..()

	show()
		..()

		for(var/mob/m in mobs)
			var/PartyMemberDisplay/p = mobs[m]
			if(p)
				p.show()

	hide()
		for(var/mob/m in mobs)
			var/PartyMemberDisplay/p = mobs[m]
			if(p)
				p.hide()

		..()

	proc
		update(mob/m)

			var/PartyMemberDisplay/p = mobs[m]
			if(p)
				p.refresh()

		refresh()

			// if you're not in a party, clear the display
			if(!owner.party)
				for(var/mob/m in mobs)
					var/PartyMemberDisplay/p = mobs[m]

					if(p)
						p.hide()
						del p

			// if you're still in a party, update the members
			else
				var/index = 1

				// remove the displays of any mobs that aren't in the party
				for(var/mob/m in mobs)
					if(!(m in owner.party.mobs))
						var/PartyMemberDisplay/p = mobs[m]
						if(p)
							p.hide()
							del p

						mobs -= m

				// for each mob in your party
				for(var/mob/m in owner.party.mobs)

					// skip yourself
					if(m == owner) continue

					var/PartyMemberDisplay/p

					// grab their display if they've got one already
					if(m in mobs)
						p = mobs[m]
						// if(!p) p = new(owner, m)

					// if they don't have a display, create one
					else
						p = new(owner, m)
						mobs[m] = p

					// update its position
					p.pos(sx - index * 64, sy)
					index += 1

mob
	var
		PartyDisplay/party_display

	init_hud()
		..()

		if(party_display)
			party_display.hide()
			del party_display

		if(Constants.USE_PARTY_DISPLAY)
			party_display = new(src)

	clear_hud()
		..()

		if(party_display)
			party_display.hide()
			del party_display

	key_down(k)
		..()

		if(k == Constants.KEY_PARTY)
			if(party && party_display)
				party_display.toggle()
