
// File:    effects-sound.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains procs for playing sound effects
//   to a single player or to all players in an area.

atom
	proc
		noise(file, volume = 100, frequency = 0, pan = 0, channel = 0, range = Constants.SOUND_RANGE)

			var/sound/s = sound(file)
			s.volume = volume * Constants.VOLUME
			s.frequency = frequency
			s.pan = pan
			s.channel = channel
			s.falloff = 4

			for(var/mob/m in range(range, src))
				s.x = x - m.x
				s.y = y - m.y

				if(m.client)
					if(m.client.sound_volume)
						s.volume *= m.client.sound_volume
						m << s

mob
	var
		music

	proc
		sound_effect(file, atom/owner, volume = 100, frequency = 0, pan = 0, channel = 0)

			if(!client)
				return

			var/sound/s = sound(file)
			s.volume = volume * Constants.VOLUME
			s.frequency = frequency
			s.pan = pan
			s.channel = channel

			if(client.sound_volume)
				s.volume *= client.sound_volume

			if(owner)
				s.x = owner.x - x
				s.y = owner.y - y

			src << s

		music(file, volume = 100)

			if(!client)
				return

			var/sound/s = sound(file)
			s.volume = volume * Constants.VOLUME * client.music_volume

			s.channel = Constants.MUSIC_CHANNEL

			if(!file)
				s.status = SOUND_UPDATE
				s.file = music

				if(!s.volume)
					s.status = SOUND_MUTE

			else
				music = file

			src << s
