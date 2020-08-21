params ["_document"];


missionNamespace setVariable ["intelRetrieved", false, true];

if ( hasInterface ) then {
	_document addAction [
		"Pick up laptop",
		{[_this,"action"] spawn BIS_fnc_initIntelObject;},
		[],
		10,
		true,
		true,
		"",
		"isplayer _this && {_this distance _target < 2} &&
		{(side group _this) in (_target getvariable ['RscAttributeOwners',[west,east,resistance,civilian]])}"
	];
};


if (isServer) then {
	
	// "Diary picture";
	_document setVariable [
		"RscAttributeDiaryRecord_texture",
	// "Path to picture";
		"a3\structures_f_epc\Items\Documents\Data\document_secret_01_co.paa",
		true
	];
	
	// "Diary Title and Description";
	[
		_document,
		"RscAttributeDiaryRecord",
		// "[ Title, Description]";
		["Top Secret Docs","These Docs outline the enemies defenses"]
	] call BIS_fnc_setServerVariable;
	
	// "Diary entry shared with.. follows  target rules";
	_document setVariable ["recipients", west, true];
	
	// "Sides that can interact with intelObject";
	_document setVariable ["RscAttributeOwners", [west], true];

};