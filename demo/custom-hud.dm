
// File:    demo\custom-hud.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   This file shows how to use the /HudBox object to
//   create a custom interface.

MyCustomHud
	parent_type = /HudBox

	var
		HudListBox/list_box

	New()
		..()

		// create a 5x5 panel as the background
		panel(5, 5)

		// create a 4x3 list box
		list_box = list_box(4, 3)
		list_box.pos(16, 16)

		// center the interface
		pos(176, 112)

		// make the list box show your abilities
		list_box.display(owner.abilities)

		// hide this interface by default
		hide()

	key_down(k)
		..()

		if(k == Constants.KEY_CANCEL)
			close()

		// we forward keystrokes to the list box control
		// because it handles moving the cursor when you
		// press the arrow keys.
		else
			list_box.key_down(k)

			if(k == Constants.KEY_SELECT)
				var/Ability/ability = list_box.get_value()

				if(ability)
					world << "You picked [ability.name]."
					close()

	// when you close it, we hide the interface and
	// restore focus to the owner
	close()
		hide()
		owner.client.focus = owner

mob
	var
		MyCustomHud/my_custom_hud

	init_hud()
		..()
		my_custom_hud = new(src)

	key_down(k)
		..()

		// Press C to open the custom hud.
		if(k == "c")
			client.focus = my_custom_hud
			my_custom_hud.show()
