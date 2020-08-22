missionNamespace setVariable ["capturedVIP", false, true];























//This bit goes at the bottom NO EXCEPTIONS
waitUntil {alive player};

if (player == leader group player) then {
	[player] execVM "scripts\bot_camo.sqf";
	[player] execVM "scripts\camo.sqf";
} else {
	[player] execVM "scripts\camo.sqf";
};