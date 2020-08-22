/*
	Forces helicopter to land. Only works with non-fixed wings and maybe VTOLs.
	Requires at least one helipad near destination.
	Usage:	[_helo, _destination] call ONI_fnc_landHelo
		_helo : helicopter you want to land
		_destination : position you want to land at (preferrably at a helipad of some kind)

*/

params ["_helicopter", "_destination"];


_helicopter move (getPos _destination);
[_helicopter] spawn {
    params ["_helicopter"];
    sleep 3;
	
    if (alive _helicopter) then { 
        waitUntil {unitReady _helicopter};
        _helicopter land "LAND";    
    };
};

