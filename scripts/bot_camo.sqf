params ["_player"];

//Only executes for non-human team members
_player setVariable ["teamCamoActive", false];

if (!(_player getVariable "camoActive")) then {
	_player groupChat "TEAM Camo Ready";
	teeamCamoActionID = _player addAction 
	[
		"TEAM CAMO ON", 
		{
			{
				if !(isPlayer _x) then { 
					_x setUnitTrait ["camouflageCoef", 0.5];
					_x setUnitTrait ["audibleCoef", 0.5];
					_x groupChat "Camo ON";
					_this select 0 setVariable ["teamCamoActive", true];
					sleep 0.3;
				};
			} forEach units group (_this select 0);
			sleep 2;

			player removeAction (_this select 2);

			{	
				if !(isPlayer _x) then {
					_x setUnitTrait ["camouflageCoef", 1.0];
					_x setUnitTrait ["audibleCoef", 1.0];
					_x groupChat "Camo Depleted. Recharging ...";
					_x setVariable ["teamCamoActive", false];
					sleep 0.3;
				};	
			} forEach units group (_this select 0);	
			sleep 2;

			[_this select 0] execVM "scripts\bot_camo.sqf";	
		},
		nil,
		1.5,
		true,
		true,
		"",
		"",
		-1
	];
};