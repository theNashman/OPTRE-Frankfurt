//Adds Action to turn on camo
//Makes use of fn_activeCamo


params ["_unit"];



if !(isPlayer _unit) exitWith {};
_unit setVariable ["camoActive", false];

camoActionID = _unit addAction 
[
	"ACTIVATE CAMO", 
	{
		
		params ["_target", "_caller", "_actionId", "_arguments"];
		player removeAction (_actionId);

		[_target] spawn ONI_fnc_activeCamo;

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




