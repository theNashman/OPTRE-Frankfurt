hint "called exfil";

HeliPad2="Land_HelipadEmpty_F" createVehicle getMarkerPos "exfil_marker"; 
heli1 move position HeliPad2;
[heli1, HeliPad2] call ONI_fnc_landHelo;