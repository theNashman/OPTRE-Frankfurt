//IMPORTANT: This code MUST and I repeat MUST run in a scheduled scope
//I could try wrapping everything with a giant 'spawn' but that sounds lazy and dumb




params ["_unit"];


if !(isPlayer _unit) exitWith {};

_unit setVariable ["camoActive", false];

if (!(_unit getVariable "camoActive")) then {
	_unit groupChat "Active Camo Ready";
	camoActionID = _unit addAction 
	[
		"ACTIVE CAMO ON", 
		{
			params ["_target", "_caller", "_actionId", "_arguments"];

			_target setUnitTrait ["camouflageCoef", 0.35];
			_target setUnitTrait ["audibleCoef", 0.5];

			//This bit makes every opfor unit to "forget" unit that has camo.
			//It only runs once so if you fire at them again they will fire back

			{
				if (side _x == east) then {
					_x forgetTarget _target;
				};
			} forEach allUnits;
			systemChat "done";

			_target groupChat "Active Camo ON";
			_target setVariable ["camoActive", true];
			player removeAction (_actionId);
			sleep 2;



			//Camo depleted
			_target setUnitTrait ["camouflageCoef", 1.0];
			_target setUnitTrait ["audibleCoef", 1.0];
			_target groupChat "Active Camo Depleted. Recharging ...";
			_target setVariable ["camoActive", false];	
			sleep 2;
			[_target] execVM "scripts\camo.sqf";
		},
		nil,
		3,
		false,
		true,
		"",
		"",
		-1
	];

};


