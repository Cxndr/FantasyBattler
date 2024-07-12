
// Camera Placement (basic)

var camera_x = 0;
var camera_y = 0;


/*// Camera Placement (object tracking)
var camera_x = clamp (tracking_object.x - camera_show_width/2, 0, room_width - camera_show_width);
var camera_y = clamp (tracking_object.y - camera_show_height/2, 0, room_height - camera_show_height);
*/


/*// Scroll Speed on object tracking
var current_x = camera_get_view_x (view_camera[0]);
var current_y = camera_get_veiw_y (view_camera[0]);
var scroll_speed = 0.1;

camera_set_view_pos(view_camera[0],
							lerp (current_x, camera_x, scroll_speed),
							lerp (current_x, camera_x, scroll_speed)
							);

*/


// Scale Factor
if keyboard_check_direct(vk_control) && keyboard_check_pressed(vk_enter) {
	
	if scale_factor < 3 {
		scale_factor += 1;
	}
	else {
		scale_factor = 1;
	}
	
	// process
	window_set_size(camera_show_width*scale_factor,camera_show_height*scale_factor);
	surface_resize(application_surface,camera_show_width*scale_factor,camera_show_height*scale_factor)

	alarm[0] = 1;

	camera_set_view_size(view_camera[0], camera_show_width, camera_show_height);
	
}

// Fullscreen - Alt Tab
if keyboard_check_direct(vk_alt) && keyboard_check_pressed(vk_enter) {
	if (window_get_fullscreen() == true) {
		window_set_fullscreen(false);
	}
	else {
		window_set_fullscreen(true);	
	}
}


