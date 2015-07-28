Skill
	parent_type = /obj

	Attack
		Click()
			usr << "You clicked [src]"

	Defend
		Click()
			usr << "You clicked [src]"

	Shikai
		Click()
			usr << "You clicked [src]"
			usr.abilities += new /Ability/ShikaiRelease()

	Bankai
		Click()
			usr << "You clicked [src]"
			usr.abilities += new /Ability/BankaiRelease()

	Ress
		Click()
			usr << "You clicked [src]"
		//	usr.abilities += new /Ability/Ress()

	SRess
		Click()
			usr << "You clicked [src]"
		//	usr.abilities += new /Ability/Ress()
