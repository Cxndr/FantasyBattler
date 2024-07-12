// incoming variables (just initialize, these are set on creation by obj_battle)
enemy_id = 0;
party_pos = 0;
me = obj_party.party[|party_pos]; // better to init to a 0 position party member than to leave empty


// mechanical variables
spell_distance = 30;


// settings
ui_direction = 1;
face_up = false;



// Inherit the parent event
event_inherited();


