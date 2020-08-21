params ["_captive"];

_captive setCaptive true;
removeAllWeapons _captive;
_captive setBehaviour "CARELESS";

_captive addAction
[
	"--CAPTURE--",	// title
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; // script
		_caller action ["Surrender", _target];
		[_target] join _caller;
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