

_heliArray = [markerPos "helispawn", direction player, "OPTRE_Pelican_armed", west] call BIS_fnc_spawnVehicle;
_heliArray params ["_heliArrayVeh", "_heliArrayCrew", "_heliArrayGrp"];
heli1 = _heliArrayVeh;
publicVariable "heli1";
_heliArrayGrp setGroupId ["ECHO 219"];

hint "called extraction";

HeliPad1="Land_HelipadEmpty_F" createVehicle getMarkerPos "extract_marker"; 
heli1 move position HeliPad1;
[heli1, HeliPad1] call ONI_fnc_landHelo;