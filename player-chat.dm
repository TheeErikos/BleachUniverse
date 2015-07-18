
// File:    player-chat.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains the code to manage player chat.

client
	script = "<style>a.blank { text-decoration: none; color: #fff; } a.private { text-decoration: none; color: #FFFF90; } a.normal { text-decoration: none; color: #8090E0; } </style>"

	var
		list/ignore_list

	proc
		ignore(mob/m)
			if(!ignore_list)
				ignore_list = list()

			// the argument can be a mob, client, or a string
			var/n = m
			if(istype(m))
				n = m.ckey
			else if(istype(m, /client))
				n = m.key

			// you can't ignore yourself
			if(n == ckey)
				return 0

			if(n in ignore_list)
				return 0

			ignore_list += n
			return 1

		unignore(mob/m)

			if(!ignore_list)
				ignore_list = list()

			// the argument can be a mob, client, or a string
			var/n = m
			if(istype(m))
				n = m.ckey
			else if(istype(m, /client))
				n = m.key

			if(n in ignore_list)
				ignore_list -= n
				return 1

			return 0

		chat_target(client/c)
			if(c)
				// winset(src, "default.chat-title", "text=Private+Chat")
				winset(src, "default.chat-input", list2params(list("text" = "[c.key]: ")))
				winset(src, "default.chat-input", "focus=true")
			else
				// winset(src, "default.chat-title", "text=Chat")
				winset(src, "default.map", "focus=true")

	Topic(href, list/href_list, hsrc)
		..()

		if("chat_target" in href_list)
			var/client/target = locate(href_list["chat_target"])
			chat_target(target)

mob
	verb
		Say(message as text)
			set hidden = 1

			// use the chat object to send the message
			Chat.say(client, message)

			// restore focus to the map control
			winset(src, "default.map", "focus=true")

		WhosOnline()

			if(Chat.players.len == 1)
				src << "<b>1 player online:</b>"
			else
				src << "<b>[Chat.players.len] players online:</b>"

			for(var/client/c in Chat.players)
				if(client == c)
					src << " * [c.key]"
				else
					src << " * <a class=\"blank\" href=\"?chat_target=\ref[c]\">[c.key]</a> \[<a href=\"?send_invite=\ref[c.mob]\">Invite</a>]"

		ChatMenu()
			src << "There's no chat menu yet."

	key_down(k)
		..()

		// if the player presses the chat key (the enter key by default),
		// set the focus to the chat input textbox.
		if(k == Constants.KEY_CHAT)
			winset(src, "default.chat-input", "focus=true")

		else if(k == Constants.KEY_CANCEL)
			client.chat_target(null)

var
	Chat/Chat = new()

client
	New()
		..()
		Chat.players += src

	Del()
		Chat.players -= src
		..()

Chat
	var
		list/players = list()

	proc
		say(client/player, message)

			// if the message starts with a player's key followed
			// by a colon, treat it as a private message.
			var/client/target
			for(var/client/c in players)
				if(findtextEx(message, "[c.key]:") == 1)
					target = c

					// remove the target's name from the message
					message = copytext(message, length(c.key) + 2)

					// trim the leading space if there is one
					if(copytext(message, 1, 2) == " ")
						message = copytext(message, 2)

					break

			// format the message and display it
			message = format_message(player, message, target)

			if(target)
				if(target.ignore_list)
					if(player.ckey in target.ignore_list)
						player.mob.ignored_by_player(target)
					else
						target << message
				else
					target << message

			else
				for(var/client/c in players)
					if(c.ignore_list)
						if(player.ckey in c.ignore_list) continue

					c << message

		format_message(client/c, message, client/target)
			if(target)
				return "<a class=\"private\" href=\"?chat_target=\ref[c]\">[c.key]</a>: [message]"
			else
				return "<a class=\"normal\" href=\"?chat_target=\ref[c]\">[c.key]</a>: [message]"
