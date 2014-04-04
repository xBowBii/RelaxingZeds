/**
 * English and French comments
 * Commentaires anglais et français
 * 
 * This file adds the ArmA 2 and Arrowhead objetcs in the configuration variables of the logistics system.
 * Fichier ajoutant les objets d'ArmA 2 et Arrowhead dans la configuration du système de logistique.
 * 
 * Important note : All the classes names which inherits from the ones used in configuration variables will be also available.
 * Note importante : Tous les noms de classes dérivant de celles utilisées dans les variables de configuration seront aussi valables.
 */

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of vehicles which can tow towable objects.
 * This is the list of Vehicles that are ABLE to tow.
 */
R3F_LOG_CFG_remorqueurs = R3F_LOG_CFG_remorqueurs +
["GAZ_Vodnik_MedEvac,
GAZ_Vodnik,
V3S_Civ,
V3S_GUE,
KamazReammo,
KamazRefuel,
KamazRepair,
KamazOpen,
Kamaz,
UralRepair_CDF,
UralRefuel_INS,
UralRefuel_CDF,
UralReammo_INS,
UralReammo_CDF,
UralOpen_CDF,
UralOpen_CDF,
UralOpen_CDF,
Ural_CDF,
UralOpen_INS,
Ural_CDF,
MTVR_Refuel,
MTVR_Repair,
MTVR_Reammo,
MTVR,
MTVR_DES_EP1,
MtvrReammo_DES_EP1,
MtvrRefuel_DES_EP1,
MtvrRepair_DES_EP1,
MtvrSalvage_DES_EP1,
MtvrSupply_DES_EP1,
UralReammo_TK_EP1,
UralRefuel_TK_EP1,
UralRepair_TK_EP1,
UralSalvage_TK_EP1,
UralSupply_TK_EP1,
Ural_TK_CIV_EP1,
Ural_UN_EP1,
V3S_Open_TK_CIV_EP1,
V3S_Open_TK_EP1,
V3S_Reammo_TK_GUE_EP1,
V3S_Refuel_TK_GUE_EP1,
V3S_Repair_TK_GUE_EP1,
V3S_Salvage_TK_GUE_EP1,
V3S_Supply_TK_GUE_EP1,
V3S_TK_EP1,
V3S_TK_GUE_EP1"];

/**
 * List of class names of towables objects.
 * This is the list of vehicles that ARE towable
 */
R3F_LOG_CFG_objets_remorquables = R3F_LOG_CFG_objets_remorquables +
["HMMWV_Ambulance,
HMMWV,
HMMWV_Armored,
UAZ_MG_INS,
UAZ_MG_CDF,
UAZ_AGS30_RU,
UAZ_AGS30_INS,
UAZ_AGS30_CDF,
UAZ_RU,
UAZ_INS,
UAZ_CDF,
SkodaRed,
SkodaGreen,
Skoda,
SkodaBlue,
VWGolf,
car_hatchback,
car_sedan,
Lada1,
Lada2,
LadaLM,
datsun1_civil_1_open,
datsun1_civil_2_covered,
datsun1_civil_3_open,
hilux1_civil_1_open,
hilux1_civil_2_covered,
hilux1_civil_3_open,
MMT_Civ,
MMT_USMC,
M1030,
TT650_Gue,
TT650_Ins,
TT650_Civ,
TowingTractor,
ATV_CZ_EP1,
ATV_US_EP1,
HMMWV_Ambulance_DES_EP1,
HMMWV_Ambulance_CZ_DES_EP1,
HMMWV_DES_EP1,
HMMWV_M1035_DES_EP1,
HMMWV_M1151_M2_CZ_DES_EP1,
HMMWV_M1151_M2_DES_EP1,
HMMWV_M998A2_SOV_DES_EP1,
HMMWV_Terminal_EP1,
Lada1_TK_CIV_EP1,
LandRover_CZ_EP1,
Lada2_TK_CIV_EP1,
LandRover_TK_CIV_EP1,
M1030_US_DES_EP1,
Offroad_DSHKM_TK_GUE_EP1,
Old_bike_TK_CIV_EP1,
Old_bike_TK_INS_EP1,
Old_moto_TK_Civ_EP1,
Pickup_PK_TK_GUE_EP1,
SUV_TK_CIV_EP1,
SUV_TK_EP1,
SUV_UN_EP1,
TT650_TK_CIV_EP1,
TT650_TK_EP1,
UAZ_MG_TK_EP1,
UAZ_Unarmed_TK_CIV_EP1,
UAZ_Unarmed_TK_EP1,
UAZ_Unarmed_UN_EP1,
VolhaLimo_TK_CIV_EP1,
Volha_1_TK_CIV_EP1,
Volha_2_TK_CIV_EP1,
hilux1_civil_3_open_EP1"];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of air vehicles which can lift liftable objects.
 * This is the list of HELICOPTERS that can lift
 */
R3F_LOG_CFG_heliporteurs = R3F_LOG_CFG_heliporteurs +
["Mi17_CDF,
Mi17_INS,
Mi17_medevac_CDF,	
Mi17_medevac_Ins,	
Mi17_medevac_RU,
Mi17_Civilian,
UH1Y,
MV22,
CH_47F_EP1,
Mi171Sh_CZ_EP1,
Mi17_TK_EP1,
Mi17_UN_CDF_EP1,
UH1H_TK_EP1,
UH1H_TK_GUE_EP1,
UH60M_EP1,
UH1H_DZ,
UH60M_MEV_EP1,
MH60S,
Mi17_CDF,
UH1Y,
BAF_Merlin_HC3_D"];

/**
 * List of class names of liftable objects.
 * This is the list of vehicles that CAN be lifted
 */
R3F_LOG_CFG_objets_heliportables = R3F_LOG_CFG_objets_heliportables +
["HMMWV_Ambulance,
HMMWV,
HMMWV_Armored,
UAZ_MG_INS,
UAZ_MG_CDF,
UAZ_AGS30_RU,
UAZ_AGS30_INS,
UAZ_AGS30_CDF,
UAZ_RU,
UAZ_INS,
UAZ_CDF,
SkodaRed,
SkodaGreen,
Skoda,
SkodaBlue,
VWGolf,
car_hatchback,
car_sedan,
Lada1,
Lada2,
LadaLM,
datsun1_civil_1_open,
datsun1_civil_2_covered,
datsun1_civil_3_open,
hilux1_civil_1_open,
hilux1_civil_2_covered,
hilux1_civil_3_open,
MMT_Civ,
MMT_USMC,
M1030,
TT650_Gue,
TT650_Ins,
TT650_Civ,
TowingTractor,
ATV_CZ_EP1,
ATV_US_EP1,
HMMWV_Ambulance_DES_EP1,
HMMWV_Ambulance_CZ_DES_EP1,
HMMWV_DES_EP1,
HMMWV_M1035_DES_EP1,
HMMWV_M1151_M2_CZ_DES_EP1,
HMMWV_M1151_M2_DES_EP1,
HMMWV_M998A2_SOV_DES_EP1,
HMMWV_Terminal_EP1,
Lada1_TK_CIV_EP1,
LandRover_CZ_EP1,
Lada2_TK_CIV_EP1,
LandRover_TK_CIV_EP1,
M1030_US_DES_EP1,
Offroad_DSHKM_TK_GUE_EP1,
Old_bike_TK_CIV_EP1,
Old_bike_TK_INS_EP1,
Old_moto_TK_Civ_EP1,
Pickup_PK_TK_GUE_EP1,
SUV_TK_CIV_EP1,
SUV_TK_EP1,
SUV_UN_EP1,
TT650_TK_CIV_EP1,
TT650_TK_EP1,
UAZ_MG_TK_EP1,
UAZ_Unarmed_TK_CIV_EP1,
UAZ_Unarmed_TK_EP1,
UAZ_Unarmed_UN_EP1,
VolhaLimo_TK_CIV_EP1,
Volha_1_TK_CIV_EP1,
Volha_2_TK_CIV_EP1,
hilux1_civil_3_open_EP1,
HMMWV_TOW"];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
 * This section use a quantification of the volume and/or weight of the objets.
 * The arbitrary referencial used is : an ammo box of type USSpecialWeaponsBox "weights" 5 units.
 * 
 * Cette section utilise une quantification du volume et/ou poids des objets.
 * Le référentiel arbitraire utilisé est : une caisse de munition de type USSpecialWeaponsBox "pèse" 5 unités.
 * 
 * Note : the priority of a declaration of capacity to another corresponds to their order in the tables.
 *   For example : the "Truck" class is in the "Car" class (see http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   If "Truck" is declared with a capacity of 140 before "Car". And if "Car" is declared after "Truck" with a capacity of 40,
 *   Then all the sub-classes in "Truck" will have a capacity of 140. And all the sub-classes of "Car", excepted the ones
 *   in "Truck", will have a capacity of 40.
 * 
 * Note : la priorité d'une déclaration de capacité sur une autre correspond à leur ordre dans les tableaux.
 *   Par exemple : la classe "Truck" appartient à la classe "Car" (voir http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   Si "Truck" est déclaré avec une capacité de 140 avant "Car". Et que "Car" est déclaré après "Truck" avec une capacité de 40,
 *   Alors toutes les sous-classes appartenant à "Truck" auront une capacité de 140. Et toutes les sous-classes appartenant
 *   à "Car", exceptées celles de "Truck", auront une capacité de 40.
 */

/**
 * List of class names of (ground or air) vehicles which can transport transportable objects.
 * The second element of the arrays is the load capacity (in relation with the capacity cost of the objects).
 * 
 * [Vehicle Name, Capacity],
 * ["Ikarus", 50],
 */
R3F_LOG_CFG_transporteurs = R3F_LOG_CFG_transporteurs +
[];

/**
 * List of class names of transportable objects.
 * The second element of the arrays is the cost capacity (in relation with the capacity of the vehicles).
 * 
 * [VEHICLE NAME, COST CAPACITY],
 * ["ATV_Base_EP1", 20],
 */
R3F_LOG_CFG_objets_transportables = R3F_LOG_CFG_objets_transportables +
[];


/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects moveable by player.
 * "MASH",
 */
R3F_LOG_CFG_objets_deplacables = R3F_LOG_CFG_objets_deplacables +
[];