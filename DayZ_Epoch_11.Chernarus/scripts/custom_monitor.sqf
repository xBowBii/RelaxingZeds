fnc_debug = {
    debugMonitor = true;
    while {debugMonitor} do
    {
					_nearestCity = nearestLocations [getPos player, ["NameCityCapital","NameCity","NameVillage","NameLocal"],750];
					_textCity = "Wilderness";
					if (count _nearestCity > 0) then {_textCity = text (_nearestCity select 0)};
					
					_timeleft = _combattimeout-time;
					_kills = 		player getVariable["zombieKills",0];
					_killsH = 		player getVariable["humanKills",0];
					_killsB = 		player getVariable["banditKills",0];
					_humanity =		player getVariable["humanity",0];					
					_dmpic = "";
					_dmtit = ""; // ('' + (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'displayName')))
					if (player == vehicle player) then {
						_dmpic = (gettext (configFile >> 'cfgWeapons' >> (currentWeapon player) >> 'picture'));
						_dmtit = (gettext (configFile >> 'cfgWeapons' >> (currentWeapon player) >> 'displayName'));
					} else {
						_dmpic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));
						_dmtit = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'displayName'));
					};
					
				hintSilent parseText format ["
				<t size='1' font='Bitstream' align='Center' >%19</t><br/>
				<img size='4.75' image='%9' align='Center'/><br/>
				<t size='1' font='Bitstream' align='left' color='#EEC900'>Location:</t><t size='1' font='Bitstream' align='right' color='#FFFAF0'>%11</t><br/>
				<t size='1' font='Bitstream' align='center' color='#DDDDDD'></t><br/>
				<t size='1' font='Bitstream' align='left' color='#B40404'>Blood:</t><t size='1' font='Bitstream' align='right' color='#FFFAF0'>%1</t><br/>
				<t size='1' font='Bitstream' align='left' color='#2E64FE'>Humanity:</t><t size='1' font='Bitstream' align='right' color='#FFFAF0'>%2</t><br/>
				<t size='1' font='Bitstream' align='left' color='#EEC900'>Killed Heroes:</t><t size='1' font='Bitstream' align='right' color='#FFFAF0'>%3</t><br/>
				<t size='1' font='Bitstream' align='left' color='#EEC900'>Killed Bandits:</t><t size='1' font='Bitstream' align='right' color='#FFFAF0'>%4</t><br/>
				<t size='1' font='Bitstream' align='left' color='#EEC900'>Killed Zombies:</t><t size='1' font='Bitstream' align='right' color='#FFFAF0'>%5</t><br/>
				<t size='1' font='Bitstream' align='left' color='#EEC900'></t><br/>
				<t size='1' font='Bitstream' align='left' color='#EEC900'>FPS:</t><t size='1' font='Bitstream' align='right' color='#FFFAF0'>%14</t><br/>
				<t size='1' font='Bitstream' align='center' color='#DDDDDD'></t><br/>
				<t size='1' font='Bitstream' align='center' color='#DDDDDD'></t><br/>
				<t size='1' font='Bitstream' align='center' color='#DDDDDD'>RelaxingZeds Custom Mod (%17/42)</t><br/>",

							r_player_blood,												//1
							round _humanity,											//2
							_killsH,													//3
							_killsB,													//4
							_kills,														//5
							_headShots,													//6
							(dayz_Survived),											//7
							(360-(round(serverTime/60))),								//8
							_dmpic,														//9
							_logo,														//10
							_textCity,													//11
							count entities "zZombie_Base",								//12
							{alive _x} count entities "zZombie_Base",					//13
							(round diag_FPS),													//14
							dayz_playerName, //15
							round(dayz_temperatur), //16
							(count playableUnits),  //17
							(round(357-(serverTime) / 60)), //18
							_dmtit, //19
							MissionGoName, // 20
							MissionGoNameMinor //21
						]; 
			sleep 2;
    };
};

sleep 25.5;
systemChat ("<System>: -END- key toggles the debugmonitor"); 
[] spawn fnc_debug;
