/*
SS13 Map Making Files v. 1
Applicable up to SS13 version

Disclaimer:
By using the files you automatically agree:
A. Not to use the icons in any way except for the SS13 map making tools
B. Not distribute the files to anyone.
C. To agree automatically to any changes in this contract.

Instructions:
Basically what you have here is the stripped down SS13 files.
Your main file is main.dmp
	NEVER DELETE THIS!
	THIS IS the SS13 map in its entirety.
	You may wish to uncheck it though
		however, you probably will never need to compile.
Also look at areas.dm as it has a few mroe instructions on dealing with areas.

To use these files jsut create a enw map file. You can adjust the dimensions to anything!
However for now try to keep the z levels the same.
As in so that the prison station is on its current level and so is SS13 as well as CC.
	All the other sats can be moved, deleted, etc. You can even add some.

Once you are done adding everything, send me ONLY the *.dmp and the areas.dm file.

Post on general under new map
	if you need access to any more variables to customize the map.
*/

//Don't touch
#define AVER_OXY		756000 //cubic meters
#define AVER_PLAS		0
#define AVER_NO2		0
#define AVER_N2			2844000 //cubic meters
#define AVER_CO2		0
/turf
	var
		oxygen = AVER_OXY
		poison = AVER_PLAS//plasma
		co2 = AVER_CO2
		sl_gas = AVER_NO2
		n2 = AVER_N2
/turf/space
	icon = 'turfs.dmi'
	icon_state = "space"
/turf/station/r_wall
	icon = 'wall.dmi'
	icon_state = "r_wall"
/turf/station/wall
	icon = 'wall.dmi'
	icon_state = ""
/turf/station/floor/plasma_test
//This was used for beta-testing fire effects
//Igniter+THIS=Instant incinerator until the floor burns away that is
//Don't place this on SS13... use a custom designed floor instead
	icon = 'Icons.dmi'
	icon_state = "Floor"
/turf/station/floor
	icon = 'Icons.dmi'
	icon_state = "Floor"
/turf/station/floor/grid
	icon = 'weap_sat.dmi'
	icon_state = "grid"
/turf/station/engine/floor
	icon = 'engine.dmi'
	icon_state = "floor"
/turf/station/engine
	icon = 'engine.dmi'
	icon_state = ""
/turf/station/command/floor/other
	icon = 'Icons.dmi'
	icon_state = "Floor"
/turf/station/command/floor
	icon = 'Icons.dmi'
	icon_state = "Floor3"
/turf/station/command/wall/other
	icon = 'wall.dmi'
	icon_state = "r_wall"
/turf/station/command/wall
	icon = 'wall.dmi'
	icon_state = "CCWall"
/turf/station/shuttle/wall
	icon = 'shuttle.dmi'
	icon_state = "wall"
/turf/station/shuttle/floor
	icon = 'shuttle.dmi'
	icon_state = "floor"

/mob/monkey
	icon = 'monkey.dmi'
	icon_state = "monkey1"

/obj/move/airtunnel/connector/wall
	icon = 'airtunnel.dmi'
	icon_state = "wall-c"
/obj/move/airtunnel/connector
	icon = 'airtunnel.dmi'
	icon_state = "floor-c"
/obj/move/airtunnel/wall
	icon = 'airtunnel.dmi'
	icon_state = "wall"

/obj/move/floor
	icon = 'shuttle.dmi'
	icon_state = "floor"
/obj/move/wall
	icon = 'shuttle.dmi'
	icon_state = "wall"

/obj/machinery/at_indicator
	icon = 'airtunnel.dmi'
	icon_state = "reader00"
/obj/machinery/computer/airtunnel
	icon = 'airtunnelcomputer.dmi'
	icon_state = "console00"
/obj/machinery/computer/security
	icon = 'stationobjs.dmi'
	icon_state = "sec_computer"
	var/network
/obj/machinery/computer/communications
	icon = 'stationobjs.dmi'
	icon_state = "comm_computer"
/obj/machinery/computer/card
	icon = 'stationobjs.dmi'
	icon_state = "id_computer"
/obj/machinery/computer/pod
	icon = 'escapepod.dmi'
	icon_state = "computer"
	var/id = 1//For synchronization with the other pod launch stuff
/obj/machinery/computer/med_data
	icon = 'weap_sat.dmi'
	icon_state = "computer"
/obj/machinery/computer/secure_data
	icon = 'weap_sat.dmi'
	icon_state = "computer"
/obj/machinery/computer/sleep_console
	icon = 'Cryogenic2.dmi'
	icon_state = "sleeperconsole"
