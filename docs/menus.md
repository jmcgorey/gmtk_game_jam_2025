# Menus

## Overview

Some of the menus (including the "Options" and "Credits" menus) are created in 
a way that they can be added on top of whichever scene instantiates them.  This
lets us sgement the menu display logic into the following responsibilities:
	
	Caller:
		- Instantiates menu scene and adds it to the scene tree
		- Listens for the "menu_closed" signal
		- queue_free's the menu scene instance
	
	Menu:
		- Does its work
		- Emits "menu_closed" signal when it is time to close

This way, rather than having the menus as their own standalone scenes, they can
appear on top of whatever scene we need them in.


## Future notes

Currently, the logic is separate for each menu type.  We could probably refactor
to have a base "Menu" scene that things like Pause, Options, Credits etc extend.
