function create_sfx(_x, _y, _target_x, _target_y, _type) {

	switch (_type) {
	
	
	
		/// **** ATTACK 
		case "attack":
					
			// setup
			if draw_sfx = 0 {
				
				switch (atk_no) {
					case 0: _anim = [ 0,1,2,3,4,5,6 ]; break;
					case 1: _anim = [ 0,7,8,9,10,11,12 ]; break;
					case 2: _anim = [ 0,13,14,15,16,17,18 ]; break;
					case 3: _anim = [ 0,19,20,21,23,24 ]; break;
					default: _anim = [0]; break;
				}
				
				if _atks > 1 { _anim_speed_manip = 5 * _atks; } else { _anim_speed_manip = 0; }
				
				_sfx = instance_create_layer(_target_x,_target_y,"Instances_SFX", obj_sfx);
				with (_sfx) {
					type = _type;
					target_distance = 0;
					sprite = spr_sfx_weapon;
					sfx_anim = other._anim;
					target_x = _target_x;
					target_y = _target_y;
					anim_speed = anim_speed + other._anim_speed_manip;
				}
				draw_sfx = 1;
				atk_no += 1;
				if atk_no >= 4 { atk_no = 0 };
			}
					
			
			
			if !instance_exists(_sfx) { 
				draw_sfx = 0;
				return true; 
			}
			

		break;
			

		/// **** 
		
	
	
	
	
	
		/// **** FIREBALL
		case "fireball":
					
			// setup
			if draw_sfx = 0 {

				_anim = [ 0,1,2,3,2,1];
				
				// scale speed with damage
				if _dmg < 50 { _mov_speed = 3; }
				else if _dmg < 100 { _mov_speed = 4; }
				else if _dmg < 500 { _mov_speed = 5; }
				else if _dmg < 1000 { _mov_speed = 8; }
				else if _dmg < 3000 { _mov_speed = 10; }
				else { _mov_speed = 13; }

				_sfx = instance_create_layer(_x,_y,"Instances_SFX", obj_sfx);
				with (_sfx) {
					type = _type;
					target_distance = 0;
					mov_speed = other._mov_speed;
					sprite = spr_sfx_fire;
					sfx_anim = other._anim;
					target_x = _target_x;
					target_y = _target_y;
					anim_speed = 20;
					target_object = other.target_object;
					direction = point_direction(_x, _y, _target_x, _target_y);
				}
				
				draw_sfx = 1;
			}
					

			if !instance_exists(_sfx) { 
				draw_sfx = 0;
				return true; 
			}
			

		break;
			

		/// **** 
		
		
		
		
	
		/// **** PILLAR OF FLAME
		case "pillar of flame":
					
			// setup
			if draw_sfx = 0 {
				
				_anim = []
				for (var i = 10; i < 28; i += 1) { array_push(_anim, i); }

				// scale by damage
				if _dmg < 50 { _scale = 1.5; }
				else if _dmg < 100 { _scale = 2; }
				else if _dmg < 500 { _scale = 3; }
				else if _dmg < 1000 { _scale = 4; }
				else if _dmg < 3000 { _scale = 5; }
				else { _scale = 6; }
		
				// position
				_target_y = _target_y + (sprite_get_height(obj_battle.target_object.sprite_index)/2);

				_sfx = instance_create_layer(_target_x,_target_y,"Instances_SFX", obj_sfx);
				with (_sfx) {
					type = _type;
					target_distance = 0;
					sprite = spr_sfx_firepillar;
					sfx_anim = other._anim;
					target_x = _target_x;
					target_y = _target_y;
					anim_speed = 20;
					scale = other._scale;
					scale_x = scale;
					scale_y = scale;
				}
				
				draw_sfx = 1;
			}
					

			if !instance_exists(_sfx) { 
				draw_sfx = 0;
				return true; 
			}
			

		break;
			

		/// ****
		
		
		
		/// **** HEAL
		case "heal":
					
			// setup
			if draw_sfx = 0 {
				
				_anim = []
				for (var i = 0; i < 23; i += 1) { array_push(_anim, i); }

				// scale by damage
				if _dmg > -50 { _scale = 1.5; }
				else if _dmg > -100 { _scale = 2; }
				else if _dmg > -500 { _scale = 3; }
				else if _dmg > -1000 { _scale = 4; }
				else if _dmg > -3000 { _scale = 5; }
				else { _scale = 6; }
		
				// position
				_target_y = _target_y + (sprite_get_height(obj_battle.target_object.sprite_index)/2);

				_sfx = instance_create_layer(_target_x,_target_y,"Instances_SFX", obj_sfx);
				with (_sfx) {
					type = _type;
					target_distance = 0;
					sprite = spr_sfx_heal;
					sfx_anim = other._anim;
					target_x = _target_x;
					target_y = _target_y;
					anim_speed = 20;
					scale = other._scale;
					scale_x = scale;
					scale_y = scale;
				}
				
				draw_sfx = 1;
			}
					

			if !instance_exists(_sfx) { 
				draw_sfx = 0;
				return true; 
			}
			

		break;
			

		/// **** 
		
		
		
		
		
		
	
	}
	
	
	
}