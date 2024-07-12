//stay on top
depth = -9999

// functional variable


// parameters
textbox_width = 766; //362;
textbox_height = 150; //96;
padding = 24;
padding_h_offset = 4;
text_x_offset = [0];
line_sep = 30;
line_width = textbox_width - (padding*2);
text_speed = 1;
textbox_spr[0] = spr_textbox;
textbox_img = 0;
textbox_img_speed = 6/60;
arrow_w = sprite_get_width(spr_textbox_arrow);

text[0] = "";

centered[0] = false;

// mechanical variables
page = 0;
page_number = 0;
text[0] = "";
text_length[0] = string_length(text[0]);
char[0,0] = "";
char_x[0,0] = 0;
char_y[0,0] = 0;
draw_char = 0;
setup = false;
mouse_x_last = 0;
mouse_y_last = 0;
accept_click = false;
x_offset = 0;
y_offset = 0;

// options
option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_number = 0;
option_hovering = false;

// sound
sound_delay = 4;
sound_count = sound_delay;

// effects
set_defaults_for_text();
last_free_space = 0;
text_pause_timer = 0;
text_pause_time = 16;

// centered
centered = false;
center_link_id = 0;
