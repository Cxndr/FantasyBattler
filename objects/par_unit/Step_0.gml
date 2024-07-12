

// ------ DEATH ------ //
if me.hp <= 0 { 
	dead = true;
	me.dead = true;
	current_state = state.dead;
}
else { 
	dead = false; 
}

