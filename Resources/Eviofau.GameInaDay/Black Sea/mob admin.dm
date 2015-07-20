mob/Admin
	key="Evi of au"
	verb/Reboot()
		set category="Admin"
		world<<{"<tt><span style="color:rgb(100,200,0);">Rebooting! If you are for some reason disconnected, rejoin here; byond://[world.address]:[world.port]</span></tt>"}
		world.Reboot()