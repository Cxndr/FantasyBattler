randomize();


// state machine for anims
enum state {
	idle,
	run_up,
	attack,
	cast,
	run_back,
	dead,
}
current_state = state.idle;

// get sizes for floating combat text
dmg_med = obj_battle.dmg_med;
dmg_large = obj_battle.dmg_large;
dmg_xl = obj_battle.dmg_xl;
dmg_xxl = obj_battle.dmg_xxl;
dmg_xxxl = obj_battle.dmg_xxxl;

// mechanical variables
anim_frame = random(3);
target_x = display_get_gui_width()/2;
target_y = display_get_gui_height()/2;
spr_w = sprite_get_width(sprite_index);
spr_h = sprite_get_height(sprite_index);
hit = false; // use to animate damage taken
hit_timer_reset = 4;
hit_timer = 0;
miss = false; // use for ?????
sfx_anim_frame = 0;
sfx_anim = [0];
draw_sfx = 0;
//spell_distance = 0; // this is set in obj_hero and obj_enemy, just initializing here.
run_distance = 40; // gets set in each skill
anim_speed = 9;
inc_damage = 0;
combo_damage = 0;
combo_meter_reset = 30;
combo_meter = 0;
dead = false;
randomize(); dead_turn = irandom(1);

enum reset {
	smooth,
	rand
}
reset_type = reset.smooth;


// settings
healthbar_h = 3;
right_pad = (2 * obj_camera.scale_factor)-1; // cut right side pixel off for healthbar (hero sprites are shifted 1 pixel to left because of even number pixel width)
bar_pad = 9;
txt_pad = 5;
ui_pad = 2;
txt_font = fnt_ui_tiny;
txt_size = font_get_size(fnt_ui_tiny);
run_speed = 5;

if ui_direction = 0 {
	hp_bar_y = bar_pad + ui_pad;
	hp_txt_y = bar_pad + ui_pad + txt_pad + healthbar_h;
	mp_bar_y = ((bar_pad*2)-1) + ui_pad + txt_pad + healthbar_h + txt_size;
	mp_txt_y = ((bar_pad*2)-1) + ui_pad + (txt_pad*2) + (healthbar_h*2)+ txt_size;
}
else {
	hp_bar_y = ui_pad + txt_pad + txt_size + healthbar_h;
	hp_txt_y = ui_pad + txt_size;
	mp_bar_y = (bar_pad-1) + ui_pad + (txt_pad*2) + (txt_size*2) + (healthbar_h*2);
	mp_txt_y = (bar_pad-1) + ui_pad + txt_pad + (txt_size*2) + healthbar_h;
}

