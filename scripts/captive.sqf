params ["_captive"];





[_captive] call ONI_fnc_throwWeapon;
removeAllWeapons _captive;					//Remove binoculars
player action ["Surrender", _captive];
_captive setBehaviour "CARELESS";

_captive addAction
[
	"--CAPTURE--",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script
		[_target] join _caller;
		_target switchMove "";
		missionNamespace setVariable ["capturedVIP", true, true];
		_target removeAction _actionId;
	},
	nil,		// arguments
	6,			// priority
	true,		// showWindow
	true,		// hideOnUse
	"",			// shortcut
	"true", 	// condition
	2,			// radius
	false,		// unconscious
	"",			// selection
	""			// memoryPoint
];