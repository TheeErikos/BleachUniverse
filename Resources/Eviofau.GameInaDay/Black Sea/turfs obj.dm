turf
	space
		icon='turfs.dmi'
		icon_state="1"
		New()
			src.icon_state=pick("1","2","3","4","5")
			src.dir=pick(NORTH,SOUTH,EAST,WEST)

	title/icon='title.PNG'
	dense/density=1

	space_dense
		name="space"
		icon='turfs.dmi'
		icon_state="0"
		density=1

obj
	projectiles
		icon='projectiles.dmi'
		laser/icon_state="laser"
		rocket/icon_state="rocket"

obj/BlackSea
	icon='general_hud.dmi'
	layer=MOB_LAYER+1
	New(client/c)
		c.screen+=src

obj
	planet
		var/wealth
		icon='planets.dmi'
		icon_state="1"
		density=1
		New()
			src.icon_state=pick("1","2")
			src.icon+=rgb(rand(1,50),rand(1,50),rand(1,50))
			src.wealth=rand(100,200)
			src.relocate()
		proc/relocate()
			var/tooClose=0
			src.loc=locate(rand(9,58),rand(9,58),1)
			for(var/obj/planet/v in oview(6,src)) if(v) tooClose++
			if(tooClose) src.relocate()
			else return
		proc/rewealth()
			sleep(300)
			src.wealth=rand(100,200)

	circle
		var/Dir
		icon='mob_hud.dmi'
		New(mob/m)
			if(src.Dir==NORTH)
				src.pixel_x=0;src.pixel_y=32;
			if(src.Dir==NORTHWEST)
				src.pixel_x=-32;src.pixel_y=32;
			if(src.Dir==WEST)
				src.pixel_x=-32;src.pixel_y=0;
			if(src.Dir==SOUTHWEST)
				src.pixel_x=-32;src.pixel_y=-32;
			if(src.Dir==SOUTH)
				src.pixel_x=0;src.pixel_y=-32;
			if(src.Dir==SOUTHEAST)
				src.pixel_x=32;src.pixel_y=-32;
			if(src.Dir==EAST)
				src.pixel_x=32;src.pixel_y=0;
			if(src.Dir==NORTHEAST)
				src.pixel_x=32;src.pixel_y=32;
			src.icon+=rgb(m.R,m.G,m.B)
			m.overlays+=src
		c1
			icon_state="1"
			Dir=NORTHWEST
		c2
			icon_state="2"
			Dir=NORTH
		c3
			icon_state="3"
			Dir=NORTHEAST
		c4
			icon_state="4"
			Dir=WEST
		c5
			icon_state="5"
			Dir=EAST
		c6
			icon_state="6"
			Dir=SOUTHWEST
		c7
			icon_state="7"
			Dir=SOUTH
		c8
			icon_state="8"
			Dir=SOUTHEAST

obj/health
	name="Ship Health"
	layer=MOB_LAYER+2
	New(client/c)
		c.screen+=src
	bar1
		screen_loc="15,1"
		icon='health_hud_1.dmi'
		icon_state="100"
	bar2
		screen_loc="14,1"
		icon='health_hud_2.dmi'
		icon_state="100"
	bar3
		screen_loc="13,1"
		icon='health_hud_3.dmi'
		icon_state="100"

obj/weapon_changer
	name="Weapon"
	layer=MOB_LAYER+2
	New(client/c)
		c.screen+=src
	laser
		screen_loc="3,1"
		icon='projectiles.dmi'
		icon_state="c_las"
		Click()
			usr<<{"<tt><span style="color:rgb(100,200,0);">Weapon set to laser.</span></tt>"}
			usr.weapon="laser"
	rocket
		screen_loc="4,1"
		icon='projectiles.dmi'
		icon_state="c_roc"
		Click()
			usr<<{"<tt><span style="color:rgb(100,200,0);">Weapon set to rocket.</span></tt>"}
			usr.weapon="rocket"