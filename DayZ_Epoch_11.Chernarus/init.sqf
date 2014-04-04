/*	
	For DayZ Epoch
	Addons Credits: Jetski Yanahui by Kol9yN, Zakat, Gerasimow9, YuraPetrov, zGuba, A.Karagod, IceBreakr, Sahbazz
*/
startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance =	11;					//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio true;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

// DayZ Epoch config
DZE_MissionLootTable = false;
spawnShoremode = 0; // Default = 1 (on shore)
spawnArea= 1500; // Default = 1500
MaxHeliCrashes= 25; // Default = 5
MaxVehicleLimit = 1200; // Default = 50
MaxMineVeins = 50;
MaxDynamicDebris = 150; // Default = 100
dayz_MapArea = 14000; // Default = 10000
dayz_maxLocalZombies = 10; // Default = 30 
dayz_zedsAttackVehicles = false;
DZE_DeathMsgGlobal = false; 
DZE_DeathMsgTitleText = true; 
DZE_requireplot = 0;
DZE_BuildingLimit = 500;
DZE_BackpackGuard = true;
DZE_R3F_Weight = false;
DZE_GodModeBase = true;
DZE_StaticConstructionCount = 1;
dayz_paraSpawn = false;
dayz_minpos = 0; 
dayz_maxpos = 16000;
DZE_ForceNameTag = true;
dayz_sellDistance_vehicle = 10;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 40;
DZE_HeliLift = false;
DZE_PlayerZed = false;
DZE_vehicleAmmo = 1; //Default = 0, deletes ammo from vehicles with machine guns every restart if set to 0.
dayz_maxAnimals = 4; // Default: 8
dayz_tameDogs = false;
DynamicVehicleDamageLow = 20; // Default: 0
DynamicVehicleDamageHigh = 60; // Default: 100
DynamicVehicleFuelLow = 0;
DynamicVehicleFuelHigh = 50;
DZE_AllowForceSave = true;

// Newspawns Loadout
DefaultMagazines = ["30Rnd_545x39_AK","30Rnd_545x39_AK","ItemBandage","ItemBandage","ItemBloodbag","ItemPainkiller","ItemSodaRbull"];
DefaultWeapons = ["AK_74","ItemMap","ItemToolbox","ItemKnife"];
DefaultBackpack = "DZ_Patrol_Pack_EP1";
DefaultBackpackWeapon = "";

EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"],["any","any","any","any",15,"supply_drop"],["any","any","any","any",10,"Military"],["any","any","any","any",25,"Treasure"],["any","any","any","any",40,"Supplyitems"],["any","any","any","any",55,"Construction"]];
dayz_fullMoonNights = true;

//Load in compiled functions
call compile preprocessFileLineNumbers "custom\variables.sqf";				// \z\addons\dayz_code\init Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "custom\compiles.sqf";				//Compile regular functions
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "server_traders.sqf";				//Compile trader configs
progressLoadingScreen 1.0;

fnc_usec_selfActions = compile preprocessFileLineNumbers "custom\fn_selfActions.sqf";



"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if (isServer) then {
	call compile preprocessFileLineNumbers "custom\dynamic_vehicle.sqf";
	//Compile vehicle configs
	
	// Add trader citys
	_nil = [] execVM "custom\mission.sqf";
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	execVM "SERVICE\service_point.sqf";
	
	//Run the player monitor
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	
	//anti Hack

	//Lights
	//[0,0,true,true,true,58,280,600,[0.698, 0.556, 0.419],"Generator_DZ",0.1] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
	
	
	
	[] execVM "SERVICE\service_point.sqf";
	
	// Custom Monitor
	[] execVM "scripts\custom_monitor.sqf";
	
	
	// Evac Chopper
	[] execVM "addons\JAEM\EvacChopper_init.sqf";
};

//Start Dynamic Weather
[] execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";

#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

// auto refuell
[] execVM "scripts\kh_actions.sqf"; 

[] ExecVM "custom\loginCamera.sqf";

// Lift und Tow
[] execVM "R3F_ARTY_AND_LOG\init.sqf";	

// Safe Zone
[] execVM "scripts\safezone.sqf";

// Custom Menu
[] execVM "scripts\custom_menu.sqf";

//Barracken
[] ExecVM "Barracken.sqf";

//DayZ Watermark
if (!isNil "server_name") then {
	[] spawn {
		waitUntil {(!isNull Player) and (alive Player) and (player == player)};
		waituntil {!(isNull (findDisplay 46))};
		5 cutRsc ["wm_disp","PLAIN"];
		((uiNamespace getVariable "wm_disp") displayCtrl 1) ctrlSetText server_name;
	};
};

// Security + AntiSteal Loadouts.
//If (freshSpawn == 2) then {
//[] ExecVM "\z\addons\dayz_server\Loadouts\loadouts.sqf";
//};
