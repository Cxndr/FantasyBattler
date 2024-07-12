/// @description Insert description here
// You can write your code in this editor

// **************** debug *****************
/*
draw_set_font(fnt_text);
draw_text(200,20,"gui width: " + string(display_get_gui_width()));

draw_text(200,140,"option_pos: " + string(option_pos));
draw_text(200,160,"option_hovering: " + string(option_hovering));
draw_text(200,180,"shake_timer: " + string(shake_timer));

draw_text(200,220,"line_width: " + string(line_width));
draw_text(200,240,"textbox_width: " + string(textbox_width));
*/

// shorthand external variables
scale_factor = obj_camera.scale_factor;
screen_w = display_get_gui_width();
screen_h = display_get_gui_height();


// ***** Input & Init ****** //

if mouse_check_button_pressed(mb_left) && option_hovering == true {
	accept_click = true;	
}
else {
	accept_click = false;
}
accept_key = keyboard_check_pressed(vk_enter);

textbox_x = 0; //camera_get_view_x(view_camera[0] );
textbox_y = screen_h - textbox_height - (8 * scale_factor);

// offsets (set on incoming function that creates textbox object)
textbox_x = textbox_x + x_offset;
textbox_y = textbox_y + y_offset;


// ******** setup ********
if setup == false {
    setup = true;

    textbox_font_setup();
	// disable typing effect for centered text
	if centered == true {
		draw_char = text_length[page]
	}
        
    // loop through the pages
	for(var p = 0; p < page_number; p++) {
        
        // find how many characters are on each page and store that number in the 'text_length' array
        text_length[p] = string_length(text[p]);
        
        // get the x position for the textbox
		
            //character on the left
			text_x_offset[p] = textbox_height + ((6 + 8)*scale_factor) ;
			portrait_x_offset[p] = 8 * scale_factor;
			
			//character on the right
			if speaker_side[p] == -1 {
				
				text_x_offset[p] = 8 * scale_factor;
				portrait_x_offset[p] = textbox_width + ((8 + 6)*scale_factor);
			}
			
			// centered textbox
            if speaker_sprite[p] == noone {
				
				text_x_offset[p] = (screen_w - textbox_width)/2
			}
		
		
		// setting individual characters and finding where the lines of text should break
		for (var c = 0; c < text_length[p]; c++) {
			
			var _char_pos = c+1;
			
			// store individual characters in the "char" array
			char[c,p] = string_char_at(text[p], _char_pos);
			
			// get current width of the line
			var _txt_up_to_char = string_copy(text[p],1,_char_pos);
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c,p]);
			

										/* // - didn't work becuase we are not using \n to make line breaks, we are manually drawing them. but still a useful way to find line width for later maybe.
										// centered - get total width of the line	
										_line_end_pos = string_pos_ext("\n",text[p],_char_pos)
										if _line_end_pos = 0 { _line_end_pos = string_length(text[p]) } // if there is no /n found then use the end of string
			
										_line_start_pos = tmc_string_pos_last("\n", _txt_up_to_char);
										if _line_start_pos = 0 { _line_start_pos = 1; } // if there is no /n found then start from first character in string.
			
										var _string_line = string_copy(text[p], _line_start_pos, _line_end_pos - _line_start_pos);
										var _line_width = string_width(_string_line);
										*/
			
			
			// get the last free space
			if char[c,p] == " " { last_free_space = _char_pos+1; }
						
			
			// get the line breaks
			if _current_txt_w - line_break_offset[p] > line_width - padding {
			
				line_break_pos[line_break_num[p], p] = last_free_space;
				
				line_break_num[p]++;

				var _txt_up_to_last_space = string_copy(text[p], 1, last_free_space);
				var _last_free_space_string = string_char_at(text[p], last_free_space);
				line_break_offset[p] = string_width(_txt_up_to_last_space) - string_width(_last_free_space_string);	
			}
			
			
			
		
		}
		
		
		// getting each characters coordinates
		for (var c = 0; c < text_length[p]; c++) {
		
			var _char_pos = c+1;
			var _str_copy = text[p];


			// get current width of the line
			var _txt_up_to_char = string_copy(text[p],1,_char_pos);
			var _current_txt_w = string_width(_txt_up_to_char) - string_width(char[c,p]);
			
			var _txt_line = 0;
			
			
			// compensate for string breaks
			for (var lb = 0; lb < line_break_num[p]; lb++) {
			
				// if the current looping character is after a line break
				if _char_pos >= line_break_pos[lb,p] {
				
					_str_copy = string_copy(text[p], line_break_pos[lb,p], _char_pos - line_break_pos[lb,p]);  // this is how far along the line we are at current character - but we want the length of the entire current line
					_current_txt_w = string_width(_str_copy);
					

					// record the "line" this character should be on
					_txt_line = lb+1; // +1 since lb starts at 0
									
				
				}
				
			
				
			}
			
			// setup base positions
						/*		
						if centered == true {
				
							//var _line_string = string_copy(text[p], line_break_pos[0,p], line_break_pos[_txt_line,p]);
							//var _line_length = string_width(_line_string);
							//var _line_length = string_width(_current_txt_w);
							//show_message(string(_current_txt_w));
				
				

										
				
				
							var _txt_x = round((camera_get_view_width(view_camera[0]) / 2 ) - _line_width / 2); // replace 100 with the line width
							var _txt_y = textbox_y + textbox_height/2;				
						}
						else {
						*/
				var _txt_x = textbox_x + text_x_offset[p] + padding;
				var _txt_y = textbox_y + padding - padding_h_offset;
						//}
			
			
			
			// add to the x and y cordinates based on the positional info
			char_x[c,p] = _txt_x + _current_txt_w;
			char_y[c,p] = _txt_y + _txt_line*line_sep;
			
			
		
		}
		
		
	}
        
}


