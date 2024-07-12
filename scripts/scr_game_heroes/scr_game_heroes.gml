	//------------- CLASSES ---------------//

// Main
function hero() constructor {
	
	name = "";
	index = 0;
	class = "";
	description = "";
	sprite = spr_hero_0;
		
	max_hp = 100;
	max_mp = 20;
	hp = max_hp;
	mp = max_mp;
	
	// weapon speed
	// weapon damage
	// gem that gives def lowers speed and vice versa
	
	STR = 20; // melee damage
	AIM = 20; // ranged damage
	MGC = 20; // magic damage
	DEF = 20; // defence/armor
	SPD = 20; // evasion and weapon strikes
	SPT = 20; // spirit (mana regen)
	
	wpn_type = "sword";
	wpn_dmg = 4;
	wpn_spd = 1;
	
	skill_1 = "Fireball";
	skill_2 = "Pillar of Flame";
	skill_3 = "Heal";
	
	// mechanical variables
	dead = false;
	
}


	//------------- INDIVIDUAL HEROES ---------------//

// ROKO HANS
function hero_roko() : hero() constructor {
	
	name = "Roko Hans";
	index = 1;
	description = "";
	sprite = spr_hero_1;
		
	max_hp = 100;
	max_mp = 100;
	hp = max_hp;
	mp = max_mp;
	hp = 50;
	mp = 20;
	
	// weapon speed
	// weapon damage
	// gem that gives def lowers speed and vice versa
	
	STR = 8; // melee damage
	AIM = 1; // ranged damage
	MGC = 1; // magic damage
	DEF = 2; // defence/armor
	SPD = 2; // evasion and weapon strikes
	SPT = 1; // spirit (mana regen)
	
	skill_1 = "Fireball";
	skill_2 = "Pillar of Flame";
	skill_3 = "Heal"
	
}

// TUCA BELLE
function hero_tuca() : hero() constructor {
	
	name = "Tuca Belle";
	index = 2;
	description = "";
	sprite = spr_hero_2;
		
	max_hp = 40;
	max_mana = 20;
	hp = max_hp;
	mp = max_mp;
	hp = 10;
	mp = 10;
	
	// weapon speed
	// weapon damage
	// gem that gives def lowers speed and vice versa
	
	STR = 6; // melee damage
	AIM = 1; // ranged damage
	MGC = 1; // magic damage
	DEF = 2; // defence/armor
	SPD = 4; // evasion and weapon strikes
	SPT = 1; // spirit (mana regen)
	
}


// Piko
function hero_piko() : hero() constructor {
	
	name = "Piko";
	index = 3;
	description = "";
	sprite = spr_hero_3;
		
	max_hp = 40;
	max_mana = 20;
	hp = max_hp;
	mp = max_mp;
	hp = 10;
	mp = 10;
	
	// weapon speed
	// weapon damage
	// gem that gives def lowers speed and vice versa
	
	STR = 100; // melee damage
	AIM = 1; // ranged damage
	MGC = 40 // magic damage
	DEF = 2; // defence/armor
	SPD = 10; // evasion and weapon strikes
	SPT = 1; // spirit (mana regen)
	
}


// Arabella
function hero_arubella() : hero() constructor {
	
	name = "Arubella";
	index = 4;
	description = "";
	sprite = spr_hero_4;
		
	max_hp = 40;
	max_mana = 20;
	hp = max_hp;
	mp = max_mp;
	hp = 10;
	mp = 10;
	
	// weapon speed
	// weapon damage
	// gem that gives def lowers speed and vice versa
	
	STR = 3; // melee damage
	AIM = 1; // ranged damage
	MGC = 1; // magic damage
	DEF = 2; // defence/armor
	SPD = 1; // evasion and weapon strikes
	SPT = 1; // spirit (mana regen)
	
}