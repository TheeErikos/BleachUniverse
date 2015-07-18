
// File:    player-abilities.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the Ability object, which has
//   vars and procs you can use to create custom attacks
//   and other special abilities.

Ability
	var
		tmp/name = ""
		tmp/icon = Constants.HUD_ICON
		tmp/icon_state = ""

		// this is just used for display purposes since
		// an ability may trigger any number of cooldowns
		tmp/cooldown = 0

		// this is used for display and is enforced by the
		// default can_use proc.
		tmp/mana_cost = 0

		// this is the animation flicked by the player when
		// the ability is used.
		tmp/animation = ""

		tmp/description = ""

	proc
		description()
			if(description)
				return "<b>[name]</b>\n[description]\n[cooldown] tick cooldown"
			else
				return "<b>[name]</b>\n[cooldown] tick cooldown"

		can_use(mob/user, mob/target)
			if(user.mana < mana_cost)
				return 0

			return 1

		use(mob/user, mob/target)
			if(!can_use(user, target))
				return 0

			if(animation)
				user.state(animation, 10)

			user.lose_mana(mana_cost)

			effect(user, target)

		effect(mob/user, mob/target)

mob
	var
		list/key_bindings
		tmp/list/cooldowns
		list/abilities = list()

	key_down(k)
		..()

		if(!key_bindings)
			key_bindings = list()

		if(k in key_bindings)
			var/Ability/ability = key_bindings[k]

			if(ability && istype(ability))
				use_ability(ability)

	proc
		// binds an ability to a key
		bind_key(k, Ability/ability)

			if(!key_bindings)
				key_bindings = list()

			key_bindings[k] = ability

			if(ability_bar)
				ability_bar.refresh()

		// checks all general restrictions for ability usage
		// before invoking the ability
		use_ability(Ability/ability)

			if(dead)
				return 0

			ability.use(src)

		// triggers a cooldown or refreshes one that's still active
		cooldown(cooldown_name, cooldown_duration)

			if(!cooldowns)
				cooldowns = list()

			if(cooldowns[cooldown_name])
				cooldowns[cooldown_name] = max(cooldowns[cooldown_name], world.time + cooldown_duration * world.tick_lag)
			else
				cooldowns[cooldown_name] = world.time + cooldown_duration * world.tick_lag

		// each parameter is the name of a cooldown to check, this
		// proc returns 1 if any of the names are still on cooldown
		on_cooldown()

			if(!cooldowns)
				cooldowns = list()

			for(var/a in args)
				if(cooldowns[a] && cooldowns[a] > world.time)
					return 1

			return 0

		// each parameter is the name of a cooldown to clear.
		clear_cooldown()

			if(!cooldowns)
				cooldowns = list()

			for(var/a in args)
				cooldowns[a] = 0
