// set position
y -= mov_speed;

// set alpha
alpha -= (1/alpha_timer)


// draw text
ui_font_setup();


if damage > dmg_xxxl { draw_set_font(fnt_ui_xxxl); }
else if damage > dmg_xxl { draw_set_font(fnt_ui_xxl); }
else if damage > dmg_xl { draw_set_font(fnt_ui_xl); }
else if damage > dmg_large { draw_set_font(fnt_ui_large); }
else if damage > dmg_med { draw_set_font(fnt_ui_med); }
else { draw_set_font(fnt_ui_small); }


//draw_set_font(fnt_ui_xxl); // overwrites scaling based on damage
draw_set_alpha(alpha);
draw_set_color(c_yellow);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x,y,string(damage))


// destroy at 0 alpha
if alpha <= 0 {
	instance_destroy();
}