/obj/machinery/computer/atmosphere/siphonswitch/mastersiphonswitch
	icon = 'turfs.dmi'
	icon_state = "switch"
/obj/machinery/computer/atmosphere/siphonswitch
	icon = 'turfs.dmi'
	icon_state = "switch"
/obj/machinery/computer/dna
	icon = 'Cryogenic2.dmi'
	icon_state = "dna_computer"
/obj/machinery/computer/engine
	icon = 'enginecomputer.dmi'
	icon_state = ""
/obj/machinery/computer/hologram_comp
	icon = 'stationobjs.dmi'
	icon_state = "holo_console0"
/obj/machinery/computer/prison_shuttle
	icon = 'shuttle.dmi'
	icon_state = "shuttlecom"
/obj/machinery/computer/shuttle
	icon = 'shuttle.dmi'
	icon_state = "shuttlecom"
/obj/machinery/computer/teleporter
	icon = 'stationobjs.dmi'
	icon_state = "tele_computer"
/obj/machinery/computer/data/weapon/log
	icon = 'weap_sat.dmi'
	icon_state = "computer"
/obj/machinery/computer/data/weapon/info
	icon = 'weap_sat.dmi'
	icon_state = "computer"
/obj/machinery/computer/data
	icon = 'weap_sat.dmi'
	icon_state = "computer"

/obj/machinery/camera
	icon = 'stationobjs.dmi'
	icon_state = "camera"
	var/network	//Set this as same with a computer to allow multiple camera names
	//Default ones sued are SS13 and PS13 but you can use other strings
	//YOU CANNOT merge networks!
	var/c_tag	//Name shown on security computer.
/obj/machinery/sec_lock
	icon = 'stationobjs.dmi'
	icon_state = "sec_lock"
	var/a_type = 0//See map for better info:
	//0 means the doors are lcoated S/SE,1=SW/Knight's move SW (prison),2=NW/Knight's move NW (prison)
/obj/machinery/injector
	icon = 'stationobjs.dmi'
	icon_state = "injector"
/obj/machinery/alarm/indicator
	icon = 'airtunnel.dmi'
	icon_state = "indicator"
/obj/machinery/alarm
	icon = 'stationobjs.dmi'
	icon_state = "alarm:0"
/obj/machinery/meter
	icon = 'pipes.dmi'
	icon_state = "meter"
/obj/machinery/connector
	icon = 'pipes.dmi'
	icon_state = "connector"
/obj/machinery/mass_driver
	icon = 'stationobjs.dmi'
	icon_state = "mass_driver"
	var/id = 1

/obj/machinery/pipes/flexipipe
	icon = 'wire.dmi'
	icon_state = "12"
/obj/machinery/pipes/high_capacity
	icon = 'hi_pipe.dmi'
	icon_state = "12"
/obj/machinery/pipes
	var/p_dir = 12
	//used internally, make it the same as the icon_state
	//FYI its a bit flag variable

/obj/machinery/atmoalter/siphs/fullairsiphon/port
	icon = 'stationobjs.dmi'
	icon_state = "siphon:0"
/obj/machinery/atmoalter/siphs/fullairsiphon/air_vent
	icon = 'aircontrol.dmi'
	icon_state = "vent2"
/obj/machinery/atmoalter/siphs/fullairsiphon
	icon = 'turfs.dmi'
	icon_state = "siphon:0"
/obj/machinery/atmoalter/siphs/scrubbers/air_filter
	icon = 'aircontrol.dmi'
	icon_state = "vent2"
/obj/machinery/atmoalter/siphs/scrubbers/port
	icon = 'stationobjs.dmi'
	icon_state = "scrubber:0"
/obj/machinery/atmoalter/siphs/scrubbers
	icon = 'turfs2.dmi'
	icon_state = "siphon:0"

/obj/machinery/atmoalter/heater
	icon = 'stationobjs.dmi'
	icon_state = "heater1"
/obj/machinery/atmoalter/canister/poisoncanister
	icon = 'canister.dmi'
	icon_state = "0orange"
/obj/machinery/atmoalter/canister/oxygencanister
	icon = 'canister.dmi'
	icon_state = "blue"
/obj/machinery/atmoalter/canister/anesthcanister
	icon = 'canister.dmi'
	icon_state = "red"
/obj/machinery/atmoalter/canister/n2canister
	icon = 'canister.dmi'
	icon_state = "red"

/obj/machinery/door/poddoor
	icon = 'Door1.dmi'
	icon_state = "door1"
	var/id = 1
/obj/machinery/door/window
	icon = 'windoor.dmi'
	icon_state = "door1"
