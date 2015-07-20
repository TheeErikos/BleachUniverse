obj/Timer
	icon='hud_timer.dmi'
	icon_state="background"
	screen_loc="2,13"
	layer=MOB_LAYER+2
	New(client/c)
		var/icon/min=new('hud_timer.dmi',"[minutes]")
		var/icon/sec1= seconds < 10 ? new('hud_timer.dmi',"0") : new('hud_timer.dmi',"[copytext(num2text(seconds),1,2)]")
		var/icon/sec2= seconds < 10 ? new('hud_timer.dmi',"[seconds]") : new('hud_timer.dmi',"[copytext(num2text(seconds),2)]")
		sec1.Shift(EAST,13)
		sec2.Shift(EAST,22)
		src.overlays+=min
		src.overlays+=sec1
		src.overlays+=sec2
		c.screen+=src

mob/proc/tick_timer()
	for(var/obj/Timer/t in src.client.screen)
		var/icon/min=new('hud_timer.dmi',"[minutes]")
		var/icon/sec1= seconds < 10 ? new('hud_timer.dmi',"0") : new('hud_timer.dmi',"[copytext(num2text(seconds),1,2)]")
		var/icon/sec2= seconds < 10 ? new('hud_timer.dmi',"[seconds]") : new('hud_timer.dmi',"[copytext(num2text(seconds),2)]")
		sec1.Shift(EAST,13)
		sec2.Shift(EAST,22)
		t.overlays=null
		t.overlays+=min
		t.overlays+=sec1
		t.overlays+=sec2

proc/timer()
	seconds--
	if(seconds <= 0)
		minutes--
		if(minutes >= -1)
			seconds=59
	for(var/mob/m in world)
		if(m.client)
			if(m in players)
				m.tick_timer()
	if(minutes >= -1)
		if(seconds)
			spawn(10) timer()
	else
		endGame()