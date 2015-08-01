
// File:    hud-quests.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the on-screen quest tracker which
//   shows the name of each quest you have and its status.
//   The player can give focus to the quest tracker by
//   pressing Q and delete quests.

QuestTracker
	parent_type = /HudGroup

	layer = Constants.HUD_LAYER - 5

	var
		list/captions = list()
		list/borders = list()

		index = 0
		HudObject/cursor

		mob/owner

		width = 5

	New(mob/m)
		..()
		owner = m

		add(0, 0, "", maptext = "<b>Quest Tracker</b>", maptext_width = width * Constants.ICON_WIDTH, maptext_height = 16, layer = layer + 2)
		add(-1, -1, "", maptext = "<font color=#000><b>Quest Tracker</b></font>", maptext_width = width * Constants.ICON_WIDTH, maptext_height = 16, layer = layer + 1)
		cursor = add(0, 0, "")

		pos(Constants.ICON_WIDTH * (Constants.VIEW_WIDTH - width - 0.5), Constants.ICON_HEIGHT * (Constants.VIEW_HEIGHT - 1))

		refresh()

	key_down(k)
		if(k == Constants.KEY_UP)
			set_index(index - 1)
		else if(k == Constants.KEY_DOWN)
			set_index(index + 1)
		else if(k == Constants.KEY_DELETE)

			var/Quest/q = owner.quests[index]
			var/choice = owner.prompt("Are you sure you want to abandon the quest '[q.name]'?", "Abandon", "Cancel")

			if(choice == "Abandon")
				owner.abandon_quest(q)

			// if that was the last quest, set focus back to the player
			if(!owner.quests.len)
				cursor.icon_state = ""
				owner.client.focus = owner

		else if(k == Constants.KEY_CANCEL)
			cursor.icon_state = ""
			owner.client.focus = owner

	focus()
		if(owner.quests && owner.quests.len)
			set_index(1)
			cursor.icon_state = "menu-cursor"
			owner.client.focus = src

	proc
		set_index(i)
			if(!owner || !owner.quests || !owner.quests.len)
				return

			if(i < 1) i = 1
			if(i > owner.quests.len) i = owner.quests.len

			index = i
			cursor.pos(-11, index * -16 + 3)

		refresh()

			var/num_quests = 0

			if(owner && owner.quests)
				for(var/i = 1 to owner.quests.len)
					num_quests += 1

					var/Quest/quest = owner.quests[i]

					var/HudObject/caption
					var/HudObject/border

					if(i > captions.len)
						captions += add(0, i * -16, "", maptext_width = width * Constants.ICON_WIDTH, maptext_height = 16, layer = layer + 2)

					if(i > borders.len)
						borders += add(-1, i * -16 - 1, "", maptext_width = width * Constants.ICON_WIDTH, maptext_height = 16, layer = layer + 1)

					caption = captions[i]
					border = borders[i]

					if(quest.status)
						caption.maptext = "[quest.name] ([quest.status])"
						border.maptext = "<font color=#000>[quest.name] ([quest.status])</font>"
					else
						caption.maptext = "[quest.name]"
						border.maptext = "<font color=#000>[quest.name]</font>"

			while(captions.len > num_quests)
				var/HudObject/o = captions[num_quests + 1]
				captions -= o
				del o

			while(borders.len > num_quests)
				var/HudObject/o = borders[num_quests + 1]
				borders -= o
				del o

			if(num_quests)
				show()
			else
				hide()

			set_index(index)

mob
	var
		QuestTracker/quest_tracker

	init_hud()
		..()

		if(Constants.USE_QUEST_TRACKER)
			if(quest_tracker)
				quest_tracker.hide()
				del quest_tracker

			quest_tracker = new(src)

	clear_hud()
		..()

		if(quest_tracker)
			quest_tracker.hide()
			del quest_tracker

	key_down(k)
		..()

		if(Constants.USE_QUEST_TRACKER)
			if(k == Constants.KEY_QUESTS)
				quest_tracker.focus()
