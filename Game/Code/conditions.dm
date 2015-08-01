
// File:    conditions.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the Condition object which can be
//   used to create temporary, timed, or periodic effects
//   that are attached to a mob.

var
	ConditionLoop/ConditionLoop = new()

ConditionLoop
	var
		list/conditions = list()

	New()
		loop()

	proc
		loop()
			spawn()
				while(1)
					sleep(world.tick_lag)

					for(var/Condition/c in conditions)

						// if it has a set duration, check for when it expires.
						if(c.duration)
							if(c.__delay > 0)
								c.__delay -= 1
							else
								del c

						// if it ticks, check for the next tick and update the
						// delay accordingly (or delete it when the last tick fires).
						else if(c.tick_rate)
							if(c.__delay > 0)
								c.__delay -= 1
							else
								c.tick()

								// we need to check if c exists because calling tick()
								// might do something that causes the condition to be
								// deleted.
								if(c)
									c.__delay = c.tick_rate
									c.__ticks_left -= 1
									if(c.__ticks_left <= 0)
										del c

mob
	var
		list/conditions

	proc
		has_condition(condition_type)
			for(var/Condition/c in conditions)
				if(c.type == condition_type)
					return 1
			return 0

		add_condition(condition_type)
			new condition_type(src)

		remove_condition(condition_type)
			for(var/Condition/c in conditions)
				if(c.type == condition_type)
					del c

Condition
	var
		tmp/name

		tmp/active = 0

		// these are used for display purposes
		tmp/icon
		tmp/icon_state

		// each condition stores a reference to the mob
		// it affects and the mob that created it.
		mob/target
		tmp/mob/owner

		// this sets the condition's total duration
		tmp/duration = 0

		// these vars can be used too
		tmp/tick_count = 0
		tmp/tick_rate = 0

		// limits how many instances of the same type of condition
		// can be stacked on a single target. A value of zero means
		// that the effect can stack infinitely.
		tmp/stack_size = 1

		// determines if the condition is removed from the player
		// when they die.
		tmp/remove_on_death = 1

		// determines if the condition is displayed on the player's
		// on-screen display.
		tmp/displayed = 1

		__delay = 0
		__ticks_left = 0

	New(mob/target, mob/owner)
		..()

		if(!target)
			target = src.target

		if(!owner)
			owner = src.owner

		// check if the condition can stack again (if applicable)
		if(stack_size)
			if(target.conditions)
				var/count = 0
				for(var/Condition/c in target.conditions)
					if(istype(c, type))
						count += 1

						// if we're at the limit already, delete this condition
						if(count >= stack_size)
							del src

		src.target = target
		src.owner = owner

		if(!__delay)
			if(duration)
				__delay = duration
			else if(tick_count)
				__delay = tick_rate
				__ticks_left = tick_count

		activate()

		// update the target's list of conditions
		if(target)

			if(!target.conditions)
				target.conditions = list(src)
			else
				target.conditions += src

			target.condition_applied(src)

	Del()
		if(target)
			remove()

		ConditionLoop.conditions -= src

		// update the target's list of conditions
		if(target)
			if(!target.conditions)
				target.conditions = list()
			else
				target.conditions -= src

			target.condition_removed(src)

		..()

	proc
		apply()
		remove()
		tick()

		activate()
			if(active) return
			if(!target || !target.active) return

			apply()
			active = 1
			ConditionLoop.conditions += src

		deactivate()
			if(!active) return

			remove()
			active = 0
			ConditionLoop.conditions -= src
mob
	died()

		// when a player dies, check for conditions that
		// we need to remove.
		if(conditions)
			for(var/Condition/c in conditions)
				if(c.remove_on_death)
					del c

		..()