/obj/machinery/door/false_wall
	icon = 'Doorf.dmi'
	icon_state = "door1"
/obj/machinery/door/airlock
	icon = 'Door1.dmi'
	icon_state = "door1"
/obj/machinery/door/firedoor
	icon = 'Door1.dmi'
	icon_state = "door0"
/obj/machinery/door
	icon = 'doors.dmi'
	icon_state = "door1"
	var
		r_access;r_lab;r_engine;r_air


/obj/machinery/pod
	icon = 'escapepod.dmi'
	icon_state = "pod"
	var/id = 1//For synchronization with computer commands
/obj/machinery/recon
	icon = 'escapepod.dmi'
	icon_state = "recon"
	var/id = 1//For synchronization with computer commands
/obj/machinery/freezer
	icon = 'Cryogenic2.dmi'
	icon_state = "freezer_0"
/obj/machinery/sleeper
	icon = 'Cryogenic2.dmi'
	icon_state = "sleeper_0"
/obj/machinery/cryo_cell
	icon = 'Cryogenic2.dmi'
	icon_state = "celltop"
/obj/machinery/igniter
	icon = 'stationobjs.dmi'
	icon_state = "igniter1"
/obj/machinery/firealarm
	icon = 'items.dmi'
	icon_state = "firealarm"
/obj/machinery/dispenser
	icon = 'turfs2.dmi'
	icon_state = "dispenser"
	var //if you have to ask, I have to ask, have you played the game?
		pltanks = 10
		o2tanks = 10
/obj/machinery/dna_scanner
	icon = 'Cryogenic2.dmi'
	icon_state = "scanner_0"
/obj/machinery/scan_console
	icon = 'Cryogenic2.dmi'
	icon_state = "scannerconsole"
/obj/machinery/restruct
	icon = 'Cryogenic2.dmi'
	icon_state = "restruct_0"
/obj/machinery/hologram_proj
	icon = 'stationobjs.dmi'
	icon_state = "hologram0"
/obj/machinery/recharger
	icon = 'stationobjs.dmi'
	icon_state = "recharger0"
/obj/machinery/shuttle/engine/propulsion/burst/left
	icon = 'shuttle.dmi'
	icon_state = "burst_l"
/obj/machinery/shuttle/engine/propulsion/burst/right
	icon = 'shuttle.dmi'
	icon_state = "burst_r"
/obj/machinery/shuttle/engine/propulsion/burst
	icon = 'shuttle.dmi'
	icon_state = "propulsion"
/obj/machinery/shuttle/engine/propulsion
	icon = 'shuttle.dmi'
	icon_state = "propulsion"
/obj/machinery/shuttle/engine/router
	icon = 'shuttle.dmi'
	icon_state = "router"
/obj/machinery/shuttle/engine/platform
	icon = 'shuttle.dmi'
	icon_state = "platform"
/obj/machinery/shuttle/engine/heater
	icon = 'shuttle.dmi'
	icon_state = "heater"

/obj/machinery/shuttle
	icon = 'shuttle.dmi'
	icon_state = ""
/obj/machinery/teleport/hub
	icon = 'stationobjs.dmi'
	icon_state = "tele0"
/obj/machinery/teleport/station
	icon = 'stationobjs.dmi'
	icon_state = "controller"
/obj/machinery/teleport
	icon = 'stationobjs.dmi'
	icon_state = ""
/obj/machinery/nuclearbomb
	icon = 'stationobjs.dmi'
	icon_state = "nuclearbomb0"
	var/extended = 0 //make this 1 to have it frozen in place

/obj/landmark//This is a pretty complicated object used mainly for CTF and nuclear mode
	//Just consult the map and sue it as a guide for placing the stuff.
	//It's a good thing you've played the game!
	icon = 'screen1.dmi'
	icon_state = "x2"
/obj/landmark/alterations
	icon = 'screen1.dmi'
	icon_state = "x2"
/obj/start
	icon = 'screen1.dmi'
	icon_state = "x"
/obj/sp_start
	icon = 'human.dmi'
	icon_state = "male"
	var/special
	//2 means remvoe all tiems frmo character,3 means make character a monkey
	//FYI if you ahven't noticed the name is the ckey of the user

//Not sure what you want to do with these but I just decided...
//Why not jsut toss em in.
/obj/item/weapon/organ/external/head
	icon = 'human.dmi'
	icon_state = "head"
/obj/item/weapon/organ/external/chest
	icon = 'human.dmi'
	icon_state = "chest"
/obj/item/weapon/organ/external/diaper
	icon = 'human.dmi'
	icon_state = "diaper"
