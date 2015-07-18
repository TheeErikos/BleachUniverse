
client
	var
		sound_volume = 1
		music_volume = 1
		screen_size = 2

	proc
		sound_volume(v)
			if(v > 1.0)
				v = 1.0
			else if(v < 0)
				v = 0

			sound_volume = v

		music_volume(v)
			if(v > 1.0)
				v = 1.0
			else if(v < 0)
				v = 0

			music_volume = v
			mob.music(null)

		screen_size(s)

			if(s < 0.5)
				s = 0.5
			else if(s > 2.0)
				s = 2.0

			screen_size = s

			var/width = 512 * screen_size + 240
			var/height = 384 * screen_size

			winset(src, "default", "size=[width]x[height]")
