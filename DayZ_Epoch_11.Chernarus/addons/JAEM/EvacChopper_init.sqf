//JAEM
//Just another Chopper-Evac Mod v1.0
//OtterNas3
//01/14/2014

private ["_evacCallerID","_evacCallerUID","_evacFields","_evacFieldID","_ownerKeyId","_itemsPlayer","_temp_keys","_key_colors","_hasKey","_cTarget","_vehicleKey"];
waitUntil {!isNil "dayz_animalCheck"};

_evacCallerID = (player getVariable ["CharacterID","0"]);
_evacCallerUID = (getPlayerUID player);
playerHasEvacField = false;
_evacFields = nearestObjects [player, ["HeliHRescue"], 20000];
if ((count _evacFields) > 0) then
{
	{
		_evacFieldID = _x getVariable ["CharacterID", "0"];
		if (_evacCallerID == _evacFieldID || _evacCallerUID == _evacFieldID) then {
			playerHasEvacField = true;
		};
	} forEach _evacFields;
};
while{true} do {
	sleep 3;
	if (vehicle player == player && playerHasEvacField) then {
		if (s_player_evacCall < 0) then {
			s_player_evacCall = player addAction [("<t color=""#FF0000"">" + ("Call Evac-Chopper") + "</t>"),"addons\JAEM\CallEvacChopper.sqf",[],-1,false,false,"",""];
		};
	} else {
		player removeAction s_player_evacCall;
		s_player_evacCall = -1;
	};
	if (!isNull cursorTarget && vehicle player == player && cursorTarget isKindOf "Helicopter" && player distance cursorTarget <= 10 && !isEngineOn cursorTarget) then {
		_cTarget = cursorTarget;
		_vehicleKey = _cTarget getVariable ["CharacterID","0"];
		if (_vehicleKey != "0") then {
			_itemsPlayer = items player;
			_temp_keys = [];
			_key_colors = ["ItemKeyYellow","ItemKeyBlue","ItemKeyRed","ItemKeyGreen","ItemKeyBlack"];
			{
				if (configName(inheritsFrom(configFile >> "CfgWeapons" >> _x)) in _key_colors) then {
					_ownerKeyId = getNumber(configFile >> "CfgWeapons" >> _x >> "keyid");
					_temp_keys set [count _temp_keys,str(_ownerKeyId)];
				};
			} forEach _itemsPlayer;
			_hasKey = _vehicleKey in _temp_keys;
			if (_hasKey) then {
				if (s_player_makeEvacChopper < 0) then {
					s_player_makeEvacChopper = player addAction [("<t color=""#FF0000"">" + ("Set Evac-Chopper") + "</t>"),"addons\JAEM\SetEvacChopper.sqf",_cTarget,-1,false,false,"",""];
				};
			} else {
				player removeAction s_player_makeEvacChopper;
				s_player_makeEvacChopper = -1;
			};
		} else {
			player removeAction s_player_makeEvacChopper;
			s_player_makeEvacChopper = -1;
		};
	} else {
		player removeAction s_player_makeEvacChopper;
		s_player_makeEvacChopper = -1;
	};
};