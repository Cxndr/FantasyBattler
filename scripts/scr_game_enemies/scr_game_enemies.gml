	//------------- CLASSES ---------------//

// Main
function enemy() constructor {
	name = "";
	index = 0;
	description = "enemy not loaded";
	sprite = spr_enemy_0;
			
	max_hp = 100;
	max_mp = 20;
	hp = max_hp;
	mp = max_mp;
	
	STR = 20; // melee damage
	AIM = 20; // ranged damage
	MGC = 20; // magic damage
	DEF = 20; // defence/armor
	SPD = 20; // evasion and weapon strikes
	SPT = 20; // spirit (mana regen)]
	
	// mechanical variables
	dead = false;
	
}




	//------------- INDIVIDUAL ENEMIES ---------------//
	
	
// Slime
function enemy_slime() : enemy() constructor {
	name = "Slime";
	index = 1;
	description = "...";
	sprite = spr_enemy_1;
			
	max_hp = 50;
	max_mana = 20;
	hp = max_hp;
	mana = max_mana;
	
	hp = 30;
	mp = 12;
	
	STR = 1; // melee damage
	AIM = 1; // ranged damage
	MGC = 2; // magic damage
	DEF = 3; // defence/armor
	SPD = 1; // evasion and weapon strikes
	SPT = 1; // spirit (mana regen)
	
	skill_1 = 1;
	skill_2 = 0;
	
}

// Wyvern
function enemy_wyvern() : enemy() constructor {
	name = "Wyvern";
	index = 2;
	description = "...";
	sprite = spr_enemy_9;
			
	max_hp = 80;
	max_mana = 20;
	hp = max_hp;
	mana = max_mana;
	
	hp = 30;
	mp = 12;
	
	STR = 2; // melee damage
	AIM = 1; // ranged damage
	MGC = 2; // magic damage
	DEF = 1; // defence/armor
	SPD = 1; // evasion and weapon strikes
	SPT = 1; // spirit (mana regen)
	
	skill_1 = 1;
	skill_2 = 0;
	
}

// Bat
function enemy_bat() : enemy() constructor {
	name = "Bat";
	index = 3;
	description = "...";
	sprite = spr_enemy_8;
			
	max_hp = 300;
	max_mana = 20;
	hp = max_hp;
	mana = max_mana;
	
	STR = 2; // melee damage
	AIM = 1; // ranged damage
	MGC = 2; // magic damage
	DEF = 1; // defence/armor
	SPD = 1; // evasion and weapon strikes
	SPT = 1; // spirit (mana regen)
	
	skill_1 = 1;
	skill_2 = 0;
	
}