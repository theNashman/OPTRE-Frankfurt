/*
	Small function for ambient AI animations. AI will leave animation state only if trigger is provided or if in combat state.
	Function must run in scheduled environment.

	Usage: [object, animation, distance*, time*] call ONI_fnc_ambientAI
		object - Unit who will perform animation
		animation - Name of animation, must be viable for BIS_fnc_ambientAnim
		distance (optional) - Distance between unit and player for the animation to end. Defaults to 5
		time (optional) - Delay between when the unit has reached distance and actual end of animation. Defaults to 5

	Example: [_soldier1, "SIT2", 5] call ONI_fnc_ambientAI;
		Soldier1 will be in "SIT2" animation until either in danger or player is within 5m


*/




params ["_unit", "_animation", ["_distance", 5], ["_time", 5], ["_debug", true]];

[_unit, _animation] call BIS_fnc_ambientAnim;


[_unit] spawn {

	params ["_unit"];

	waitUntil {behaviour _unit == "combat"};
	_unit call BIS_fnc_ambientAnim__terminate;
};

[_unit, _distance, _time] spawn {

	params ["_unit", "_distance", "_time"];

	waitUntil {(player distance _unit) < _distance};
	sleep _time;
	_unit call BIS_fnc_ambientAnim__terminate;
};


//Mandatory function return 
true;