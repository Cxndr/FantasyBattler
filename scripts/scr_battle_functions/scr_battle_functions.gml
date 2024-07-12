

function ally_length_alive() {
	_count = 0;
	for (i=0; i < ally_length; i++) { 
		if party[|i].dead == false { 
			_count += 1;
		}
	}
	return _count;
}


function enemy_length_alive() {
	_count = 0;
	for (i=0; i < enemy_length; i++) {
		if eparty[|i].dead == false { 
			_count += 1;
		}
	}
	return _count;
}


function select_target(_type) {

	// setup
	selecting = 1;
	selected = 0;

	// inputs
	key_left = keyboard_check_pressed(vk_left);
	key_right = keyboard_check_pressed(vk_right);
	key_up = keyboard_check_pressed(vk_up);
	key_down = keyboard_check_pressed(vk_down);
	key_accept = keyboard_check_pressed(vk_enter);
	
	
	switch (_type) {
	
		case "any":

			// --- SELECTING
			if selected == 0 {
				
				// Switch Between Enemys & Allies.
				sel_allies += (key_up - key_down);
				if sel_allies >= 2 { sel_allies = 0; }
				if sel_allies < 0 { sel_allies = 1; }
				if sel_allies != last_sel_allies {
					if sel_allies == 0 {
						if current_sel >= enemy_length { current_sel = enemy_length-1; }
						while obj_battle.eparty[|current_sel].dead == true { current_sel += 1; if current_sel >= enemy_length { current_sel = 0; } }
					}
					else if sel_allies == 1 {
						if current_sel >= ally_length { current_sel = ally_length-1; }
						while obj_battle.party[|current_sel].dead == true { current_sel += 1; if current_sel >= ally_length { current_sel = 0; } }
					}
				}
				
				// Move Left & Right
				if sel_allies == 0  {
					if enemy_length_alive() > 1 and (key_right - key_left) != 0 { current_sel += (key_right - key_left); };
					if current_sel >= enemy_length { current_sel = 0; }
					if current_sel < 0 { current_sel = enemy_length-1; }
					while obj_battle.eparty[|current_sel].dead == true { current_sel += (key_right - key_left); if current_sel >= enemy_length { current_sel = 0; } }
				}
				else if sel_allies == 1  {
					if ally_length_alive() > 1 and (key_right - key_left) != 0 { current_sel += (key_right - key_left); }
					if current_sel >= ally_length { current_sel = 0; }
					if current_sel < 0 { current_sel = ally_length -1; }
					while obj_battle.party[|current_sel].dead == true { current_sel += (key_right - key_left); if current_sel >= ally_length { current_sel = 0; } }
				}
				
				// set *last* variables
				last_sel_allies = sel_allies;
				
				// Choose Selection
				if sel_allies == 0 && key_accept {
					obj_battle.target = obj_battle.eparty[|current_sel];
					obj_battle.target_object = obj_battle.eparty_objects[|current_sel];
					//show_message(string(obj_battle.eparty[|current_sel]));
					//show_message(string(obj_battle.target));
					//show_message(string(obj_battle.target_object));
					selected = 1;
					selecting = 0;
					return true;
				}
				else if sel_allies == 1 && key_accept {
					obj_battle.target = obj_party.party[|current_sel];
					obj_battle.target_object = obj_battle.party_objects[|current_sel];
					selecting = 0;
					selected = 1;
					
					return true;
				}
			
			} // selecting end
			
			break;
			
			
			
	} // switch end
	
} // function end



