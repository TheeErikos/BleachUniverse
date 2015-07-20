var
	minutes=6
	seconds=0

	game_started=0

	list/directions=list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
	list/players=list()
	list/players_rgbs=list(
		"Blue"=list(0,60,120),
		"Red"=list(200,0,0),
		"Green"=list(60,120,60),
		"Orange"=list(250,130,0),
		"Aqua"=list(0,220,220),
		"Yellow"=list(230,230,0),
		"Pink"=list(255,120,255),
		"Purple"=list(150,0,150)
		)

	list/players_rgbs_backup=list(
		"Blue"=list(0,60,120),
		"Red"=list(200,0,0),
		"Green"=list(60,120,60),
		"Orange"=list(250,130,0),
		"Aqua"=list(0,220,220),
		"Yellow"=list(230,230,0),
		"Pink"=list(255,120,255),
		"Purple"=list(150,0,150)
		)

	help={"
<style>body{background-color: black; color: white; font-family: courier new;}</style>
<center><span style="color: #00ff00;">
<huge>Pirates in the sky</huge><br></span>
<i><small>By: Evi of au for Crispy's Game-in-a-day contest</small></i></center><br><br>
<small>Ahoy thar matey! So ye want to work for the Universal Pirates Union do ye? Har har, rightly so. Heres a ship to start off. Just remember, being a pirate isn't easy! You have to take what you want, and don't stand and watch what's yers be takin' be anyone else! If you see another pirate vessol, take em' out. It's every man for themself out thar. Bring me yer plunder and ye can keep the ship!</medium>
"}

mob/var
	R=255
	G=255
	B=255
	COLOR
	favoriteColor=null
	plunder=0
	health=100
	can_move=0
	direction
	weapon="laser"
	l_ammo=30
	r_ammo=6