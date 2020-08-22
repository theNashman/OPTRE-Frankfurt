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