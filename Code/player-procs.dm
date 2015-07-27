
// File:    player-procs.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file contains helper procs that are specific
//   to the framework. Many helper procs end up becoming
//   part of the Pixel Movement library so we get them
//   for free here, but some aren't general purpose enough
//   to belong there.

mob
	proc
		is_near(object_type, range = 64)
			if(locate(object_type) in obounds(src, range))
				return 1
			else
				return 0
