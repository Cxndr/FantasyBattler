/// @param text_id
function scr_game_text(_text_id){

	// setup
	if instance_exists(obj_battle) {
		user = obj_battle.party[|obj_battle.party_active];
		target = obj_battle.target;
	}
	else {
		user = obj_party.party[|0];
		target = undefined;
	}


	switch(_text_id) {
	
		case "break":
		
			break;

 // **** BATTLE **** //

		case "battle_action1":
			scr_text("What should " + string(obj_party.party[|obj_battle.party_active].name) + " do?");
				scr_option("Attack", "battle_action_atk1");
				scr_option("Skill", "battle_action_skill1");
				scr_option("Item", "battle_action_skill1");
				scr_option("Skip", "battle_action_skill1");
			break;
			
		case "battle_action_atk1":
			scr_text("Who to attack?");
			obj_battle.choice = 1; // 1 = attack
			
			break;
		
		case "battle_action_atk2":
			scr_text("Damage Dealt");
			break;
			
		case "battle_action_skill1":
		
			// bounce back to action menu if no skills
			if user.skill_1 == "" and user.skill_2 == "" { obj_battle.choice = 0; break; }
			
			scr_text("Which skill?");
				scr_option(user.skill_1,"battle_action_skill2_1");
				scr_option(user.skill_2,"battle_action_skill2_2");
				scr_option(user.skill_3,"battle_action_skill2_3");
			break;
			
		case "battle_action_skill2_1":
			obj_battle.choice = 2;
			obj_battle._skill = user.skill_1;
			break;
		case "battle_action_skill2_2":
			obj_battle.choice = 2;
			obj_battle._skill = user.skill_2;
			break;
		case "battle_action_skill2_3":
			obj_battle.choice = 2;
			obj_battle._skill = user.skill_3;
			break;








// *** CUTSCENES *** //

		case "npc1":
			scr_text_center("Welcome");
			scr_text_center("Sector 5ZF - Ogga", "npc1_1");
			break;
			
		case "npc1_1":
			scr_text("be careful of shooga boogas in this area.");
				scr_text_wavy(14, 27);
				scr_text_shake(28, 42);
				scr_text_color(14, 27, c_red, c_red, c_yellow, c_yellow);
			scr_text("woiehoqwh. nhhhhhhh... you gonna use that???");
				scr_text_wavy(14, 27)
				scr_option("YEY", "npc1_yes");
				scr_option("NaNNN", "npc1_no");
				scr_option("meeeehbe", "npc_maybe");
				
			break;
			
			case "npc1_yes":
				scr_text("ohh no");
				scr_text("You run into a booga shooga wooga.");
					scr_text_shake(15, 39)
				scr_text("aisudhi. qwewq iueoqwiue, oqwiueo qwieuq!! woiue qowie uoqwiueq owqiue qiowue", "char2");
				scr_text("owhdowuho. iowhdo. woqihj. wdoqihoih!!", "char1","v_high")
				scr_text("bubba. hubba. chubba.", "char2","v_low", -1)
				scr_text("* this is a message from hq: testo testoroso testomundi *", "char2", "t_mid", -1);
				scr_text("* ding ding ding ding ding *", "char2", "t_high", -1);
				scr_text("* womp womp womp womp *", "char2", "t_low", -1);
				break;
				
			case "npc1_no":
				scr_text("o. o. o. m. g. g. g. gggg.", "char3");
				break;
				
			case "npc1_maybe":
				scr_text("FIFHOEIFOEIFNO");
				break;
			
		case "npc2":
			
			break;
			
		case "npc3":
		
			break;
		

	
	}

}