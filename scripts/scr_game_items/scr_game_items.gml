	//------------- CLASSES ---------------//

// Main
function item() constructor {
	name = "";
	description = "item not loaded";
	flavour = "whoops";
	icon_sprite = spr_items;
	icon_index = 0;
	buy_price = 0;
	
	sell_price = round(buy_price/5) * 5; // round to nearest 5
	
}

// Item Types
function item_food() : item() constructor {
	hp_restore = 0;
}

function item_weapon() : item() constructor {
	wpn_speed = 1;
	wpn_dmg = 0;
}





	//------------- INDIVIDUAL ITEMS ---------------//

// Food
function item_food_chickenleg() : item_food () constructor {
	name = "Chicken Leg";
	description = "Restores 150hp.";
	flavour = "If you hold it upright it becomes a meat ice-cream.";
	icon_sprite = spr_items;
	icon_index = 1;
	buy_price = 0;
	
	hp_restore = 150;
}

function item_food_steak() : item_food () constructor {
	name = "Steak";
	description = "Restores 500 hp.";
	flavour = "It's a steak";
	icon_sprite = spr_items;
	icon_index = 2;
	buy_price = 0;
	
	hp_restore = 500;
}

function item_food_cookie() : item_food () constructor {
	name = "Cookie";
	description = "Restores 120 hp.";
	flavour = "It's a cookie";
	icon_sprite = spr_items;
	icon_index = 3;
	buy_price = 0;
	
	hp_restore = 120;
}

function item_food_burger() : item_food () constructor {
	name = "Burger";
	description = "Restores 120 hp.";
	flavour = "It's a Ham Burger";
	icon_sprite = spr_items;
	icon_index = 4;
	buy_price = 0;
	
	hp_restore = 700;
}

// Weapons