
// File:    player-leveling.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the mob's experience, level, and
//   souls vars and has the procs to update these vars.

mob
	var
		level = 1
		experience = 0
		experience_needed = 5
		souls = 0
	proc
		description(full_description = 0)
			if(full_description)
				return "<b>Level [level]</b>"
			else
				return "Level [level]"

		gain_experience(e)
			set_experience(experience + e)

		set_experience(e)
			experience = e

			check_level()

			if(info_box)
				info_box.refresh()

		check_level()
			while(experience >= experience_needed)
				level_up()

		level_up()
			if(experience >= experience_needed)
				experience_needed = level*1337
				src.level += 1
				src.talentpoint += 4
				src.Skill_Points += 1
				src.SkillsCheck()
			experience = experience - experience_needed

		gain_souls(m)
			set_souls(souls + m)

		set_souls(m)
			souls = m