/obj/item/weapon/organ/external/l_leg
	icon = 'human.dmi'
	icon_state = "l_leg"
/obj/item/weapon/organ/external/r_leg
	icon = 'human.dmi'
	icon_state = "r_leg"
/obj/item/weapon/organ/external/l_foot
	icon = 'human.dmi'
	icon_state = "l_foot"
/obj/item/weapon/organ/external/r_foot
	icon = 'human.dmi'
	icon_state = "r_foot"
/obj/item/weapon/organ/external/l_arm
	icon = 'human.dmi'
	icon_state = "l_arm"
/obj/item/weapon/organ/external/r_arm
	icon = 'human.dmi'
	icon_state = "r_arm"
/obj/item/weapon/organ/external/l_hand
	icon = 'human.dmi'
	icon_state = "l_hand"
/obj/item/weapon/organ/external/r_hand
	icon = 'human.dmi'
	icon_state = "r_hand"

/obj/item/weapon/flasks/oxygen
	icon = 'Cryogenic2.dmi'
	icon_state = "oxygen-c"
/obj/item/weapon/flasks/plasma
	icon = 'Cryogenic2.dmi'
	icon_state = "plasma-c"
/obj/item/weapon/flasks/coolant
	icon = 'Cryogenic2.dmi'
	icon_state = "coolant-c"
/obj/item/weapon/clothing/head/helmet
	icon = 'items.dmi'
	icon_state = "helmet"
/obj/item/weapon/clothing/head/bio_hood
	icon = 'items.dmi'
	icon_state = "bio_hood"
/obj/item/weapon/clothing/head/swat_hel
	icon = 'items.dmi'
	icon_state = "swat_hel"
/obj/item/weapon/clothing/head/s_helmet
	icon = 'items.dmi'
	icon_state = "s_helmet"
/obj/item/weapon/clothing/head
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/clothing/gloves/latex
	icon = 'items.dmi'
	icon_state = "lgloves"
/obj/item/weapon/clothing/gloves/robot
	icon = 'items.dmi'
	icon_state = "r_hands"
/obj/item/weapon/clothing/gloves/swat
	icon = 'items.dmi'
	icon_state = "swat_gl"
/obj/item/weapon/clothing/gloves/black
	icon = 'items.dmi'
	icon_state = "bgloves"
/obj/item/weapon/clothing/gloves
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/clothing/ears/earmuffs
	icon = 'items.dmi'
	icon_state = "earmuffs"
/obj/item/weapon/clothing/ears
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/clothing/glasses/meson
	icon = 'items.dmi'
	icon_state = "m_glasses"
/obj/item/weapon/clothing/glasses/thermal
	icon = 'items.dmi'
	icon_state = "t_glasses"
/obj/item/weapon/clothing/glasses/sunglasses
	icon = 'items.dmi'
	icon_state = "s_glasses"
/obj/item/weapon/clothing/glasses/regular
	icon = 'items.dmi'
	icon_state = "p_glasses"
/obj/item/weapon/clothing/glasses/blindfold
	icon = 'items.dmi'
	icon_state = "blindfold"
/obj/item/weapon/clothing/glasses
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/clothing/shoes/orange
	icon = 'items.dmi'
	icon_state = "o_shoes"
/obj/item/weapon/clothing/shoes/black
	icon = 'items.dmi'
	icon_state = "bl_shoes"
/obj/item/weapon/clothing/shoes/brown
	icon = 'items.dmi'
	icon_state = "b_shoes"
/obj/item/weapon/clothing/shoes/white
	icon = 'items.dmi'
	icon_state = "w_shoes"
/obj/item/weapon/clothing/shoes/robot
	icon = 'items.dmi'
	icon_state = "r_feet"
/obj/item/weapon/clothing/shoes/swat
	icon = 'items.dmi'
	icon_state = "swat_sh"
/obj/item/weapon/clothing/shoes
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/clothing/under/orange
	icon = 'items.dmi'
	icon_state = "o_suit"
/obj/item/weapon/clothing/under/yellow
	icon = 'items.dmi'
	icon_state = "y_suit"
/obj/item/weapon/clothing/under/blue
	icon = 'items.dmi'
	icon_state = "b_suit"
/obj/item/weapon/clothing/under/red
	icon = 'items.dmi'
	icon_state = "r_suit"
/obj/item/weapon/clothing/under/pink
	icon = 'items.dmi'
	icon_state = "p_suit"
/obj/item/weapon/clothing/under/black
	icon = 'items.dmi'
	icon_state = "bl_suit"
/obj/item/weapon/clothing/under/white
	icon = 'items.dmi'
	icon_state = "w_suit"
