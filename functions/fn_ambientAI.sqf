/*
	Small function for ambient AI animations. AI will leave animation state only if trigger is provided or if in combat state.
	Function must run in scheduled environment.

	Usage: [object, animation, trigger] spawn ONI_fnc_ambientAI
		object - Unit who will perform animation
		animation - name of animation, must be viable for BIS_fnc_ambientAnim
		trigger (optional) - trigger which must activate for animation to stop

	Example: [_soldier1, "SIT2", trg_1] spawn ONI_fnc_ambientAI;
		Soldier1 will be in "SIT2" animation until either in danger or trg_1 is active


*/

params ["_unit", "_animation", ["_trigger", false], ["_debug", true]];
systemChat "working";

[_unit, _animation] call BIS_fnc_ambientAnim;


if (typeName _trigger == "BOOL") then {
	waitUntil {behaviour _unit == "combat"};
	_unit call BIS_fnc_ambientAnim__terminate;
} else {
	waitUntil {behaviour _unit == "combat" || triggerActivated _trigger};
	_unit call BIS_fnc_ambientAnim__terminate;
};
