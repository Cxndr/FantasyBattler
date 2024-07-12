#macro INVENTORY_SLOTS 15

inventory = array_create(INVENTORY_SLOTS, -1);

randomize();

// functional variables
show_inventory = true;

// visual settings
row_length = 6;
slot_size = 16;
slot_padding = 2;
bg_border = 6;

// 1st time setup
inventory_add(new item_food_chickenleg());
inventory_add(new item_food_chickenleg());
inventory_add(new item_food_chickenleg());
inventory_add(new item_food_chickenleg());

