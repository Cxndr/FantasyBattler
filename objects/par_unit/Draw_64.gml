// ---------- SETUP VARIABLES --------- //

// step - setup compensation for camera scaling if we want to use this to position based on instances.
gui_x = org_x * obj_camera.scale_factor;
gui_y = org_y * obj_camera.scale_factor;

// get sprite width & height
spr_w = sprite_get_width(sprite_index);
spr_h = sprite_get_height(sprite_index);

// create - setup compensation for camera scaling if we want to use this to position based on instances.
gui_spr_w = spr_w * obj_camera.scale_factor;
gui_spr_h = spr_h * obj_camera.scale_factor;

// set artificial width for ui elements (healthbar, stats)
if ui_direction = 0 {
	full_w = spr_w + 6;
}
else {
	full_w = spr_w + 6;
}
gui_full_w = full_w * obj_camera.scale_factor;







// ---------- DRAW HP & MP BAR --------- //

if dead == false {

	// draw hp - bar
	percent_hp = ( me.hp / me.max_hp ) * 100;
	if ui_direction = 0 {
		draw_healthbar( gui_x-(gui_full_w/2) , gui_y+hp_bar_y , gui_x+(gui_full_w/2)-right_pad , gui_y+hp_bar_y+healthbar_h ,  percent_hp , global.hp_bar_bcol , global.hp_bar_fcol , global.hp_bar_fcol , 0 , true , false)
	} 
	else {
		draw_healthbar( gui_x-(gui_full_w/2) , gui_y-(gui_spr_h/2)-hp_bar_y , gui_x+(gui_full_w/2)-right_pad , gui_y-(gui_spr_h/2)-hp_bar_y+healthbar_h ,  percent_hp , global.hp_bar_bcol , global.hp_bar_fcol , global.hp_bar_fcol , 0 , true , false)
	}	

	// draw hp - text
	ui_font_setup();
	draw_set_color(c_white);
	draw_set_font(txt_font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	if ui_direction = 0 {
		draw_text( gui_x-1 , gui_y+hp_txt_y , string(me.hp) + "/" + string(me.max_hp) );
	}
	else {
		draw_text( gui_x-1 , gui_y-(gui_spr_h/2)-hp_txt_y , string(me.hp) + "/" + string(me.max_hp) );
	}

	// draw mp - bar
	percent_mp = ( me.mp / me.max_mp ) * 100;
	if ui_direction = 0 {
		draw_healthbar( gui_x-(gui_full_w/2) , gui_y+mp_bar_y , gui_x+(gui_full_w/2)-right_pad , gui_y+mp_bar_y+healthbar_h ,  percent_mp , global.mp_bar_bcol , global.mp_bar_fcol , global.mp_bar_fcol , 0 , true , false)
	}
	else {
		draw_healthbar( gui_x-(gui_full_w/2) , gui_y-(gui_spr_h/2)-mp_bar_y , gui_x+(gui_full_w/2)-right_pad , gui_y-(gui_spr_h/2)-mp_bar_y+healthbar_h ,  percent_mp , global.mp_bar_bcol , global.mp_bar_fcol , global.mp_bar_fcol , 0 , true , false)
	}

	// draw mp - text
	ui_font_setup();
	draw_set_color(c_white);
	draw_set_font(txt_font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	if ui_direction = 0 {
		draw_text( gui_x-1 , gui_y+mp_txt_y , string(me.mp) + "/" + string(me.max_mp) );
	}
	else {
		draw_text( gui_x-1 , gui_y-(gui_spr_h/2)-mp_txt_y , string(me.mp) + "/" + string(me.max_mp) );
	}


}







// ---------- TAKING DAMAGE --------- //

// *** TAKE DAMAGE
if inc_damage > 0 {

	// draw floating battle text
	_text = instance_create_layer(gui_x,gui_y-(spr_h/2),"Instances_SFX", obj_fbt_dmg);
	with (_text) {
		damage = other.inc_damage;
	}
	
	// deduct damage
	me.hp = max(0,me.hp-inc_damage);
	
	// combo meter
	combo_damage += inc_damage
	combo_meter = combo_meter_reset;
	
	// reset
	inc_damage = 0;

}

// *** COMBO METER

// setup
_ctimer_x = gui_x - 55;
_ctimer_y = gui_y-(spr_h/2)-35;

// timer
if combo_meter > 0 { 
	combo_meter -= 1; 
}
else { 
	combo_damage = 0;
}
if combo_meter == 1 {
	_ftb_combo = instance_create_layer(_ctimer_x, _ctimer_y, "Instances_SFX", obj_fbt_combo)
	with (_ftb_combo) {
		damage = other.combo_damage;
	}	
}

// draw combo meter
if combo_meter > 0 {
	ui_font_setup();
	
	if combo_damage > dmg_xxxl { draw_set_font(fnt_ui_xxxl); }
	else if combo_damage > dmg_xxl { draw_set_font(fnt_ui_xxl); }
	else if combo_damage > dmg_xl { draw_set_font(fnt_ui_xl); }
	else if combo_damage > dmg_large { draw_set_font(fnt_ui_large); }
	else if combo_damage > dmg_med { draw_set_font(fnt_ui_med); }
	else { draw_set_font(fnt_ui_small); }
	
	//draw_set_font(fnt_ui_xxl); // overwrites damage scaling size
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_yellow);
	draw_text(_ctimer_x, _ctimer_y, string(combo_damage) );

}






// ------- DEBUG ON SPRITE ------- // 
if global.debug == true {
	debug_font_setup();
	draw_set_color(c_black);
	draw_set_font(fnt_debug);
	draw_set_halign(fa_middle);
	draw_set_valign(fa_top);
	draw_text(gui_x, gui_y-20, "state: " + string(current_state));
	draw_text(gui_x + 40, gui_y -100, "combo_meter: " + string(combo_meter) + "\n combo_damage: " + string(combo_damage) )
	
	draw_sprite(spr_dbg_cross,image_index,gui_x,gui_y);
	draw_sprite(spr_dbg_cross2,image_index,org_x*obj_camera.scale_factor,org_y*obj_camera.scale_factor);
	//draw_text(gui_x,gui_y+100,"healthbar top: " + string(gui_y - hp_bar_y) + "\n healthbar bot" + string(gui_y - hp_bar_y - healthbar_h) + "\n object: " + string(object_get_name) + "\n  ui direction: " + string(ui_direction));
	//draw_text(gui_x+100,gui_y+10, "x:" + string(x) + " y:" + string(y) + "\n org_x:" + string(org_x) + "\n org_y:" + string(org_y) + "\n gui_x:" + string(gui_x) + "\n gui_y:" + string(gui_y) + "\n spr_h:" + string(sprite_get_height(sprite_index)) + " spr_w:" + string(sprite_get_width(sprite_index)));
	//draw_text(gui_x, gui_y-80, " current state: " + string(current_state) + "\n frame_output: " + string(frame_output));
	//draw_text_ext(gui_x, gui_y-80, "target: " + string(target),14,800);
	
}