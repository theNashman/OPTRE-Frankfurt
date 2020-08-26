if (heli_1 = objectParent player) then { 
	extractionReady = true;
	publicVariable "extractionReady";
};

_wp = group player addWaypoint [position heli_1, 0];
_wp setWaypointType "GETIN";
[group player, 0] waypointAttachVehicle heli_1;

HeliPad2="Land_HelipadEmpty_F" createVehicle getMarkerPos "heliMarker2";

_helicopter move (getPos _destination);

sleep 3;

while { ( (alive _helicopter) && !(unitReady _helicopter) ) } do
{
       sleep 1;
};

if (alive _helicopter) then
{
       _helicopter land "LAND";
};

_time = time;
waitUntil {time == _time + 10};
systemChat "Large QRF on the way"

_bigQRF = [["OPTRE_M12_LRV_ins", "OPTRE_m1015_mule_ins"], getMarkerPos "qrf_large", position player] call ONI_fnc_createQRF;

_smallQRF = [getMarkerPos "qrf_large", east, (configfile >> "CfgGroups" >> "East" >> "OPTRE_Ins" >> "Infantry_URF" >> "OPTRE_Ins_URF_Inf_RifleSquad")] call BIS_fnc_spawnGroup;
units _smallQRF join _bigQRF;
_bigQRF addWaypoint [position player, 0] setWaypointType "SAD";


(keystone knowsAbout player) > 0.6 && ({alive _x && side _x == EAST} count allUnits in thisList) < 2;


_guards = [];
_all = allUnits inAreaArray trg_surrender;
{
	if (alive _x and side _x == EAST) then {
		_guards pushBack _x;
		};
} forEach _all;

count _guards;

[group this, getMarkerPos "vip_marker", 50] call BIS_fnc_taskPatrol;