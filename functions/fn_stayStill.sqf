/* 
	Author : nash
	
	Small function to make AI stay where they were placed in the editor including facing directions.
	Should be useful for any missions where you want the AI to look pretty and stop moving into formations.
	AI will start to move once in combat or spotted an enemy.
	Works on groups or on single unit.


	Usage: [name, enableCombat] call ONI_fnc_stayStill;
		name: unit name or group name
		enableCombat (Optional): boolean value, determines whether AI can move when in danger. Defaults true

	Example: [_soldier1] call ONI_fnc_stayStill;
		_soldier1 will not move from position but can still aim and shoot. He will start to move if he's in danger.

*/

if (!isServer) exitWith {};
//waituntil{time > 0.1};

params ["_unit", ["_combatBOOL", true], ["_debug", false]];
//NOTE: Change _debug to 'false' to stop error logging



isUnitFnc = {
	params ["_unit", ["_combatBOOL", true], ["_debug", false]];

	_unit disableAI "ANIM";
	_unit forceSpeed 0;
	if (_debug) then {systemChat "AI is now frozen"};

	//Reenable normality once in danger
	if (_combatBOOL) then {
		if (_debug) then {systemChat "AI will awaken if aggroed"};

		[_unit, _debug] spawn {
			params ["_unit", "_debug"];

			waitUntil {behaviour _unit == "COMBAT"};
			_unit enableAI "ANIM";
			_unit forceSpeed -1;
			if (_debug) then {systemChat "AI is now active"};
		};
	};
};


isGroupFnc = {
	params ["_group", ["_combatBOOL", true], ["_debug", true]];

	{
		_x disableAI "ANIM";
		_x forceSpeed 0;

	} forEach units _group;
	if (_debug) then {systemChat "AI is now frozen"};


	//If any member in group goes into combat they all will be 'reawakened'
	if (_combatBOOL) then {
		if (_debug) then {systemChat "AI will awaken if aggroed"};

		[_group, _debug] spawn {
			params ["_group", "_debug"];

			waitUntil {units _group findIf {behaviour _x == "COMBAT"} != -1};
			{
				_x enableAI "ANIM";
				_x forceSpeed -1;
				if (_debug) then {systemChat "AI is now active"};
			} forEach units _group;
		};
	};
};



if (_debug) then {systemChat "fnc_stayStill is running..."};

//Parmeters type check
switch (typeName _unit) do {
	case "OBJECT": {[_unit, _combatBOOL] call isUnitFnc};
	case "GROUP": {[_unit, _combatBOOL] call isGroupFnc};
	default {
		//throw ("argument must be group or unit");
		if(_debug) exitWith {systemChat "EXCEPTION: Argument must be group or unit"};
	};
};

//systemChat str _unit;
