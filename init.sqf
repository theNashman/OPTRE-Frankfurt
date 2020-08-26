//Mission constants and important variables go here
missionNamespace setVariable ["capturedVIP", false, true];

//Remove NVGs from all OPFOR
{
	//Must define new var first because isNil takes string as var param and class name is also string
	_hmd = hmd _x; 					
	if ((side _x == east) and !(isNil "_hmd")) then {
		_x unlinkItem hmd _x;
	};
} forEach allUnits;


















//This bit goes at the bottom NO EXCEPTIONS
waitUntil {alive player};

if (player == leader group player) then {
	[player] execVM "scripts\bot_camo.sqf";
	[player] execVM "scripts\camo.sqf";
} else {
	[player] execVM "scripts\camo.sqf";
};