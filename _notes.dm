/*

 -- Version History --

Version 10 (posted 07-07-2012)
 * Added the info bar which is shown at the top of the screen. Added the
   Constants.KEY_INFO_BAR var, which is "h" by default, that sets focus to
   the info bar. While it has focus you can use the Delete key to remove
   messages and the arrow keys to cycle through them. The Esc and H keys
   set focus back to the player.
 * You can use the mob.info_bar.add_message() proc to show a text string in
   the info bar. You can use the info_bar's remove_message() proc to remove
   a message. There are examples of this in demo\help.dm.
 * Added health and mana regeneration. The mob.health_regen() and mob.mana_regen()
   procs are called periodically when the mob is below their maximum value. By
   default these procs do nothing but you can override them to call gain_health()
   and gain() mana. The sample game has an example of this. Note: the regen procs
   are only called if you're below your max health/mana value.
 * Added the Constants.REGEN_TICK_LENGTH variable which is the number of frames
   between calls to health_regen() and mana_regen(). It's default value is 40 so
   these procs are called once per second.
 * Increased the mana cost of Fireball in the sample game so you can notice
   mana regeneration more easily.
 * Increased the default layer of objects created with the atom.effect() proc
   to be the atom's layer + 10 because there were still some layering issues
   with these objects and equipment overlays.
 * Added the "attached" named parameter to the atom.effect() proc. If you call
   mob.effect("something", attached = 1), the object will follow the player as
   they move.
 * Changed the Quest.complete() proc to be called "is_complete" instead.
 * Added the Quest.acquired(), removed(), and completed() procs. acquired() is
   called when you receive a quest, removed() is called when you abandon or complete
   a quest, and completed() is called when you complete a quest. By default these
   don't do anything but they let you add custom behavior to getting or losing
   quests.
 * Added demo\help.dm which shows some ways to use the info bar to create
   context-sensitive help messages to a game.
 * Added the mob.number_prompt() proc which is similar to text_prompt() except
   you can only type digits.
 * Changed the way text and number prompts are handled internally, but this
   doesn't change how they're used.
 * Added the show_caption var to the HealthMeter and ManaMeter objects. When this
   is set to 1 it'll cause the stat's value and maximum to be displayed to the
   right of the meter. It is zero by default but the sample game includes code
   in demo\mobs.dm to set it to 1 for both meters.
 * Added the ability to drop items on the map. When you call mob.drop_item(item),
   the item will be placed on the map. It'll be displayed using its map_icon and
   map_state vars.
 * Previously, mob.drop_item(item) would set the item's loc to null and cause the
   item to be deleted. If you want to simply remove the item from their inventory
   and delete it, you can call mob.remove_item(item). This will set the item's
   loc to null.
 * Added the item.pickup var whose value can be item.WALK_OVER or item.INTERACT.
   This determines how the item is picked up - by walking over the item or by
   interacting (pressing the space bar). The default value is INTERACT.
 * Pressing D in the inventory screen makes you drop an item. Pressing the Delete
   key removes the item and deletes it entirely.
 * Made the ability menu able to show multiple columns in case the player has
   many abilities to choose from. The height of each column is determined by
   the AbilityMenu/size var which is 8 by default, but is set to 4 in the sample
   game so you'll see multiple columns there.
 * Added the AbilityMenu/show_ability() proc which takes an Ability object as a
   parameter and returns 0 or 1 to determine if the ability should be listed. This
   way you can limit what abilities are shown when the player is customizing their
   key bindings (ex: you can hide their crafting abilities from that menu and
   provide a separate interface to access them).
 * Added an outline to the item description text in the inventory screen to make
   it more readable when the caption is over top of a bright item.
 * Changed some things about on-screen interfaces. The HudBox object which many
   interface elements extend now contains the box() proc which is used to create
   the background of each window instead of creating the box using parameters
   passed to the New() proc.
 * Added the party.size_limit var which limits the number of players that can
   be in a party. The default is zero, which means there is no limit.
 * Added the party.invite_player(mob) proc which is used to invite players. This
   proc enforces the size limit. You can still call the mob's invite_player() proc
   since it calls the party.invite_player proc.
 * Added the HudGroup.focus() and close() procs. By default these do nothing
   but they're commonly defined procs that might come in handy for defining the
   behavior that should happen when interfaces are opened and closed.
 * Added the HudBox.panel() proc which creates an on-screen panel. These panels
   look like the backgrounds of the mob selection menu, inventory screen, prompt
   boxes, and other interface elements.
 * Added the HudBox.box() proc which has the same effect as the panel() proc but
   panel() creates the box as a child HudObject and box() creates it by adding
   objects to the current HudGroup.
 * Added the HudBox.list_box() proc which create an on-screen list box that can
   be used to display a list of objects. The list_box returns a type of HudGroup
   object. To use the list box you have to pass keystrokes to it. See
   demo\custom-hud.dm for an example.
 * Updated the current HUD interface elements to make use of the new vars and procs.

Version 9 (posted 06-29-2012)
 * Checked for zero values in the health/mana meters to remove a runtime error
   that could occur.
 * Made the health/mana meters show one bubble even if your maximum value is
   zero. If you've got 0/0 health or mana it'll show as one empty bubble.
 * Checked for a null quests list in hud-quests.dm to avoid a runtime error
   that would occur when you pressed Q without having any quests.
 * Added the player bank which is shared across all characters the player has.
 * When banking, use the arrow keys to move the cursor and the space bar to
   move items between your inventory and bank. When you're done, press escape
   to close the interface.
 * Added an NPC to the sample game that you interact with to access the banking
   interface.
 * Added the mob.item_prompt() proc which can be used to ask the user to select
   an item from their inventory.
 * Changed how medals work. Medals are now an in-game thing that can be awarded
   to each character. If you give them a hub_name they'll also be awarded on the
   BYOND hub, but you don't need a hub to give in-game medals. Each character
   keeps track of the medals they've been awarded. This also means that medals
   can be awarded to a player even if they're playing offline.
 * Added the mob.sync_medals() proc which checks what medals the player has
   earned and updates the BYOND hub accordingly. Since medals can be awarded even
   when the BYOND hub can't be reached, you can call this proc to update the hub's
   record of what medals the player has.
 * Fixed a bug with the consume_item and remove_item procs. Now they will properly
   delete stacks when their quantity is reduced to zero.
 * I also changed the way that has_item and remove_item compare item types. They
   used to use istype(), which meant that consume_item(/item/potion) might delete
   an instance of /item/potion/super_potion. Now it uses the == operator so it has
   to be an exact match.
 * Adjusted the health and mana meter bubbles so the images are centered in the
   icons.
 * Updated the party display and made it enabled by default. Party members are
   shown in the top-right corner of the screen. The list is updated as party
   members come and go and their health/mana displays are updated as they change.
 * You can press the P key to hide or show the party display.
 * In the sample game you can click on a mob to add or remove them from your
   party. This is done just so you can test out the party display.
 * Added "layer" as a named parameter to the atom.effect() proc, its default value
   is the atom's layer plus five.
 * Added a trail behind the fireball ability in the sample game. The trail is
   purely visual, touching it doesn't inflict damage.
 * Added the KEY_QUESTS constant which is "q" by default. This is the key you can
   press to set focus to the quest tracker.

Version 8 (posted 06-23-2012)
 * Increased the layer of objects created by the atom.effect() proc to make
   them less likely to appear underneath overlays.
 * Added a new graphical effect for being poisoned and taking poison damage.
 * Changed the way shadows work in the sample game and added shadows to enemies.
 * Added the /Medal object which contains all of the information you need to
   describe a medal. You're still responsible for checking the conditions to
   determine when a player has earned a medal.
 * Added the mob.award_medal() proc which can take a /Medal object type path
   or an object instance. This proc automatically handles the on-screen display
   of medals when the player receives one.
 * Added the Options.medal_display_time var which determines how long a medal
   is shown on the screen when it's received. The default value is 30 (3 seconds).
 * Added two medals to the sample game.
 * Added the mob.text_prompt() proc which creates an on-screen prompt that
   displays a message and prompts the user to type in a string. When the user
   hits enter, the proc returns. The return value is the string that was typed.
 * Added a message that gets displayed at the bottom of a prompt window that
   contains text and no buttons. This message is defined in the Options object
   as Options.prompt_continue_message, so you can easily change it if you'd like.
   The default value is "Press the Space Bar to continue."
 * Added a basic character creation process to the mob.new_character() proc in
   the sample game. When you make a new character, it now asks for your name
   and character class.
 * Added the mob.class var to the sample game, moved the mob's description()
   proc to the sample game, and made it use your class and name.
 * Updated shadow-47.dmi in the sample game to make the shadows a little bit
   lighter (important change, I know).
 * Fixed a bug with quests dialogs. Previously mobs would offer you a quest
   even if they were only the ending point of the quest.
 * Added the mob.pvp var. Two mobs on the TEAM_PLAYERS team can attack each
   other if their mob.pvp vars are both 1. Setting this var is completely up
   to you. Maybe you want players to be able to turn PVP mode on or off for
   themselves. Maybe you want the game to enable PVP for players when they
   enter a certain area.
 * Added an example of enabling and disabling PVP in the sample game. When you
   press the P key it adds or removes a condition. See demo\conditions.dm for
   more details.
 * Added the /Party object and the ability for players to be in groups with
   other players. You can invite players to your party by clicking the "Invite"
   link next to their name in the "Who's Online" list.
 * Updated the can_attack proc to let you attack players if both of you have
   pvp enabled. Also updated the proc to prevent you from attacking people
   who are also in your party.
 * Added the Options.title_screen var. You can override its default value to
   specify a custom file to be used as the title screen. If the image is smaller
   than an icon it'll be tiled, otherwise it'll be centered in the screen. There's
   an example of how to do this in demo\mobs.dm but it's commented out by default.
 * Changed the way health and mana meters determine how many bubbles to show.
   The relationship between the value and the number of bubbles is logarithmic
   now, so that 50 is five bubbles, 100 is six, and 500 is eight bubbles.

Version 7 (posted 06-15-2012)
 * Fixed the alignment of item captions in the loot window when the item
   name wrapped to a second line. Also increased the width of the loot
   window by a tile to make it less likely that item names will wrap.
 * Condition objects are now saved and loaded. Their durations are only
   being checked and diminished when the character owning them is active.
   If you give the player a condition that lasts for 10 minutes, it'll
   only expire after 10 minutes of playing time on that character.
 * Updated the combat object in the sample game to not check for critical
   hits when the attacker is null.
 * Added client options for screen size, sound volume, and music volume.
   These values are also stored in the client's savefile.
 * Added the interface to set the client options in the "Game Options" menu.
 * Made the escape key only open the game menu if it didn't perform any other
   action (ex: untargeting the mob you're currently targeting).
 * Set the anchor property of the chat input control so the window resizes
   properly now.
 * Added the icon-generation folder which contains code and icons used to
   generate overlays. This lets you easily generate new armor or helmet
   overlays with different colors or patterns.
 * Added the mob.music proc which is used to play music to the player. The
   songs are automatically updated when the client's volume setting is changed.
 * Added music to the sample game.
 * Added the "slowed" condition to the sample game. The blue oozes attacks slow
   your movement speed by 50% for one second.
 * Added the base_speed var to the sample game. This is a value that doesn't
   change so even if you modify the player's move_speed var, you always know
   what their base movement speed was.
 * Shifted the condition icons up and over 8 pixels so they're in the center of
   their icon states now. The ConditionsBar HUD element was shifted down and
   left 8 pixels so the icons still appear in the same position on the screen.
 * Fixed a bug with the Condition.stack_size var. Previously it'd allow one
   more condition than you had told it to allow.
 * Replaced the mob.saved_loc var with the mob.saved_x/y/z vars. Saving a
   reference to your turf could cause unwanted things to be saved. Instead we
   use the saved coordinates to get a reference to your saved loc at runtime.
 * Added the Quest datum and the mob procs to manage accepting quests, updating
   the progress on quests, abandoning them, and completing them.
 * The Quest datum automatically has procs that are called when you kill an
   enemy, get an item, lose an item, or get killed. This makes it easy to
   capture these events to update the quest's status accordingly.
 * Added the mob.quest_dialog() proc which takes a /Quest type and displays
   the appropriate prompts given the player's current progress on that quest.
   The second argument is the dialog type, which can be QUEST_START,
   QUEST_END, or QUEST_START | QUEST_END. This lets you make NPCs act as only
   the quest's starting point, only the end point, or both.
 * Added two quests to the sample game. See demo\npcs,dm for more details.
 * Added the on-screen quest tracker which shows the name of each quest and
   its status.
 * Pressing the Q key will set focus to the quest tracker. The player can use
   the arrow keys to select a quest and press the delete key to abandon a
   quest (there is a confirmation prompt before it's abandoned).
 * Made the mob.prompt() proc create a dialog with no buttons if you pass null
   as a button name. Omitting all button names makes it default to having just
   an "Ok" button, but calling prompt("text...", null) makes it not show any
   buttons.
 * Added support for specifying a width and height for prompt windows. The first
   parameter to prompt() is still the message. Any parameter after the first
   that's a number is assumed to be the width or height of the window. For
   example, prompt("", "Ok", "Cancel", 4, 4) makes a 4x4 prompt. The default
   size is 6x4.
 * Added the global Options object. This is like the Constants object except
   it contains values that aren't needed at compile-time. This makes it easier
   to change options in your project because you can simply do:
   Options/space_opens_inventory = 0 to change that option and it overrides
   the value specified in the library.
 * Added the "space_opens_inventory" option to the Options object. This is used
   to determine if the space bar should open the inventory screen when there's
   nothing else for you to interact with (it's 1 by default).
 * Changed the mob.wander() proc to check for some conditions that would cause
   infinite loops.
 * Added shadows below mobs in the sample game.
 * Removed the "Chat Menu" button from the interface. It'll be accessed through
   the game menu (the one that appears when you press escape) though it's still
   not implemented yet.

Version 6 (posted 06-13-2012)
 * Made it so you can't use, equip, or unequip items when you're dead.
 * Changed how attack animations are played. Instead of using flick(), it now
   just changes your icon_state for a specified amount of time.
 * Added character saving and loading as the client.save() and client.load()
   procs. The load() proc simply populates the client's mobs list which you
   can then display to the user to let them select a character.
 * Added a title screen and character selection menu.
 * I had to change some things to support saving and loading:
    - Instead of using mob/Login to initialize your mob, it now uses the mob's
      new_character() proc. This ways it's only called when you create a new
      character and not when you connect to one you loaded.
    - Added the client.connect(mob/m) proc which connects the client to a mob.
      This triggers all of the actions that have to happen (setting client.mob,
      setting client.statobj, setting client.focus, calling init_hud(), etc.).
    - Made a bunch of the mob's vars tmp vars so they don't get saved.
 * Added the Constants.CLIENT_SIDE_SAVING variable which determines if savefiles
   are stored on the server or client. The default is to store files on the
   server. If you change to use client-side savefiles, be aware that you'll have
   to change when client.save() gets called. By default it's only called from
   client/Del() which does not allow for the savefile to be exported.
 * Added the /missile object which is a child type of /projectile. The missile
   object is purely graphical. It passes through all objects and always hits the
   specified target, calling the hit() proc when it has reached its target. Its
   New() proc takes two parameters, the owner and the target.
 * Updated the ShootArrow ability to use the new /missile object to create a
   graphical effect and deal damage when the projectile graphic hits the target.
 * Added the ability to send private messages by starting your messages with a
   player's name followed by a colon.
 * Removed the ability to target a player by clicking on their name. Clicking
   on a player's name now prompts you to send them a private message. Clicking
   on a player's name in the "Who's Online" output also does this.
 * Changed how chat messages are colored. Instead of using color constants from
   the global Constants object, it now uses client/script to control the color.
   This is needed so the link's color doesn't change to the visited link color
   after you click on it.
 * Added a game menu that is accessed by pressing escape while in the game. It
   contains some placeholder options and a working option to return to the title
   screen (which lets players change characters).
 * Added the ability to delete characters at the character selection screen by
   pressing the delete key and selecting "Delete" at the confirmation prompt.
 * Added the item.overlay_icon, overlay_state, and overlay_layer vars.
 * Updated how overlays and equipment overlays are handled. You can now call the
   mob.overlay() proc and pass it an item. It'll create and return the /Overlay
   object to represent the item based on its overlay_icon/state/layer vars.
 * Added the mob.remove(item) proc which removes an equipment overlay.
 * Added the move_state var which is the movement portion of the player's icon
   state (ex: standing, moving, attacking, dead, etc.). Overlays created by
   passing the overlay() proc an item are automatically updated to always match
   the player's movement state.
 * Updated the sample game to include equipment based overlays. The shield was
   changed to body armor which has an overlay. The sword also has an overlay.
   Also added a helmet which has an overlay.
 * Updated the melee attack graphical effect to remove the sword part, now it's
   just the white slashing line (if you have a sword equipped, your overlay will
   be animated to show the sword slash).
 * Made the character selection menu display overlays based on what items each
   character has equipped.
 * Added the ability to delete items from the inventory screen by pressing the
   delete key.
 * Fixed a glitch in the mob.drop_item() proc. Previously it wouldn't unequip an
   item before dropping it.

Version 5 (posted 06-09-2012)
 * Fixed a movement bug. Previously you would continue moving if you held
   and arrow key while you died.
 * Moved the enemy AI into the library to be the default ai() proc. Non-client
   mobs that don't override their ai() proc will wander, look for targets, and
   use their abilities to attack them.
 * Added some vars to manage the default enemy AI. Check enemy-ai.dm for more
   details.
 * Made the font of the chat input field match the rest of the interface.
 * Removed the global Combat var. If you need to use it, define your own.
 * Defined the PhysicalCombat object in the sample game which contains the
   rules for physical damage (dodging, critical hits, etc.).
 * Added the MagicCombat object to the sample game which has slightly different
   rules than the PhysicalCombat object. It uses the mind stat for critical hits
   and the resistance stat for damage reduction.
 * Added the mind and resistance stats which are used by the new MagicCombat
   object.
 * Changed how teams work. The team var is now a bit mask. If two mobs have
   no matching bits set, they can attack each other. By default all mobs are
   on TEAM_PLAYERS and mobs of type /mob/enemy are only on the TEAM_ENEMIES team.
 * Removed the TARGET_RANGE constant. If you want to change it, just override
   the default value of the mob's target_range var.
 * Added the mob.ignore and unignore procs which can be used to ignore chat
   messages from certain players. Your ignore list stores each mob's ckey, but
   you can pass a ckey or mob reference to these procs.
 * Made the player able to target non-enemies by holding down the shift key
   while pressing tab.
 * Also added the ability to target a mob by clicking on their name in the chat log.
 * Added the name display below targeted mobs.
 * Made projectiles pass through friendly mobs.
 * Updated the sound procs. There is now the atom.noise() proc and the
   mob.sound_effect() proc. The atom.noise() proc is for creating noises that
   nearby players can hear (ex: casting a spell). The mob.sound_effect() proc
   is for playing sound effects to a single player (ex: when they make a
   selection in a menu).
 * Added sound effects to the sample game.
 * Added the mob.rumble proc which makes the screen shake.

Version 4 (posted 06-04-2012)
 * Fixed a bug in the on-screen shopkeeper display that would let you buy
   items you couldn't afford.
 * Updated the on-screen shopkeeper to show prices. Also set the cost var
   of the items the shopkeeper sells.
 * Updated the shopkeeper NPC to display a greeting using the prompt() proc.
 * Added player-chat.dm which contains code to manage global chat.
 * Updated the interface to support player chat.
 * Made the info box disappear while you're moving and only appear after
   you've been standing still for two seconds.
 * Changed the way cooldowns work. Now the library stores the soonest time
   you can use each ability again instead of using spawn() to clear each one.
 * If you call cooldown(x, y) while x is on cooldown, it's duration will be
   set to y (provided that's longer than the current remaining duration).
 * Updated the combat procs and events to handle damage that comes from null
   or unknown sources. Previously if you called mob.lose_health(10) it could
   cause a runtime error, now it doesn't.
 * Added conditions.dm which defines the /Condition object that you can use
   to create buffs or debilitating effects.
 * Added the condition_applied and condition_removed events that are automatically
   called when a condition is applied or removed.
 * Added the mob.conditions list which is a list (that's automatically
   maintained) of the conditions affecting the mob.
 * Added the Poison ability to the sample game which shows how to use conditions
   to create an ability that deals damage over time. Also added a new kind of
   enemy that poisons the player.
 * Added the mob.clear_cooldown() proc which clears each cooldown passed to it.
 * Added the set_max_health, gain_max_health, and lose_max_health procs which
   can be used to modify a mob's max_health value.
 * Added the gain_mana, lose_mana, gain_max_mana, lose_max_mana, and set_max_mana
   proc which are used for modifying a mob's mana and max_mana values.
 * Expanded the sample game's stats to include power, speed, and defense instead
   of just attack and defense. Power was substituted for attack.
 * Expanded the combat in the sample game to give you a chance to dodge attacks
   and get critical hits (both are based on your speed var).
 * Made mobs only yield experience and money if they were killed by another mob,
   so that you can't get experience and money for killing yourself.
 * Added hud-conditions.dm which contains the on-screen interface for showing a
   list of conditions that are currently applied to the player.

Version 3 (posted 05-26-2012)
 * Changed interaction to use obounds(8, src) instead of front(8), this way it
   works for diagonals.
 * Made the ShootArrow ability in the demo check if(!user.target ||
   !user.can_target(user.target)) so you can't shoot dead targets. I also
   added user.target.effect("arrow-hit")
 * Added an arrow-hit animation.
 * Changed the target-marker icon a little to make the edges smoother.
 * Changed the way crafting abilities are defined and moved the definition of
   CraftingAbility to the framework (in player-crafting.dm).
 * Changed the /projectile type's constructor. The first parameter is still
   the mob who is firing the projectile. The second parameter can either be
   a direction, an atom, or null. If it's a direction, the projectile is fired
   in that direction. If it's an atom, the projectile is fired towards that
   atom. If it's null, it's fired in the direction of the mob who fired the
   projectile.
 * Updated the demo to make the Fireball ability be fired towards your target.
   If you don't have a target, it's fired in the direction you're facing.
 * Changed the range for interacting with objects. It now checks obounds(8)
   for objects to interact with, previously it checked front(1).
 * Made the space bar close the loot window if there are no more items shown
   in the window.
 * Rearranged the code for abilities in the demo to make target checking part of
   the ability's can_use() proc. This way the mana cost and cooldowns aren't
   triggered if the ability doesn't have a valid target. These abilities now also
   trigger the no_target_selected() event to fire in these cases.
 * Added the atom/movable/lootable var which is used to determine if an object
   can be looted. By default it is zero for all objects and only 1 for mobs of
   the /mob/enemy type.
 * Added a loot indicator. When you kill a mob and it drops loot, a treasure chest
   icon is shown next to its corpse. Once all of its items are looted, the
   indicator disappears.
 * Added the ability to clear a key binding in the ability bar.
 * Added the lost_item event for movable atoms. This is called on the object that
   used to contain an item when an item is gotten by a player. The default behavior
   is to remove the loot indicator if this was the last item the container had.
 * Changed the way damage numbers are created in the demo. They're now created
   by the mob's took_damage proc. This is more consistent since the events are
   primarily for creating custom notifications. Previously the damage numbers
   were created by the Combat's attack() proc, but that shouldn't worry about
   what notifications are being created.
 * Also used the took_damage event to make enemies target their attacker.
 * Removed the ai_delay proc. To limit actions performed in a mob's ai() proc
   you can just use cooldowns. I updated the sample enemy and NPC AI to show
   how you can do this. This is better because the ai_delay() proc enforced a
   single delay on the entire ai proc. Using cooldowns lets you create limits
   for each specific action so that other parts of the ai() proc can still run
   uninterrupted. The ai_pause() and ai_play() procs still exist.

Version 2 (posted 05-25-2012)
 * Replaced the label() proc with the hud_label() and map_label() procs.
   These do almost the same thing but map_label uses pixel_z to offset the
   outline and hud_label() uses pixel_y.
 * Made projectiles pass through dense mobs if they cannot hit the mob.
 * Fixed a runtime error with the looting window that would occur if you
   pressed the space bar with no item selected.
 * Added support for equipment-based overlays. Call the mob's equipment()
   proc to create an overlay that will match their movement state (standing,
   moving, jumping, dead, etc.).
 * Added a dependency on the Forum_account.Overlays library. This is used
   to create the equipment overlays and to create the target marker (the
   circle under the mob you're targeting).
 * Added hud-shopkeeper.dm which defines the on-screen shopkeeper interface.
   There is an example of how to create a shopkeeper in demo\npcs.dm.
 * Added events.dm which contains procs that are called when certain events
   happen. Many of the procs do nothing or just output a notification to the
   player. These procs exist so you can override them to easily create or
   modify these events and notifications.
 * Added targeting. You can now press tab to cycle through nearby targets.
   When you attack, the melee_target() proc will return your targeted mob
   if they are within your melee range, otherwise it'll return the first
   mob within melee range. See player-targeting.dm for more details.
 * Changed how the all_melee_targets() proc works. It used to return a list
   of all targetable mobs in front of the player, now it uses obounds() so
   the direction you're facing doesn't matter. If you want to attack a mob
   in front, press tab until it is selected as your target.
 * Added a description var to the /Ability object and made the on-screen
   ability menu display descriptions of each ability.
 * Renamed some files: hud.dmi is now framework-hud.dmi and effects.dmi is
   now framework-effects.dmi.
 * Made the ability bar no longer add the "ability-button-" prefix to icon
   states automatically. Now the Ability object's icon_state is used the
   way it is.
 * When you press the 1-6 keys while the ability bar is active (after you've
   pressed A) the cursor will jump to that slot and open the ability menu.
 * Added the mob.line_of_sight() proc which takes an atom as a parameter and
   determines of the mob has line of sight to that atom. There's also the
   mob.los() proc which just calls line_of_sight().
 * Added the ShootArrow ability to the demo which uses the new line of sight
   proc and targeting feature.
 * Gave the /item type a constructor which can take a location, location and
   quantity, or just a quantity.
 * Added a crafting ability to the demo. This also required some additional
   helper procs. Some events were added to events.dm. I also added player-procs.dm
   which contains, for now, just the is_near proc.
 * Fixed a bug in the mob's get_quantity() proc.
 * Added the ability.icon var which is used to display the ability icons on
   the ability bar. By default it is set to the HUD_ICON constant, but you
   can change it so you can put your game-specific ability icons in an icon
   file inside your project.

Version 1 (posted 05-23-2012)
 * Initial version.

*/