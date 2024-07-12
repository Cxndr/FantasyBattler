

if show_toggle = 1 {

	//draw the options
	draw_set_font(fnt_text);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);

	// dynamically get width and height of menu (based on first menu item hieght)
	var _new_w = 0;
	for (var o = 0; o < op_length; o++) {
		var _op_w = string_width(option[menu_level,o]);
		_new_w = max(_new_w, _op_w);
	}
	width = _new_w + op_padding*2;
	height = op_padding*2 + string_height(option[0,0]) + ( (op_length-1) * op_space ) ;

	// center menu 
	x = ( camera_get_view_x(view_camera[0]) + ((camera_get_view_width(view_camera[0])/2)*obj_camera.scale_factor) - (width/2) );
	y = ( camera_get_view_y(view_camera[0]) + ((camera_get_view_height(view_camera[0])/2)*obj_camera.scale_factor) - (height/2) );
	//x = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0])/2) - (width/2);
	//y = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0])/2) - (height/2);
	
	// debug
	//draw_text(50,50,"camera x: " + string(camera_get_view_x(view_camera[0])) + "  camera w: " + string(camera_get_view_width(view_camera[0])) + "  width: " + string(width));


	//draw the menu background
	draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);



	for (var o = 0; o < op_length; o++) {
	
		var _c = c_white;
		if pos == o { _c = c_red };
		draw_text_color(x + op_padding, y + op_padding + op_space*o, option[menu_level,o], _c, _c, _c, _c, 1);
		
	}

}



