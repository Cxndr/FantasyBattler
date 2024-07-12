
/// ALL THIS IS TEMP CODE - NOT FINISHED!!!!!

function choose_target(type){
	
	switch (type) {
		
		// type 0 - enemy
		case 0:
			_enemies = obj_battle.enemy_party;
			_count = ds_list_size(_enemies);
			scr_text("Which enemy to target?");
			for (var i = 1; i < _count; i++) {
				_enemy = ds_list_find_value(_enemies,i);
				_name = _enemy.hp;
				scr_option(_name, "break", _enemy);
			}
			break;
	
		// type 1 - friendly
		
		
		// type 2 - any
		
	}
}


function use_skill(id,user,_target){

	if _target == undefined {
		
	} 
}