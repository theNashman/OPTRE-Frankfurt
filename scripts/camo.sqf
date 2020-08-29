//Adds Action to turn on camo
//Makes use of fn_activeCamo


params ["_unit"];



if !(isPlayer _unit) exitWith {};
_unit setVariable ["camoCharged", true, true];

camoActionID = _unit addAction 
[
	"ACTIVATE CAMO", 
	{
		
		params ["_target", "_caller", "_actionId", "_arguments"];

		[_target] call ONI_fnc_activeCamo;

	},
	nil,
	3,
	false,
	true,
	"",
	'(_target getVariable "camoCharged")',
	-1
];



