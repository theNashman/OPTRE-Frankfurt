//if (isPlayer (leader group player)) then {[leader group player] execVM "scripts\bot_camo.sqf"};
if (player == leader group player) then {
	[player] execVM "scripts\bot_camo.sqf";
};

//} else {
	//[player] execVM "scripts\camo.sqf";
//};

missionNamespace setVariable ["capturedVIP", false, true];