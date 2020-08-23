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








