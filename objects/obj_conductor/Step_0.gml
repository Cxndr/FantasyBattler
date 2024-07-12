if keyboard_check_pressed(vk_space){
	
	create_textbox("npc1");
	
}

// debug mode activate
if keyboard_check_pressed(vk_f1) {
	global.debug = !global.debug;
}