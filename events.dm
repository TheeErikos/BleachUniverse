
// File:    events.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains all of the events that can be
//   triggered. Other files contain the procs that actually
//   do things (like inflict damage). If you want to add an
//   event that happens whenever you deal damage to an enemy,
//   you may not want to override the proc that actually
//   deals damage. Instead, you can override the event that's
//   defined here (the dealt_damage proc).
//
//   Many of the procs here have no default action or simply
//   print a message to the player. These procs exist solely
//   for you to override them to add custom events and
//   notifications to your game. Some of them aren't even
//   called anywhere in the framework (ex: no_line_of_sight)
//   because they're called from abilities and the framework
//   doesn't define any abilities. Still, these events exist
//   so you have a common place to define the behavior for
//   all no-LOS notifications to the player.

mob
	proc
		// this is called when a player tries to purchase an item
		// but doesn't have enough money.
		cannot_afford_item(item/item, cost)
			src << "You need $[cost] to buy [item]."

		// This is called after a player has purchased an item.
		// This proc doesn't give the item to the player or subtract
		// from their money - that's handled internally - this proc
		// is just a notification you can override to create a more
		// elaborate graphical or audio effect.
		purchased_item(item/item, cost)
			src << "You purchased [item] for $[cost]."

		// This is called when a player doesn't have enough room in
		// their inventory to hold an items. This can be called when
		// you try to buy or loot an item.
		cannot_hold_item(item/item)
			src << "You cannot get [item], your inventory is full."

		// This is called when you kill a mob and gain experience
		// and money.
		experience_and_money_gain(experience, money, mob/m)
			src << "You gain [experience] XP and $[money]."

		// This is called when you take damage from combat.
		took_damage(damage, mob/attacker, Combat/combat)

		// This is called when you deal damage in combat.
		dealt_damage(damage, mob/target, Combat/combat)

		// This is called when the mob dies. The parameter is the
		// mob that dealt the killing blow.
		died(mob/attacker)

			if(quests)
				for(var/Quest/q in quests)
					q.died(attacker)

			// if the mob is lootable and has loot, show the indicator
			if(lootable && contents.len)
				loot_indicator = overlay(Constants.EFFECTS_ICON, "loot-indicator")
				loot_indicator.PixelY(pixel_y - 1)

		// This is called when you killed a mob. The parameter is
		// the mob you killed.
		killed(mob/m)

			if(quests)
				for(var/Quest/q in quests)
					q.killed(m)

			if(client && m.lootable && src != m)
				experience_and_money_gain(m.experience, m.money, m)
				gain_experience(m.experience)
				gain_money(m.money)

		// This is called when a mob respawns.
		respawned()

		// This is called when an item is added to your inventory.
		got_item(item/item)
			if(quests)
				for(var/Quest/q in quests)
					q.got_item(item)

		// This is called when the player drops an item from their
		// inventory. It's not called when an item is consumed.
		dropped_item(item/item)

			if(quests)
				for(var/Quest/q in quests)
					q.dropped_item(item)

		no_target_selected(Ability/ability)
			src << "You can't use [ability.name] because you have no target."

		no_line_of_sight(mob/target)
			src << "You don't have line of sight to [target]."

		target_out_of_range(mob/target)
			src << "Your target is out of range."

		missing_item(item_type, quantity = null)
			var/item/item = new item_type()

			if(isnull(quantity))
				src << "You need [item]."
			else
				src << "You need [item] x[quantity]."

		not_near(object_type)
			var/atom/a = new object_type()
			src << "You need to be near [a.name]."
			del a

		created_item(item/item)
			src << "You created [item]."

		condition_applied(Condition/condition)

		condition_removed(Condition/condition)

		ignored_by_player(client/c)
			src << "[c.key] is ignoring you."

		received_quest(Quest/q)
		abandoned_quest(Quest/q)
		completed_quest(Quest/q)

		offline_notification()
			src << "The BYOND hub cannot be reached. Any medals and scores cannot be reported to the hub. They will be saved to your character so the hub can be updated later."

		health_changed()
			if(party)
				for(var/mob/m in party.mobs)
					m.ally_health_changed(src)

		mana_changed()
			if(party)
				for(var/mob/m in party.mobs)
					m.ally_mana_changed(src)

		ally_health_changed(mob/m)
			if(party_display)
				party_display.update(m)

		ally_mana_changed(mob/m)
			if(party_display)
				party_display.update(m)

		// events needed by the party system
		player_left_party(mob/m)
			src << "[m] left your party."
			if(party_display)
				party_display.refresh()

		player_joined_party(mob/m)
			src << "[m] joins your party."
			if(party_display)
				party_display.refresh()
				party_display.show()

		you_left_party()
			src << "You left the party."
			if(party_display)
				party_display.refresh()

		you_joined_party()
			src << "You joined the party."
			if(party_display)
				party_display.refresh()

		must_be_party_leader()
		promoted_to_party_leader()
		party_is_full()

atom
	movable
		proc
			// This is called when an item was removed from a mob's inventory.
			lost_item(item/item)

mob
	lost_item(item/item)
		..()

		if(loot_indicator && !contents.len)
			loot_indicator.Hide()
			del loot_indicator
