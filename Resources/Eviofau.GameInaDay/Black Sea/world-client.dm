client
	view="15x13"
	command_text="say \""
	perspective=EDGE_PERSPECTIVE
	script="<style>body{background-color: black; color: white;}</style>"

	North()
		step(mob,mob.dir)

	West()
		mob.direction--
		if(mob.direction < 1) mob.direction=directions.len
		mob.dir=directions[mob.direction]

	East()
		mob.direction++
		if(mob.direction > directions.len) mob.direction=1
		mob.dir=directions[mob.direction]

	South()
		return

world
	hub="Eviofau.PiratesintheSky"
	name="Pirates in the Sky"