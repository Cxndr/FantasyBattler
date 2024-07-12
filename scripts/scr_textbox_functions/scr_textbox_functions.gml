function basic_font_setup() {
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fnt_debug);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

function debug_font_setup() {
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fnt_debug);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

function ui_font_setup() {
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fnt_ui_small);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

function textbox_font_setup() {

	if centered == true {
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_font(fnt_text_b);
		draw_set_valign(fa_middle); 
		draw_set_halign(fa_center);//(fa_center);		// MAKES NO DIFFERENCE WITH INDIVIDUAL CHARACTER DRAWING IMPLEMENTED!!!!
	}
	else {
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_font(fnt_text);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
	}
	
}


function set_defaults_for_text() {
	line_break_pos[0, page_number] = 999; // any value will work, has to be more than max chars.
	line_break_num[page_number] = 0;
	line_break_offset[page_number] = 0;

	// variables for individual characters
	for (var c = 0; c < 999; c++) {
	
		// colours
		col_1[c, page_number] = c_white;
		col_2[c, page_number] = c_white;
		col_3[c, page_number] = c_white;
		col_4[c, page_number] = c_white;
		
		// wavy text effect
		wavy_text[c, page_number] = 0;
		wavy_dir[c, page_number] = c*20; // c * seperation
		
		// shake text effect
		shake_text[c, page_number] = 0;
		shake_dir[c, page_number] = irandom(360);
		shake_timer[c,page_number] = irandom_range(1,6);//irandom_range(3,5);
	
	}
	
	textbox_spr[page_number] = spr_textbox;
	speaker_sprite[page_number] = noone;
	speaker_side[page_number] = 1;
	sound[page_number] = undefined // moved to text function (want to have no sound sometimes)
}





// --------------------- Text VFX -----------------//
/// @param 1st_char
/// @param last_char
/// @param col1
/// @param col2
/// @param col3
/// @param col4
function scr_text_color(_start, _end, _col1, _col2, _col3, _col4) {

	for (var c = _start; c <= _end; c++) {
	
		col_1[c, page_number-1] = _col1;
		col_2[c, page_number-1] = _col2;
		col_3[c, page_number-1] = _col3;
		col_4[c, page_number-1] = _col4;
		
	
	}

}




/// @param 1st_char
/// @param last_char
function scr_text_wavy(_start, _end) {

	for (var c = _start; c <= _end; c++) {
		wavy_text[c, page_number-1] = true;
		
	}

}



/// @param 1st_char
/// @param last_char
function scr_text_shake(_start, _end) {

	for (var c = _start; c <= _end; c++) {
		shake_text[c, page_number-1] = true;
		
	}

}


/// @param text
/// @param [link_id]
function scr_text_center(_text){

	centered = true;
	set_defaults_for_text();

	
	text[page_number] = _text;
	
	sound[page_number] = undefined; // - no sound (maybe add later?)
		
	// pass link - [portrait] MUST LINK OUT TO MOVE TO A NON CENTERED BOX!
	if argument_count > 1 {
		center_link_id = argument[1];
	}
	
	page_number++;

}

/// @param text
/// @param [portrait]
/// @param [sound]
/// @param [side]
function scr_text(_text){

	centered = false;
	set_defaults_for_text();

	text[page_number] = _text;
	
	sound[page_number] = snd_type_mid;
	
	// get character info - [portrait]
	if argument_count > 1 {
		
		switch(argument[1]) {
		
			case "char1":
				speaker_sprite[page_number] = spr_portrait_char1;
				sound[page_number] = snd_voice_mid;
				// anything else specific to speaker
				break;
			case "char2":
				speaker_sprite[page_number] = spr_portrait_char2;
				sound[page_number] = snd_voice_mid;
				break;
			case "char3":
				speaker_sprite[page_number] = spr_portrait_char3;
				sound[page_number] = snd_voice_mid;
				break;
		}
	}
	

	// which sound to play with - [sound]
	if argument_count > 2 {
	
		switch(argument[2]) {
		
			case "t_low":
				sound[page_number] = snd_type_low;
				break;
			
			case "t_mid":
				sound[page_number] = snd_type_mid;
				break;
				
			case "t_high":
				sound[page_number] = snd_type_high;
				break;
				
			case "v_low":
				sound[page_number] = snd_voice_low;
				break;
				
			case "v_mid":
				sound[page_number] = snd_voice_mid;
				break;
				
			case "v_high":
				sound[page_number] = snd_voice_high;
				break;
		
		}		
	}
		
	// side the character is on - [side]
	if argument_count > 3 {
		speaker_side[page_number] = argument[3];
	}
	
	page_number++;
}






/// @param option
/// @param link_id
function scr_option(_option, _link_id) {

	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	option_number++;
	
}





/// @param text_id
function create_textbox(_text_id, _x=0, _y=0, _h=0, _w=0) {

	//with(obj_textbox) { instance_destroy(); }
	with(instance_create_depth(0,0,-9999,obj_textbox)) {
		
		// optionals
		x_offset = _x;
		y_offset = _y;
		if _h != 0 { textbox_height = _h; }
		if _w != 0 { textbox_width = _w; }
		
		scr_game_text(_text_id);
			
	}
	//instance_create_depth(0,0,-9999,obj_textbox);

}


/// @param text_id
function create_textbox_battle_left(_text_id, height) {

	//with(obj_textbox) { instance_destroy(); }
	with(instance_create_depth(0,0,-9999,obj_textbox)) {
		x_offset = -86;
		y_offset = 112;
		
		scr_game_text(_text_id);
			
	}
	//instance_create_depth(0,0,-9999,obj_textbox);

}