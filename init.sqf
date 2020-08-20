if (isPlayer (leader group player)) then {[player] execVM "scripts\bot_camo.sqf"};

if (player == leader group player) then {
	systemChat "true";
	//[player] execVM "scripts\bot_camo.sqf";
} else {
	systemChat "false";
	//[player] execVM "scripts\camo.sqf";
};