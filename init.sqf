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


//Make units stay still. Executed on marked non-patroling units
//I prefer this to using init fields because of Multiplayer
_beStillARRAY = [baddie_1, baddie_2, baddie_3, baddie_4, baddie_5, baddie_6];
{
	[group _x] call ONI_fnc_stayStill;

} forEach _beStillARRAY;















//This bit goes at the bottom NO EXCEPTIONS


[] spawn {
	waitUntil {alive player};
	[player] execVM "scripts\camo.sqf";
	if (player == leader group player) then {[player] execVM "scripts\bot_camo.sqf"};
};