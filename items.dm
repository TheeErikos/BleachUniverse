
// File:    items.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the /item object type and all
//   of the procs that belong to it (equip, unequip,
//   etc.)

item
	parent_type = /obj

	pwidth = 16
	pheight = 16
	pixel_x = -8
	pixel_y = -8

	var
		slot = ""
		in_slot = ""
		stack_size = 0
		count = 1
		description = ""
		cost = 0

		overlay_icon = null
		overlay_state = ""
		overlay_layer = 1

		map_icon = null
		map_state = ""

		const
			INTERACT = 1
			WALK_OVER = 2

		// How you pick up the item when it's placed on the
		// map. Can either be INTERACT (pressing the space
		// bar when you're over it) or WALK_OVER (by walking
		// over top of it).
		pickup = INTERACT

	// we can pass the constructor an atom, and atom
	// and a quantity, or just a quantity.
	New(atom/a, quantity = null)

		if(isnum(a))
			quantity = a
			a = null

		..(a)

		if(!isnull(quantity))
			count = quantity

	proc
		// this is called when an item is equipped
		equipped(mob/m)

		// this is called when an item is unequipped
		unequipped(mob/m)

		can_equip(mob/m)
			return 1

		can_unequip(mob/m)
			return 1

		description()
			if(stack_size)
				return "<b>[name] x[count]</b>\n[description]"
			else
				return "<b>[name]</b>\n[description]"

		use(mob/m)

		consume(quantity = 1)
			var/mob/m = loc

			if(stack_size)
				count -= quantity
				if(count <= 0)
					loc = null
			else
				loc = null

			if(istype(m))
				if(m.inventory)
					m.inventory.refresh()

		drop(atom/a)
			var/turf/t = a
			var/mob/m = a

			if(istype(m))
				loc = m.loc
				Move(m.loc)
				step_x = m.step_x
				step_y = m.step_y
			else if(istype(t))
				loc = t
				Move(t)
				step_x = 8
				step_y = 8

			icon = map_icon
			icon_state = map_state

mob
	var
		list/equipment

	proc
		equip(item/item, slot = null)

			if(dead) return 0

			if(!equipment)
				equipment = list()

			if(!item) return

			if(isnull(slot))
				slot = item.slot

			if(!slot)
				return

			// if you already have something equipped there, try to remove it
			if(equipment[slot])
				if(!unequip(equipment[slot]))
					return 0

			// if the item allows itself to be equipped, equip it
			if(item.can_equip(src))
				item.in_slot = slot
				equipment[slot] = item

				if(inventory)
					inventory.refresh()

				item.equipped(src)

				return 1
			else
				return 0

		unequip(item/item)

			if(dead) return 0

			if(!equipment)
				equipment = list()

			if(!item) return

			// if the item allows itself to be unequipped, unequip it.
			if(item.can_unequip(src))
				equipment[item.in_slot] = null
				item.in_slot = ""

				if(inventory)
					inventory.refresh()

				item.unequipped(src)

				return 1
			else
				return 0

		use(item/item)
			if(dead) return 0

			item.use(src)
			return 1
