
/* 26px

mob/verb/testit()
	src.update_radar()

mob/proc/update_radar()
	for(var/mob/m in oview(src,13))
		var/obj/blip/b=new(src.client)
		var/icon/i=new('blips.dmi',"blank")
		i.DrawBox(rgb(255,0,0),m.x-src.x,m.y-src.y,m.x-src.x+1,m.y-src.y+1)
		b.icon
		//b.pixel_x+=m.x-src.x
		//b.pixel_y+=m.y-src.y


obj/blip/
	icon='blips.dmi'
	icon_state="enemy"
	screen_loc="1,1"
	pixel_x=2
	pixel_y=2
	layer=999

mob/proc/Update_Radar()
	var/obj/blip/r=new()
	for(var/mob/M in world)  // Search through all of the mobs...
		if(get_dist(src,M) < 20 && src.z == M.z && src != M)  // If the mob is within 10 squares of the player, is on the same z level, and isn't itself (don't want to place yourself on it, do you?)
			var/x=16-(src.x - M.x)+1
			var/y=16-(src.y - M.y)+1
			r.pixel_x=x-1
			r.pixel_y=y-1
			src.client.screen+=r
	spawn(5)
		src.Update_Radar()*/