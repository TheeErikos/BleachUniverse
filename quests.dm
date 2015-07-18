
// File:    quests.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the /Quest object and the mob
//   procs that manage the acceptance, completion,
//   and removal of quests. The Quest object tracks
//   the state of the quest and is responsible for
//   determining when the quest has been completed.

Quest
	var
		tmp/name = "Quest"
		tmp/description = ""
		status = ""
		mob/owner
		complete = 0

		tmp/already_completed_message = ""
		tmp/completion_message = ""
		tmp/in_progress_message = ""

	New()
		..()
		update()

	proc
		status(s)
			if(status != s)
				status = s

				if(owner && owner.quest_tracker)
					owner.quest_tracker.refresh()

		// these procs are called when you get or lose a quest
		acquired()
		removed()
		completed()

		died(mob/attacker)
		killed(mob/m)
		got_item(item/i)
		dropped_item(item/i)
		update()

		// this
		is_complete()
			return complete

mob
	var
		list/quests
		list/completed_quests

		const
			// you can use these flags when calling the quest_dialog
			// proc to limit what actions will be performed, this way
			// you can make a one NPC act as the quest giver (but not
			// act as the person you turn it in to) and another NPC
			// is the NPC who completes the quest.
			QUEST_START = 1
			QUEST_END = 2

	proc
		// the quest dialog takes a quest type (ex: /Quest/MyQuest) and shows
		// the appropriate prompt to the user. If the user doesn't have the
		// quest, it prompts them to accept it. If they already have it but
		// haven't completed it, it displays the specified message. If they
		// have the quest and it's complete, it completes the quest. If they
		// have completed the quest previously it shows a specified message.
		quest_dialog(quest_type, dialog_type = QUEST_START | QUEST_END)

			var/Quest/current = has_quest(quest_type)
			var/Quest/completed = has_completed_quest(quest_type)

			// if the player has already finished this quest...
			if(completed)
				// if they're talking to the quest giver, show them the message:
				if(dialog_type & QUEST_START)
					prompt(completed.already_completed_message)
					return 1

			// if the player has the quest, we check if they've completed it.
			else if(current)

				// if they're talking to the quest ender...
				if(dialog_type & QUEST_END)

					// and the quest is complete, call the proc to complete it:
					if(current.is_complete())
						complete_quest(quest_type)
						prompt(current.completion_message)

					// otherwise we show the "in-progress" message.
					else
						prompt(current.in_progress_message)
				else
					prompt(current.in_progress_message)

				return 1

			// otherwise, the player doesn't have the quest currently
			// and has not already completed it, so we offer it to them.
			else if(dialog_type & QUEST_START)

				// instantiate the quest
				var/Quest/quest = new quest_type()

				// Ask the user if they want to accept it
				var/choice = prompt(quest.description, "Accept", "Cancel")

				// accept or reject it
				if(choice == "Accept")
					get_quest(quest)
				else
					del quest

				return 1

			return 0

		// returns the status of the specified quest type or,
		// if a status is provided as the second argument, returns
		// zero or one to indicate if the quest's status matches
		// the specified status.
		quest_status(quest_type, status = null)
			for(var/Quest/q in quests)
				if(q.type != quest_type) continue

				if(isnull(status))
					return q.status
				else if(q.status == status)
					return 1

			return null

		has_quest(quest_type)
			// we can't use locate() or istype(), we need this to
			// be an exact match.
			for(var/Quest/q in quests)
				if(q.type == quest_type)
					return q

			return null

		has_completed_quest(quest_type)
			if(!completed_quests)
				return 0

			for(var/Quest/q in completed_quests)
				if(q.type == quest_type)
					return q

			return null

		get_quest(Quest/quest)

			if(!quests)
				quests = list()

			// make sure the player doesn't already have the quest
			var/Quest/duplicate = locate(quest.type) in quests

			if(duplicate)
				return 0

			quest.owner = src
			quests += quest

			quest_tracker.refresh()
			quest.acquired()
			received_quest(quest)

			return 1

		abandon_quest(Quest/quest)
			if(quest in quests)
				quests -= quest
				quest_tracker.refresh()

				quest.removed()
				abandoned_quest(quest)
				del quest

		complete_quest(Quest/quest)

			if(ispath(quest))
				quest = locate(quest) in quests

			if(quest in quests)
				quests -= quest

				// keep track of the quests you've finished
				if(!completed_quests)
					completed_quests = list(quest)
				else
					completed_quests += quest

				quest.removed()
				quest.completed()
				quest_tracker.refresh()

				completed_quest(quest)
