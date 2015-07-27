mob
	proc
		InjuryCalc()
			if (src.injury >= src.max_injury)
				world << "[src.name] has just died!"
				src.injury = 0
				src.base_state = "playersoul"
				src.class = "Soul"
				src.isdead = 1

		PowerState()

	verb

		SayWorld(msg as text)
			usr << "{[src.class]}[usr] says, [msg]"