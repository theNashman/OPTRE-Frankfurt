/*
	Author: JBOY_Dog/johnnyboy
	Makes unit throw weapin in random direction
	Usage: [_unit] call ONI_fnc_throwWeapon
		_unit = any unit that can hold a gun
*/

params ["_dude"];


_weapon = currentWeapon _dude;       
_dude removeWeapon (currentWeapon _dude);
[] call {sleep .1;};
_weaponHolder = "WeaponHolderSimulated" createVehicle [0,0,0];
_weaponHolder addWeaponCargoGlobal [_weapon,1];
_weaponHolder setPos (_dude modelToWorld [0,.2,1.2]);
_weaponHolder disableCollisionWith _dude;
_dir = random(360);
_speed = 1.5;
_weaponHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir), 2]