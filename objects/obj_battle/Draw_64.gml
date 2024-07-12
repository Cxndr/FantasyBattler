


// **** DRAW SELECTION ***

if selecting = 1 {
 
	// setup
	if sel_allies == 0 {
		sel_w = sprite_get_width(obj_battle.eparty_objects[|current_sel].sprite_index) * obj_camera.scale_factor;
		sel_h = sprite_get_height(obj_battle.eparty_objects[|current_sel].sprite_index) * obj_camera.scale_factor;	
		sel_x = obj_battle.eparty_objects[|current_sel].gui_x;
		sel_y = obj_battle.eparty_objects[|current_sel].gui_y - (sel_h/2);

	}
	else if sel_allies == 1 {
		sel_w = sprite_get_width(obj_battle.party_objects[|current_sel].sprite_index) * obj_camera.scale_factor;
		sel_h = sprite_get_height(obj_battle.party_objects[|current_sel].sprite_index) * obj_camera.scale_factor ;
		sel_x = obj_battle.party_objects[|current_sel].gui_x;
		sel_y = obj_battle.party_objects[|current_sel].gui_y - (sel_h);

	}

	// execute
	//show_message( "x: " + string(sel_x) + ", y: " + string(sel_y) + ", w: " + string(sel_w) + ", h: " + string(sel_h) )
	draw_sprite_ext(sel_sprite , image_index , sel_x - (sel_w/2) - sel_pad, sel_y - round(sel_pad/3.5), (sel_w + (sel_pad*2)) / sel_sprite_w , (sel_h + (sel_pad)) / sel_sprite_h  , 0 , c_white , 1 );

}



// debug stuff
if global.debug = true {
	debug_font_setup();
	draw_text(10, 10, "combat phase: " + string(combat_phase));
	draw_text(10, 30, "action phase: " + string(action_phase));
	draw_text(10, 50, "selecting: " + string(selecting));
	draw_text(10, 70, "sel_x: " + string(selecting));
	draw_text(10, 90, "choice: " + string(choice));
	draw_text(10,110, "turn no: " + string(turn_no));
	draw_text(10,130, "whos_turn: " + string(whos_turn));
	draw_text(10,150, "choice_drawn: " + string(choice_drawn));
	draw_text(10,170, "_spell: " + string(_spell));
	draw_text(10,190, "_skill: " + string(_skill));
	draw_sprite(spr_dbg_cross,image_index,target_object.x*obj_camera.scale_factor,target_object.y*obj_camera.scale_factor);
	
}