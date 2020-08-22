params ["_player"];

//Only executes for non-human team members
_player setVariable ["teamCamoActive", false];

if (!(_player getVariable "teamCamoActive")) then {
	_player groupChat "TEAM Camo Ready";
	teeamCamoActionID = _player addAction 
	[
		"TEAM CAMO ON", 
		{
			params ["_target", "_caller", "_actionId", "_arguments"];

			{
				if !(isPlayer _x) then { 
					_x setUnitTrait ["camouflageCoef", 0.35];
					_x setUnitTrait ["audibleCoef", 0.5];
					_x groupChat "Camo ON";
					_target setVariable ["teamCamoActive", true];
					sleep 0.3;

					//This bit makes every opfor unit to "forget" unit that has camo.
					//It only runs once so if you fire at them again they will fire back
					_x0 = _x;
					{
						if ((side _x) == east) then {
							_x forgetTarget _x0;
							systemChat "drake has forgotten mason";
						}
					} forEach allUnits;
				};
			} forEach units group (_target);
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
			} forEach units group (_target);	
			sleep 2;

			[_target] execVM "scripts\bot_camo.sqf";	
		},
		nil,
		2,
		false,
		true,
		"",
		"player == leader group _this;",
		-1
	];
};