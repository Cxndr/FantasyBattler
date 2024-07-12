
if global.inputs_disabled = false {
	
	if keyboard_check_pressed(vk_tab) {
		show_inventory = !show_inventory;
	}
	
	//-------------- TEST TRIGGERS -----------------//
	if keyboard_check_pressed(ord("S")) {
		inventory_remove_name("Cookie");
		//ds_list_add(inventory, new item_food_chickenleg());
	}
	if keyboard_check_pressed(ord("Q")) {
		inventory_remove_slot(3);

	}
	if keyboard_check_pressed(ord("1")) {
		inventory_add(new item_food_chickenleg());

	}
	if keyboard_check_pressed(ord("2")) {
		inventory_add(new item_food_steak());

	}
	if keyboard_check_pressed(ord("3")) {
		inventory_add(new item_food_cookie());

	}
	if keyboard_check_pressed(ord("4")) {
		inventory_add(new item_food_burger());

	}
	//------------------------------------------------
	
}

