mob

	Login()
		if(fexists("savefiles/players/[src.ckey].sav"))
			var/savefile/s=new("savefiles/players/[src.ckey].sav")
			src.Read(s)
		src.loc=locate(32,33,2)
		src<<browse(help,"window=help")
		world<<"<b><tt>[src] has entered!"

	Logout()
		src.client.screen=list()
		src.client.images=list()
		src.leave_game()
		if(src in players)
			world<<{"<tt><b><span style="color:rgb(200,0,0);">[src] has left!</span></tt>"}
			world<<{"<tt><b><span style="color:rgb(200,0,0);">[src] has been removed from the player list.</span></tt>"}
			var/savefile/s=new("savefiles/players/[src.ckey].sav")
			src.Write(s)
			if(players.len==1)
				var/mob/m=players[1]
				world<<{"<tt><b><span style="color:rgb([m.R],[m.G],[m.B]);">[m] has won the game by default with [m.plunder] plunder! (all other players logged out)</span></tt>"}
				endGame()
			if(players.len==0)
				world<<{"<tt><b><span style="color:rgb(200,0,0);">The last player has logged out, leaving the game playerless! Server restarting!  If you are for some reason disconnected, rejoin here; byond://[world.address]:[world.port]</span></tt>"}
				world.Reboot()
			del(src)
		else
			var/savefile/s=new("savefiles/players/[src.ckey].sav")
			src.Write(s)
			world<<"<b><tt>[src] has left!"
			del(src)