if room = rm_items { show_inventory = true; }
else { show_inventory = false; }

if show_inventory = true {
	
	// draw background
	draw_sprite_stretched (
		spr_textbox_inventory,
		0,
		x - bg_border,
		y - bg_border,
		(bg_border*2) + row_length * (slot_size + slot_padding),
		(bg_border*2) + (((INVENTORY_SLOTS -1 ) div row_length ) +1 ) * (slot_size + slot_padding)
	);

	// draw items
	for (var i = 0; i < INVENTORY_SLOTS; i += 1) {
	
		var xx = x + (i mod row_length) * (slot_size + slot_padding) + 2;
		var yy = y + (i div row_length) * (slot_size + slot_padding) + 2;
		var _item = inventory[ i];
		draw_sprite(spr_inventory_slot, 0, xx, yy)
		if (inventory[i] != -1)
		{
			draw_sprite(_item.icon_sprite, _item.icon_index, xx, yy);
		}
	}

}






/*
// system for drawing via a ds_list - useful later if we need to create infinite slot inventory
// draw background
draw_sprite_stretched (
	spr_textbox_inventory,
	0,
	x - bg_border,
	y - bg_border,
	(bg_border*2) + row_length * (slot_size + slot_padding),
	(bg_border*2) + (((ds_list_size(inventory) -1 ) div row_length ) +1 ) * (slot_size + slot_padding)
);

// draw items
for (var i = 0; i < ds_list_size(inventory); i++) {
	
	var xx = x + (i mod row_length) * (slot_size + slot_padding) + 2;
	var yy = y + (i div row_length) * (slot_size + slot_padding) + 2;
	var _item = inventory[| i]
	draw_sprite(spr_inventory_slot, 0, xx, yy);
	
	draw_sprite(spr_items, _item.icon_index, xx, yy);

	
}
*/