
// incoming variables (just initialize, these are set on creation by obj_battle)
hero_id = 0;
party_pos = 0;
me = obj_eparty.eparty[|party_pos]; // better to init to a 0 position party member than to leave empty

// mechanical variables
spell_distance = -28;


// settings
ui_direction = 0;
face_up = true;

// Inherit the parent event
event_inherited();

