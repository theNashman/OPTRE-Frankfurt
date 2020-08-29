params ["_leader"];

//Only executes for non-human team members as AI won't be able to use it anyway.
//Below line will never execute because of checks in init.sqf
if !(isPlayer _leader) exitWith {systemChat "Team Leader is not human."};


//_leader setVariable ["teamCamoCharged", true, true];
aiUnits = [];
{
	if !(isPlayer _x) then {
		aiUnits pushBack _x;
		_x setVariable ["camoCharged", true, true];
	};

} forEach units group _leader;

_leader groupChat "TEAM Camo Ready";
teamCamoActionID = _leader addAction 
[
	"TEAM CAMO ON", 
	{
		params ["_target", "_caller", "_actionId", "_aiUnits"];

		{
			//Only bots will have their camo turned on
			[_x] spawn ONI_fnc_activeCamo; 

		} forEach _aiUnits;

		//_leader setVariable ["teamCamoCharged", true, true];

	},
	aiUnits,
	2,
	false,
	true,
	"",
	'aiUnits findIf {_x getVariable "camoCharged"} != -1',
	-1
];

//aiUnits findIf {_x getVariable "camoCharged" == true} != -1