// output

sfx_anim_frame += anim_speed / room_speed; // animation play speed



switch (type) {


	case "attack":
	
		// destroy when anim ends
		if ( sfx_anim_frame >= array_length(sfx_anim) ) { 
			sfx_anim_frame = 0; 
			instance_destroy();
		}
		
		// end
		break;
		
		
	case "fireball":
	
		// looping anim
		if ( sfx_anim_frame >= array_length(sfx_anim) ) { 
			sfx_anim_frame = 0; 	
		}
		
		// move towards target
		if point_distance(x, y, target_x, target_y) > mov_speed {
			move_towards_point(target_x, target_y, mov_speed);
		}
		// destroy when hit target
		else {
			instance_destroy();	
		}
		
		// set image angle
		image_angle = point_direction(x,y,target_x, target_y) + 90;

		
		// end 
		break;

		
	case "pillar of flame":
	
		// destroy when anim ends
		if ( sfx_anim_frame >= array_length(sfx_anim) ) { 
			sfx_anim_frame = 0; 
			instance_destroy();
		}
		
		// end
		break;
		
		
	case "cure":
	
		// destroy when anim ends
		if ( sfx_anim_frame >= array_length(sfx_anim) ) { 
			sfx_anim_frame = 0; 
			instance_destroy();
		}
		
		// end
		break;

}

// final output
sfx_frame_output = sfx_anim[floor(sfx_anim_frame)];
draw_sprite_ext(sprite,sfx_frame_output,x, y + target_distance,scale_x,scale_y,image_angle,c_white,1);

// debug
if global.debug == true {
	debug_font_setup();
	draw_set_font(fnt_debug);
	draw_text(100,100,(string(sfx_anim_frame) + " -- " + string(sfx_anim[floor(sfx_anim_frame)])));
	draw_text(100,120,string(direction));
	draw_text(100,140,string(scale));
}