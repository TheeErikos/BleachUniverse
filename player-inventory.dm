
// File:    player-inventory.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the procs to manage a player's
//   inventory (pick up items, drop them, check to see
//   if they have an item, etc.)

mob
	var
		inventory_size = Constants.INVENTORY_SIZE

	proc
		// determines whether the mob has the specified quantity of an item type
		has_item(item_type, quantity = 1)
			if(get_quantity(item_type) >= quantity)
				return 1
			else
				return 0

		// returns how many of an item type the mob has
		get_quantity(item_type)
			. = 0

			for(var/item/item in contents)
				if(item.type == item_type)
					if(item.stack_size)
						. += item.count
					else
						. += 1

		// returns a list of the instances of the specified quantity of items
		remove_item(item_type, quantity = 1)

			var/item/item = item_type

			// if the first argument was an item, try to
			// remove it from your inventory
			if(istype(item))

				if(item.in_slot)
					if(!unequip(item))
						return null

				item.loc = null

				if(inventory)
					inventory.refresh()

				dropped_item(item)

				return item

			if(!has_item(item_type, quantity))
				return null

			var/list/items = list()

			for(item in contents)
				if(quantity <= 0)
					break

				if(item.type != item_type)
					continue

				// if the item is stackable
				if(item.stack_size)

					// if we remove the whole stack
					if(quantity >= item.count)
						quantity -= item.count
						items += item
						item.loc = null

					// if we only need part of the stack
					else
						// reduce the size of the stack in your inventory
						item.count -= quantity

						// create the partial stack that's being removed
						var/item/stack = new item.type()
						stack.loc = null
						stack.count = quantity

						quantity = 0
						items += stack

				// non-stackable items count as one each
				else
					if(quantity > 0)
						items += item
						item.loc = null
						quantity -= 1

			if(inventory)
				inventory.refresh()

			return items

		// deletes the specified number of the specified item, but only
		// if the mob had that quantity to begin with.
		consume_item(item_type, quantity = 1)

			var/list/items = remove_item(item_type, quantity)

			// this will happen if you didn't have a sufficient quantity
			if(!items)
				return 0

			// delete each item
			for(var/item/item in items)
				del item

			// return an indication of success
			return 1

		// tries to add an item to the mob's inventory
		get_item(item/item)

			var/mob/old_loc = item.loc

			// determine if you can hold the item
			var/will_fit = 0

			// if it's a stackable item...
			if(item.stack_size)

				// if you have an open slot, of course it'll fit
				if(contents.len < inventory_size)
					will_fit = 1

				// otherwise we need to see if it can be added to existing stacks
				else
					var/spare_capacity = 0
					for(var/item/i in contents)
						if(item.type == i.type)
							spare_capacity = i.stack_size - i.count

					if(spare_capacity >= item.count)
						will_fit = 1

			// if it's not a stackable item you need to have an open slot.
			else
				if(contents.len < inventory_size)
					will_fit = 1

			if(!will_fit)
				return null

			// if the item is in someone's inventory, remove it.
			if(istype(old_loc))
				if(!old_loc.remove_item(item))
					return null

				if(old_loc.inventory)
					old_loc.inventory.refresh()

			// if we're adding a stackable item...
			if(item.stack_size)

				// ... we add whatever we can to existing stacks
				for(var/item/i in contents)

					// if the stack we're adding is empty, we're done
					if(item.count <= 0)
						item.loc = null
						break

					if(i.type != item.type)
						continue

					// figure out how many more the current item can hold
					var/can_hold = i.stack_size - i.count

					// we don't care if it can hold more than we're adding
					if(can_hold > item.count)
						can_hold = item.count

					// shift some items to the stack in your inventory
					if(can_hold)
						item.count -= can_hold
						i.count += can_hold

				// if there were some left over, add this item as a new stack
				if(item && item.count)
					item.loc = src

			// if it's not a stackable item we simply add it to your contents
			else
				item.loc = src

			item.icon = initial(item.icon)
			item.icon_state = initial(item.icon_state)

			if(inventory)
				inventory.refresh()

			got_item(item)

			if(istype(old_loc, /atom/movable))
				old_loc.lost_item(item)

			return item

		// remove an item from the mob's inventory
		drop_item(item/item)

			// if the item is equipped, you can only drop it if
			// you can unequip it.
			if(item.in_slot)
				if(!unequip(item))
					return null

			item.drop(src)

			if(inventory)
				inventory.refresh()

			dropped_item(item)

			return item
