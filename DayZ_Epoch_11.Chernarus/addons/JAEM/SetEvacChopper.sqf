//JAEM
//Just another Chopper-Evac Mod v1.0
//OtterNas3
//01/14/2014

private ["_evacFieldID","_locationPlayer","_cnt","_playerEvacField","_objectID","_objectUID","_targetVehicle","_playerID","_playerUID","_magazinesPlayer","_has10ozGold","_evacFields","_foundPlayerEvacField","_location","_dir","_object"];
player removeAction s_player_makeEvacChopper;
s_player_makeEvacChopper = 1;

//Getting the target Vehicle and needed variables
_targetVehicle = _this select 3;
_location = getPosATL _targetVehicle;
_dir = getDir _targetVehicle;
_playerID = (player getVariable ["CharacterID", "0"]);
_playerUID = (getPlayerUID player);
_foundPlayerEvacField = [];
_magazinesPlayer = magazines player;

//Cause we can only make a sign on Terrain and not on buildings or buildables
//We check if the Chopper height is below 1m above Terrain
if ((_location) select 2 >= 1) then {
	systemChat("Sorry but Evac-Choppers need to be build on flat Terrain");
	systemChat("Make sure you got no objects like Buildings or Trees around!");
};


//Check if he has a 10ozGold to pay for the Evac-Chopper
//If not exit script
_has10ozGold = ("ItemGoldBar10oz" in _magazinesPlayer);
if (!_has10ozGold) then {
	systemChat("Making a Evac-Chopper costs 1 10ozGold - You dont have one - Sorry!");
	s_player_makeEvacChopper = -1;
	breakOut "exit";
};

//If player already has a Evac-Chopper we have to check which it is
//Getting all HeliHRescue signs on Server and check if Player is owner
if (playerHasEvacField) then {
	_evacFields = nearestObjects [player, ["HeliHRescue"], 20000];
	if ((count _evacFields) > 0) then {
		{
			_evacFieldID = _x getVariable ["CharacterID", "0"];
			if (_evacFieldID != "" && _evacFieldID != "0" && (_evacFieldID == _playerID || _evacFieldID == _playerUID)) then {
				_foundPlayerEvacField set [(count _foundPlayerEvacField), _x];
			};
		} forEach _evacFields;
	};
	//We found one the player is the owner of
	//Tell him that only 1 Evac-Chopper is allowed
	//Give him 5 seconds until we change the Evac-Chopper to the current target
	if ((count _foundPlayerEvacField) > 0) then {
		_playerEvacField = _foundPlayerEvacField select 0;
		systemChat("WARNING! You already have a Evac-Chopper - Maximum reached");
		_cnt = 5;
		_locationPlayer = (getPosATL player);
		for "_p" from 1 to 5 do
		{
			systemChat(format ["WARNING! Changing Evac-Chopper to this target in %1s - Move to cancel",_cnt]);
			if (player distance _locationPlayer > 0.2) then {
				systemChat("Changing Evac-Chopper canceled");
				s_player_makeEvacChopper = -1;
				breakOut "exit";
			};
			sleep 1;
			_cnt = _cnt - 1;
		};
		_objectID = _playerEvacField getVariable["ObjectID","0"];
		_objectUID = _playerEvacField getVariable["ObjectUID","0"];
		PVDZE_obj_Delete = [_objectID,_objectUID];
		publicVariableServer "PVDZE_obj_Delete";
		deleteVehicle _playerEvacField;
		playerHasEvacField = false;
	};
};

//Before we start the building process
//we give the player a warning that Evac-Choppers needs free sight around
//Countdown for 10 seconds
systemChat("WARNING! Evac-Choppers needs free sight to all sides");
sleep 2;
systemChat("WARNING! Make sure you got no objects like Buildings or Trees around!");
sleep 2;
_cnt = 10;
for "_i" from 1 to 10 do
{
	systemChat(format ["Building of Evac-Chopper starts in %1s - Move to cancel",_cnt]);
	if (player distance _locationPlayer > 0.2) then {
		systemChat("Building of Evac-Chopper canceled");
		s_player_makeEvacChopper = -1;
		breakOut "exit";
	};
	sleep 1;
	_cnt = _cnt - 1;
};

//Start Building

//Player did not had a Evac-Chopper yet or decided to replace it with the new target
//So we check again if he STILL has the 10ozGold in his inventory
//If yes, we remove it and say thanks ^^
_magazinesPlayer = magazines player;
_has10ozGold = ("ItemGoldBar10oz" in _magazinesPlayer);
if (!_has10ozGold) then {
	systemChat("Making a Evac-Chopper costs 1 10oz Gold - You dont have one - Sorry!");
	s_player_makeEvacChopper = -1;
	breakOut "exit";
} else {
	[player, "ItemGoldBar10oz", 1] call BIS_fnc_invRemove;
	systemChat("Making a Evac-Chopper costs 1 10oz Gold - Thanks for your payment!");
};


//The playe payd so we make the Sign and write it to the database
//We use the playerUID so the ownage is permanent!
_object = createVehicle ["HeliHRescue", _location, [], 0, "CAN_COLLIDE"];
_object addEventHandler ["HandleDamage", {false}];
_object enableSimulation false;
_object setDir _dir;
_object setPosATL _location;
player playActionNow "Medic";
_object setVariable ["CharacterID",_playerUID,true];
_object setVariable ["Classname", "HeliHRescue",true];
PVDZE_obj_Publish = [_playerUID,_object,[_dir,_location],"HeliHRescue"];
publicVariableServer "PVDZE_obj_Publish";
player removeAction s_player_evacCall;
s_player_evacCall = -1;
s_player_makeEvacChopper = -1;
playerHasEvacField = true;
//Thats it for the creation part of the Evac-Chopper
//Hope you enjoyed it :)
//Moo,
//Otter