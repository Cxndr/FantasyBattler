

switch(combat_phase){




	/// *** INIT
	case phase.init:

		// Spawn Party
		party = obj_party.party;
		party_size = ds_list_size(party);
		split_size = ( room_width - (hero_area_padding*2) - abs(hero_area_offset) ) / party_size;
		ds_list_clear(party_objects);
		for (var i = 0; i < party_size; i++) {
			_sprite = party[|i].sprite;
			_x = (split_size*(i+1))-(split_size/2) + hero_area_offset + hero_area_padding;
			_hero = instance_create_layer(_x,hero_y,"Instances_Units", obj_hero);
			ds_list_add(party_objects,_hero);
			with (_hero) {
				hero_id = other.party[|i].index;
				party_pos = i;
				org_x = other._x;
				org_y = other.hero_y;
				sprite_index = other._sprite;
				me = obj_party.party[|party_pos];
			}
		}
		
		// Spawn Enemies
		eparty = obj_eparty.eparty;
		eparty_size = ds_list_size(eparty);
		split_size = ( room_width - (enemy_area_padding*2) - abs(enemy_area_offset) ) / eparty_size;
		ds_list_clear(eparty_objects);
		for (var i = 0; i < eparty_size; i++) {
			_sprite = eparty[|i].sprite;
			_x = (split_size*(i+1))-(split_size/2) + enemy_area_offset + enemy_area_padding;
			_enemy = instance_create_layer(_x,enemy_y,"Instances_Units", obj_enemy);
			ds_list_add(eparty_objects,_enemy);
			target_object = _enemy;
			with (_enemy) {
				enemy_id = other.eparty[|i].index;
				party_pos = i;
				org_x = other._x;
				org_y = other.enemy_y;
				sprite_index = other._sprite;
				me = obj_eparty.eparty[|party_pos];

			}
		} 
	
		// exit
		combat_phase = phase.start_turn;
	break; 
	
	
	
	
	
	
	/// *** START TURN
	case phase.start_turn: 
	
		turn_no += 1;
		choice = 0;
		_spell = false;
		
		combat_phase = phase.wait;
		
	break;
	




	
	/// *** WAIT
	case phase.wait:
		// draw options and set "choice" variable, target variable and any others needed in option selection return
		
		// Draw Options
		switch (choice) {
			
			case 0: // ask for option
				if choice_drawn < 1 {
					create_textbox_battle_left("battle_action1");
					choice_drawn = 1;
				}
				
			break;
				
				
			case 1: // attack
				combat_phase = phase.process;
				
			break;
			
			
			case 2: // skill
				combat_phase = phase.process;
				
			break;
			
			
		}
	break;


	/// *** PROCESS
	case phase.process:
		if party[|party_active].dead == true { combat_phase = phase.check_finish; break; }
		
		// use choice variable to choose which action we're doing
		switch (choice) {
		
			case 1: // CHOICE 1 - ATTACK
				_spell = cast_spell("Attack");
				if _spell == true {
					combat_phase = phase.check_finish;
				}
			break;
			
			case 2: // CHOICE 2 - SKILL
				_spell = cast_spell(_skill);
				if _spell == true {
					combat_phase = phase.check_finish;
				}
			break;
			
			
		}
		break;
	

	
	
	
	/// *** CHECK FINISH
	case phase.check_finish: 
	
	
		// check for win
		ep_hp = 0;
		for (i=0; i < enemy_length; i++) { ep_hp += eparty[|i].hp; }
		if ep_hp <= 0 { combat_phase = phase.win; break;}
		
		// check for loss
		p_hp = 0;
		for (i=0; i < ally_length; i++) { p_hp += party[|i].hp }
		if p_hp <= 0 { combat_phase = phase.lose; break;}
	
		// reset stuff
		action_phase = action.init;
		selected = 0;
		selecting = 0;
		choice = 0;
			// reset selection if selected unit dies
		if sel_allies == 1 and party[|current_sel].dead == true {
			current_sel = 0;
			//if current_sel >= ally_length { current_sel = 0; }
			//if current_sel < 0 { current_sel = ally_length -1; }
			while party[|current_sel].dead == true { current_sel += 1; }
		}
		else if sel_allies == 0 and eparty[|current_sel].dead == true {
			current_sel = 0;
			//if current_sel >= ally_length { current_sel = 0; }
			//if current_sel < 0 { current_sel = ally_length -1; }
			while eparty[|current_sel].dead == true { current_sel += 1; }
		}
	
	
		// move active_player and check for turn end
		if whos_turn == 0 {
			party_active += 1;
			if party_active >= ally_length-1 { party_active = 0; }
			while (party[|party_active].dead == true) { party_active += 1; }
			if party_active >= ally_length-1 {
				whos_turn = 1;
				combat_phase = phase.end_turn;
			}
		}
		else {
			eparty_active += 1;
			if eparty_active >= enemy_length-1 { eparty_active = 0; }
			while (eparty[|eparty_active].dead == true) { eparty_active += 1; }
			if eparty_active >= enemy_length-1 {
				eparty_active = 0;
				whos_turn = 0;
				combat_phase = phase.end_turn;
			}
		}
		
		// go to next party member if every check fails
		combat_phase = phase.end_turn;

	break;
		
		
		
		
	/// *** END TURN
	case phase.end_turn:
		choice_drawn = 0;
		combat_phase = phase.start_turn;
	break;
		
		
		
		
	
	/// *** BATTLE WIN
	case phase.win: 
	break;
	
	
	
	
	/// *** BATTLE LOSE
	case phase.lose: 
	break;


}