
// File:    hud-conditions.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the ConditionBar object which
//   creates the on-screen display of what conditions
//   are currently affecting the player.

ConditionsBar
	parent_type = /HudGroup

	icon = Constants.EFFECTS_ICON

	var
		mob/owner

	New(mob/m)
		..(m)

		owner = m
		pos(0, Constants.VIEW_HEIGHT * Constants.ICON_HEIGHT - 62)

		refresh()

	proc
		refresh()

			// we keep track of how many conditions are displayed
			// so we know if there are any extra icons that can
			// be removed.
			var/displayed_conditions = 0

			if(owner && owner.conditions)
				for(var/i = 1 to owner.conditions.len)
					var/Condition/c = owner.conditions[i]

					if(!c.displayed)
						continue

					displayed_conditions += 1

					var/HudObject/h

					// use an existing object if we have one
					if(i <= objects.len)
						h = objects[i]
						h.icon_state = c.icon_state

					// otherwise we need to create a new screen object
					else
						h = add(i * 16 - 16, 0, icon_state = c.icon_state)

			// remove any extra objects
			while(objects.len > displayed_conditions)
				remove(objects[displayed_conditions + 1])

mob
	var
		tmp/ConditionsBar/conditions_bar

	init_hud()
		..()

		if(client && Constants.USE_CONDITIONS_BAR)
			conditions_bar = new(src)

	clear_hud()
		..()

		if(Constants.USE_CONDITIONS_BAR)
			if(conditions_bar)
				conditions_bar.hide()
				del conditions_bar

	// we use the condition_applied/removed events to
	// trigger updates.
	condition_applied(Condition/condition)
		..()

		if(conditions_bar)
			conditions_bar.refresh()

	condition_removed(Condition/condition)
		..()

		if(conditions_bar)
			conditions_bar.refresh()
