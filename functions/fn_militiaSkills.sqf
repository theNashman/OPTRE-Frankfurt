/*
	Author: nash


	This function is intended to give AI lower skills and make them less competent.
	It's meant for playing against militia, rebels, insurgents etc. Who don't have world-class training
	like regular soldiers.
	This may/may not have the added bonus of making the AI more "aggressive",
	as well as cheese a lot of things so use with caution.

	Usage: 	[name] call ONI_fnc_militiaSkills
			name - Unit name or Group name
	
	Example [_soldier1] call ONI_fnc_militiaSkills;


	NOTE:	If you don't want a specific unit to be affected by this
			use an override var named "ONI_Skilled" within unit's namespace

*/

params ["_unit", ["_debug", false]];




//Skill constants
_skillArray = [
	0.1, 	//aimingAccuracy
	0.1, 	//commanding
	0.1,	//courage
	0.1,	//reloadSpeed
	0.1, 	//spotDistance
	0.1,	//spotTime
	0.1		//aimingShake
];


//Do not execute if unit has safeword


//The effectively makes AI dumb

isUnitFnc = {
	params ["_unit", "_skillArray", ["_debug", false]];

	//Don't execute if safeword present
	if (_unit getVariable ["ONI_Skilled", false]) exitWith {};



	_aimingAccuracy = _skillArray select 0;
	_commanding = _skillArray select 1;
	_courage = _skillArray select 2;
	_reloadSpeed = _skillArray select 3;
	_spotDistance = _skillArray select 4;
	_spotTime = _skillArray select 5;
	_aimingShake = _skillArray select 6;

	


	_unit disableAI "FSM";

	_unit setSkill ["aimingAccuracy", _aimingAccuracy];
	_unit setSkill ["commanding", _commanding];
	_unit setSkill ["courage", _courage];
	_unit setSkill ["reloadSpeed", _reloadSpeed];
	_unit setSkill ["spotDistance", _spotDistance];
	_unit setSkill ["spotTime", _spotTime];
	_unit setSkill ["aimingShake", _aimingShake];

	if (_debug) then {systemChat "DEBUG: Deskilled a unit"};

};

isGroupFnc = {
	

	params ["_unit", "_skillArray", ["_debug", false]];
	_group = _unit;


	_aimingAccuracy = _skillArray select 0;
	_commanding = _skillArray select 1;
	_courage = _skillArray select 2;
	_reloadSpeed = _skillArray select 3;
	_spotDistance = _skillArray select 4;
	_spotTime = _skillArray select 5;
	_aimingShake = _skillArray select 6;

	{
		//Don't execute if it has safeword
		if (_x getVariable "ONI_Skilled") exitWith {};


		_x disableAI "FSM";

		_x setSkill ["aimingAccuracy", _aimingAccuracy];
		_x setSkill ["commanding", _commanding];
		_x setSkill ["courage", _courage];
		_x setSkill ["reloadSpeed", _reloadSpeed];
		_x setSkill ["spotDistance", _spotDistance];
		_x setSkill ["spotTime", _spotTime];
		_x setSkill ["aimingShake", _aimingShake];
	} forEach units _group;

	if (_debug) then {systemChat "DEBUG: Deskilled a group"};

};

//Parameter check for unit or group
switch (typeName _unit) do {
	case "OBJECT": {[_unit, _skillArray, _debug] call isUnitFnc};
	case "GROUP": {[_unit, _skillArray, _debug] call isGroupFnc};
	default {
		//throw ("argument must be group or unit");
		if(_debug) exitWith {systemChat "EXCEPTION: fnc_militiaSkills expects UNIT or GROUP"};
	};
};




