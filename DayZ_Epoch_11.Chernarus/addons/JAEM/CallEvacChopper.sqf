//JAEM
//Just another Chopper-Evac Mod v1.0
//OtterNas3
//01/14/2014


private ["_evacFieldID","_checkForChopper","_validPlayerEvacField","_evacCallerID","_evacCallerUID","_evacFields","_playerEvacField","_heliHRescue","_routeFinished","_evacZone","_chopperStartPos","_getChopperStartPos","_evacZoneDistance","_startZoneWaypoint","_evacZoneWaypoint","_part","_damage","_hitpoints","_evacChopperFuel","_finishMarker"];
player removeAction s_player_evacCall;
s_player_evacCall = 1;
systemChat ("Searching for your Evac-Chopper - Please wait...");
sleep 5;

//Setting needed variables to check which Evac-Field the player owns
_evacCallerID = (player getVariable ["CharacterID","0"]);
_evacCallerUID = (getPlayerUID player);
_playerEvacField = [];

//Getting all HeliHRescue signs on Server and check it Player is owner
_evacFields = nearestObjects [player, ["HeliHRescue"], 20000];
if ((count _evacFields) > 0) then
{
	{
		_evacFieldID = _x getVariable ["CharacterID", "0"];
		if (_evacCallerID == _evacFieldID || _evacCallerUID == _evacFieldID) then {
			_playerEvacField set [(count _playerEvacField), _x];
		};
	} forEach _evacFields;
};

//We found a HeliHRescue of the player now check if a Chopper is on it
if ((count _playerEvacField) > 0) then {
	_validPlayerEvacField = [];
	{
		_checkForChopper = nearestObjects [_x, ["Helicopter"], 10];
		if ((count _checkForChopper) > 0) then {
			_validPlayerEvacField set [(count _validPlayerEvacField), _x];
			evacChopper = _checkForChopper select 0;
		} else {
			systemChat ("Sorry but you dont have a Evac-Chopper");
			s_player_evacCall = -1;
			breakOut "exit";
		};
	} forEach _playerEvacField;
};

//We found a Chopper
systemChat("Player Evac-Chopper found - Checking Fuel and Damage");
sleep 5;
//Let's get the Damage of the Chopper and the fuel

//Fuel check
_evacChopperFuel = fuel evacChopper;
if (_evacChopperFuel < 0.2) then {
	systemChat("Sorry but the Fuel of your Evac-Chopper is to low to fly");
	systemChat("Keep your Evac-Chopper refueled next time!");
	sleep 30;
	s_player_evacCall = -1;
	breakOut "exit";
};

//Damage check
_hitpoints = evacChopper call vehicle_getHitpoints;
{			
	_damage = [evacChopper,_x] call object_getHit;
	if(["Engine",_x,false] call fnc_inString) then {
		_part = "PartEngine";
	};
		
	if(["HRotor",_x,false] call fnc_inString) then {
		_part = "PartVRotor"; //yes you need PartVRotor to fix HRotor LOL
	};

	if (_damage >= 1 && (_part == "PartEngine" || _part == "PartVRotor")) then {
		if(_part == "PartEngine") then {
			systemChat("Sorry but the Engine of your Evac-Chopper is to damaged to fly");
			systemChat("Keep your Evac-Chopper repaired next time!");
		};
		if (_part == "PartVRotor") then {
			systemChat("Sorry but the Main-Rotor of your Evac-Chopper is to damaged to fly");
			systemChat("Keep your Evac-Chopper repaired next time!");
		};
		sleep 30;
		s_player_evacCall = -1;
		breakOut "exit";
	};
} forEach _hitpoints;
sleep 5;

//All is okay and we can start the creation of the Rescue sign
//create the AI Pilot and waypoints
//and get him on his way to the player
systemChat("Check done - Your Evac-Chopper is starting");
//Create the Evacuation Zone Marker
_heliHRescue = "HeliHRescue" createVehicle getPosATL player;
_heliHRescue setDir (getDir player);
_heliHRescue setPosATL (getPosATL player);

//Reset of the checkpoint bool's
evacZoneReached = false;
_routeFinished = false;

//Get needed positions
_evacZone = (getPosATL _heliHRescue);
_getChopperStartPos = getPosATL evacChopper;
_chopperStartPos = _getChopperStartPos;

