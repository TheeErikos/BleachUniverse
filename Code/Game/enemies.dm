
// File:    demo\enemies.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines an enemy. The enemy has a simple
//   AI routine and its own attack ability.

// The abilities in abilities.dm are explained better than this one.
Ability
	EnemyAttack
		icon_state = "melee-attack"
		animation = "attacking"

		can_use(mob/user)
			if(user.on_cooldown("enemy-attack"))
				return 0

			if(!user.melee_target())
				return 0

			return ..()

		effect(mob/user)

			user.cooldown("enemy-attack", 40)

			var/mob/target = user.melee_target()

			if(target)
				PhysicalCombat.attack(user, target, user.effectiveattack)
				new /Condition/Slowed(target, user)

				target.effect("punch")
				target.noise('hit-2.wav', frequency = rand(0.7, 1.3))

	EnemyPoisonAttack
		icon_state = "melee-attack"
		animation = "attacking"

		can_use(mob/user)
			if(user.on_cooldown("enemy-poison-attack"))
				return 0

			if(!user.melee_target())
				return 0

			return ..()

		effect(mob/user)

			user.cooldown("enemy-poison-attack", 160)

			var/mob/target = user.melee_target()

			if(target)
				new /Condition/Poisoned(target, user)
				target.effect("punch")
				target.noise('hit-2.wav', frequency = rand(0.7, 1.3))

mob
	enemy
		// when an enemy takes damage, make them target their attacker.
		took_damage(damage, mob/attacker, Combat/combat)
			..()

			if(!target)
				target = attacker

		// now we'll define a specific enemy
		blue_ooze
			base_state = "blue-ooze"
			icon_state = "blue-ooze-standing"

			effectiveattack = 4
			effectivespeed = 5
			effectivedefense = 5

			health = 40
			max_health = 40

			base_effectivespeed = 1

			abilities = list(new /Ability/EnemyAttack())

			New()
				..()
				souls = rand(1, 10)
				experience = 6

			// we override the died proc to give enemies a chance to drop items
			died()
				noise('splat.wav')

				if(prob(50))
					new /item/health_potion(src)

				if(prob(25))
					new /item/sword(src)

				..()

		// green oozes are just like blue ones except they have a poison attack too.
		green_ooze
			base_state = "green-ooze"
			icon_state = "green-ooze-standing"
			effectiveattack = 4
			effectivespeed = 5
			effectivedefense = 5

			health = 40
			max_health = 40

			base_effectivespeed = 1

			abilities = list(new /Ability/EnemyAttack(), new /Ability/EnemyPoisonAttack())

			New()
				..()
				souls = rand(3, 12)
				experience = 10

			// we override the died proc to give enemies a chance to drop items
			died()
				noise('splat.wav', frequency = 0.6)

				if(prob(100))
					new /item/health_potion(src)

				if(prob(25))
					new /item/sword(src)

				..()

		invertedHuman
			base_state = "inverthuman"
			icon_state = "inverthuman-standing"

			effectiveattack = 10
			effectivespeed = 3
			effectivedefense = 10

			health = 25
			max_health = 25

			base_effectivespeed = 1

			abilities = list(new /Ability/EnemyAttack())

			New()
				..()
				souls = rand(3, 12)
				experience = rand(1000, 5000)

			// we override the died proc to give enemies a chance to drop items
			died()
				noise('splat.wav', frequency = 0.6)
				spawn(100) respawn()
				..()
