
// get inputs
up_key = keyboard_check_pressed(vk_up);
down_key = keyboard_check_pressed(vk_down);
accept_key = keyboard_check_pressed(vk_enter);

// store number of options in current menu
op_length = array_length(option[menu_level]);

// move through the menu
pos += down_key - up_key;
if pos >= op_length { pos = 0 };
if pos < 0 { pos = op_length -1 };


// using the options
if accept_key {
	
	var _sml = menu_level; // sml = start menu level - storing so we can reset
	
	switch(menu_level) {
		
		// pause menu
		case 0:
			switch(pos) {
				
				// start game
				case 0: room_goto(rm_battle); break;
				//case 0: room_goto_next(); break;
				// items
				case 1: room_goto(rm_items); break;
				// settings
				case 2:	menu_level = 1; break;
				// quit game
				case 3:	game_end();	break;
			}
			break;

		// settings
		case 1:
			switch(pos) {
				
				// window size
				case 0:
					
					break;
					
				// brightness
				case 1:
					
					break;
					
				// controls
				case 2:
					
					break;
					
				// back
				case 3:
					menu_level = 0;
					break;
				
			}
			break;
	}
	
	// set position back
	if _sml != menu_level { pos = 0 };
	
	// correct option length
	op_length = array_length(option[menu_level]);
	
}