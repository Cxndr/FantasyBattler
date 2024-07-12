enum phase {
	init,
	start_turn,
	wait,
	process,
	check_finish,
	end_turn,
	win,
	lose
}
combat_phase = phase.init;


enum action {
	init,
	select,
	cast_anim,
	cast,
	return_anim,
	report
}
action_phase = action.init;


// enemy party setup
enemy_party = ds_list_create();
ds_list_add(enemy_party, new enemy_slime());
ds_list_add(enemy_party, new enemy_slime());

// setup party objects
party_objects = ds_list_create();
eparty_objects = ds_list_create();
party_active = 0;
eparty_active = 0;

// floating combat damage sizes (get referenced by other objects) 
dmg_med = 10;
dmg_large = 50;
dmg_xl = 100;
dmg_xxl = 300;
dmg_xxxl = 1000;

// mechanical variables
current_sel = 0;
selecting = 0;
selected = 0;
sel_allies = 0;
last_sel_allies = sel_allies
enemy_length = ds_list_size(obj_eparty.eparty);
ally_length = ds_list_size(obj_party.party);
sel_sprite = spr_select;
sel_sprite_w = sprite_get_width(sel_sprite);
sel_sprite_h = sprite_get_height(sel_sprite);
draw_sfx = 0;
atk_no = 0;
resume = true;
choice = 0;
choice_drawn = 0;
target = self;
target_object = noone;
turn_no = 0;
whos_turn = 0; // 0 for player, 1 for enemy.
_spell = noone;
_skill = noone;



// settings
hero_y = room_height - 70;
hero_area_padding = 90;
hero_area_offset = 0;
enemy_y = room_height - 180;
enemy_area_padding = 90;
enemy_area_offset = 0;
sel_pad = 20; // selection padding
global.hp_bar_fcol = $53b184; //$70b153; 67c15b 81c15b 76b153 84b153
global.hp_bar_bcol = $242493; //$cc2222; 932424
global.mp_bar_fcol = $c8bb73; //$4fbed2; 63c0d1 83c9d5 54bdd0 74b5c1 73bbc8
global.mp_bar_bcol = $807b62; //$52868f; 386972 627b80

