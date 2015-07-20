proc/returnPixex(Dir)
	if(Dir==NORTH) return 0
	if(Dir==NORTHWEST) return -32
	if(Dir==WEST) return -32
	if(Dir==SOUTHWEST) return -32
	if(Dir==SOUTH) return 0
	if(Dir==SOUTHEAST) return 32
	if(Dir==EAST) return 32
	if(Dir==NORTHEAST) return 32

proc/returnPixey(Dir)
	if(Dir==NORTH) return 32
	if(Dir==NORTHWEST) return 32
	if(Dir==WEST) return 0
	if(Dir==SOUTHWEST) return -32
	if(Dir==SOUTH) return -32
	if(Dir==SOUTHEAST) return -32
	if(Dir==EAST) return 0
	if(Dir==NORTHEAST) return 32

proc/endGame()
	if(game_started)
		var/list/scores=findTopscorer()
		var/ranks=1
		world<<{"<tt><span style="color:rgb(100,200,0);">The game has ended! Here is the list of scores!</span></tt><br>"}
		world<<{"<tt><span style="color:rgb(100,200,0);">--------------------------</span></tt><br>"}
		for(var/mob/m in scores)
			world<<{"<tt><span style="color:rgb(100,200,0);">[ranks]\th) [m] -- [m.plunder]!</span></tt><br>"}
			ranks++
		world<<{"<tt><span style="color:rgb(100,200,0);">--------------------------</span></tt><br>"}
		world<<{"<tt><span style="color:rgb(100,200,0);">Auto-Rebooting! If you are for some reason disconnected, rejoin here; byond://[world.address]:[world.port]</span></tt><br>"}
		world.Reboot()

proc/findTopscorer()
	var/list/scores=list()
	for(var/mob/m in players)
		scores+=m
		scores[m]=m.plunder
	for(var/i=1,i<scores.len,i++)
		if(scores.len > i)
			if(scores[scores[i]]<scores[scores[i+1]]) scores.Swap(i,i+1)
	return scores