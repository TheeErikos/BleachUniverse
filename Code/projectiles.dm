
// File:    projectiles.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the /projectile type which is a
//   mob that contains vars that you can use to create
//   custom projectile types.

projectile
	parent_type = /mob

	icon = Constants.EFFECTS_ICON
	density = 0
	move_speed = 6

	var
		tmp/hits = 1
		tmp/die_on_hit = 1
		tmp/animation = ""
		tmp/shoot_sound
		tmp/hit_sound
		tmp/damage = 0
		tmp/lifetime = 0

		tmp/list/already_hit = list()
		tmp/mob/owner

	New(mob/m, d)

		activate()

		loc = m.loc
		set_pos(m.px + (m.pwidth - pwidth) / 2, m.py + (m.pheight - pheight) / 2)

		if(isnull(d))
			dir = m.dir
		else
			dir = d

		if(isnull(d))
			dir = m.dir
		else
			if(isnum(d))
				dir = d
			else if(istype(d, /atom))
				target = d
				dir = m.dir

		owner = m

		if(target)
			vel_x = (target.px + target.pwidth / 2) - (px + pwidth / 2)
			vel_y = (target.py + target.pheight / 2) - (py + pheight / 2)

		// set the velocity based on the dir
		else
			if(dir & NORTH)
				vel_y = move_speed
			else if(dir & SOUTH)
				vel_y = -move_speed

			if(dir & EAST)
				vel_x = move_speed
			else if(dir & WEST)
				vel_x = -move_speed

		// limit the velocity's magnitude to move_speed
		var/len = sqrt(vel_x * vel_x + vel_y * vel_y)
		vel_x = (vel_x / len) * move_speed
		vel_y = (vel_y / len) * move_speed

		if(animation)
			flick(animation, src)

		if(shoot_sound)
			sound_effect(shoot_sound)

		if(lifetime)
			spawn(lifetime * world.tick_lag)
				del src

	// the projectile's icon_state cannot change
	set_state()

	// and they can't become deactivated if no
	// players are nearby.
	deactivate()

	movement()

		// if the projectile is dead, do nothing
		if(dead) return

		if(hits > 0)
			for(var/mob/m in inside())

				// if the projectile is out of hits, stop
				if(hits <= 0) break

				// if the projectile can't hit m, skip it
				if(!can_hit(m)) continue

				// if the projectile already hit m, skip it
				if(m in already_hit) continue

				already_hit += m
				hits -= 1

				if(hit_sound)
					sound_effect(hit_sound, src)

				hit(m)

				if(die_on_hit)
					spawn(world.tick_lag)
						del src

		pixel_move(vel_x, vel_y)

	// projectiles don't bump mobs, only other
	// obstacles that'd cause them to be deleted.
	bump()
		del src

	can_bump(mob/m)
		if(istype(m))
			return 0
		else
			return ..()

	proc
		// this is used in addition to the "damaging" var to determine
		// what objects the projectile can hit. by default, we skip
		// dead mobs and the shooter.
		can_hit(mob/m)
			if(m == owner) return 0
			if(m.dead) return 0
			if(istype(m, /projectile)) return 0
			if(owner && !owner.can_attack(m)) return 0
			return 1

		// this is called when the projectile hits a mob, it's what
		// inflicts damage.
		hit(mob/m)

missile
	parent_type = /projectile

	var
		// determines if the missile's icon is turned to
		// face the target or not.
		tmp/angle = 1

	New(mob/m, atom/a)
		owner = m
		target = a

		activate()
		loc = m.loc
		set_pos(m.px + (m.pwidth - pwidth) / 2, m.py + (m.pheight - pheight) / 2)

		dir = get_dir(m, a)

		/*
		// figure out the angle to the target and rotate the icon
		if(angle)
			var/icon/I = icon(icon, icon_state)

			var/dx = (target.px + target.pwidth / 2) - (px + pwidth / 2)
			var/dy = (target.py + target.pheight / 2) - (py + pheight / 2)

			I.Turn(__atan2(dx, dy))
			icon = I
		*/

	movement()
		var/dx = (target.px + target.pwidth / 2) - (px + pwidth / 2)
		var/dy = (target.py + target.pheight / 2) - (py + pheight / 2)
		var/len = sqrt(dx * dx + dy * dy)

		if(len > move_speed)
			dx = (dx / len) * move_speed
			dy = (dy / len) * move_speed
			set_pos(px + dx, py + dy)
		else
			set_pos(px + dx, py + dy)
			hit(target)
			del src

	can_bump()
		return 0

proc
	__atan2(dx, dy)
		if(!dy)
			return (dx >= 0) ? 90 : 270

		if(dy < 0)
			return __atan(dx / dy) + 180
		if(dx < 0)
			return __atan(dx / dy) + 360

		return __atan(dx / dy)

	__atan(m)
		return arcsin(m / sqrt(1 + m * m))
