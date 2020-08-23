/*
	An overengineered function that spawns a small QRF team and creates a SAD waypoint at a desired location.
	Side of group created will be the same as default side of first unit in array.
	Side will default to EAST, if default side is neither EAST, WEST, IND or CIV
	If multiple classes are give, they will be spawned 5m apart in a straight line
	Technically this can be altered to give any kind of commands to a group ater spawning them in
	Usage: [_qrfTeam, _pos, _dest] call ONI_fnc_createQRF
		_qrfTeam : Array containing class names of QRF team
		_pos : spawn position of QRF team
		_dest : location of SAD waypoint
		E.g : [["O_MRAP_02_hmg_F", "O_MRAP_02_hmg_F"], getMarkerPos "qrf_spawn", position player] call ONI_fnc_createQRF
*/

if ((count _this) < 3) exitWith {debugLog "Log: [createQRF] Function requires at leat 3 parameters!"};
params ["_qrfTeam", "_position", "_destination"];

_sideArray = [east, west, resistance, civilian];


_i = getNumber (configFile >> "CfgVehicles" >> _qrfTeam select 0  >> "side");
if (_i < 4) then {_qrfSide = _sideArray select _i;} else {_qrfSide = east};


_relPosArray = [];
if (count _qrfTeam > 1) then {
	_posX = 0;
	_posY = 0;

	for "_i" from 0 to (count _qrfTeam - 1) do {
		if !(_i == 0) then {
			_posX = (_relPosArray select (_i - 1) select 0) + 5
		};
		systemChat format ["_posX shallow is: %1", _posX];
		
		//_posX = random [-15, 5, 15];
		//_posY = random [-15, -5, 15];

		_relPosArray pushBack [_posX,_posY];
	};
};

//systemChat format ["Position array is: %1", _relPosArray];
_qrfGroup = [_position, _qrfSide, _qrfTeam, _relPosArray] call BIS_fnc_spawnGroup;
_qrfGroup deleteGroupWhenEmpty true;

_qrfGroup addWaypoint [_destination, 0] setWaypointType "SAD";





/* Debug Only

systemChat format ["QRF spawned at: %1.", _position];
systemChat format ["QRF contains: %1.", _qrfTeam select 0];
systemChat format ["QRF headed to: %1.", _destination];

*/