//Unlocking the Chopper and create the AI Pilot
evacChopper setVehicleLock "UNLOCKED";
evacChopperGroup = createGroup WEST;
evacChopperPilot = evacChopperGroup createUnit ["USMC_Soldier_pilot", evacChopper, [], 0,"LIEUTENANT"];
{[evacChopperPilot, _x, 1] call BIS_fnc_invRemove;}forEach items evacChopperPilot;
{[evacChopperPilot, _x, 1] call BIS_fnc_invRemove;}forEach magazines evacChopperPilot;
{[evacChopperPilot, _x, 1] call BIS_fnc_invRemove;}forEach weapons evacChopperPilot;
evacChopperPilot removeAllEventHandlers "handleDamage";
evacChopperPilot addEventHandler ["handleDamage", {false}];
evacChopperPilot allowDamage false;
evacChopperPilot assignAsDriver evacChopper;
evacChopperPilot moveInDriver evacChopper;
evacChopperPilot setSkill 1;
evacChopperGroup setBehaviour "CARELESS";
sleep 1;

//Lock the Chopper again so noone can jump in
evacChopper setVehicleLock "LOCKED";
//Turn the Engine on and set fly height for the Pilot
evacChopper engineOn true;
evacChopper flyInHeight 100;

//Create the Waypoint for the Evacuation Zone
_startZoneWaypoint = evacChopperGroup addWaypoint [_chopperStartPos, 0];
_startZoneWaypoint setWaypointBehaviour "CARELESS";
_startZoneWaypoint setWaypointType "MOVE";
_startZoneWaypoint setWaypointCompletionRadius 5;
_startZoneWaypoint setWaypointSpeed "FULL";
_evacZoneWaypoint = evacChopperGroup addWaypoint [_evacZone, 0];
_evacZoneWaypoint setWaypointBehaviour "CARELESS";
_evacZoneWaypoint setWaypointType "MOVE";
_evacZoneWaypoint setWaypointCompletionRadius 5;
_evacZoneWaypoint setWaypointSpeed  "FULL" ;
_evacZoneWaypoint setWaypointStatements ["true", "evacZoneReached = true; evacChopper land 'LAND';"];
_evacZoneWaypoint setWaypointCombatMode "BLUE";

//Checking for player still alive - Evac Zone reached - Chopper still alive
//Showing a Hint-Box with informations to the player
//about the Evac-Chopper - Height - Speed - Distance
while {sleep 0.5; alive player && !_routeFinished && alive evacChopper} do {
	debugMonitor = false;
	//Still on his way
	if (!evacZoneReached) then {
		_evacZoneDistance = format["%1m", round (evacChopper distance _evacZone)];
	} else {
		//Arrived!
		if (((getPosATL evacChopper) select 2) < 1) then {
			waitUntil {!isEngineOn evacChopper};
			_routeFinished = true;
			_evacZoneDistance = "!!! ARRIVED !!!";
			_evacZoneWaypoint = evacChopperGroup addWaypoint [_evacZone, 0];
			_evacZoneWaypoint setWaypointType "GETOUT";
		} else {
			_evacZoneDistance = format["%1m", round (evacChopper distance _evacZone)];
		};
	};
	hintSilent parseText format ["
		<t size='1.15'	font='Bitstream'align='center' 	color='#5882FA'>EVAC-Chopper</t>			<br/>
		<t size='1'		font='Bitstream'align='center' 	color='#00FF00'>----------------------</t>	<br/>
		<t size='1'		font='Bitstream'align='left' 	color='#FFBF00'>Fly Height:</t>				<t size='1'		font='Bitstream'align='right'>%1</t><br/>
		<t size='1'		font='Bitstream'align='left' 	color='#FFBF00'>Fly Speed:</t>				<t size='1'		font='Bitstream'align='right'>%2</t><br/>
		<t size='1'		font='Bitstream'align='left' 	color='#FFBF00'>Distance:</t>				<t size='1'		font='Bitstream'align='right'>%3</t><br/>",
		(round ((position evacChopper) select 2)), (round (speed evacChopper)), _evacZoneDistance
	];
};

[] spawn fnc_debug;

