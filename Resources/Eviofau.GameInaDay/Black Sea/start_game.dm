mob/player/verb

	Leave_game()
		src.client.screen=list()
		src.client.images=list()
		world<<{"<tt><b><span style="color:rgb([src.R],[src.G],[src.B]);">[src] has stopped playing!</span></tt>"}
		src.leave_game()

	Start_game()
		if(game_started || !players.Find(usr)) return
		if(players.len > 0)
			world<<{"<tt><span style="color:rgb(100,200,0);">The game has been started by [src]!</span></tt>"}
			game_started=1
			for(var/mob/m in world)
				if(m.client)
					if(m in players)
						m.can_move=1
						m.update_user_images()
			timer()
		else world<<{"<tt><span style="color:rgb(200,100,0);">You need two or more players to start a game!</span></tt>"}