/obj/item/weapon/clothing/under/green
	icon = 'items.dmi'
	icon_state = "g_suit"
/obj/item/weapon/clothing/under
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/clothing/suit/firesuit
	icon = 'items.dmi'
	icon_state = "firesuit"
/obj/item/weapon/clothing/suit/straight_jacket
	icon = 'items.dmi'
	icon_state = "straight_jacket"
/obj/item/weapon/clothing/suit/armor
	icon = 'items.dmi'
	icon_state = "armor"
/obj/item/weapon/clothing/suit/robot_suit
	icon = 'items.dmi'
	icon_state = "ro_suit"
/obj/item/weapon/clothing/suit/bio_suit
	icon = 'items.dmi'
	icon_state = "bio_suit"
/obj/item/weapon/clothing/suit/swat_suit
	icon = 'items.dmi'
	icon_state = "swat_suit"
/obj/item/weapon/clothing/suit/sp_suit
	icon = 'items.dmi'
	icon_state = "s_suit"
/obj/item/weapon/clothing/suit
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/clothing/mask/robot/swat
	icon = 'items.dmi'
	icon_state = "r_head"
/obj/item/weapon/clothing/mask/robot
	icon = 'items.dmi'
	icon_state = "r_head"
/obj/item/weapon/clothing/mask/gasmask
	icon = 'items.dmi'
	icon_state = "mask"
/obj/item/weapon/clothing/mask/m_mask
	icon = 'items.dmi'
	icon_state = "m_mask"
/obj/item/weapon/clothing/mask/muzzle
	icon = 'items.dmi'
	icon_state = "muzzle"
/obj/item/weapon/clothing/mask/surgical
	icon = 'items.dmi'
	icon_state = "s_mask"
/obj/item/weapon/clothing/mask
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/clothing
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/tank/oxygentank
	icon = 'items.dmi'
	icon_state = "oxygen"
/obj/item/weapon/tank/jetpack
	icon = 'items.dmi'
	icon_state = "jetpack0"
/obj/item/weapon/tank/anesthetic
	icon = 'items.dmi'
	icon_state = "an_tank"
/obj/item/weapon/tank/plasmatank
	icon = 'items.dmi'
	icon_state = "plasma"
/obj/item/weapon/tank
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/table_parts
	icon = 'items.dmi'
	icon_state = "table_parts"
/obj/item/weapon/rack_parts
	icon = 'items.dmi'
	icon_state = "rack_parts"
/obj/item/weapon/paper_bin
	icon = 'stationobjs.dmi'
	icon_state = "paper_bin1"
	var/amount = 30//Amount of paper in the bin... dont bother adjusting
/obj/item/weapon/game_kit
	icon = 'items.dmi'
	icon_state = "game_kit"
/obj/item/weapon/bedsheet
	icon = 'Icons.dmi'
	icon_state = "sheet"
/obj/item/weapon/wrapping_paper
	icon = 'items.dmi'
	icon_state = "wrap_paper"
/obj/item/weapon/c_tube
	icon = 'items.dmi'
	icon_state = "c_tube"
/obj/item/weapon/a_gift
	icon = 'items.dmi'
	icon_state = "gift"
/obj/item/weapon/flashbang
	icon = 'items.dmi'
	icon_state = "flashbang"
/obj/item/weapon/flash
	icon = 'items.dmi'
	icon_state = "flash"
/obj/item/weapon/locator
	icon = 'items.dmi'
	icon_state = "locator"
/obj/item/weapon/syndicate_uplink
	icon = 'items.dmi'
	icon_state = "radio"
/obj/item/weapon/sword
	icon = 'items.dmi'
	icon_state = "sword0"
/obj/item/weapon/shield
	icon = 'items.dmi'
	icon_state = "shield0"
/obj/item/weapon/cloaking_device
	icon = 'items.dmi'
	icon_state = "shield0"
/obj/item/weapon/ammo/a357
	icon = 'ammo.dmi'
	icon_state = "357-7"
/obj/item/weapon/gun/revolver
	icon = 'items.dmi'
	icon_state = "revolver"
/obj/item/weapon/gun/energy/laser_gun
	icon = 'items.dmi'
	icon_state = "gun"
/obj/item/weapon/gun/energy/taser_gun
	icon = 'items.dmi'
	icon_state = "t_gun"
/obj/item/weapon/pill_canister/placebo
	icon = 'items.dmi'
	icon_state = "pill_canister"
/obj/item/weapon/pill_canister/antitoxin
	icon = 'items.dmi'
	icon_state = "pill_canister"