// ****** typing the text *********

if text_pause_timer <= 0  {
	
	
	
	if draw_char < text_length[page] {

	    draw_char += text_speed;
	    draw_char = clamp(draw_char,0,text_length[page]);
	
		var _check_char = string_char_at(text[page], draw_char);
		
		if !is_undefined(sound[page]) {
			
			if _check_char == "." || _check_char == "?" || _check_char == "!" || _check_char == "," {
				text_pause_timer = text_pause_time;
				if !audio_is_playing(sound[page]) {
					audio_play_sound(sound[page],8,false);
				}
			}
			else {
				// typing sound
				if sound_count < sound_delay {
					sound_count++;
				}
				else {
					sound_count = 0;
					audio_play_sound(sound[page],8,false);
				}
			}
			
		}
		
	}
	
	
	
} 
else if centered == true {
	text_pause_timer = text_pause_time;
}
else {
	text_pause_timer --;
}


// ***** flip through pages *******
if accept_key or accept_click {
    
	// ---- FOR CENTERED EFFECT ---- //
	if centered == true {
		//next page
		if page < page_number-1 {
			page++;
	    }
		//destroy text box
		else {
			create_textbox(center_link_id,x_offset,y_offset,textbox_height,textbox_width); //link text for center
			instance_destroy();
		}
			
	}
	
	// ---- FOR TYPING EFFECT ---- //
	else {
	    // if the typing is done
	    if draw_char == text_length[page]
	    {
	        // next page
	        if page < page_number-1 {
	            page++;
	            draw_char = 0;
	        }
	        // destroy text box
	        else {
				// link text for options
				if option_number > 0 {
					create_textbox(option_link_id[option_pos],x_offset,y_offset,textbox_height,textbox_width);
					
				}
	            instance_destroy();
			}
		}
	    // if not done typing 
	    else {
	        draw_char = text_length[page];
	    }  
	}
}



// ****** draw the textbox ******
var _textbox_x = textbox_x + text_x_offset[page];
var _textbox_y = textbox_y;
textbox_img += textbox_img_speed;
textbox_spr_w = sprite_get_width(textbox_spr[page]);
textbox_spr_h = sprite_get_height(textbox_spr[page]);

// draw the speaker 
if speaker_sprite[page] != noone {

	sprite_index = speaker_sprite[page];
	var _speaker_x = textbox_x + portrait_x_offset[page];
	//if speaker_side[page] == -1 {_speaker_x += (sprite_width*scale_factor)}; // don't need at 2x scale
	
	// draw the speaker
	draw_sprite_ext(textbox_spr[page], textbox_img, textbox_x + portrait_x_offset[page], textbox_y, (sprite_width*scale_factor)/textbox_spr_w, (sprite_width*scale_factor)/textbox_spr_h, 0, c_white,1);
	draw_sprite_ext(sprite_index, image_index, _speaker_x, textbox_y, 1*scale_factor, 1*scale_factor, 0, c_white, 1)
}

// back of the textbox
draw_sprite_ext(textbox_spr[page], textbox_img, _textbox_x, _textbox_y, textbox_width/textbox_spr_w, textbox_height/textbox_spr_h, 0, c_white, 1)

    
// ***** options *******
if draw_char == text_length[page] && page == page_number - 1 {
	
	// option selection
	option_pos += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	if keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up) != 0 { 
	}
	option_pos = clamp(option_pos, 0, option_number-1);
	
	
	// setup to disable mouse hover selection if keyboard pressed and mouse not moving
	if keyboard_check_pressed(vk_down) or keyboard_check_pressed(vk_up) {
		mouse_x_last = mouse_x;
		mouse_y_last = mouse_y;
	}
	
	
	// draw the options
	var _op_space_margin = 4;
	var _op_padding = 14;
