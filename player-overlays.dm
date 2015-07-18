
// File:    player-overlays.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the equipment() proc which is
//   used to create overlays to represent the player's
//   equipment.

Overlay
	var
		base_state = ""
		move_state = ""

mob
	var
		tmp/move_state = ""
		tmp/list/equipment_overlays
		tmp/__state = ""
		tmp/__state_duration = 0

	proc
		state(i, d = 8)
			__state = i
			__state_duration = world.time + world.tick_lag * d

	proc
		remove(item/item)
			if(!equipment_overlays)
				equipment_overlays = list()

			var/Overlay/overlay = equipment_overlays[item.slot]

			if(overlay)
				overlay.Hide()

	overlay(item/item)

		if(!istype(item))
			return ..()

		if(!equipment_overlays)
			equipment_overlays = list()

		var/Overlay/overlay

		if(equipment_overlays[item.slot])
			overlay = equipment_overlays[item.slot]
		else
			overlay = ..(item.overlay_icon, "")
			equipment_overlays[item.slot] = overlay

		overlay.base_state = item.overlay_state
		overlay.Layer(layer + item.overlay_layer)
		overlay.Show()

		return overlay

	set_state()

		if(dead)
			move_state = "dead"
		else if(world.time <= __state_duration)
			move_state = __state
		else if(!moved)
			move_state = STANDING
		else
			move_state = MOVING

		for(var/slot in equipment_overlays)
			var/Overlay/o = equipment_overlays[slot]
			if(!o) continue

			if(o.move_state != move_state)
				o.IconState("[o.base_state]-[move_state]")
				o.move_state = move_state

		icon_state = "[base_state]-[move_state]"
