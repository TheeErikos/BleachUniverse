
// File:    enemy-ai.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the code that manages which mobs
//   are active. If a mob isn't near a client it is
//   deactivated to save CPU usage. This file also contains
//   the ai() proc which can be used to create enemy AI.

var
	list/active_mobs = list()

PixelMovement
	movement()
		for(var/mob/m in active_mobs)
			m.check_loc()
			m.movement(tick_count)

mob
	var
		tmp/ai_paused = 0
		tmp/wander_delay = 0
		tmp/activation_range = 10
		tmp/active = 0
		tmp/deactivation_delay = 0

		// this is the number of tiles the mob will stray while wandering
		tmp/wander_distance = 4

		// this is the distance in pixels the mob will get from their
		// target to attack them. The default, 8 pixels, is melee range.
		tmp/attack_distance = 6

		// this is the number of tiles around the mob will check to find
		// a target and the cooldown (in ticks) between attempts to find
		// a target. The target_range var is also used by the player's
		// targeting - when you press tab it'll cycle through all targets
		// within this range of the player.
		tmp/target_range = 5
		tmp/target_cooldown = 20

	// enemies have a smaller default targeting range.
	enemy
		target_range = 3

	movement(t)

		// only non-client mobs can become deactivated
		if(!client)

			// check every 40 ticks
			deactivation_delay -= 1
			if(deactivation_delay <= 0)
				deactivation_delay = 40

				// see if there's a nearby client
				var/deactivate = 1
				for(var/mob/m in oview(activation_range + 1, src))
					if(m.client)
						deactivate = 0
						break

				// if no clients are nearby, deactivate
				if(deactivate)
					deactivate()
					return

		..()

	action(t)

		if(dead)
			moved = 0

			// clear the player's input so they stop
			// moving even if they were holding a key
			if(client)
				client.clear_input()

			slow_down()
			return

		// if the mob is alive, check if health and mana regen
		// should be called.
		if(health < max_health)
			if(!on_cooldown("health_regen"))
				cooldown("health_regen", Constants.REGEN_TICK_LENGTH)
				health_regen()

		if(mana < max_mana)
			if(!on_cooldown("mana_regen"))
				cooldown("mana_regen", Constants.REGEN_TICK_LENGTH)
				mana_regen()


		// only clients check for mobs to activate
		if(client)

			..()

			// check every 40 ticks
			deactivation_delay -= 1
			if(deactivation_delay <= 0)
				deactivation_delay = 40

				for(var/mob/m in oview(activation_range, src))
					m.activate()

		// for non-client mobs, call their ai() proc
		else
			if(moved)
				moved = 0
			else
				slow_down()

			if(ai_paused)
				return

			if(path || destination)
				follow_path()

			if(!ai_paused)
				ai()

	proc
		// by default these do nothing, they're just called
		// periodically and you can implement regeneration
		// however you'd like.
		health_regen()
		mana_regen()

		// by default, the mob's AI makes them wander around, look
		// for targets, and attack their targets.
		ai()
			// if the enemy has a target, move towards it
			if(target)
				if(bounds_dist(src, target) > attack_distance)
					move_towards(target)
				else
					stop()

				// try using each attack
				if(abilities)
					for(var/Ability/ability in abilities)
						use_ability(ability)

			// otherwise we wander around and look for a target
			else
				if(wander_distance)
					wander(wander_distance)

				// we use cooldowns to limit how often we look for targets.
				if(!on_cooldown("find-target"))

					// look for a target
					target = find_target(target_range)

					// if we didn't find a target, wait before checking again
					if(!target)
						cooldown("find-target", target_cooldown)

		ai_pause()
			ai_paused = 1

		ai_play()
			ai_paused = 0

		// makes the mob move to a random turf located within a
		// specified range of the mob's initial position.
		wander(range = 3)
			if(!loc) return
			if(!x) return
			if(!initial(x)) return

			if(!path)
				var/turf/t = loc

				while(!t || t.density || t == loc)
					t = locate(initial(x) + rand(-range, range), initial(y) + rand(-range, range), z)

				if(t)
					move_to(t)

		activate()
			if(active) return

			active = 1
			active_mobs += src
			deactivation_delay = rand(60, 90)

			for(var/Condition/c in conditions)
				c.activate()

		deactivate()
			if(!active) return

			active = 0
			active_mobs -= src

			if(client)
				for(var/Condition/c in conditions)
					c.deactivate()

		// enemy AI helper procs
		find_target(range = 4)
			for(var/mob/m in oview(range, src))
				if(can_attack(m))
					return m
