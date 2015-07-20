
// File:    _constants.dm
// Library: Forum_account.ActionRpgFramework
// Author:  Forum_account
//
// Contents:
//   These constants are used by the framework.

Constants
	var
		const
			HUD_ICON = 'framework-hud.dmi'
			HUD_LAYER = 50

			// the icon used for graphical effects
			EFFECTS_ICON = 'framework-effects.dmi'

			// used to make selections and close menus
			KEY_SELECT = "space"
			KEY_CANCEL = "escape"

			// used to move the cursor in menus
			KEY_UP = "w"
			KEY_DOWN = "s"
			KEY_RIGHT = "d"
			KEY_LEFT = "a"

			// used to open/close the loot and inventory panels
			KEY_LOOT = "l"
			KEY_INVENTORY = "i"
			KEY_ABILITIES = "n"
			KEY_QUESTS = "q"
			KEY_PARTY = "p"
			KEY_INFO_BAR = "h"
			KEY_STATS = "k"

			// other controls
			KEY_TARGET = "r"
			KEY_TARGET_NON_ENEMIES = "shift"
			KEY_CHAT = "return"
			KEY_DELETE = "delete"
			KEY_DROP = "x"

			// these enable or disable HUD elements
			USE_ABILITY_BAR = 1
			USE_INFO_BOX = 0
			USE_INVENTORY = 1
			USE_LOOT_WINDOW = 1
			USE_HEALTH_METER = 1
			USE_MANA_METER = 1
			USE_SHOPKEEPER = 1
			USE_CONDITIONS_BAR = 1
			USE_GAME_MENU = 1
			USE_QUEST_TRACKER = 1
			USE_MEDAL_DISPLAY = 1
			USE_PARTY_DISPLAY = 1
			USE_BANK = 1
			USE_INFO_BAR = 0

			// the size of the on-screen inventory
			INVENTORY_DISPLAY_SIZE = "5x3"
			BANK_DISPLAY_SIZE = "6x4"

			// the number of items a player can hold
			INVENTORY_SIZE = 15
			BANK_SIZE = 32

			// the info box appears after you've been standing
			// still for two seconds.
			INFO_BOX_DELAY = 10
			// the size of an icon in pixels
			ICON_WIDTH = 32
			ICON_HEIGHT = 32

			// the size of the map's display area in tiles
			VIEW_WIDTH = 16
			VIEW_HEIGHT = 12

			// Bit flags that correspond to the different teams a mob
			// can belong to. The library only defines two teams, players
			// and enemies.
			TEAM_PLAYERS = 1
			TEAM_ENEMIES = 2

			// this is the range (in tiles) for how far away players
			// will hear a sound played by calling atom.sound_effect()
			SOUND_RANGE = 8

			MONEY_COLOR = rgb(255, 255, 128)
			EXPERIENCE_COLOR = rgb(196, 196, 255)
			// CHAT_COLOR = rgb(128, 144, 240)
			// PRIVATE_CHAT_COLOR = rgb(255, 255, 144)

			// The multiplier applied to the volume level of all sounds.
			VOLUME = 1
			MUSIC_CHANNEL = 1000

			// The number of characters a player can have
			SAVE_SLOTS = 1

			// 1 for client-side savefiles, 0 for server-side
			CLIENT_SIDE_SAVING = 0

			// this is the number of frames between health/reiatsu regen events
			REGEN_TICK_LENGTH = 50
