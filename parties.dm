
// File:    parties.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file defines the /Party object which is
//   used to manage groups of players.

Party
	var
		tmp/list/mobs = list()
		tmp/mob/leader
		tmp/size_limit

	New(mob/m)
		if(m)
			mobs += m
			leader = m

	proc
		add_player(mob/m)

			if(mobs.len >= size_limit)
				m.party_is_full()
				return 0

			mobs += m

			for(var/mob/a in mobs)
				a.player_joined_party(m)

			m.party = src
			m.you_joined_party()
			return 1

		remove_player(mob/m)
			mobs -= m

			for(var/mob/a in mobs)
				a.player_left_party(m)

			m.you_left_party()
			m.party = null

			// if this was the last mob in the party, delete the party object
			if(!mobs.len)
				del src

			// if the leader left, promote another mob to be the leader
			if(leader == m)
				leader = null

				for(var/mob/a in mobs)
					leader = a
					break

				if(leader)
					leader.promoted_to_party_leader()

		invite_player(mob/m)

			if(mobs.len >= size_limit)
				leader.party_is_full()
				return 0

			if(!m || !m.client || m == src)
				return 0

			m << "[leader] has invited you to join their party.\[<a href=\"?accept_party_invite=\ref[src]&mob=\ref[m]\">Accept Invitation</a>]"

			return 1

mob
	var
		tmp/Party/party

	proc
		invite_player(mob/m)

			if(!m || !m.client || m == src)
				return 0

			// if you're in a party but you aren't the leader, you can't invite people
			if(party && party.leader != src)
				must_be_party_leader()
				return 0

			// if you're not in a party, make one
			party = new(src)

			return party.invite_player(m)

		join_party(Party/p)

			if(istype(p, /mob))
				var/mob/m = p
				p = m.party

			if(party)
				party.remove_player(src)

			p.add_player(src)

		leave_party()
			if(party)
				party.remove_player(src)

client
	Topic(href, list/href_list, hsrc)
		..()

		if("send_invite" in href_list)
			var/mob/m = locate(href_list["send_invite"])

			if(m)
				mob.invite_player(m)

		if("accept_party_invite" in href_list)

			// make sure you're still playing the mob who received the invitation
			var/mob/m = locate(href_list["mob"])

			if(m == mob)
				var/Party/p = locate(href_list["accept_party_invite"])
				mob.join_party(p)
