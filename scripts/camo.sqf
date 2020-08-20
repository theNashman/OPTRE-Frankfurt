params ["_unit"];


if !(isPlayer _unit) exitWith {};

_unit setVariable ["camoActive", false];

if (!(_unit getVariable "camoActive")) then {
	_unit groupChat "Active Camo Ready";
	camoActionID = _unit addAction 
	[
		"ACTIVE CAMO ON", 
		{
			_this select 0 setUnitTrait ["camouflageCoef", 0.5];
			_this select 0 setUnitTrait ["audibleCoef", 0.5];
			_this select 0 groupChat "Active Camo ON";
			_this select 0 setVariable ["camoActive", true];
			player removeAction (_this select 2);
			sleep 2;

			_this select 0 setUnitTrait ["camouflageCoef", 1.0];
			_this select 0 setUnitTrait ["audibleCoef", 1.0];
			_this select 0 groupChat "Active Camo Depleted. Recharging ...";
			_this select 0 setVariable ["camoActive", false];	
			sleep 2;
			[_this select 0] execVM "scripts\camo.sqf";
		},
		nil,
		1.5,
		true,
		true,
		"",
		"player == leader group _this;",
		-1
	];

};


