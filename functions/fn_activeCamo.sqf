/*
	Authour: nash

	Active Camouflage script.

	Works by reducing the camouflage coefficient to a preset value
	For reference, camoCoef for sniper in full ghillie is about 0.7 - 0.8.
	It also reduces the chance of being heard by the AI as well.

	Finally it makes the AI 'forget' about the unit in order to simulate turning invisible.
	Of course you're not perfectly invisible, 
	so if you turn it on while in a firefight and AI still has LOS it won't do anything.

	Usage: [name] spawn ONI_fnc_activeCamo;
		name: unit name

	Example: [player] spawn ONI_fnc_activeCamo;


	CAUTION: MUST be run in a Scheduled environment because of `sleep`
	WARNING: Will only work properly when executed serverside in Multiplayer
*/

//Don't execute locally
if !(isServer) exitWith {};


params ["_unit", ["_debug", false]];

_camoCoef = 0.35;	//How effective is camo, smaller is better
_audioCoef = 0.45;
_cooldown = 2;		//How long camo will last in seconds
_recharge = 4;		//How long does camo take to recharge. Set to '0' for no recharge




_unit setUnitTrait ["camouflageCoef", _camoCoef];
_unit setUnitTrait ["audibleCoef", _audioCoef];

{
	if !(_x in units group _unit) then {
		_x forgetTarget _unit;
	};

	if (_debug) then {systemChat "DEBUG_CAMO:enemy has forgotten"};
	
} forEach allUnits;
//Used allUnits becuse it is faster than checking if enemy knowsAbout or enemy is enemy


_unit groupChat "Active Camo ON";
_unit setVariable ["camoCharged", false];
sleep _cooldown;


//Camo depleted
_unit setUnitTrait ["camouflageCoef", 1.0];
_unit setUnitTrait ["audibleCoef", 1.0];
_unit groupChat "Active Camo Depleted. Recharging ...";	
sleep _recharge;
_unit setVariable ["camoCharged", true];

_unit groupChat "Active Camo READY";
