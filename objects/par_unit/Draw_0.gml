

/// --------- ANIMATIONS --------- ///


// ******* SETUP AND MOVE WITH STATES ******** //
switch(current_state) {


	/// *** IDLE
	case state.idle:
	
			// setup
		anim_speed = 20;
		reset_type = reset.rand;
		if me.hp < (me.max_hp * 0.3) { anim = [ 12,12,12,13,12,12 ]; } // animation frames 
		else { anim = [ 12,12,12,12,12,13,12,12 ]; } // animation frames
	
	break;
	
	/// *** RUN UP
	case state.run_up:

		// setup
		anim_speed = 10;
		reset_type = reset.smooth;
		if face_up = true { 
			end_y = org_y - run_distance;
			anim = [ 9,10,11,10 ];
		}
		else { 
			end_y = org_y + run_distance; 
			anim = [ 0,1,2,1 ];
		}

		// move
		if point_distance(x, y, org_x, end_y) > run_speed {
			move_towards_point(org_x, end_y, run_speed);
		}
		else { // exit
			speed = 0;
			obj_battle.resume = true;
			anim = [ 11 ];
		}
		
	break;
		
		
		
	/// *** RUN BACK
	case state.run_back:
		
		// setup
		anim_speed = 10;
		reset_type = reset.smooth;
		if face_up = true { 
			anim = [ 0,1,2,1 ];
		}
		else {
			anim = [ 9,10,11,10 ];
		}
		// move
		if point_distance(x, y, org_x, org_y) > run_speed {
			move_towards_point(org_x, org_y, run_speed); 
		}
		else { //exit
			x = org_x;
			y = org_y;
			speed = 0;
			obj_battle.resume = true;
			current_state = state.idle;
		}

	break;

		
	/// *** ATTACK
	case state.attack:
		anim_speed = 10;
		reset_type = reset.smooth;
		if face_up = true {
			anim = [ 11 ];
		}
		else {
			anim = [ 2 ];
		}
		speed = 0;
	
	break;
	
	
	/// *** CAST
	

	
	
	/// *** DEAD
	case state.dead:
		anim_speed = 10;
		reset_type = reset.smooth;
		if dead_turn == 0 { anim = [18]; } else { anim = [20]; }
		speed = 0;
		

}


// ******* EXECUTE ANIMATION FRAMES ******** //

	// set play speed
anim_frame += anim_speed / room_speed;
		
	// reset
if reset_type == reset.smooth {
	if (anim_frame >= array_length(anim) ) { anim_frame = 0; }
}
else if reset_type == reset.rand {
	if (anim_frame >= array_length(anim) - round(random(2)) ) { anim_frame = 0; }	
}

	// final output
frame_output = anim[floor(anim_frame)];
image_index = frame_output;





/// --------- DRAWING SPRITE --------- ///

// hit animation
if hit == true { hit_timer = hit_timer_reset; hit = false;}
if hit_timer > 0 {
	shader_set(shdr_flash_white);
	hit_timer -= 1;
}

// final draw
draw_self();

// shader reset
shader_reset();







// ----------- DEBUG ----------- //
