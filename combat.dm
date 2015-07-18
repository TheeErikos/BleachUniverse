
// File:    combat.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the Combat object, which has
//   procs for dealing damage. This file also contains
//   the procs for updating a mob's health and handling
//   their death.

atom
	movable
		var
			lootable = 0

mob
	var
		dead = 0
		invulnerable = 0

		health = 0
		max_health = 0

		mana = 0
		max_mana = 0

		tmp/Overlay/loot_indicator

		team = Constants.TEAM_PLAYERS

	enemy
		lootable = 1
		team = Constants.TEAM_ENEMIES

	set_state()
		if(dead)
			if(base_state)
				icon_state = "[base_state]-dead"
			else
				icon_state = "dead"
		else
			..()

	move()
		if(!dead)
			..()


	// these are helper procs for creating ability effects
	proc

		// procs for managing health / mana
		lose_health(h, mob/attacker = null)
			set_health(health - h, attacker)

		gain_health(h, mob/attacker = null)
			set_health(health + h, attacker)

		set_health(h, mob/attacker = null)
			if(h < 0) h = 0
			if(h > max_health) h = max_health

			if(health > 0)
				health = h

				if(health <= 0)
					die(attacker)

			else
				health = h

			if(health_meter)
				health_meter.update()

			health_changed()

		lose_max_health(h)
			set_max_health(max_health - h)

		gain_max_health(h)
			set_max_health(max_health + h)

		set_max_health(h)
			if(h < 0) h = 0

			max_health = h

			if(health > max_health)
				set_health(max_health)

		lose_mana(m)
			set_mana(mana - m)

		gain_mana(m)
			set_mana(mana + m)

		set_mana(m)
			if(m < 0) m = 0
			if(m > max_mana) m = max_mana

			mana = m

			if(mana_meter)
				mana_meter.update()

			mana_changed()

		lose_max_mana(h)
			set_max_mana(max_mana - h)

		gain_max_mana(h)
			set_max_mana(max_mana + h)

		set_max_mana(h)
			if(h < 0) h = 0

			max_mana = h

			if(mana > max_mana)
				set_mana(max_mana)

		die(mob/attacker)

			// if you're already dead, do nothing
			if(dead)
				return

			dead = 1

			stop()
			density = 0

			// execute the "killed" and "died" events
			if(attacker)
				attacker.killed(src)

			died(attacker)

		respawn()

			// if the mob wasn't dead, do nothing
			if(!dead)
				return

			dead = 0
			density = 1

			set_health(max_health)
			set_mana(max_mana)

			// execute the "respawned" event
			respawned()

Combat
	proc
		attack(mob/attacker, mob/target, damage)

			if(!target || target.dead || target.invulnerable)
				return 0

			// return the amount of damage done
			return deal_damage(attacker, target, damage)

		deal_damage(mob/attacker, mob/target, damage)

			// the framework supports invulnerable targets
			// for things like NPCs.
			if(target.invulnerable)
				damage = 0

			if(damage < 0)
				damage = 0
			else
				damage = round(damage)

			// Update the target's health
			target.lose_health(damage, attacker)

			target.took_damage(damage, attacker, src)

			if(attacker)
				attacker.dealt_damage(damage, target, src)

			// return the amount of damage done
			return damage