/obj/item/weapon/pill_canister/Tourette
	icon = 'items.dmi'
	icon_state = "pill_canister"
/obj/item/weapon/pill_canister/sleep
	icon = 'items.dmi'
	icon_state = "pill_canister"
/obj/item/weapon/pill_canister/epilepsy
	icon = 'items.dmi'
	icon_state = "pill_canister"
/obj/item/weapon/pill_canister/cough
	icon = 'items.dmi'
	icon_state = "pill_canister"
/obj/item/weapon/m_pill/superpill
	icon = 'items.dmi'
	icon_state = "pill"
/obj/item/weapon/m_pill/sleep
	icon = 'items.dmi'
	icon_state = "pill"
/obj/item/weapon/m_pill/cyanide
	icon = 'items.dmi'
	icon_state = "pill5"
/obj/item/weapon/m_pill/antitoxin
	icon = 'items.dmi'
	icon_state = "pill"
/obj/item/weapon/m_pill/cough
	icon = 'items.dmi'
	icon_state = "pill4"
/obj/item/weapon/m_pill/epilepsy
	icon = 'items.dmi'
	icon_state = "pill3"
/obj/item/weapon/m_pill/Tourette
	icon = 'items.dmi'
	icon_state = "pill2"
/obj/item/weapon/handcuffs
	icon = 'items.dmi'
	icon_state = "handcuff"
/obj/item/weapon/card/data
	icon = 'items.dmi'
	icon_state = "card-data"
	var/function = "storage"
	var/data = "null"
	var/special = null
/obj/item/weapon/card/emag
	icon = 'items.dmi'
	icon_state = "emag-card"
/obj/item/weapon/card/id
	icon = 'items.dmi'
	icon_state = "card-id"
	var/access_level //general level of access
	var/lab_access //level of lab access
	var/engine_access //level of engine access
	var/air_access //level of systems access
	var/registered //name registered to
	var/assignment //like pilot,captain,researcher
/obj/item/weapon/rods
	icon = 'items.dmi'
	icon_state = "rods"
/obj/item/weapon/sheet/r_metal
	icon = 'items.dmi'
	icon_state = "sheet-r_metal"
/obj/item/weapon/sheet/metal
	icon = 'items.dmi'
	icon_state = "sheet-metal"
/obj/item/weapon/sheet/glass
	icon = 'items.dmi'
	icon_state = "sheet-glass"
/obj/item/weapon/sheet
	var/amount = 1
/obj/item/weapon/wirecutters
	icon = 'items.dmi'
	icon_state = "cutters"
/obj/item/weapon/clipboard
	icon = 'items.dmi'
	icon_state = "clipboard00"
/obj/item/weapon/fcardholder
	icon = 'items.dmi'
	icon_state = "fcardholder0"
/obj/item/weapon/extinguisher
	icon = 'items.dmi'
	icon_state = "fire_extinguisher0"
/obj/item/weapon/pen/sleepypen
	icon = 'items.dmi'
	icon_state = "pen"
/obj/item/weapon/pen
	icon = 'items.dmi'
	icon_state = "pen"
/obj/item/weapon/paint
	icon = 'items.dmi'
	icon_state = "paint_neutral"
/obj/item/weapon/camera
	icon = 'items.dmi'
	icon_state = "camera"
/obj/item/weapon/paper/flag
	icon = 'items.dmi'
	icon_state = "flag_neutral"//Whatever...
/obj/item/weapon/paper/jobs
	icon = 'items.dmi'
	icon_state = "paper"
/obj/item/weapon/paper/sop
	icon = 'items.dmi'
	icon_state = "paper"
/obj/item/weapon/paper/courtroom
	icon = 'items.dmi'
	icon_state = "paper"
/obj/item/weapon/paper/Toxin
	icon = 'items.dmi'
	icon_state = "paper"
/obj/item/weapon/paper/Internal
	icon = 'items.dmi'
	icon_state = "paper"
/obj/item/weapon/paper/Map
	icon = 'items.dmi'
	icon_state = "paper"
/obj/item/weapon/paper
	icon = 'items.dmi'
	icon_state = "paper"
	var/info//If you want to create some customized HTML message go ahead.
/obj/item/weapon/f_card
	icon = 'items.dmi'
	icon_state = "f_print_card0"
/obj/item/weapon/f_print_scanner
	icon = 'items.dmi'
	icon_state = "f_print_scanner0"
/obj/item/weapon/healthanalyzer
	icon = 'items.dmi'
	icon_state = "healthanalyzer"
/obj/item/weapon/analyzer
	icon = 'items.dmi'
	icon_state = "analyzer"