function cast_spell(_type) {

// shorthands
user = obj_party.party[|obj_battle.party_active];
user_object = obj_battle.party_objects[|obj_battle.party_active];
user_x = obj_battle.user_object.x;
user_y = obj_battle.user_object.y;
target = obj_battle.target;
target_object = obj_battle.target_object;
target_x = obj_battle.target_object.x;
target_y = obj_battle.target_object.y;
total_spd = user.SPD + user.wpn_spd;
total_str = user.STR + user.wpn_dmg;
total_aim = user.AIM + user.wpn_dmg;
total_mgc = user.MGC;

/*
	init,
	select,
	cast_anim,
	cast
	return_anim,
	report
*/

	switch (_type) {
	
	
	
		case "Attack":
			switch (action_phase) {
				
				// INIT
				case action.init:
					// calculate attacks
					_atks = total_spd;
					
					// calculate damage
					_dmg = total_str;
					action_phase = action.select;
				break;
				
				// SELECT TARGETS
				case action.select:
					if select_target("any") == true {
						resume = false;
						action_phase = action.cast_anim;

					}
				break;
					
				// CAST ANIM (RUN UP)
				case action.cast_anim:
					if resume = false {
						user_object.current_state = state.run_up;
						user_object.run_distance = 30;
					}
					else {
						user_object.current_state = state.attack;
						action_phase = action.cast
					}
				break;
				
				// CAST
				case action.cast:
					// execute hits
					if _atks > 0 {
						if random(10) + (user.SPD - target.SPD) < 5  {
							if create_sfx(user_x,user_y,target_x,target_y,"miss") == true and resume == true {
								target_object.miss = true;
								_atks -= 1;
							}
						}
						else {
							if create_sfx(user_x,user_y,target_x,target_y,"attack") == true and resume == true {
								target_object.hit = true;
								target_object.inc_damage = _dmg;
								_atks -= 1;
							}
						}
					} 
					else {
						resume = false;
						action_phase = action.return_anim;
					}
				break;
					
				// sfx
				// attack anim
				// effect
				
				// RETURN ANIM
				case action.return_anim:
					if resume = false {
						user_object.current_state = state.run_back;
					}
					else {
						user_object.current_state = state.idle;
						action_phase = action.report;
					}
				break;
				
				// REPORT
				case action.report:
					//create_textbox("battle_action_atk2");
					action_phase = action.init;
					return true;
				break;
				
			}
		break;
		
		
		
		
		
		
		case "Fireball":
			switch (action_phase) {
				
				// INIT
				case action.init:
				
					// calculate attacks
					_atks = 1;
					
					// calculate damage
					_dmg = total_mgc * 1.5;
					action_phase = action.select;
					
				break;
				
				// SELECT TARGETS
				case action.select:
					if select_target("any") == true {
						resume = false;
						action_phase = action.cast_anim;

					}
				break;
					
				// CAST ANIM (RUN UP)
				case action.cast_anim:
					if resume = false {
						user_object.current_state = state.run_up;
						user_object.run_distance = 15;
					}
					else {
						user_object.current_state = state.attack;
						action_phase = action.cast
					}
				break;
				
				// CAST
				case action.cast:
				
					// execute hits
					if _atks > 0 {
						if random(20) + (user.SPD - target.SPD) < 3  {
							if create_sfx(user_x,user_y + user_object.spell_distance,target_x,target_y,"fireball_miss") == true and resume == true {
								target_object.miss = true;
								_atks -= 1;
							}
						}
						else {
							//show_message(string(user_object.spell_distance));
							if create_sfx(user_x,user_y + user_object.spell_distance,target_x,target_y,"fireball") == true and resume == true {
								target_object.hit = true;
								target_object.inc_damage = _dmg;
								_atks -= 1;
							}
						}
					} 
					else {
						resume = false;
						action_phase = action.return_anim;
					}
				break;
					
				// sfx
				// attack anim
				// effect

				// RETURN ANIM
				case action.return_anim:
					if resume = false {
						user_object.current_state = state.run_back;
					}
					else {
						user_object.current_state = state.idle;
						action_phase = action.report;
					}
				break;
				
				// REPORT
				case action.report:
					//create_textbox("battle_action_atk2");
					action_phase = action.init;
					return true;
				break;
			}
		break;
		
		
		
		
		
		case "Pillar of Flame":
			switch (action_phase) {
				
				// INIT
				case action.init:
				
					// calculate attacks
					_atks = 1;
					
					// calculate damage
					_dmg = total_mgc * 1.5;
					action_phase = action.select;
					
				break;
				
				// SELECT TARGETS
				case action.select:
					if select_target("any") == true {
						resume = false;
						action_phase = action.cast_anim;
					}
				break;
					
				// CAST ANIM (RUN UP)
				case action.cast_anim:
					if resume = false {
						user_object.current_state = state.run_up;
						user_object.run_distance = 15;
					}
					else {
						user_object.current_state = state.attack;
						action_phase = action.cast
					}
				break;
				
				// CAST
				case action.cast:
				
					// execute hits
					if _atks > 0 {
						if random(20) + (user.SPD - target.SPD) < 3  {
							if create_sfx(user_x,user_y + user_object.spell_distance,target_x,target_y,"miss") == true and resume == true {
								target_object.miss = true;
								_atks -= 1;
							}
						}
						else {
							//show_message(string(user_object.spell_distance));
							if create_sfx(user_x,user_y + user_object.spell_distance,target_x,target_y,"pillar of flame") == true and resume == true {
								target_object.hit = true;
								target_object.inc_damage = _dmg;
								_atks -= 1;
							}
						}
					} 
					else {
						resume = false;
						action_phase = action.return_anim;
					}
				break;
					
				// sfx
				// attack anim
				// effect

				// RETURN ANIM
				case action.return_anim:
					if resume = false {
						user_object.current_state = state.run_back;
					}
					else {
						user_object.current_state = state.idle;
						action_phase = action.report;
					}
				break;
				
				// REPORT
				case action.report:
					//create_textbox("battle_action_atk2");
					action_phase = action.init;
					return true;
				break;
			}
		break;
		
		
		
		
		
		
		case "Cure":
			switch (action_phase) {
				
				// INIT
				case action.init:
				
					// calculate attacks
					_atks = 1;
					
					// calculate damage
					_dmg = total_mgc * 1.5;
					action_phase = action.select;
					
				break;
				
				// SELECT TARGETS
				case action.select:
					if select_target("any") == true {
						resume = false;
						action_phase = action.cast_anim;
					}
				break;
					
				// CAST ANIM (RUN UP)
				case action.cast_anim:
					if resume = false {
						user_object.current_state = state.run_up;
						user_object.run_distance = 15;
					}
					else {
						user_object.current_state = state.attack;
						action_phase = action.cast
					}
				break;
				
				// CAST
				case action.cast:
				
					// execute hits
					if _atks > 0 {
						if random(20) + (user.SPD - target.SPD) < 3  {
							if create_sfx(user_x,user_y + user_object.spell_distance,target_x,target_y,"miss") == true and resume == true {
								target_object.miss = true;
								_atks -= 1;
							}
						}
						else {
							//show_message(string(user_object.spell_distance));
							if create_sfx(user_x,user_y + user_object.spell_distance,target_x,target_y,"cure") == true and resume == true {
								target_object.hit = true;
								target_object.inc_damage = -_dmg;
								_atks -= 1;
							}
						}
					} 
					else {
						resume = false;
						action_phase = action.return_anim;
					}
				break;
					
				// sfx
				// attack anim
				// effect

				// RETURN ANIM
				case action.return_anim:
					if resume = false {
						user_object.current_state = state.run_back;
					}
					else {
						user_object.current_state = state.idle;
						action_phase = action.report;
					}
				break;
				
				// REPORT
				case action.report:
					//create_textbox("battle_action_atk2");
					action_phase = action.init;
					return true;
				break;
			}
		break;
		
		
		
		
		
		
		
		

	}

}






/* old method for adding to list
// --- SETUP
if setup = 0 {
	// add enemies
	for (var i; i < ds_list_size(obj_eparty.eparty); i++) {

	}
			
	// add friendlies
	for (var i; i < ds_list_size(obj_party.party); i++) {
		if obj_party.party[|i] != obj_battle.party_active {
			ds_list_add(target_options,obj_party.party[|i]);
		}
	}
			
	// ---- END SETUP
	setup = 1;
}
*/