mob/proc/leave_game()
	src.overlays=list()
	players-=src
	src.COLOR=null
	src.R=255;src.G=255;src.B=255
	src.icon=null
	src.can_move=0
	src.loc=locate(32,33,2)
	players_rgbs+=src.COLOR
	players_rgbs+=players_rgbs_backup[src.COLOR]
	src.verbs-=/mob/player/verb/Start_game
	src.verbs-=/mob/player/verb/Leave_game

mob/proc/update_user_images()
	if(!game_started) return
	if(src in players)
		var/obj/planet/userPlanet
		for(userPlanet in oview(100)) if(userPlanet.wealth) break
		var/image/i=new('mob_hud.dmi',src,"close_planet",MOB_LAYER+1,get_dir(src,userPlanet))
		i.icon+=rgb(src.R,src.G,src.B)
		i.pixel_x=returnPixex(get_dir(src,userPlanet))
		i.pixel_y=returnPixey(get_dir(src,userPlanet))
		src.client.images=null
		src.client.images+=i
		spawn(2) src.update_user_images()

mob/proc/check_death(mob/m)
	if(src.health<=0)
		if(m)
			world<<{"<tt><b><span style="color:rgb([m.R],[m.G],[m.B]);">[m] has killed [src]!</span></tt>"}
			var/half_plunder=round(src.plunder/2)
			src<<{"<tt><b>You lost half of your plunder!</span></tt>"}
			m<<{"<tt><b>You have gained [half_plunder] plunder!</span></tt>"}
			src.plunder-=half_plunder
			m.plunder+=half_plunder
		else
			world<<{"<tt><b><span style="color:rgb([src.R],[src.G],[src.B]);">[src] has died!</span></tt>"}
			var/half_plunder=round(src.plunder/2)
			src<<{"<tt><b>You lost half of your plunder!</span></tt>"}
			src.plunder-=half_plunder
		src.loc=locate(rand(9,58),rand(9,58),1)
		src.r_ammo=6
		src.l_ammo=30
		src.health=100
		src.update_health()

mob/proc/generate_hud()
	new/obj/Timer(src.client)
	new/obj/health/bar1(src.client)
	new/obj/health/bar2(src.client)
	new/obj/health/bar3(src.client)
	new/obj/weapon_changer/laser(src.client)
	new/obj/weapon_changer/rocket(src.client)
	new/obj/circle/c1(src)
	new/obj/circle/c2(src)
	new/obj/circle/c3(src)
	new/obj/circle/c4(src)
	new/obj/circle/c5(src)
	new/obj/circle/c6(src)
	new/obj/circle/c7(src)
	new/obj/circle/c8(src)
	var/list/hud_pieces=icon_states('general_hud.dmi')
	for(var/i=1,i<=hud_pieces,i++)
		if(i > hud_pieces.len) return
		var/state=hud_pieces[i]
		var/obj/BlackSea/b=new(src.client)
		b.screen_loc="[state]"
		b.icon_state="[state]"

mob/proc/recharge_laser()
	if(src in players)
		if(src.l_ammo < 30) src.l_ammo++
		spawn(10) src.recharge_laser()

mob/proc/update_health()
	if(src in players)
		for(var/obj/health/o in src.client.screen) o.icon_state="[round(src.health/100*100,10)]"