//If Chopper got destroyed delete AI Pilot and his group
//give a Hint to the player about the Crash
//and exit the script
if (!alive evacChopper) then {
	{deleteWaypoint _x} forEach waypoints evacChopperGroup;
	deleteVehicle evacChopperPilot;
	waitUntil{sleep 5; count units group evacChopperPilot == 0};
	deleteGroup evacChopperGroup;
	deleteVehicle _heliHRescue;
	hintSilent parseText format ["
		<t size='1.15'	font='Bitstream'align='center' 	color='#5882FA'>EVAC-Chopper</t>			<br/>
		<t size='1'		font='Bitstream'align='center' 	color='#00FF00'>----------------------</t>	<br/>
		<t size='1.15'	font='Bitstream'align='center' 	color='#FFBF00'>!!! CRASHED !!!</t>			<br/>"
	];
	s_player_evacCall = -1;
	breakOut "exit";
};

//If player dies reset the Evac-Chopper to the start position
//remove the AI Pilot and his group
//delete the Evac-Zone Marker
//and exit the script
if (!alive player) then {
	deleteVehicle _heliHRescue;
	evacChopper engineOn false;
	evacChopper setPosATL _chopperStartPos;
	evacChopper setVelocity [0,0,0.01];
	{deleteWaypoint _x} forEach waypoints evacChopperGroup;
	_evacZoneWaypoint = evacChopperGroup addWaypoint [_chopperStartPos, 0];
	_evacZoneWaypoint setWaypointType "GETOUT";
	waitUntil{{_x in evacChopper} count units group evacChopperPilot == 0};
	{deleteWaypoint _x} forEach waypoints evacChopperGroup;
	deleteVehicle evacChopperPilot;
	waitUntil{sleep 5; count units group evacChopperPilot == 0};
	deleteGroup evacChopperGroup;
	evacChopper setVehicleLock "LOCKED";
	s_player_evacCall = -1;
	breakOut "exit";
};

//All good to this point
//Create Visible Marker
_dayTime = dayTime;
if (_dayTime > 6 && _dayTime < 18.5) then {
	_finishMarker = "SmokeShellGreen" createVehicle getPosATL evacChopper;
	_finishMarker setPosATL (getPosATL evacChopper);
	_finishMarker attachTo [evacChopper,[0,0,0]];
};
if (_dayTime > 18.5 && _dayTime < 6) then {
	_finishMarker = "ARTY_Flare_Medium" createVehicle getPosATL evacChopper;
	_finishMarker setPosATL (getPosATL evacChopper);
	_finishMarker attachTo [evacChopper, [0,0,0]];
};

//We delete the AI Pilot his group and the Evac-Zone Marker
waitUntil{{_x in evacChopper} count units group evacChopperPilot == 0};
{deleteWaypoint _x} forEach waypoints evacChopperGroup;
deleteVehicle evacChopperPilot;
waitUntil{sleep 0.5; count units group evacChopperPilot == 0};
deleteGroup evacChopperGroup;
deleteVehicle _heliHRescue;

//Wait until player dies - Chopper get destroyed or
//the player moves close to the Evac-Chopper
waitUntil {sleep 1; (player distance evacChopper) < 10 || !alive player || !alive evacChopper};

//If player dies reset the Evac-Chopper to the start position
//remove the AI Pilot and his group
//delete the Evac-Zone Marker
//and exit the script
if (!alive player) then {
	deleteVehicle _finishMarker;
	deleteVehicle _heliHRescue;
	evacChopper setPosATL _chopperStartPos;
	evacChopper setVelocity [0,0,0.01];
	{deleteWaypoint _x} forEach waypoints evacChopperGroup;
	_evacZoneWaypoint = evacChopperGroup addWaypoint [_chopperStartPos, 0];
	_evacZoneWaypoint setWaypointType "GETOUT";
	waitUntil{{_x in evacChopper} count units group evacChopperPilot == 0};
	{deleteWaypoint _x} forEach waypoints evacChopperGroup;
	deleteVehicle evacChopperPilot;
	waitUntil{sleep 5; count units group evacChopperPilot == 0};
	deleteGroup evacChopperGroup;
	evacChopper setVehicleLock "LOCKED";
	s_player_evacCall = -1;
	breakOut "exit";
};

//All fine player is close to the Chopper
//in that case we unlock it
systemChat("Owner detected - ACCESS GRANTED! Have a good Flight Sir!");
evacChopper setVehicleLock "UNLOCKED";

//delete the Smoke/Flare marker
deleteVehicle _finishMarker;

//reset the action menu variable
s_player_evacCall = -1;		


//Thats it for the Evacutaion process
//Hope you enjoyed it :)
//Moo,
//Otter