//	var _op_padding_t = 1; // only affects text y.
	var _op_space = line_sep + (_op_padding);
	option_hovering = false;
	for (var op = 0; op < option_number; op++) {
	
		// setup
		textbox_font_setup();
		var _option_x = _textbox_x + arrow_w + _op_space_margin;
		var _option_y = _textbox_y - _op_space*option_number + _op_space*op;
		var _option_w = string_width(option[op]) + _op_padding + (_op_space_margin*2);
		var _option_h = (_op_space - _op_space_margin);
	
		// draw the option box
		draw_sprite_ext(textbox_spr[page], textbox_img, _option_x + _op_space_margin, _option_y, _option_w/textbox_spr_w, _option_h/textbox_spr_h, 0, c_white, 1);
		
		// draw option box hover selection
		if point_in_rectangle(mouse_x, mouse_y, _option_x, _option_y, _option_x + _option_w, _option_y + _option_h) && mouse_x_last != mouse_x && mouse_y_last != mouse_y {
			option_pos = op;
			option_hovering = true;
		}
		
		// draw the arrow
		if option_pos == op
		{
			draw_sprite(spr_textbox_arrow, 0, _textbox_x + _op_space_margin, _textbox_y - _op_space*option_number + (_op_space*op) + round((_option_h/2)) + round(_op_space_margin/2) - 1 );
		}
		
		// draw the option text
		draw_set_valign(fa_middle);
		draw_text(_option_x + _op_padding/2 + (_op_space_margin*2) , _textbox_y - _op_space*option_number + (_op_space*op) + round(_option_h/2) + round(_op_space_margin/2) - 1 , option[op] );
	}
	
	
}



// ******** draw the text ********

/* OLD METHOD
	var _drawtext = string_copy(text[page], 1, draw_char); 
	draw_text_ext(textbox_x + _textbox_x + padding, _textbox_y + padding, _drawtext, line_sep, line_width) 	
*/


// disable typing effect for centered text
if centered == true {
	draw_char = text_length[page]
}
//else {
		
//----------- FINAL DRAW  -------------//
textbox_font_setup();
for(var c = 0; c < draw_char; c++) {


	//-------- special effects ----------//
	
		// wavy text
		var _wavy_y = 0;
		if wavy_text[c, page] == true {
		
			wavy_dir[c, page] += -6; // wave speed
			_wavy_y = dsin(wavy_dir[c, page] ) * 2; // wave height
		}
		
		// shake text
		var _shake_x = 0;
		var _shake_y = 0;
		

		if shake_text[c, page] == true {
			//show_message(string(shake_timer));
			if shake_timer[c,page] > 1 {
				shake_timer[c,page] = shake_timer[c,page]-1;
			}
			if shake_timer[c,page] <= 1 { 
				shake_timer[c,page] = irandom_range(3,5);
				shake_dir[c,page] = irandom(360);
			}
			
		_shake_x = lengthdir_x(1, shake_dir[c,page]);
		_shake_y = lengthdir_y(1, shake_dir[c,page]);
			
		}
	
	
	// Draw Text
	if centered != true {
		// STANDARD DRAW
		draw_text_color(char_x[c,page] + _shake_x, char_y[c,page] + _wavy_y + _shake_y, char[c,page], col_1[c,page], col_2[c,page], col_3[c,page], col_4[c,page], 1);
	}
	
}
    
if centered == true {
	// CENTERED DRAW
	var _drawtext = text[page];
	draw_set_valign(fa_middle);
	draw_text_ext( screen_w/2, textbox_y + (textbox_height/2) , _drawtext, -1, line_width);
	//draw_text_ext( camera_get_view_width(view_camera[0])/2, textbox_y + (textbox_height/2) + ((string_height("W")/2)-1), _drawtext, line_sep, line_width);
}










////// ------- DEBUG ---------- /////

if global.debug == true {
	debug_font_setup();
	draw_set_font(fnt_debug);
	draw_set_halign(fa_left);
	draw_set_color(c_black);
	draw_text(300, 20, "option[]: " + string(option));
	//draw_text(300, 60, "option[] len: " + string(string_width(option[0])));
	//draw_text(300, 80, "option[] len: " + string(string_width(option[1])));

}




//}
    
/*
draw_line_color(0,textbox_y,900,textbox_y,c_lime,c_lime);
draw_line_color(0,_textbox_y,900,_textbox_y,c_yellow,c_yellow);
draw_text( 20, 20, "y:" + string(textbox_y) + " _y:" + string(_textbox_y) );
  */  
/*
    
//draw textbox
draw_sprite(spr_textbox, 0, x, y);

//draw text
draw_text_ext(x,y,text,stringHeight,boxWidth);

*/