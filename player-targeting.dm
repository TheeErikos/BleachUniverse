
// File:    player-targeting.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains procs to manage the player's
//   target, to show a marker over their target, and
//   some helper procs used to get targets for abilities,

mob
	var
		tmp/mob/target
		tmp/Overlay/target_marker
		tmp/Overlay/target_name
		tmp/pvp = 0

	key_down(k)
		..()

		if(k == Constants.KEY_TARGET)
			target(next_target())
		else if(k == Constants.KEY_CANCEL)
			if(target)
				target(null)
			else
				if(Constants.USE_GAME_MENU)
					game_menu.show()
					client.focus = game_menu

	proc
		// based on the player's current target, find
		// the next one in order.
		next_target()

			var/target_enemies = 1
			if(client.keys[Constants.KEY_TARGET_NON_ENEMIES])
				target_enemies = 0

			var/mob/first_mob
			var/use_next_one = 0
			for(var/mob/m in oview(target_range, src))

				// if we're targeting enemies, skip mobs you can't attack.
				// if we're targeting non-enemies, skip mobs you can attack.
				if(target_enemies != can_attack(m)) continue

				// if you don't have a target, the first mob you
				// can target is the next one.
				if(!target) return m

				// we keep track of the first mob in case the last
				// mob is the one you have selected.
				if(!first_mob) first_mob = m

				// this will only happen when the mob from the
				// previous iteration is what you're targeting now.
				if(use_next_one) return m

				// if the mob in this iteration is the mob you're
				// targeting, the mob in the next iteration is
				// the one we should return.
				if(m == target) use_next_one = 1

			return first_mob

		// switch to target the specified mob
		target(mob/m)
			if(m != target)

				target = m

				if(!target_marker)
					if(target)
						target_marker = target.overlay(Constants.EFFECTS_ICON, "target-marker")
						target_marker.Layer(target.layer - 0.5)
						target_marker.ShowTo(src)
				else
					target_marker.Move(target)

				if(!target_name)
					if(target)
						target_name = target.overlay()
						target_name.ShowTo(src)
						target_name.PixelY(-12)
						target_name.PixelX(-48)
						target_name.TextBounds(128, 32)
				else
					target_name.Move(target)

				if(target && target_name)
					target_name.Text("<text align=center>[target.name]</text>")

		// determines if the player can target a specific mob
		can_attack(mob/m)
			if(!m) return 0
			if(m.dead || m.invulnerable) return 0
			if(istype(m, /projectile)) return 0

			// if you're in the same party you can't attack each other
			if(party && party == m.party)
				return 0

			// if you're both players and your pvp flags are on
			if(team & Constants.TEAM_PLAYERS & m.team)
				if(pvp && m.pvp)
					return 1

			if(team & m.team) return 0
			return 1

		// find a target in melee range - if the player has a mob
		// targeted and their target is in melee range, return that
		// mob, otherwise return the first mob in melee range.
		melee_target(range = 8)

			var/mob/first_mob
			for(var/mob/m in obounds(range))
				if(!can_attack(m))
					continue

				// if your target is attackable and in melee range, reutrn it
				if(m == target)
					return m

				// otherwise we keep track of the first attackable mob
				if(!first_mob)
					first_mob = m

			// this statement will only be reached if you don't have an
			// attackable target in melee range, and this will automatically
			// return null if there are no attackable targets.
			return first_mob

		// return a list of all targets in melee range.
		all_melee_targets(range = 8)
			. = list()
			for(var/mob/m in obounds(range))
				if(can_attack(m))
					. += m

		// alias of line_of_sight
		los(atom/a)
			return line_of_sight(a)

		line_of_sight(atom/a)

			// if you're not on the same z level, you can't see them!
			if(a.z != z)
				return 0

			// trace the ray from your center to theirs
			var/cx = px + pwidth / 2
			var/cy = py + pheight / 2

			var/dx = (a.px + a.pwidth / 2) - cx
			var/dy = (a.py + a.pheight / 2) - cy

			/*
			// Simple LOS
			var/num_steps = 15
			for(var/i = 1 to num_steps)
				var/pct = i / num_steps

				var/tx = round((cx + dx * pct) / Constants.ICON_WIDTH)
				var/ty = round((cy + dy * pct) / Constants.ICON_HEIGHT)

				var/turf/t = locate(tx, ty, z)

				if(!t || t.density)
					return 0

			return 1
			*/

			// More proper LOS
			var/tile_x = round(cx / Constants.ICON_WIDTH)
			var/tile_y = round(cy / Constants.ICON_HEIGHT)

			while(1)

				var/turf/t = locate(tile_x, tile_y, z)

				if(!t)
					return 0

				if(bounds_dist(t, a) < 0)
					return 1

				if(t.density)
					return 0

				var/tx = cx - tile_x * Constants.ICON_WIDTH
				var/ty = cy - tile_y * Constants.ICON_HEIGHT

				if(dx < 0)
					tx = tx / -dx
				else if(dx > 0)
					tx = (Constants.ICON_WIDTH - tx) / dx
				else
					tx = 10000

				if(dy < 0)
					ty = ty / -dy
				else if(dy > 0)
					ty = (Constants.ICON_HEIGHT - ty) / dy
				else
					ty = 10000

				if(tx < ty)
					cx += tx * dx
					cy += tx * dy

					if(dx < 0)
						tile_x -= 1
					else
						tile_x += 1
				else
					cx += ty * dx
					cy += ty * dy

					if(dy < 0)
						tile_y -= 1
					else
						tile_y += 1