/obj/item/weapon/storage/lglo_kit
	icon = 'items.dmi'
	icon_state = "lglo_kit"
/obj/item/weapon/storage/flashbang_kit
	icon = 'items.dmi'
	icon_state = "flashbang_kit"
/obj/item/weapon/storage/stma_kit
	icon = 'items.dmi'
	icon_state = "lglo_kit"
/obj/item/weapon/storage/gl_kit
	icon = 'items.dmi'
	icon_state = "id_kit"
/obj/item/weapon/storage/trackimp_kit
	icon = 'items.dmi'
	icon_state = "imp_kit"
/obj/item/weapon/storage/fcard_kit
	icon = 'items.dmi'
	icon_state = "id_kit"
/obj/item/weapon/storage/id_kit
	icon = 'items.dmi'
	icon_state = "id_kit"
/obj/item/weapon/storage/box
	icon = 'items.dmi'
	icon_state = "box"
/obj/item/weapon/storage/handcuff_kit
	icon = 'items.dmi'
	icon_state = "handcuff_kit"
/obj/item/weapon/storage/disk_kit/disks
	icon = 'items.dmi'
	icon_state = "id_kit"
/obj/item/weapon/storage/disk_kit/disks2
	icon = 'items.dmi'
	icon_state = "id_kit"
/obj/item/weapon/storage/disk_kit
	icon = 'items.dmi'
	icon_state = "id_kit"
/obj/item/weapon/storage/backpack
	icon = 'items.dmi'
	icon_state = "backpack"
/obj/item/weapon/storage/toolbox
	icon = 'items.dmi'
	icon_state = "toolbox"
/obj/item/weapon/storage/firstaid/fire
	icon = 'items.dmi'
	icon_state = "firstaid-ointment"
/obj/item/weapon/storage/firstaid/syringes
	icon = 'items.dmi'
	icon_state = "syringe_kit"
/obj/item/weapon/storage/firstaid/regular
	icon = 'items.dmi'
	icon_state = "firstaid"
/obj/item/weapon/storage/firstaid/toxin
	icon = 'items.dmi'
	icon_state = "firstaid-toxin"
/obj/item/weapon/tile
	icon = 'items.dmi'
	icon_state = "tile"
/obj/item/weapon/igniter
	icon = 'items.dmi'
	icon_state = "igniter"
/obj/item/weapon/radio/electropack
	icon = 'items.dmi'
	icon_state = "electropack0"
/obj/item/weapon/radio/headset
	icon = 'items.dmi'
	icon_state = "headset"
/obj/item/weapon/radio/beacon
	icon = 'items.dmi'
	icon_state = "beacon"
/obj/item/weapon/radio/signaler
	icon = 'items.dmi'
	icon_state = "signaler"
/obj/item/weapon/radio/intercom
	icon = 'items.dmi'
	icon_state = "intercom"
/obj/item/weapon/radio
	icon = 'items.dmi'
	icon_state = "radio"
	var/freq = 145.1//Please don't make me explain this.
//In theory you can go beyond the default ranges for really private things but
//The player could easily ruin that,
/obj/item/weapon/shard
	icon = 'shards.dmi'
	icon_state = "small"
/obj/item/weapon/crowbar
	icon = 'items.dmi'
	icon_state = "crowbar"
/obj/item/weapon/wrench
	icon = 'items.dmi'
	icon_state = "wrench"
/obj/item/weapon/screwdriver
	icon = 'items.dmi'
	icon_state = "screwdriver"
/obj/item/weapon/dropper
	icon = 'items.dmi'
	icon_state = "dropper_0"
/obj/item/weapon/implantcase/tracking
	icon = 'items.dmi'
	icon_state = "implantcase-b"
/obj/item/weapon/implantcase
	icon = 'items.dmi'
	icon_state = "implantcase-0"
/obj/item/weapon/implantpad
	icon = 'items.dmi'
	icon_state = "implantpad-0"
/obj/item/weapon/implanter
	icon = 'items.dmi'
	icon_state = "implanter0"
/obj/item/weapon/syringe
	icon = 'items.dmi'
	icon_state = "syringe_0"
/obj/item/weapon/brutepack
	icon = 'items.dmi'
	icon_state = "brutepack"
/obj/item/weapon/hand_tele
	icon = 'items.dmi'
	icon_state = "hand_tele"
/obj/item/weapon/ointment
	icon = 'items.dmi'
	icon_state = "ointment"
/obj/item/weapon/bottle/toxins
	icon = 'items.dmi'
	icon_state = "toxinbottle"
/obj/item/weapon/bottle/antitoxins
	icon = 'items.dmi'
	icon_state = "atoxinbottle"
