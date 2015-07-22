mob
	proc
		InjuryCalc()
			if (src.injury >= 100)
				world << "[src] has just died!"
				src.injury = 0
				src.base_state = "playersoul"
				src.isdead = 1

		PowerState()

	verb

		SayWorld(msg as text)
			world << "{[src.class]}[usr] says, [msg]"