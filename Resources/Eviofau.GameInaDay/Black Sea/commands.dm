mob/verb

	say(t as text)
		if(t) world<<{"<tt><span style="color:rgb([src.R],[src.G],[src.B]);"><b>[src]:</b> [html_encode(t)]</span></tt>"}

	Favorite_color()
		var/color=input("You can choose a favorite color here. If you join a game, and someone doesn't allready have your favorite color, it will automatically set your color to it.")as null|anything in players_rgbs_backup
		if(color)
			src.favoriteColor=color
			src<<{"<tt><b><span style="color:rgb(255,255,255);">-- Favorite color set to [color]!</span></tt>"}

	Join_game()
		if(src in players) return
		if(players.len < 8 || game_started)
			players+=src
			var/colorName
			if(src.favoriteColor != null && src.favoriteColor in players_rgbs) colorName=src.favoriteColor
			else colorName=pick(players_rgbs)
			var/list/newColor=players_rgbs[colorName]
			src.COLOR=colorName
			players_rgbs-=colorName
			src.R=newColor[1]
			src.G=newColor[2]
			src.B=newColor[3]
			src.icon='icons.dmi'
			src.generate_hud()
			src.recharge_laser()
			src.update_health()
			src.update_user_images()
			src.loc=locate(rand(9,58),rand(9,58),1)
			world<<{"<tt><b><span style="color:rgb([src.R],[src.G],[src.B]);">[src] has joined the game!</span></tt>"}
			src.verbs+=/mob/player/verb/Start_game
			src.verbs+=/mob/player/verb/Leave_game
		else
			var/spectate=input("The server has reached it's max amount of players, or that game has allready started, would you like to spectate?","Spectate")in list("Yes","No")
			if(spectate=="Yes")
				src.loc=locate(rand(9,58),rand(9,58),1)
				src.density=0
				src.can_move=1