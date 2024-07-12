if (ds_exists(enemy_party, ds_type_list)) {
	ds_list_destroy(enemy_party);
}

if (ds_exists(party_objects, ds_type_list)) {
	ds_list_destroy(party_objects);
}

if (ds_exists(eparty_objects, ds_type_list)) {
	ds_list_destroy(eparty_objects);
}
