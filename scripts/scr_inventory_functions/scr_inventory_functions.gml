// search inventory and return array id of result
function inventory_search_slot(item_slot) {

	for (var i = 0; i < INVENTORY_SLOTS; i += 1) {
		if (obj_inventory.inventory[i] == item_slot) {
			return(i);
		}
	}
	return(-1); // return -1 (empty slot) if nothing found
}



// search inventory and return array id of result
function inventory_search_name(item_name) {

	for (var i = 0; i < INVENTORY_SLOTS; i += 1) {
		if (obj_inventory.inventory[i][$ "name"] == item_name) {
			return(i);
		}
	}
	return(-1); // return -1 (empty slot) if nothing found
}



// remove a specific inventory slot
function inventory_remove_slot(inventory_slot) {

	var _slot = obj_inventory.inventory[inventory_slot];
	if (_slot != -1) { // -1 = empty slot
		obj_inventory.inventory[inventory_slot] = -1; // -1 = empty slot
		return true;
	}
	else return false;

}


// remove the first item that matches item_name
function inventory_remove_name(item_name) {

	var _slot = inventory_search_name(item_name);
	if (_slot != -1) { // -1 = empty slot
		obj_inventory.inventory[_slot] = -1; // -1 = empty slot
		return true;
	}
	else return false;

}


// add specific item to inventory (  use "new structname()" or "*slot* structname()"  )
function inventory_add(new_struct) {

	var _slot = inventory_search_slot(-1); // -1 = search for empty slot
	if (_slot != -1) {
		obj_inventory.inventory[_slot] = new_struct;
		return true;
	}
	else return false;
	
}