/obj/item/weapon/bottle/r_epil
	icon = 'items.dmi'
	icon_state = "medibottle"
/obj/item/weapon/bottle/r_ch_cough
	icon = 'items.dmi'
	icon_state = "medibottle"
/obj/item/weapon/bottle/rejuvenators
	icon = 'items.dmi'
	icon_state = "rejuvbottle"
/obj/item/weapon/bottle/s_tox
	icon = 'items.dmi'
	icon_state = "toxinbottle"
/obj/item/weapon/bottle
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/weldingtool
	icon = 'items.dmi'
	icon_state = "welder"
/obj/item/weapon/disk/nuclear
	icon = 'items.dmi'
	icon_state = "nucleardisk"
/obj/item/weapon/disk
	icon = 'items.dmi'
	icon_state = ""
/obj/item/weapon/infra_sensor
	icon = 'items.dmi'
	icon_state = "infra_sensor"
/obj/item/weapon/prox_sensor
	icon = 'items.dmi'
	icon_state = "motion0"
/obj/item/weapon/infra
	icon = 'items.dmi'
	icon_state = "infrared0"
/obj/item/weapon/timer
	icon = 'items.dmi'
	icon_state = "timer"

/obj/secloset/personal
	icon = 'stationobjs.dmi'
	icon_state = "0secloset0"
/obj/secloset/security2
	icon = 'stationobjs.dmi'
	icon_state = "1secloset0"
/obj/secloset/security1
	icon = 'stationobjs.dmi'
	icon_state = "1secloset0"
/obj/secloset/highsec
	icon = 'stationobjs.dmi'
	icon_state = "1secloset0"
/obj/secloset/animal
	icon = 'stationobjs.dmi'
	icon_state = "1secloset0"
/obj/secloset/medical1
	icon = 'stationobjs.dmi'
	icon_state = "1secloset0"
/obj/secloset/medical2
	icon = 'stationobjs.dmi'
	icon_state = "1secloset0"
/obj/secloset
	icon = 'stationobjs.dmi'
	icon_state = "1secloset0"
	var/allowed //it may be best you examine the map if you override these.
/obj/morgue
	icon = 'stationobjs.dmi'
	icon_state = "morgue1"
/obj/closet/syndicate/nuclear
	icon = 'stationobjs.dmi'
	icon_state = "syndicate0"
/obj/closet/emcloset
	icon = 'stationobjs.dmi'
	icon_state = "emcloset0"
/obj/closet/l3closet
	icon = 'stationobjs.dmi'
	icon_state = "l3closet0"
/obj/closet/wardrobe/red
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-r"
/obj/closet/wardrobe/pink
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-p"
/obj/closet/wardrobe/black
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-bl"
/obj/closet/wardrobe/green
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-g"
/obj/closet/wardrobe/orange
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-o"
/obj/closet/wardrobe/yellow
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-y"
/obj/closet/wardrobe/mixed
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-bp"
/obj/closet/wardrobe/white
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-w"
/obj/closet/wardrobe
	icon = 'stationobjs.dmi'
	icon_state = "wardrobe-b"
/obj/closet
	icon = 'stationobjs.dmi'
	icon_state = "closet"
/obj/stool/bed
	icon = 'Icons.dmi'
	icon_state = "bed"
/obj/stool/chair
	icon = 'Icons.dmi'
	icon_state = "chair"
/obj/stool
	icon = 'Icons.dmi'
	icon_state = "stool"
/obj/grille
	icon = 'turfs2.dmi'
	icon_state = "grille"
/obj/window
	icon = 'turfs2.dmi'
	icon_state = "window"
/obj/begin
	icon = 'stationobjs.dmi'
	icon_state = "begin"
/obj/manifest
	icon = 'screen1.dmi'
	icon_state = "x"
/obj/bedsheetbin
	icon = 'Icons.dmi'
	icon_state = "bedbin"
/obj/table
	icon = 'table.dmi'
	icon_state = "alone"
/obj/rack
	icon = 'Icons.dmi'
	icon_state = "rack"
/obj/weldfueltank
	icon = 'items.dmi'
	icon_state = "weldtank"
/obj/watertank
	icon = 'stationobjs.dmi'
	icon_state = "watertank"
/obj/d_girders
	icon = 'stationobjs.dmi'
	icon_state = "d_girders"
/obj/barrier
	icon = 'stationobjs.dmi'
	icon_state = "barrier"
/obj/shuttle/door
	icon = 'shuttle.dmi'
	icon_state = "door1"

/atom/movable/var/anchored //use with caution
//Basically if it is 1, it is immobile.