
// File:    demo\abilities.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains definitions of three abilities,
//   two are melee attacks and one is a ranged attack.
//   These examples show how to create cooldowns, mana
//   costs, damage, graphical effects, and projectiles.

Ability
	MeleeAttack
		name = "Melee Attack"
		icon_state = "ability-button-melee-attack"
		description = "Deals damage to a single melee target."
		animation = "attacking"
		cooldown = 40

		// can_use enforces the mana cost by default, we
		// override it to check the cooldown.
		can_use(mob/user)
			if(user.on_cooldown("melee-attack", "attack"))
				return 0

			// make sure the user has a target
			var/mob/target = user.melee_target()
			if(!target)
				user.no_target_selected(src)
				return 0

			return ..()

		effect(mob/user)

			// find a target in the attacker's melee range
			var/mob/target = user.melee_target()

			// trigger a 40 tick cooldown for this ability and
			// a 10 tick cooldown for all attacks
			user.cooldown("melee-attack", cooldown)
			user.cooldown("attack", 10)

			// inflict damage and show a graphical effect on the target
			PhysicalCombat.attack(user, target, 5 + user.power)
			target.effect("dagger-slash")
			target.noise('hit-1.wav', frequency = rand(0.7, 1.3))

	Poison
		name = "Poison"
		icon_state = "ability-button-make-sword"
		description = "Deals 16 damage over 4 seconds."
		animation = "attacking"
		cooldown = 80

		// poison also has a cooldown
		can_use(mob/user)
			if(user.on_cooldown("poison", "attack"))
				return 0

			// make sure the user has a target
			var/mob/target = user.melee_target()
			if(!target)
				user.no_target_selected(src)
				return 0

			return ..()

		effect(mob/user)

			var/mob/target = user.melee_target()

			user.cooldown("poison", cooldown)
			user.cooldown("attack", 10)

			// create the poisoned condition
			new /Condition/Poisoned(target, user)

			// show a graphical effect and play a sound
			target.effect("poison")
			target.noise('hit-1.wav', frequency = rand(0.7, 1.3))

	Cleave
		name = "Cleave"
		icon_state = "ability-button-cleave"
		description = "Deals damage to all melee targets."
		animation = "attacking"
		cooldown = 20

		// cleave also has a cooldown
		can_use(mob/user)
			if(user.on_cooldown("cleave", "attack"))
				return 0

			// make sure there's at least one target in range.
			var/list/targets = user.all_melee_targets()

			if(!targets.len)
				user.no_target_selected(src)
				return 0

			return ..()

		effect(mob/user)

			// 20 tick ability cooldown, 10 tick attack cooldown
			user.cooldown("cleave", cooldown)
			user.cooldown("attack", 10)

			// damage all targets in melee range
			for(var/mob/target in user.all_melee_targets())
				PhysicalCombat.attack(user, target, 3 + user.power / 2)
				target.effect("sword-slash")
				target.noise('hit-2.wav', frequency = rand(0.7, 1.3))

	Fireball
		name = "Fireball"
		icon_state = "ability-button-fireball"
		description = "Shoots a fireball that deals 15 magic damage."
		animation = "attacking"
		mana_cost = 3
		cooldown = 30

		// fireball also has a cooldown
		can_use(mob/user)
			if(user.on_cooldown("fireball", "attack"))
				return 0
			else
				return ..()

		effect(mob/user)

			user.cooldown("fireball", cooldown)
			user.cooldown("attack", 10)

			// All we do is create the projectile, everything is handled
			// by the /projectile/fireball definition and the built-in
			// behavior of the /projectile type.
			//
			// If your target is null, the projectile's New proc (as defined
			// by the framework) will fire the projectile in the direction
			// you're facing. If your target isn't null, the projectile will
			// be fired in the precise direction of your target. That doesn't
			// mean it's guaranteed to hit your target, but it's better than
			// only being able to shoot in 8 directions.
			new /projectile/fireball(user, user.target)

			user.noise('fire.wav', frequency = rand(0.7, 1.3))

	ShootArrow
		name = "Shoot Arrow"
		icon_state = "ability-button-shoot-arrow"
		description = "Ranged attack that deals 10 damage."
		animation = "attacking"
		cooldown = 20

		// check the cooldown
		can_use(mob/user)
			if(user.on_cooldown("shoot-arrow", "attack"))
				return 0

			// the user must have a valid target selected
			if(!user.can_attack(user.target))
				user.no_target_selected(src)
				return 0

			// and they have to be within range of their target
			if(user.distance_to(user.target) > 200)
				user.target_out_of_range(src)
				return 0

			// and they need line of sight to their target
			if(!user.los(user.target))
				user.no_line_of_sight(user.target)
				return 0

			return ..()

		effect(mob/user)

			// 20 tick ability cooldown, 10 tick attack cooldown
			user.cooldown("shoot-arrow", cooldown)
			user.cooldown("attack", 10)

			new /missile/ShootArrow(user, user.target)

missile
	ShootArrow
		move_speed = 15
		icon_state = "arrow"

		hit(mob/m)
			PhysicalCombat.attack(owner, m, 10 + owner.speed)
			m.effect("arrow-hit")
			m.noise('hit-1.wav', frequency = rand(0.7, 1.3))

projectile
	fireball
		damage = 15
		icon_state = "fireball"

		pwidth = 20
		pheight = 16
		pixel_x = -6
		pixel_y = -5

		move_speed = 5

		// make it use the MagicCombat object to deal damage
		hit(mob/m)
			MagicCombat.attack(owner, m, damage)

		movement()
			effect("flame", layer = layer - 1)
			..()
