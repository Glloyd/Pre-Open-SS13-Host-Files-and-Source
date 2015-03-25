/atom
        layer = 2.0
        var/level = 2.0
        var/flags = 256.0
        var/fingerprints = null
/atom/movable
        layer = 3.0
        var/last_move = null
        var/anchored = 0.0
        var/weight = 25000.0
        var/elevation = 2.0
        var/move_speed = 10.0
        var/l_move_time = 1.0
        var/m_flag = 1.0
/atom/movable/overlay
        var/atom/master = null
        anchored = 1.0

/client
        var/obj/admins/holder = null
        var/listen_ooc = 1.0
        var/move_delay = 1.0
        var/moving = null

/datum/air_tunnel
        //name = "air tunnel"
        //connectors = (List:13)
        var/operating = 0.0
        var/siphon_status = 0.0
        var/air_stat = 0.0

        var/list/connectors = list(  )

/datum/air_tunnel/air_tunnel1
        //name = "air tunnel1"
/datum/chemical
        //var/name = "chemical"
        var/moles = 0.0
        var/molarmass = 18.0
        var/density = 1.0
        var/chem_formula = "H2O"
        var/name = "water-l"
/datum/chemical/ch_cou
        //name = "ch cou"
        molarmass = 270.0
        name = "CCSremedy-l"
/datum/chemical/epil
        //name = "epil"
        molarmass = 230.0
        name = "EPILremedy-l"
/datum/chemical/l_plas
        //name = "l plas"
        name = "plasma-l"
        molarmass = 154.0
/datum/chemical/pathogen
        name = "pathogen"
        var/amount = 0.0
        var/structure_id = null
/datum/chemical/pathogen/antibody
        name = "antibody"
        var/tar_struct = null
        var/a_style = null
/datum/chemical/pathogen/blood
        name = "blood"
        var/antibodies = null
        var/antigens = null
        var/has_oxygen = null
        var/has_co = null
/datum/chemical/pathogen/virus
        name = "virus"
/datum/chemical/pl_coag
        name = "pl coag"
        name = "antipla-l"
        molarmass = 176.0
/datum/chemical/rejuv
        name = "rejuv"
        molarmass = 97.0
        name = "rejuv-l"
/datum/chemical/s_tox
        name = "s tox"
        name = "sleeptox-l"
        molarmass = 45.0
/datum/chemical/waste
        name = "waste"
        name = "waste-l"
        molarmass = 200.0
/datum/chemical/water
        name = "water"
/datum/control
        //name = "control"
        var/processing = 1.0
/datum/control/cellular
        //name = "cellular"
        var/checkfire = 0.0
        var/var_swap = 1.0
/datum/control/gameticker
        //name = "gameticker"
        var/timeleft = null
        var/timing = 0.0
        var/mob/human/killer = null
        var/mob/human/target = null
        var/theft_obj = null
        var/objective = null
        var/shuttle_location = SHUTTLE_Z

        var/mode = "secret"
/datum/control/poll
        //name = "poll"
        var/question = null
        //answers = (List:14)

        var/list/answers = list(  )

/datum/data
        var/name = "data"
        var/size = 1.0
        //name = null
/datum/data/function
        name = "function"
        size = 2.0
/datum/data/function/data_control
        name = "data control"
/datum/data/function/id_changer
        name = "id changer"
/datum/data/record
        name = "record"
        //fields = (List:15)
        size = 5.0

        var/list/fields = list(  )

/datum/data/text
        name = "text"
        var/data = null
/datum/engine_eject
        //name = "engine eject"
        var/status = 0.0
        var/resetting = null
        var/timeleft = 60.0
/mob
        density = 1
        layer = 4.0
        var/already_placed = 0.0
        var/obj/machinery/machine = null
        var/other_mobs = null
        var/memory = ""
        var/poll_answer = 0.0
        var/sdisabilities = 0.0
        var/disabilities = 0.0
        var/atom/movable/pulling = null
        var/stat = 0.0
        var/next_move = null
        var/monkeyizing = null
        var/other = 0.0
        var/hand = null
        var/eye_blind = null
        var/eye_blurry = null
        var/ear_deaf = null
        var/ear_damage = null
        var/stuttering = null
        var/rname = null
        var/blinded = null
        var/rejuv = null
        var/r_epil = null
        var/r_ch_cou = null
        var/r_Tourette = null
        var/antitoxs = null
        var/plasma = null
        var/virus = 0.0
        var/sleeping = 0.0
        var/resting = 0.0
        var/lying = 0.0
        var/canmove = 1.0
        var/eye_stat = null
        var/oxyloss = 0.0
        var/toxloss = 0.0
        var/fireloss = 0.0
        var/timeofdeath = 0.0
        var/bruteloss = 0.0
        var/cpr_time = 1.0
        var/health = 100.0
        var/drowsyness = 0.0
        var/paralysis = 0.0
        var/stunned = 0.0
        var/weakened = 0.0
        var/losebreath = 0.0
        var/muted = null
        var/intent = null
        var/a_intent = "disarm"
        var/m_int = null
        var/m_intent = "walk"
        var/obj/stool/chair/buckled = null
        var/obj/dna/primary = null
        var/obj/item/weapon/handcuffs/handcuffed = null
        var/obj/item/weapon/l_hand = null
        var/obj/item/weapon/r_hand = null
        var/obj/item/weapon/back = null
        var/obj/item/weapon/tank/internal = null
        var/obj/item/weapon/storage/s_active = null
        var/obj/item/weapon/clothing/mask/wear_mask = null
        var/obj/screen/flash = null
        var/obj/screen/blind = null
        var/obj/screen/hands = null
        var/obj/screen/mach = null
        var/obj/screen/sleep = null
        var/obj/screen/rest = null
        var/obj/screen/pullin = null
        var/obj/screen/internals = null
        var/obj/screen/oxygen = null
        var/obj/screen/i_select = null
        var/obj/screen/m_select = null
        var/obj/screen/toxin = null
        var/obj/screen/fire = null
        var/obj/screen/healths = null
        var/obj/screen/zone_sel/zone_sel = null
        var/obj/hud/hud_used = null
        var/start = null
        //var/organs = (List:7)
        //var/grabbed_by = (List:8)
        //var/requests = (List:9)

        var/list/organs = list(  )
        var/list/grabbed_by = list(  )
        var/list/requests = list(  )

        var/list/mapobjs = list()

/mob/ghost
        name = "ghost"
        icon_state = "ghost"
/mob/human
        name = "human"
        icon = 'mob.dmi'
        icon_state = "m-none"
        gender = MALE
        var/occupation1 = "No Preference"
        var/occupation2 = "No Preference"
        var/occupation3 = "No Preference"
        var/need_gl = 0.0
        var/be_epil = 0.0
        var/be_cough = 0.0
        var/be_tur = 0.0
        var/be_stut = 0.0
        var/r_hair = 0.0
        var/g_hair = 0.0
        var/b_hair = 0.0
        var/h_style = "Short Hair (M)"
        var/nr_hair = 0.0
        var/ng_hair = 0.0
        var/nb_hair = 0.0
        var/ns_tone = 0.0
        var/r_eyes = 0.0
        var/g_eyes = 0.0
        var/b_eyes = 0.0
        var/s_tone = 0.0
        var/age = 30.0
        var/b_type = "A+"
        //body_standing = (List:5)
        //body_lying = (List:6)
        var/obj/item/weapon/clothing/suit/wear_suit = null
        var/obj/item/weapon/clothing/under/w_uniform = null
        var/obj/item/weapon/radio/w_radio = null
        var/obj/item/weapon/clothing/shoes/shoes = null
        var/obj/item/weapon/belt = null
        var/obj/item/weapon/clothing/gloves/gloves = null
        var/obj/item/weapon/clothing/glasses/glasses = null
        var/obj/item/weapon/clothing/head/head = null
        var/obj/item/weapon/clothing/ears/ears = null
        var/obj/item/weapon/card/id/wear_id = null
        var/obj/item/weapon/r_store = null
        var/obj/item/weapon/l_store = null
        var/icon/stand_icon = null
        var/icon/lying_icon = null
        var/now_pushing = null
        var/t_plasma = 0.0
        var/t_oxygen = 0.0
        var/last_b_state = 1.0
        var/image/face = null
        var/image/face2 = null
        var/h_style_r = "hair_a"
        weight = 2500000.0

        var/list/body_standing = list(  )
        var/list/body_lying = list(  )

/mob/monkey
        name = "monkey"
        icon = 'monkey.dmi'
        icon_state = "monkey1"
        gender = MALE
        var/t_plasma = null
        var/t_oxygen = null
        var/t_sl_gas = null
        var/t_n2 = null
        var/now_pushing = null
        flags = 258.0
/obj
        var/throwspeed = 0.0
        var/throwing = null
/obj/admins
        name = "admins"
        var/rank = null
        var/a_level = 0.0
        var/screen = 1.0
        var/owner = null
/obj/barrier
        name = "barrier"
        icon = 'stationobjs.dmi'
        icon_state = "barrier"
        opacity = 1
        density = 1
        anchored = 1.0
/obj/beam
        name = "beam"
/obj/beam/a_laser
        name = "a laser"
        icon = 'weap_sat.dmi'
        icon_state = "laser"
        density = 1
        var/yo = null
        var/xo = null
        var/current = null
        var/life = 50.0
        anchored = 1.0
        flags = 2.0
/obj/beam/a_laser/s_laser
        name = "s laser"
        icon_state = "spark"
/obj/beam/i_beam
        name = "i beam"
        icon = 'weap_sat.dmi'
        icon_state = "laser"
        var/obj/beam/i_beam/next = null
        var/obj/item/weapon/infra/master = null
        var/limit = null
        var/visible = 0.0
        var/left = null
        anchored = 1.0
        flags = 2.0
/obj/bedsheetbin
        name = "Linen Bin"
        icon = 'Icons.dmi'
        icon_state = "bedbin"
        var/amount = 23.0
        anchored = 1.0
/obj/begin
        name = "begin"
        icon = 'stationobjs.dmi'
        icon_state = "begin"
        anchored = 1.0
/obj/bomb
        name = "bomb"
        icon = 'screen1.dmi'
        icon_state = "x"
/obj/bullet
        name = "bullet"
        icon = 'weap_sat.dmi'
        icon_state = "bullet"
        density = 1
        var/yo = null
        var/xo = null
        var/current = null
        anchored = 1.0
        flags = 2.0
/obj/closet
        desc = "It's a closet!"
        name = "Closet"
        icon = 'stationobjs.dmi'
        icon_state = "closet"
        density = 1
        var/original = "closet"
        var/orig_closed = "emcloset1"
        var/opened = 0.0
        var/welded = 0.0
        flags = 320.0
        weight = 1.0E8
/obj/closet/emcloset
        desc = "A bulky (yet mobile) closet. Comes prestocked with a gasmask and o2 tank for emergencies"
        name = "Emergency Closets"
        icon_state = "emcloset0"
        original = "emcloset0"
/obj/closet/l3closet
        desc = "A bulky (yet mobile) closet. Comes prestocked with level 3 biohazard gear for emergencies."
        name = "Level 3 Biohazard Suit"
        icon_state = "l3closet0"
        original = "l3closet0"
        orig_closed = "l3closet1"
/obj/closet/syndicate
        desc = "Why is this here?"
        name = "Syndicate Weapons Closet"
        icon_state = "syndicate0"
        original = "syndicate0"
/obj/closet/syndicate/nuclear
/obj/closet/wardrobe
        desc = "A bulky (yet mobile) wardrobe closet. Comes prestocked with 6 changes of clothes."
        name = "Wardrobe"
        icon_state = "wardrobe-b"
        original = "wardrobe-b"
/obj/closet/wardrobe/black
        name = "Black Wardrobe"
        icon_state = "wardrobe-bl"
        original = "wardrobe-bl"
/obj/closet/wardrobe/green
        name = "Green Wardrobe"
        icon_state = "wardrobe-g"
        original = "wardrobe-g"
/obj/closet/wardrobe/mixed
        name = "Mixed Wardrobe"
        icon_state = "wardrobe-bp"
        original = "wardrobe-bp"
/obj/closet/wardrobe/orange
        name = "Prisoners Wardrobe"
        icon_state = "wardrobe-o"
        original = "wardrobe-o"
/obj/closet/wardrobe/pink
        name = "Pink Wardrobe"
        icon_state = "wardrobe-p"
        original = "wardrobe-p"
/obj/closet/wardrobe/red
        name = "Red Wardrobe"
        icon_state = "wardrobe-r"
        original = "wardrobe-r"
/obj/closet/wardrobe/white
        name = "Medical Wardrobe"
        icon_state = "wardrobe-w"
        original = "wardrobe-w"
/obj/closet/wardrobe/yellow
        name = "Technician Wardrobe"
        icon_state = "wardrobe-y"
        original = "wardrobe-y"
/obj/ctf_assist
        name = "ctf assist"
        var/play_team = 4.0
        //avail_colors = (List:2)
        //avail_bases = (List:3)
        //pickers_left = (List:21)
        var/picker = null
        //players_left = (List:22)
        var/picking = null
        var/paint_cans = 0.0
        var/immobile = 0.0
        var/neutral_replace = 0.0
        var/ejectengine = 1.0
        var/autodress = 1.0
        var/barriertime = 3.0
        var/wintype = "None"
        var/starting = 0.0

        var/list/avail_colors = list( "red", "blue", "green", "yellow", "black", "white" )
        var/list/avail_bases = list( "Engine", "CR", "Lounge", "Atmo", "Medical" )
        var/list/pickers_left = list(  )
        var/list/players_left = list(  )

/obj/d_girders
        name = "Displaced girders"
        icon = 'stationobjs.dmi'
        icon_state = "d_girders"
        density = 1
        anchored = 0.0
        weight = 1.0E8
/obj/datacore
        name = "datacore"
        //medical = (List:31)
        //general = (List:32)
        //security = (List:33)

        var/list/medical = list(  )
        var/list/general = list(  )
        var/list/security = list(  )

/obj/dna
        name = "dna"
        var/spec_identity = null
        var/r_spec_identity = null
        var/use_enzyme = null
        var/struc_enzyme = null
        var/uni_identity = null
        var/n_chromo = null
/obj/effects
        name = "effects"
/obj/effects/smoke
        name = "smoke"
        icon = 'water.dmi'
        icon_state = "smoke"
        opacity = 1
        var/amount = 6.0
        anchored = 0.0
/obj/effects/sparks
        name = "sparks"
        icon = 'water.dmi'
        icon_state = "sparks"
        var/amount = 6.0
        anchored = 0.0
/obj/effects/sparks/ion_trails
        name = "ion trails"
        icon_state = "ion_trails"
        anchored = 1.0
/obj/effects/water
        name = "water"
        icon = 'water.dmi'
        icon_state = "extinguish"
        var/life = 15.0
        flags = 2.0
/obj/equip_e
        name = "equip e"
        var/mob/source = null
        var/s_loc = null
        var/t_loc = null
        var/obj/item/item = null
        var/place = null
/obj/equip_e/human
        name = "human"
        var/mob/human/target = null
/obj/equip_e/monkey
        name = "monkey"
        var/mob/monkey/target = null
/obj/grille
        desc = "A piece of metal with evenly spaced gridlike holes in it. Blocks large projectile type object but lets small items or energy beams through."
        name = "grille"
        icon = 'turfs2.dmi'
        icon_state = "grille"
        density = 1
        var/health = 10.0
        var/destroyed = 0.0
        anchored = 1.0
        flags = 64.0
/obj/hud
        name = "hud"
        var/adding = null
        var/other = null
        var/intents = null
        var/mov_int = null
        var/mon_blo = null
        var/m_ints = null
        var/vimpaired = null
        var/obj/screen/g_dither = null
        var/obj/screen/blurry = null
        var/h_type = /obj/screen
/obj/hud/hud2
        name = "hud2"
        h_type = /obj/screen/screen2
/obj/item
        name = "item"
        var/w_class = 3.0
/obj/item/weapon
        name = "weapon"
        icon = 'items.dmi'
        var/abstract = 0.0
        var/force = null
        var/s_istate = null
        var/damtype = "brute"
        var/throwforce = null
        var/r_speed = 1.0
        var/health = null
        var/burn_point = null
        var/burning = null
        var/obj/item/weapon/master = null
        flags = 258.0
        throwspeed = 7.0
        weight = 500000.0
/obj/item/weapon/a_gift
        name = "Gift"
        icon_state = "gift"
        s_istate = "gift"
        weight = 1.0E7
/obj/item/weapon/ammo
        name = "ammo"
        icon = 'ammo.dmi'
        var/amount_left = 0.0
        flags = 322.0
        s_istate = "syringe_kit"
/obj/item/weapon/ammo/a357
        desc = "There are 7 bullets left!"
        name = "ammo-357"
        icon_state = "357-7"
        amount_left = 7.0
/obj/item/weapon/analyzer
        desc = "Scans the environment gas levels."
        name = "analyzer"
        icon_state = "analyzer"
        w_class = 2.0
        flags = 322.0
/obj/item/weapon/assembly
        name = "assembly"
        icon = 'assemblies.dmi'
        s_istate = "assembly"
        w_class = 3.0
        var/status = 0.0

/obj/item/weapon/assembly/m_i_ptank
        desc = "A very intricate igniter and proximity sensor electrical assembly mounted onto top of a plasma tank."
        name = "Proximity/Igniter/Plasma Tank Assembly"
        icon_state = "m_i_ptank0"
        var/obj/item/weapon/prox_sensor/part1 = null
        var/obj/item/weapon/igniter/part2 = null
        var/obj/item/weapon/tank/plasmatank/part3 = null
        status = 0.0
        flags = 322.0
/obj/item/weapon/assembly/prox_ignite
        name = "Proximity/Igniter Assembly"
        icon_state = "prox_igniter0"
        var/obj/item/weapon/prox_sensor/part1 = null
        var/obj/item/weapon/igniter/part2 = null
        status = null
        flags = 322.0
/obj/item/weapon/assembly/r_i_ptank
        desc = "A very intricate igniter and signaller electrical assembly mounted onto top of a plasma tank."
        name = "Radio/Igniter/Plasma Tank Assembly"
        icon_state = "r_i_ptank"
        var/obj/item/weapon/radio/signaler/part1 = null
        var/obj/item/weapon/igniter/part2 = null
        var/obj/item/weapon/tank/plasmatank/part3 = null
        status = 0.0
        flags = 322.0
/obj/item/weapon/assembly/time_ignite
        name = "Timer/Igniter Assembly"
        icon_state = "time_igniter0"
        var/obj/item/weapon/timer/part1 = null
        var/obj/item/weapon/igniter/part2 = null
        status = null
        flags = 322.0
        s_istate = "electronic"
/obj/item/weapon/assembly/t_i_ptank
        desc = "A very intricate igniter and timer assembly mounted onto top of a plasma tank."
        name = "Timer/Igniter/Plasma Tank Assembly"
        icon_state = "t_i_ptank0"
        var/obj/item/weapon/timer/part1 = null
        var/obj/item/weapon/igniter/part2 = null
        var/obj/item/weapon/tank/plasmatank/part3 = null
        status = 0.0
        flags = 322.0
/obj/item/weapon/assembly/rad_ignite
        name = "Radio/Igniter Assembly"
        icon_state = "rad_igniter"
        var/obj/item/weapon/radio/signaler/part1 = null
        var/obj/item/weapon/igniter/part2 = null
        status = null
        flags = 322.0
/obj/item/weapon/assembly/rad_infra
        name = "Signaler/Infrared Assembly"
        icon_state = "infrared0"
        var/obj/item/weapon/radio/signaler/part1 = null
        var/obj/item/weapon/infra/part2 = null
        status = null
        flags = 322.0
/obj/item/weapon/assembly/rad_prox
        name = "Signaler/Prox Sensor Assembly"
        icon_state = "motion0"
        var/obj/item/weapon/radio/signaler/part1 = null
        var/obj/item/weapon/prox_sensor/part2 = null
        status = null
        flags = 322.0
/obj/item/weapon/assembly/rad_time
        name = "Signaler/Timer Assembly"
        icon_state = "time_sig"
        var/obj/item/weapon/radio/signaler/part1 = null
        var/obj/item/weapon/timer/part2 = null
        status = null
        flags = 322.0
/obj/item/weapon/assembly/shock_kit
        name = "Shock Kit"
        icon_state = "shock_kit"
        var/obj/item/weapon/clothing/head/helmet/part1 = null
        var/obj/item/weapon/radio/electropack/part2 = null
        status = 0.0
        w_class = 5.0
        flags = 322.0
/obj/item/weapon/bedsheet
        name = "bedsheet"
        icon = 'Icons.dmi'
        icon_state = "sheet"
        layer = 4.0
        s_istate = "w_suit"
/obj/item/weapon/bottle
        name = "bottle"
        var/obj/substance/chemical/chem = null
        throwspeed = 20.0
        w_class = 1.0
/obj/item/weapon/bottle/antitoxins
        name = "antitoxins"
        icon_state = "atoxinbottle"
/obj/item/weapon/bottle/r_ch_cough
        name = "Cough remedy"
        icon_state = "medibottle"
/obj/item/weapon/bottle/r_epil
        name = "Epileptic Remedy"
        icon_state = "medibottle"
/obj/item/weapon/bottle/rejuvenators
        name = "rejuvenators"
        icon_state = "rejuvbottle"
/obj/item/weapon/bottle/s_tox
        name = "sleep toxins"
        icon_state = "toxinbottle"
/obj/item/weapon/bottle/toxins
        name = "toxins"
        icon_state = "toxinbottle"
/obj/item/weapon/brutepack
        name = "Bruise Pack"
        icon_state = "brutepack"
        var/amount = 5.0
        w_class = 1.0
        throwspeed = 20.0
/obj/item/weapon/c_tube
        name = "Cardboard tube"
        icon_state = "c_tube"
/obj/item/weapon/camera
        name = "camera"
        icon_state = "camera"
        var/last_pic = 1.0
        s_istate = "wrench"
        w_class = 2.0
/obj/item/weapon/card
        name = "card"
        //files = (List:29)
        w_class = 1.0

        var/list/files = list(  )

/obj/item/weapon/card/data
        name = "Data Disk"
        icon_state = "card-data"
        var/function = "storage"
        var/data = "null"
        var/special = null
        s_istate = "card-id"
/obj/item/weapon/card/emag
        desc = "It's a card with a magnetic strip attached to some circuitry."
        name = "emag"
        icon_state = "emag-card"
        s_istate = "card-id"
/obj/item/weapon/card/id
        name = "Identification Card"
        icon_state = "card-id"
        var/access_level = null
        var/lab_access = null
        var/engine_access = null
        var/air_access = null
        var/registered = null
        var/assignment = null
/obj/item/weapon/clipboard
        name = "clipboard"
        icon_state = "clipboard00"
        var/obj/item/weapon/pen/pen = null
        s_istate = "clipboard"
/obj/item/weapon/cloaking_device
        name = "cloaking device"
        icon_state = "shield0"
        var/active = 0.0
        flags = 322.0
        s_istate = "electronic"
        throwforce = 5.0
        throwspeed = 5.0
        w_class = 2.0
/obj/item/weapon/clothing
        name = "clothing"
        var/a_filter = 0.0
        var/fb_filter = 0.0
        var/h_filter = 0.0
        var/s_fire = 0.0
        var/see_face = 1.0
        var/color = null
        var/brute_protect = 0.0
        var/fire_protect = 0.0
/obj/item/weapon/clothing/ears
        name = "ears"
        w_class = 2.0
/obj/item/weapon/clothing/ears/earmuffs
        name = "earmuffs"
        icon_state = "earmuffs"
        s_fire = 1.875E7
        s_istate = "earmuffs"
/obj/item/weapon/clothing/glasses
        name = "glasses"
        w_class = 2.0
        s_fire = 7.5E7
/obj/item/weapon/clothing/glasses/blindfold
        name = "blindfold"
        icon_state = "blindfold"
        s_istate = "blindfold"
/obj/item/weapon/clothing/glasses/meson
        name = "Optical Meson Scanner"
        icon_state = "m_glasses"
        s_istate = "glasses"
/obj/item/weapon/clothing/glasses/regular
        name = "Prescription Glasses"
        icon_state = "p_glasses"
        s_istate = "glasses"
/obj/item/weapon/clothing/glasses/sunglasses
        desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks many flashes."
        name = "Sunglasses"
        icon_state = "s_glasses"
        s_istate = "s_glasses"
/obj/item/weapon/clothing/glasses/thermal
        name = "Optical Thermal/Meson Scanner"
        icon_state = "t_glasses"
        s_istate = "glasses"
/obj/item/weapon/clothing/gloves
        name = "gloves"
        w_class = 2.0
        s_fire = 1.875E7
/obj/item/weapon/clothing/gloves/black
        desc = "These gloves are somewhat fire-resistant."
        name = "Black Gloves"
        icon_state = "bgloves"
        s_istate = "bgloves"
        h_filter = 4.0
        s_fire = 7.5E7
        fire_protect = 16.0
/obj/item/weapon/clothing/gloves/latex
        name = "Latex Gloves"
        icon_state = "lgloves"
        s_istate = "lgloves"
        h_filter = 5.0
/obj/item/weapon/clothing/gloves/robot
        desc = "These gloves are somewhat fire-resistant."
        name = "Robot Gloves"
        icon_state = "r_hands"
        s_istate = "r_hands"
        h_filter = 4.0
        fire_protect = 16.0
/obj/item/weapon/clothing/gloves/swat
        desc = "These gloves are somewhat fire-resistant."
        name = "SWAT Gloves"
        icon_state = "swat_gl"
        s_istate = "swat_gl"
        h_filter = 4.0
        fire_protect = 16.0
        brute_protect = 16.0
/obj/item/weapon/clothing/head
        name = "head"
/obj/item/weapon/clothing/head/bio_hood
        name = "bio hood"
        icon_state = "bio_hood"
        fb_filter = 9.0
        flags = 262.0
        see_face = 0.0
        s_fire = 1.875E7
        fire_protect = 1.0
/obj/item/weapon/clothing/head/helmet
        name = "helmet"
        icon_state = "helmet"
        flags = 266.0
        s_istate = "helmet"
        s_fire = 6.75E7
        fire_protect = 1.0
        brute_protect = 1.0
/obj/item/weapon/clothing/head/s_helmet
        name = "s helmet"
        icon_state = "s_helmet"
        flags = 262.0
        see_face = 0.0
        s_istate = "s_helmet"
        s_fire = 5.625E7
        fire_protect = 1.0
/obj/item/weapon/clothing/head/swat_hel
        name = "swat hel"
        icon_state = "swat_hel"
        flags = 270.0
        see_face = 0.0
        s_istate = "swat_hel"
        s_fire = 6.75E7
        brute_protect = 1.0
        fire_protect = 1.0
/obj/item/weapon/clothing/head/wig
        name = "wig"
/obj/item/weapon/clothing/mask
        name = "mask"
/obj/item/weapon/clothing/mask/gasmask
        name = "gasmask"
        icon_state = "mask"
        flags = 266.0
        w_class = 3.0
        fb_filter = 5.0
        a_filter = 6.0
        see_face = 0.0
        s_istate = "gas_mask"
        s_fire = 7.5E7
        brute_protect = 1.0
        fire_protect = 1.0
/obj/item/weapon/clothing/mask/m_mask
        desc = "This mask does not work very well in low pressure environments."
        name = "Medical Mask"
        icon_state = "m_mask"
        flags = 270.0
        w_class = 3.0
        fb_filter = 4.0
        a_filter = 6.0
        s_istate = "m_mask"
        s_fire = 1.875E7
/obj/item/weapon/clothing/mask/muzzle
        name = "muzzle"
        icon_state = "muzzle"
        w_class = 2.0
        a_filter = 3.0
        s_istate = "muzzle"
        s_fire = 1.875E7
/obj/item/weapon/clothing/mask/robot
        name = "Robot Mask"
        icon_state = "r_head"
        flags = 266.0
        w_class = 3.0
        fb_filter = 5.0
        a_filter = 6.0
        see_face = 0.0
        s_istate = "r_head"
        s_fire = 7.5E7
        brute_protect = 1.0
        fire_protect = 1.0
/obj/item/weapon/clothing/mask/robot/swat
        name = "SWAT Mask"
/obj/item/weapon/clothing/mask/surgical
        name = "Sterile Mask"
        icon_state = "s_mask"
        w_class = 1.0
        flags = 262.0
        fb_filter = 5.0
        a_filter = 6.0
        s_istate = "s_mask"
        s_fire = 1.875E7
/obj/item/weapon/clothing/shoes
        name = "shoes"
        var/chained = 0.0
        fb_filter = 1.0
        s_fire = 3.75E7
        brute_protect = 64.0
        fire_protect = 64.0
/obj/item/weapon/clothing/shoes/black
        name = "Black Shoes"
        icon_state = "bl_shoes"
/obj/item/weapon/clothing/shoes/brown
        name = "Brown Shoes"
        icon_state = "b_shoes"
/obj/item/weapon/clothing/shoes/orange
        name = "Orange Shoes"
        icon_state = "o_shoes"
/obj/item/weapon/clothing/shoes/robot
        name = "Robot Shoes"
        icon_state = "r_feet"
/obj/item/weapon/clothing/shoes/swat
        name = "SWAT shoes"
        icon_state = "swat_sh"
/obj/item/weapon/clothing/shoes/white
        name = "White Shoes"
        icon_state = "w_shoes"
        fb_filter = 5.0
/obj/item/weapon/clothing/suit
        name = "suit"
/obj/item/weapon/clothing/suit/armor
        name = "armor"
        icon_state = "armor"
        s_istate = "armor"
        s_fire = 1.875E7
        brute_protect = 6.0
/obj/item/weapon/clothing/suit/bio_suit
        name = "bio suit"
        icon_state = "bio_suit"
        fb_filter = 9.0
        a_filter = 9.0
        h_filter = 9.0
        s_istate = "bio_suit"
        flags = 266.0
        s_fire = 1350000.0
        fire_protect = 126.0
/obj/item/weapon/clothing/suit/firesuit
        name = "firesuit"
        icon_state = "firesuit"
        fb_filter = 6.0
        h_filter = 6.0
        a_filter = 4.0
        s_istate = "fire_suit"
        flags = 266.0
        s_fire = 7.5E7
        fire_protect = 126.0
/obj/item/weapon/clothing/suit/robot_suit
        name = "robot suit"
        icon_state = "ro_suit"
        fb_filter = 9.0
        a_filter = 9.0
        h_filter = 9.0
        s_istate = "ro_suit"
        flags = 266.0
        s_fire = 1.875E7
        fire_protect = 126.0
/obj/item/weapon/clothing/suit/sp_suit
        name = "sp suit"
        icon_state = "s_suit"
        fb_filter = 6.0
        h_filter = 6.0
        a_filter = 4.0
        s_istate = "s_suit"
        flags = 266.0
        s_fire = 6.75E7
        fire_protect = 126.0
/obj/item/weapon/clothing/suit/straight_jacket
        name = "straight jacket"
        icon_state = "straight_jacket"
        s_istate = "straight_jacket"
        s_fire = 1.875E7
        fire_protect = 126.0
/obj/item/weapon/clothing/suit/swat_suit
        name = "swat suit"
        icon_state = "swat_suit"
        fb_filter = 6.0
        h_filter = 6.0
        a_filter = 4.0
        s_istate = "swat_suit"
        flags = 266.0
        s_fire = 6.75E7
        brute_protect = 126.0
        fire_protect = 126.0
/obj/item/weapon/clothing/under
        name = "under"
        s_fire = 1.875E7
        fb_filter = 1.0
        fire_protect = 46.0
/obj/item/weapon/clothing/under/black
        name = "Black Jumpsuit"
        icon_state = "bl_suit"
        color = "black"
/obj/item/weapon/clothing/under/blue
        name = "Blue Jumpsuit"
        icon_state = "b_suit"
        color = "blue"
/obj/item/weapon/clothing/under/green
        name = "Green Jumpsuit"
        icon_state = "g_suit"
        color = "green"
/obj/item/weapon/clothing/under/orange
        name = "Orange Jumpsuit"
        icon_state = "o_suit"
        color = "orange"
/obj/item/weapon/clothing/under/pink
        name = "Pink Jumpsuit (F)"
        icon_state = "p_suit"
        color = "pink"
/obj/item/weapon/clothing/under/red
        name = "Red Jumpsuit"
        icon_state = "r_suit"
        color = "red"
/obj/item/weapon/clothing/under/white
        desc = "Made of a special fiber that gives special protection against biohazards"
        name = "White Jumpsuit"
        icon_state = "w_suit"
        color = "white"
        fb_filter = 5.0
/obj/item/weapon/clothing/under/yellow
        name = "Yellow Jumpsuit"
        icon_state = "y_suit"
        color = "yellow"
/obj/item/weapon/crowbar
        name = "crowbar"
        icon_state = "crowbar"
        flags = 322.0
        force = 5.0
        throwforce = 7.0
        s_istate = "wrench"
        w_class = 2.0
/obj/item/weapon/disk
        name = "disk"
/obj/item/weapon/disk/nuclear
        name = "Nuclear Authentication Disk"
        icon_state = "nucleardisk"
        s_istate = "card-id"
        w_class = 1.0
/obj/item/weapon/dropper
        name = "dropper"
        icon_state = "dropper_0"
        var/obj/substance/chemical/chem = null
        var/mode = "inject"
        throwspeed = 5.0
        w_class = 1.0
/obj/item/weapon/dummy
        name = "dummy"
        invisibility = 101.0
        anchored = 1.0
        flags = 2.0
/obj/item/weapon/extinguisher
        desc = "The safety is on."
        name = "Fire Extinguisher"
        icon_state = "fire_extinguisher0"
        var/waterleft = 20.0
        var/last_use = 1.0
        flags = 274.0
        w_class = 2.0
        force = 17.0
        s_istate = "fire_extinguisher"
/obj/item/weapon/f_card
        name = "Finger Print Card"
        icon_state = "f_print_card0"
        var/amount = 10.0
        s_istate = "paper"
        w_class = 1.0
/obj/item/weapon/f_print_scanner
        name = "Finger Print Scanner"
        icon_state = "f_print_scanner0"
        var/amount = 20.0
        var/printing = 0.0
        w_class = 3.0
        s_istate = "electronic"
        flags = 450.0
/obj/item/weapon/fcardholder
        name = "Finger Print Case"
        icon_state = "fcardholder0"
        s_istate = "clipboard"
        w_class = 3.0
/obj/item/weapon/flash
        name = "flash"
        icon_state = "flash"
        var/l_time = 1.0
        var/shots = 5.0
        w_class = 1.0
        flags = 322.0
        s_istate = "electronic"
        throwspeed = 20.0
/obj/item/weapon/flashbang
        desc = "It is set to detonate in 3 seconds."
        name = "flashbang"
        icon_state = "flashbang"
        var/state = null
        var/det_time = 30.0
        w_class = 2.0
        s_istate = "flashbang"
        throwspeed = 20.0
        flags = 402.0
/obj/item/weapon/flasks
        name = "flask"
        icon = 'Cryogenic2.dmi'
        var/oxygen = 0.0
        var/plasma = 0.0
        var/coolant = 0.0
/obj/item/weapon/flasks/coolant
        name = "light blue flask"
        icon_state = "coolant-c"
        coolant = 1000.0
/obj/item/weapon/flasks/oxygen
        name = "blue flask"
        icon_state = "oxygen-c"
        oxygen = 500.0
/obj/item/weapon/flasks/plasma
        name = "orange flask"
        icon_state = "plasma-c"
        plasma = 500.0
/obj/item/weapon/game_kit
        name = "Gaming Kit"
        icon_state = "game_kit"
        var/selected = null
        var/board_stat = null
        var/data = ""
        var/internet = 1.0
        s_istate = "sheet-metal"
        w_class = 5.0
/obj/item/weapon/gift
        name = "gift"
        icon_state = "gift3"
        var/size = 3.0
        var/obj/item/gift = null
        s_istate = "gift"
        w_class = 4.0
/obj/item/weapon/grab
        name = "grab"
        icon = 'screen1.dmi'
        icon_state = "grabbed"
        var/obj/screen/grab/hud1 = null
        var/mob/affecting = null
        var/mob/assailant = null
        var/state = 1.0
        var/killing = 0.0
        var/allow_upgrade = 1.0
        var/last_suffocate = 1.0
        abstract = 1.0
        s_istate = "nothing"
        w_class = 5.0
/obj/item/weapon/gun
        name = "gun"
        flags = 466.0
        s_istate = "gun"
/obj/item/weapon/gun/energy
        name = "energy"
        var/charges = 10.0
/obj/item/weapon/gun/energy/laser_gun
        name = "laser gun"
        icon_state = "gun"
        w_class = 3.0
        throwspeed = 10.0
        force = 7.0
/obj/item/weapon/gun/energy/taser_gun
        name = "taser gun"
        icon_state = "t_gun"
        w_class = 3.0
        s_istate = "gun"
        force = 10.0
        throwspeed = 10.0
/obj/item/weapon/gun/revolver
        desc = "There are 0 bullets left. Uses 357"
        name = "revolver"
        icon_state = "revolver"
        var/bullets = 0.0
        w_class = 3.0
        throwspeed = 10.0
        force = 60.0
/obj/item/weapon/hand_tele
        name = "hand tele"
        icon_state = "hand_tele"
        s_istate = "electronic"
        w_class = 2.0
/obj/item/weapon/handcuffs
        name = "handcuffs"
        icon_state = "handcuff"
        flags = 450.0
        w_class = 2.0
/obj/item/weapon/healthanalyzer
        name = "Health Analyzer"
        icon_state = "healthanalyzer"
        flags = 450.0
        w_class = 1.0
/obj/item/weapon/igniter
        name = "igniter"
        icon_state = "igniter"
        var/status = 1.0
        flags = 322.0
        s_istate = "electronic"
/obj/item/weapon/implant
        name = "implant"
        var/implanted = null
        var/color = "b"
/obj/item/weapon/implant/freedom
        name = "freedom"
        var/uses = 1.0
        color = "r"
/obj/item/weapon/implant/tracking
        name = "tracking"
        var/freq = 145.1
        var/id = 1.0
/obj/item/weapon/implantcase
        name = "Glass Case"
        icon_state = "implantcase-0"
        var/obj/item/weapon/implant/imp = null
        s_istate = "implantcase"
        throwspeed = 5.0
        w_class = 1.0
/obj/item/weapon/implantcase/tracking
        name = "Glass Case- 'Tracking'"
        icon_state = "implantcase-b"
/obj/item/weapon/implanter
        name = "implanter"
        icon_state = "implanter0"
        var/obj/item/weapon/implant/imp = null
        s_istate = "syringe_0"
        throwspeed = 5.0
        w_class = 2.0
/obj/item/weapon/implantpad
        name = "implantpad"
        icon_state = "implantpad-0"
        var/obj/item/weapon/implantcase/case = null
        var/broadcasting = null
        var/listening = 1.0
        s_istate = "electronic"
        throwspeed = 5.0
        w_class = 2.0
/obj/item/weapon/infra
        name = "Infrared Beam (Security)"
        icon_state = "infrared0"
        var/obj/beam/i_beam/first = null
        var/state = 0.0
        var/visible = 0.0
        flags = 322.0
        w_class = 2.0
        s_istate = "electronic"
/obj/item/weapon/infra_sensor
        name = "Infrared Sensor"
        icon_state = "infra_sensor"
        var/passive = 1.0
        flags = 322.0
        s_istate = "electronic"
/obj/item/weapon/locator
        name = "locator"
        icon_state = "locator"
        var/temp = null
        var/freq = 145.1
        var/broadcasting = null
        var/listening = 1.0
        flags = 322.0
        w_class = 2.0
        s_istate = "electronic"
        throwspeed = 20.0
/obj/item/weapon/m_pill
        name = "pill"
        icon_state = "pill"
        var/amount = 1.0
        var/s_time = 1.0
        w_class = 1.0
        s_istate = "pill"
        throwspeed = 20.0
/obj/item/weapon/m_pill/Tourette
        name = "green pill"
        icon_state = "pill2"
/obj/item/weapon/m_pill/antitoxin
        name = "red/blue pill"
/obj/item/weapon/m_pill/cough
        name = "red pill"
        icon_state = "pill4"
/obj/item/weapon/m_pill/cyanide
        name = "orange pill"
        icon_state = "pill5"
/obj/item/weapon/m_pill/epilepsy
        name = "blue pill"
        icon_state = "pill3"
/obj/item/weapon/m_pill/sleep
        name = "red/blue pill"
/obj/item/weapon/m_pill/superpill
        name = "red/blue pill"
/obj/item/weapon/ointment
        name = "ointment"
        icon_state = "ointment"
        var/amount = 5.0
        throwspeed = 20.0
        w_class = 1.0
/obj/item/weapon/organ
        name = "organ"
        var/owner = null
        s_istate = "bio_orange"
/obj/item/weapon/organ/external
        name = "external"
        icon = 'human.dmi'
        var/d_i_state = ""
        var/brute_dam = 0.0
        var/burn_dam = 0.0
        var/bandaged = 0.0
        var/max_damage = 0.0
        var/r_name = "chest"
        var/wound_size = 0.0
        var/max_size = 0.0
/obj/item/weapon/organ/external/chest
        name = "chest"
        icon_state = "chest"
        max_damage = 100.0
        d_i_state = "00chest0"
/obj/item/weapon/organ/external/diaper
        name = "diaper"
        icon_state = "diaper"
        r_name = "diaper"
        max_damage = 90.0
        d_i_state = "00diaper0"
/obj/item/weapon/organ/external/head
        name = "head"
        icon_state = "head"
        r_name = "head"
        max_damage = 100.0
        d_i_state = "00head0"
/obj/item/weapon/organ/external/l_arm
        name = "l arm"
        icon_state = "l_arm"
        r_name = "l_arm"
        max_damage = 40.0
        d_i_state = "00l_arm0"
/obj/item/weapon/organ/external/l_foot
        name = "l foot"
        icon_state = "l_foot"
        r_name = "l_foot"
        max_damage = 20.0
        d_i_state = "00l_foot0"
/obj/item/weapon/organ/external/l_hand
        name = "l hand"
        icon_state = "l_hand"
        r_name = "l_hand"
        max_damage = 20.0
        d_i_state = "00l_hand0"
/obj/item/weapon/organ/external/l_leg
        name = "l leg"
        icon_state = "l_leg"
        r_name = "l_leg"
        max_damage = 40.0
        d_i_state = "00l_leg0"
/obj/item/weapon/organ/external/r_arm
        name = "r arm"
        icon_state = "r_arm"
        r_name = "r_arm"
        max_damage = 40.0
        d_i_state = "00r_arm0"
/obj/item/weapon/organ/external/r_foot
        name = "r foot"
        icon_state = "r_foot"
        r_name = "r_foot"
        max_damage = 20.0
        d_i_state = "00r_foot0"
/obj/item/weapon/organ/external/r_hand
        name = "r hand"
        icon_state = "r_hand"
        r_name = "r_hand"
        max_damage = 20.0
        d_i_state = "00r_hand0"
/obj/item/weapon/organ/external/r_leg
        name = "r leg"
        icon_state = "r_leg"
        r_name = "r_leg"
        max_damage = 40.0
        d_i_state = "00r_leg0"
/obj/item/weapon/organ/internal
        name = "internal"
/obj/item/weapon/organ/internal/blood_vessels
        name = "blood vessels"
        var/heart = null
        var/lungs = null
        var/kidneys = null
/obj/item/weapon/organ/internal/brain
        name = "brain"
        var/head = null
/obj/item/weapon/organ/internal/excretory
        name = "excretory"
        var/excretory = 7.0
        var/blood_vessels = null
/obj/item/weapon/organ/internal/heart
        name = "heart"
/obj/item/weapon/organ/internal/immune_system
        name = "immune system"
        var/blood_vessels = null
        var/isys = null
/obj/item/weapon/organ/internal/intestines
        name = "intestines"
        var/intestines = 3.0
        var/blood_vessels = null
/obj/item/weapon/organ/internal/liver
        name = "liver"
        var/intestines = null
        var/blood_vessels = null
/obj/item/weapon/organ/internal/lungs
        name = "lungs"
        var/lungs = 3.0
        var/throat = null
        var/blood_vessels = null
/obj/item/weapon/organ/internal/stomach
        name = "stomach"
        var/intestines = null
/obj/item/weapon/organ/internal/throat
        name = "throat"
        var/lungs = null
        var/stomach = null
/obj/item/weapon/paint
        name = "Paint Can"
        icon_state = "paint_neutral"
        var/color = "neutral"
        s_istate = "paintcan"
        w_class = 3.0
/obj/item/weapon/paper
        name = "Paper"
        icon_state = "paper"
        var/info = null
        w_class = 1.0
        throwspeed = 15.0
/obj/item/weapon/paper/Internal
        name = "paper- 'Internal Atmosphere Operating Instructions'"
        info = "Equipment:<BR>\n\t1+ Tank(s) with appropriate atmosphere<BR>\n\t1 Gas Mask w regulator (standard issue)<BR>\n<BR>\nProcedure:<BR>\n\t1. Wear mask<BR>\n\t2. Attach oxygen tank pipe to regulater (automatic))<BR>\n\t3. Set internal!<BR>\n<BR>\nNotes:<BR>\n\tDon't forget to stop internal when tank is low by<BR>\n\tremoving internal!<BR>\n<BR>\n\tDo not use a tank that has a high concentration of toxins.<BR>\n\tThe filters shut down on internal mode!<BR>\n<BR>\n\tWhen exiting a high danger environment it is advised<BR>\n\tthat you exit through a decontamination zone!<BR>\n<BR>\n\tRefill a tank at a oxygen canister by equiping the tank (Double Click)<BR>\n\tthen 'attacking' the canister (Double Click the canister)."
/obj/item/weapon/paper/Map
        name = "paper- 'Station Blueprint'"
        info = "First Blueprint<BR>\nNote: Alterations have been made since this was drafted!<BR>\n<PRE>\n /==========EA\n         SA+|\nENG     MS CR\n      /---/\n     /--D TL\n     +----+\nM T\\ |S   |\n|----+| OS+\nL AC-/\\-/A</PRE>\n<BR>\nL: Lounge<BR>\nENG: Engine Area<BR>\nM: Medical Bay<BR>\nT: Toxin Laboratory<BR>\nAC: Air Control<BR>\nA: Shuttle Airlock<BR>\nOS: Oxygen Storage<BR>\nS: Storage<BR>\nD: Decontamination<BR>\nTL: Test Lab<BR>\nMS: Medical Storage<BR>\nCR: Control Room<BR>\nSA: Staging Area<BR>\nEA: Engine Airlock<BR>\nENG: Engine"
/obj/item/weapon/paper/Toxin
        name = "paper- 'Chemical Information'"
        info = "Known Onboard Toxins:<BR>\n\tGrade A Semi-Liquid Plasma:<BR>\n\t\tHighly poisonous. You cannot sustain concentrations above 15 units.<BR>\n\t\tA gas mask fails to filter plasma after 50 units.<BR>\n\t\tWill attempt to diffuse like a gas.<BR>\n\t\tFiltered by scrubbers.<BR>\n\t\tThere is a bottled version which is very different<BR>\n\t\t\tfrom the version found in canisters!<BR>\n<BR>\n\t\tWARNING: Highly Flammable. Keep away from heat sources<BR>\n\t\texcept in a enclosed fire area!<BR>\n\t\tWARNING: It is a crime to use this without authorization.<BR>\nKnown Onboard Anti-Toxin:<BR>\n\tAnti-Toxin Type 01P: Works against Grade A Plasma.<BR>\n\t\tBest if injected directly into bloodstream.<BR>\n\t\tA full injection is in every regular Med-Kit.<BR>\n\t\tSpecial toxin Kits hold around 7.<BR>\n<BR>\nKnown Onboard Chemicals (other):<BR>\n\tRejuvenation T#001:<BR>\n\t\tEven 1 unit injected directly into the bloodstream<BR>\n\t\t\twill cure paralysis and sleep toxins.<BR>\n\t\tIf administered to a dying patient it will prevent<BR>\n\t\t\tfurther damage for about units*3 seconds.<BR>\n\t\t\tit will not cure them or allow them to be cured.<BR>\n\t\tIt can be administeredd to a non-dying patient<BR>\n\t\t\tbut the chemicals disappear just as fast.<BR>\n\tSleep Toxin T#054:<BR>\n\t\t5 units wilkl induce precisely 1 minute of sleep.<BR>\n\t\t\tThe effects are cumulative.<BR>\n\t\tWARNING: It is a crime to use this without authorization"
/obj/item/weapon/paper/courtroom
        name = "paper- 'A Crash Course in Legal SOP on SS13'"
        info = "<B>Roles:</B><BR>\nThe Forensic Technician is basically the investigator and prosecutor.<BR>\nThe Staff Assistant can perform these functions with written authority from the Forensic Technician.<BR>\nThe Captain/HoP/Warden is ct as the judicial authority.<BR>\nThe Security Officers are responsible for executing warrants, security during trial, and prisoner transport.<BR>\n<BR>\n<B>Investigative Phase:</B><BR>\nAfter the crime has been committed the Forensic Technician's job is to gather evidence and try to ascertain not only who did it but what happened. He must take special care to catalogue everything and don't leave anything out. Write out all the evidence on paper. Make sure you take an appropriate number of fingerprints. IF he must ask someone questions he has permission to confront them. If the person refuses he can ask a judicial authority to write a subpoena for questioning. If again he fails to respond then that person is to be jailed as insubordinate and obstructing justice. Said person will be released after he cooperates.<BR>\n<BR>\nONCE the FT has a clear idea as to who the criminal is he is to write an arrest warrant on the piece of paper. IT MUST LIST THE CHARGES. The FT is to then go to the judicial authority and explain a small version of his case. If the case is moderately acceptable the authority should sign it. Security must then execute said warrant.<BR>\n<BR>\n<B>Pre-Pre-Trial Phase:</B><BR>\nNow a legal representative must be presented to the defendant if said defendant requests one. That person and the defendant are then to be given time to meet (in the jail IS ACCEPTABLE). The defendant and his lawyer are then to be given a copy of all the evidence that will be presented at trial (rewriting it all on paper is fine). THIS IS CALLED THE DISCOVERY PACK. With a few exceptions, THIS IS THE ONLY EVIDENCE BOTH SIDES MAY USE AT TRIAL. IF the prosecution will be seeking the death penalty it MUST be stated at this time. ALSO if the defense will be seeking not guilty by mental defect it must state this at this time to allow ample time for examination.<BR>\nNow at this time each side is to compile a list of witnesses. By default, the defendant is on both lists regardless of anything else. Also the defense and prosecution can compile more evidence beforehand BUT in order for it to be used the evidence MUST also be given to the other side.\nThe defense has time to compile motions against some evidence here.<BR>\n<B>Possible Motions:</B><BR>\n1. <U>Invalidate Evidence-</U> Something with the evidence is wrong and the evidence is to be thrown out. This includes irrelevance or corrupt security.<BR>\n2. <U>Free Movement-</U> Basically the defendant is to be kept uncuffed before and during the trial.<BR>\n3. <U>Subpoena Witness-</U> If the defense presents god reasons for needing a witness but said person fails to cooperate then a subpoena is issued.<BR>\n4. <U>Drop the Charges-</U> Not enough evidence is there for a trial so the charges are to be dropped. The FT CAN RETRY but the judicial authority must carefully reexamine the new evidence.<BR>\n5. <U>Declare Incompetent-</U> Basically the defendant is insane. Once this is granted a medical official is to examine the patient. If he is indeed insane he is to be placed under care of the medical staff until he is deemed competent to stand trial.<BR>\n<BR>\nALL SIDES MOVE TO A COURTROOM<BR>\n<B>Pre-Trial Hearings:</B><BR>\nA judicial authority and the 2 sides are to meet in the trial room. NO ONE ELSE BESIDES A SECURITY DETAIL IS TO BE PRESENT. The defense submits a plea. If the plea is guilty then proceed directly to sentencing phase. Now the sides each present their motions to the judicial authority. He rules on them. Each side can debate each motion. Then the judicial authority gets a list of crew members. He first gets a chance to look at them all and pick out acceptable and available jurors. Those jurors are then called over. Each side can ask a few questions and dismiss jurors they find too biased. HOWEVER before dismissal the judicial authority MUST agree to the reasoning.<BR>\n<BR>\n<B>The Trial:</B><BR>\nThe trial has three phases.<BR>\n1. <B>Opening Arguments</B>- Each side can give a short speech. They may not present ANY evidence.<BR>\n2. <B>Witness Calling/Evidence Presentation</B>- The prosecution goes first and is able to call the witnesses on his approved list in any order. He can recall them if necessary. During the questioning the lawyer may use the evidence in the questions to help prove a point. After every witness the other side has a chance to cross-examine. After both sides are done questioning a witness the prosecution can present another or recall one (even the EXACT same one again!). After prosecution is done the defense can call witnesses. After the initial cases are presented both sides are free to call witnesses on either list.<BR>\nFINALLY once both sides are done calling witnesses we move onto the next phase.<BR>\n3. <B>Closing Arguments</B>- Same as opening.<BR>\nThe jury then deliberates IN PRIVATE. THEY MUST ALL AGREE on a verdict. REMEMBER: They mix between some charges being guilty and others not guilty (IE if you supposedly killed someone with a gun and you unfortunately picked up a gun without authorization then you CAN be found not guilty of murder BUT guilty of possession of illegal weaponry.). Once they have agreed they present their verdict. If unable to reach a verdict and feel they will never they call a deadlocked jury and we restart at Pre-Trial phase with an entirely new set of jurors.<BR>\n<BR>\n<B>Sentencing Phase:</B><BR>\nIf the death penalty was sought (you MUST have gone through a trial for death penalty) then skip to the second part. <BR>\nI. Each side can present more evidence/witnesses in any order. There is NO ban on emotional aspects or anything. The prosecution is to submit a suggested penalty. After all the sides are done then the judicial authority is to give a sentence.<BR>\nII. The jury stays and does the same thing as I. Their sole job is to determine if the death penalty is applicable. If NOT then the judge selects a sentence.<BR>\n<BR>\nTADA you're done. Security then executes the sentence and adds the applicable convictions to the person's record.<BR>\n"
/obj/item/weapon/paper/flag
        icon_state = "flag_neutral"
        s_istate = "paper"
        anchored = 1.0
/obj/item/weapon/paper/jobs
        name = "paper- 'Job Information'"
        info = "Information on all formal jobs that can be assigned on Space Station 13 can be found on this document.<BR>\nThe data will be in the following form.<BR>\nGenerally lower ranking positions come first in this list.<BR>\n<BR>\n<B>Job Name</B>   general access>lab access-engine access-systems access (atmosphere control)<BR>\n\tJob Description<BR>\nJob Duties (in no particular order)<BR>\nTips (where applicable)<BR>\n<BR>\n<B>Research Assistant</B> 1>1-0-0<BR>\n\tThis is probably the lowest level position. Anyone who enters the space station after the initial job\nassignment will automatically receive this position. Access with this is restricted. Head of Personnel should\nappropriate the correct level of assistance.<BR>\n1. Assist the researchers.<BR>\n2. Clean up the labs.<BR>\n3. Prepare materials.<BR>\n<BR>\n<B>Staff Assistant</B> 2>0-0-0<BR>\n\tThis position assists the security officer in his duties. The staff assisstants should primarily br\npatrolling the ship waiting until they are needed to maintain ship safety.\n(Addendum: Updated/Elevated Security Protocols admit issuing of low level weapons to security personnel)<BR>\n1. Patrol ship/Guard key areas<BR>\n2. Assist security officer<BR>\n3. Perform other security duties.<BR>\n<BR>\n<B>Technical Assistant</B> 1>0-0-1<BR>\n\tThis is yet another low level position. The technical assistant helps the engineer and the statian\ntechnician with the upkeep and maintenance of the station. This job is very important because it usually\ngets to be a heavy workload on station technician and these helpers will alleviate that.<BR>\n1. Assist Station technician and Engineers.<BR>\n2. Perform general maintenance of station.<BR>\n3. Prepare materials.<BR>\n<BR>\n<B>Medical Assistant</B> 1>1-0-0<BR>\n\tThis is the fourth position yet it is slightly less common. This position doesn't have much power\noutside of the med bay. Consider this position like a nurse who helps to upkeep medical records and the\nmaterials (filling syringes and checking vitals)<BR>\n1. Assist the medical personnel.<BR>\n2. Update medical files.<BR>\n3. Prepare materials for medical operations.<BR>\n<BR>\n<B>Research Technician</B> 2>3-0-0<BR>\n\tThis job is primarily a step up from research assistant. These people generally do not get their own lab\nbut are more hands on in the experimentation process. At this level they are permitted to work as consultants to\nthe others formally.<BR>\n1. Inform superiors of research.<BR>\n2. Perform research alongside of official researchers.<BR>\n<BR>\n<B>Forensic Technician</B> 3>2-0-0<BR>\n\tThis job is in most cases slightly boring at best. Their sole duty is to\nperform investigations of crine scenes and analysis of the crime scene. This\nalleviates SOME of the burden from the security officer. This person's duty\nis to draw conclusions as to what happened and testify in court. Said person\nalso should stroe the evidence safely.<BR>\n1. Perform crime-scene investigations/draw conclusions.<BR>\n2. Store and catalogue evidence properly.<BR>\n3. Testify to superiors/inquieries on findings.<BR>\n<BR>\n<B>Station Technician</B> 2>0-2-3<BR>\n\tPeople assigned to this position must work to make sure all the systems aboard Space Station 13 are operable.\nThey should primarily work in the computer lab and repairing faulty equipment. They should work with the\natmospheric technician.<BR>\n1. Maintain SS13 systems.<BR>\n2. Repair equipment.<BR>\n<BR>\n<B>Atmospheric Technician</B> 3>0-0-4<BR>\n\tThese people should primarily work in the atmospheric control center and lab. They have the very important\njob of maintaining the delicate atmosphere on SS13.<BR>\n1. Maintain atmosphere on SS13<BR>\n2. Research atmospheres on the space station. (safely please!)<BR>\n<BR>\n<B>Engineer</B> 2>1-2-0<BR>\n\tPeople working as this should generally have detailed knowledge as to how the propulsion systems on SS13\nwork. They are one of the few classes that have unrestricted access to the engine area.<BR>\n1. Upkeep the engine.<BR>\n2. Prevent fires in the engine.<BR>\n3. Maintain a safe orbit.<BR>\n<BR>\n<B>Medical Researcher</B> 2>5-0-0<BR>\n\tThis position may need a little clarification. Their duty is to make sure that all experiments are safe and\nto conduct experiments that may help to improve the station. They will be generally idle until a new laboratory\nis constructed.<BR>\n1. Make sure the station is kept safe.<BR>\n2. Research medical properties of materials studied of Space Station 13.<BR>\n<BR>\n<B>Toxin Researcher</B> 2>5-0-0<BR>\n\tThese people study the properties, particularly the toxic properties, of materials handled on SS13.\nTechnically they can also be called Plasma Technicians as plasma is the material they routinly handle.<BR>\n1. Research plasma<BR>\n2. Make sure all plasma is properly handled.<BR>\n<BR>\n<B>Medical Doctor (Officer)</B> 2>0-0-0<BR>\n\tPeople working this job should primarily stay in the medical area. They should make sure everyone goes to\nthe medical bay for treatment and examination. Also they should make sure that medical supplies are kept in\norder.<BR>\n1. Heal wounded people.<BR>\n2. Perform examinations of all personnel.<BR>\n3. Moniter usage of medical equipment.<BR>\n<BR>\n<B>Security Officer</B> 3>0-0-0<BR>\n\tThese people should attempt to keep the peace inside the station and make sure the station is kept safe. One\nside duty is to assist in repairing the station. They also work like general maintenance personnel. They are not\ngiven a weapon and must use their own resources.<BR>\n(Addendum: Updated/Elevated Security Protocols admit issuing of weapons to security personnel)<BR>\n1. Maintain order.<BR>\n2. Assist others.<BR>\n3. Repair structural problems.<BR>\n<BR>\n<B>Head of Research</B> 4>5-2-2<BR>\n\tPeople assigned as head of research should make sure all experiments are conducted efficiently. They should\nalso carefully moderate the usage of all equipment. All experiment results should be reported to this person.<BR>\n1. Moderate equipment.<BR>\n2. Process research results.<BR>\n3. Coordinate all research.<BR>\n<BR>\n<B>Head of Personnel</B> 4>4-2-2<BR>\n\tPeople assigned as head of personnel will find themselves moderating all actions done by personnel. Security\nshould report to them. Also they have the ability to assign jobs and access levels.<BR>\n1. Assign duties.<BR>\n2. Moderate personnel.<BR>\n3. Command Security.<BR>\n<BR>\n<B>Captain</B> 5>5-5-5 (unrestricted station wide access)<BR>\n\tThis is the highest position youi can aquire on Space Station 13. They are allowed anywhere inside the\nspace station and therefore should protect their ID card. They also have the ability to assign positions\nand access levels. They should not abuse their power.<BR>\n1. Assign all positions on SS13<BR>\n2. Inspect the station for any problems.<BR>\n3. Perform administrative duties.<BR>\n"
/obj/item/weapon/paper/photograph
        name = "photo"
        icon_state = "photo"
        var/photo_id = 0.0
        s_istate = "paper"
/obj/item/weapon/paper/sop
        name = "paper- 'Standard Operating Procedure'"
        info = "Alert Levels:<BR>\nBlue- Emergency<BR>\n\t1. Caused by fire<BR>\n\t2. Caused by manual interaction<BR>\n\tAction:<BR>\n\t\tClose all fire doors. These can only be opened by reseting the alarm<BR>\nRed- Ejection/Self Destruct<BR>\n\t1. Caused by module operating computer.<BR>\n\tAction:<BR>\n\t\tAfter the specified time the module will eject completely.<BR>\n<BR>\nEngine Maintenance Instructions:<BR>\n\tShut off ignition systems:<BR>\n\tActivate internal power<BR>\n\tActivate orbital balance matrix<BR>\n\tRemove volatile liquids from area<BR>\n\tWear a fire suit<BR>\n<BR>\n\tAfter<BR>\n\t\tDecontaminate<BR>\n\t\tVisit medical examiner<BR>\n<BR>\nToxin Laboratory Procedure:<BR>\n\tWear a gas mask regardless<BR>\n\tGet an oxygen tank.<BR>\n\tActivate internal atmosphere<BR>\n<BR>\n\tAfter<BR>\n\t\tDecontaminate<BR>\n\t\tVisit medical examiner<BR>\n<BR>\nDisaster Procedure:<BR>\n\tFire:<BR>\n\t\tActivate sector fire alarm.<BR>\n\t\tMove to a safe area.<BR>\n\t\tGet a fire suit<BR>\n\t\tAfter:<BR>\n\t\t\tAssess Damage<BR>\n\t\t\tRepair damages<BR>\n\t\t\tIf needed, Evacuate<BR>\n\tMeteor Shower:<BR>\n\t\tActivate fire alarm<BR>\n\t\tMove to the back of ship<BR>\n\t\tAfter<BR>\n\t\t\tRepair damage<BR>\n\t\t\tIf needed, Evacuate<BR>\n\tAccidental Reentry:<BR>\n\t\tActivate fire alrms in front of ship.<BR>\n\t\tMove volatile matter to a fire proof area!<BR>\n\t\tGet a fire suit.<BR>\n\t\tStay secure until an emergency ship arrives.<BR>\n<BR>\n\t\tIf ship does not arrive-<BR>\n\t\t\tEvacuate to a nearby safe area!"
/obj/item/weapon/paper_bin
        name = "Paper Bin"
        icon = 'stationobjs.dmi'
        icon_state = "paper_bin1"
        var/amount = 30.0
        s_istate = "sheet-metal"
        w_class = 5.0
/obj/item/weapon/pen
        desc = "It's a normal black ink pen."
        name = "pen"
        icon_state = "pen"
        flags = 386.0
        w_class = 1.0
        throwspeed = 15.0
/obj/item/weapon/pen/sleepypen
        desc = "It's a normal black ink pen with a sharp point."
        var/obj/substance/chemical/chem = null
/obj/item/weapon/pill_canister
        name = "Pill Canister"
        icon_state = "pill_canister"
        w_class = 1.0
        s_istate = "brutepack"
/obj/item/weapon/pill_canister/Tourette
        desc = "<B>Tourette's Syndrome Remedy</B>\nAdminister as required to surpress Tourette syndrome induced twitching.\nAdminister only once every 15 minutes. Active for 20 at most.\n<B>WARNING</B>: Neurodepressant! Rebalances chemical alignment!\n<B>Warning</B>: May cause drowsyness.\nIf drowsyness persists for over 5 minutes contact medical professional."
        name = "Pill Canister- 'Tourette's Syndrome Remedy'"
/obj/item/weapon/pill_canister/antitoxin
        desc = "<B>Anti-toxins</B>\nAdminister as required to relieve of plasma burns.\nAdminister only once every 5 minutes.\n<B>Warning</B>: May cause drowsyness.\nIf drowsyness persists for over 5 minutes contact medical professional."
        name = "Pill Canister- 'Antitoxin Supplements'"
/obj/item/weapon/pill_canister/cough
        desc = "<B>Chronic Cough Syndrome Remedy</B>\nAdminister as required to surpress excessive coughs.\nAdminister only once every 15 minutes. Active for 20 at most.\n<B>Warning</B>: May cause drowsyness.\nIf drowsyness persists for over 5 minutes contact medical professional."
        name = "Pill Canister- 'CCS Remedy'"
/obj/item/weapon/pill_canister/epilepsy
        desc = "<B>Epilepsy Remedy</B>\nAdminister as required to surpress excessive coughs.\nAdminister only once every 15 minutes. Active for 20 at most.\n<B>WARNING</B>: Neurodepressant! Rebalances chemcial alignment!\n<B>Warning</B>: May cause drowsyness.\nIf drowsyness persists for over 5 minutes contact medical professional."
        name = "Pill Canister- 'Epilepsy Remedy'"
/obj/item/weapon/pill_canister/placebo
        desc = "<B>Placebos</B>\nThese pills do nothing phsyiologically."
        name = "Pill Canister- 'Placebos'"
/obj/item/weapon/pill_canister/sleep
        desc = "<B>Sleeping Pills</B>\nAdminister as required to calm person.\nCauses 10 minutes of drowsyness. MAY induce immediate sleep.\n<B>WARNING</B>: Neurodepressant! Do not overdose!\n<B>Warning</B>: Causes drowsiness!If drowsyness persists for over 15 minutes contact medical professional."
        name = "Pill Canister- 'Sleeping Pills'"
/obj/item/weapon/prox_sensor
        name = "Proximity Sensor"
        icon_state = "motion0"
        var/state = 0.0
        flags = 322.0
        w_class = 2.0
        s_istate = "electronic"
/obj/item/weapon/rack_parts
        name = "rack parts"
        icon_state = "rack_parts"
        flags = 322.0
/obj/item/weapon/radio
        name = "Station Bounced Radio"
        suffix = "\[3\]"
        icon_state = "radio"
        var/freq = 145.9
        var/wires = 7.0
        var/b_stat = 0.0
        var/broadcasting = null
        var/listening = 1.0
        flags = 450.0
        throwspeed = 9.0
        w_class = 2.0
        s_istate = "electronic"
/obj/item/weapon/radio/beacon
        name = "Tracking Beacon"
        icon_state = "beacon"
        var/code = "beacon"
/obj/item/weapon/radio/electropack
        name = "Electropack"
        icon_state = "electropack0"
        var/code = 2.0
        var/on = 0.0
        var/e_pads = 0.0
        freq = 144.9
        w_class = 5.0
        flags = 323.0
        s_istate = "electropack"
/obj/item/weapon/radio/headset
        name = "Radio Headset"
        icon_state = "headset"
/obj/item/weapon/radio/intercom
        name = "Station Intercom (Radio)"
        icon_state = "intercom"
        anchored = 1.0
/obj/item/weapon/radio/signaler
        name = "Remote Signaling Device"
        icon_state = "signaler"
        var/code = 30.0
        w_class = 1.0
        freq = 145.7
/obj/item/weapon/rods
        name = "rods"
        icon_state = "rods"
        var/amount = 1.0
        flags = 322.0
        w_class = 4.0
        force = 9.0
        throwforce = 20.0
        throwspeed = 10.0
/obj/item/weapon/screwdriver
        name = "screwdriver"
        icon_state = "screwdriver"
        flags = 322.0
        force = 5.0
        w_class = 2.0
        throwforce = 5.0
        throwspeed = 15.0
/obj/item/weapon/shard
        name = "shard"
        icon = 'shards.dmi'
        icon_state = "large"
        w_class = 4.0
        force = 7.0
        throwforce = 10.0
        s_istate = "shard-glass"
/obj/item/weapon/sheet
        name = "sheet"
        var/amount = 1.0
        var/length = 2.5
        var/width = 1.5
        var/height = 0.01
        flags = 322.0
        throwforce = 7.0
        throwspeed = 10.0
        w_class = 4.0
/obj/item/weapon/sheet/glass
        name = "glass"
        icon_state = "sheet-glass"
        force = 5.0
/obj/item/weapon/sheet/metal
        name = "metal"
        icon_state = "sheet-metal"
        throwforce = 14.0
/obj/item/weapon/sheet/r_metal
        name = "reinforced metal"
        icon_state = "sheet-r_metal"
        force = 5.0
        throwforce = 14.0
        s_istate = "sheet-metal"
/obj/item/weapon/shield
        name = "shield"
        icon_state = "shield0"
        var/active = 0.0
        flags = 322.0
        s_istate = "electronic"
        throwforce = 5.0
        throwspeed = 5.0
        w_class = 2.0
/obj/item/weapon/storage
        name = "storage"
        var/obj/screen/storage/boxes = null
        var/obj/screen/close/closer = null
        w_class = 3.0
/obj/item/weapon/storage/backpack
        name = "backpack"
        icon_state = "backpack"
        w_class = 4.0
        flags = 259.0
/obj/item/weapon/storage/box
        name = "Box"
        icon_state = "box"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/disk_kit
        name = "Data Disks"
        icon_state = "id_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/disk_kit/disks
/obj/item/weapon/storage/disk_kit/disks2
/obj/item/weapon/storage/fcard_kit
        name = "Fingerprint Cards"
        icon_state = "id_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/firstaid
        name = "First-Aid"
        throwspeed = 8.0
/obj/item/weapon/storage/firstaid/fire
        name = "Fire First Aid"
        icon_state = "firstaid-ointment"
/obj/item/weapon/storage/firstaid/regular
        icon_state = "firstaid"
/obj/item/weapon/storage/firstaid/syringes
        name = "Syringes (Biohazard Alert)"
        icon_state = "syringe_kit"
/obj/item/weapon/storage/firstaid/toxin
        name = "Toxin First Aid"
        icon_state = "firstaid-toxin"
/obj/item/weapon/storage/flashbang_kit
        desc = "<FONT color=red><B>WARNING: Do not use without reading these preautions!</B></FONT>\n<B>These devices are extremely dangerous and can cause blindness or deafness if used incorrectly.</B>\nThe chemicals contained in these devices have been tuned for maximal effectiveness and due to\nextreme safety precuaiotn shave been incased in a tamper-proof pack. DO NOT ATTEMPT TO OPEN\nFLASH WARNING: Do not use continually. Excercise extreme care when detonating in closed spaces.\n\tMake attemtps not to detonate withing range of 2 meters of the intended target. It is imperative\n\tthat the targets visit a medical professional after usage. Damage to eyes increases extremely per\n\tuse and according to range. Glasses with flash resistant filters DO NOT always work on high powered\n\tflash devices such as this. <B>EXERCISE CAUTION REGARDLESS OF CIRCUMSTANCES</B>\nSOUND WARNING: Do not use continually. Visit a medical professional if hearing is lost.\n\tThere is a slight chance per use of complete deafness. Exercise caution and restraint.\nSTUN WARNING: If the intended or unintended target is too close to detonation the resulting sound\n\tand flash have been known to cause extreme sensory overload resulting in temporary\n\tincapacitation.\n<B>DO NOT USE CONTINUALLY</B>\nOperating Directions:\n\t1. Pull detonnation pin. <B>ONCE THE PIN IS PULLED THE GRENADE CAN NOT BE DISARMED!</B>\n\t2. Throw grenade. <B>NEVER HOLD A LIVE FLASHBANG</B>\n\t3. The grenade will detonste 10 seconds hafter being primed. <B>EXCERCISE CAUTION</B>\n\t-<B>Never prime another grenade until after the first is detonated</B>\nNote: Usage of this pyrotechnic device without authorization is an extreme offense and can\nresult in severe punishment upwards of <B>10 years in prison per use</B>.\n\nDefault 3 second wait till from prime to detonation. This can be switched with a screwdriver\nto 10 seconds.\n\nCopyright of Nanotrasen Industries- Military Armnaments Division\nThis device was created by Nanotrasen Labs a member of the Expert Advisor Corporation"
        name = "Flashbangs (WARNING)"
        icon_state = "flashbang_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/gl_kit
        name = "Prescription Glasses"
        icon_state = "id_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/handcuff_kit
        name = "Spare Handcuffs"
        icon_state = "handcuff_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/id_kit
        name = "Spare IDs"
        icon_state = "id_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/lglo_kit
        name = "Latex Gloves"
        icon_state = "lglo_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/stma_kit
        name = "Sterile Masks"
        icon_state = "lglo_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/storage/toolbox
        name = "toolbox"
        icon_state = "toolbox"
        flags = 322.0
        force = 8.0
        throwspeed = 4.0
        w_class = 4.0
/obj/item/weapon/storage/trackimp_kit
        name = "Tracking Implant Kit"
        icon_state = "imp_kit"
        s_istate = "syringe_kit"
/obj/item/weapon/sword
        name = "sword"
        icon_state = "sword0"
        var/active = 0.0
        force = 3.0
        throwforce = 5.0
        throwspeed = 5.0
        w_class = 2.0
        flags = 290.0
/obj/item/weapon/syndicate_uplink
        name = "Station Bounced Radio"
        icon_state = "radio"
        var/temp = null
        var/uses = 1.0
        var/selfdestruct = 0.0
        flags = 322.0
        w_class = 2.0
        s_istate = "electronic"
        throwspeed = 20.0
/obj/item/weapon/syringe
        name = "syringe"
        icon_state = "syringe_0"
        var/obj/substance/chemical/chem = null
        var/mode = "inject"
        var/s_time = 1.0
        throwspeed = 5.0
        w_class = 1.0
/obj/item/weapon/table_parts
        name = "table parts"
        icon_state = "table_parts"
        flags = 322.0
/obj/item/weapon/tank
        name = "tank"
        var/maximum = null
        var/obj/substance/gas/gas = null
        var/i_used = 350.0
        flags = 323.0
        weight = 1000000.0
        force = 5.0
        throwforce = 10.0
        throwspeed = 4.0
/obj/item/weapon/tank/anesthetic
        name = "anesthetic"
        icon_state = "an_tank"
        maximum = 1750000.0
        i_used = 1.0
/obj/item/weapon/tank/jetpack
        name = "jetpack"
        icon_state = "jetpack0"
        var/on = 0.0
        maximum = 3500000.0
        w_class = 4.0
        s_istate = "jetpack"
/obj/item/weapon/tank/oxygentank
        name = "oxygentank"
        icon_state = "oxygen"
        maximum = 1750000.0
/obj/item/weapon/tank/plasmatank
        name = "plasmatank"
        icon_state = "plasma"
        maximum = 1600000.0
/obj/item/weapon/tile
        name = "steel floor tile"
        icon_state = "tile"
        var/amount = 1.0
        w_class = 3.0
        throwspeed = 5.0
        force = 6.0
        throwforce = 7.0
/obj/item/weapon/timer
        name = "timer"
        icon_state = "timer"
        var/timing = 0.0
        var/time = null
        flags = 322.0
        w_class = 2.0
        s_istate = "electronic"
/obj/item/weapon/weldingtool
        name = "weldingtool"
        icon_state = "welder"
        var/welding = 0.0
        var/weldfuel = 20.0
        flags = 322.0
        force = 3.0
        throwforce = 5.0
        throwspeed = 5.0
        w_class = 2.0
/obj/item/weapon/wire
        desc = "This is just a simple piece of regular insulated wire."
        name = "wire"
        icon_state = "item_wire"
        var/amount = 1.0
        var/laying = 0.0
        var/old_lay = null
/obj/item/weapon/wirecutters
        name = "wirecutters"
        icon_state = "cutters"
        flags = 322.0
        force = 6.0
        throwspeed = 9.0
        w_class = 2.0
/obj/item/weapon/wrapping_paper
        name = "Wrapping paper"
        icon_state = "wrap_paper"
        var/amount = 20.0
/obj/item/weapon/wrench
        name = "wrench"
        icon_state = "wrench"
        flags = 322.0
        force = 5.0
        throwforce = 7.0
        w_class = 2.0
/obj/landmark
        name = "landmark"
        icon = 'screen1.dmi'
        icon_state = "x2"
        anchored = 1.0
/obj/landmark/alterations
        name = "alterations"
/obj/laser
        name = "laser"
        icon = 'weap_sat.dmi'
        var/damage = 0.0
        var/range = 10.0
/obj/list_container
        name = "list container"
/obj/list_container/mobl
        name = "mobl"
        //container = (List:35)
        var/master = null

        var/list/container = list(  )

/obj/m_tray
        name = "m tray"
        icon = 'stationobjs.dmi'
        icon_state = "morguet"
        density = 1
        layer = 2.0
        var/obj/morgue/connected = null
        anchored = 1.0
/obj/machinery
        name = "machinery"
        var/p_dir = 0.0
/obj/machinery/alarm
        name = "alarm"
        icon = 'stationobjs.dmi'
        icon_state = "alarm:0"
        anchored = 1.0
/obj/machinery/alarm/indicator
        name = "indicator"
        icon = 'airtunnel.dmi'
        icon_state = "indicator"
/obj/machinery/at_indicator
        name = "Air Tunnel Indicator"
        icon = 'airtunnel.dmi'
        icon_state = "reader00"
        anchored = 1.0
/obj/machinery/atmoalter
        name = "atmoalter"
        var/obj/substance/gas/gas = null
        var/maximum
        var/t_status
        var/t_per
        var/c_per
        var/c_status
        var/obj/item/weapon/tank/holding
/obj/machinery/atmoalter/canister
        name = "canister"
        icon = 'canister.dmi'
        density = 1
        maximum = 1.3E8
        var/color = "blue"
        t_status = 3.0
        t_per = 50.0
        c_per = 50.0
        c_status = 0.0
        holding = null
        var/health = 20.0
        var/destroyed = null
        flags = 320.0
        weight = 1.0E7
/obj/machinery/atmoalter/canister/anesthcanister
        name = "Canister: \[N2O\]"
        icon_state = "red"
        color = "red"
/obj/machinery/atmoalter/canister/n2canister
        name = "Canister: \[N2\]"
        icon_state = "red"
        color = "red"
/obj/machinery/atmoalter/canister/oxygencanister
        name = "Canister: \[O2\]"
        icon_state = "blue"
/obj/machinery/atmoalter/canister/poisoncanister
        name = "Canister \[Plasma (Bio)\]"
        icon_state = "orange"
        color = "orange"
/obj/machinery/atmoalter/heater
        name = "heater"
        icon = 'stationobjs.dmi'
        icon_state = "heater1"
        density = 1
        maximum = 1.3E8
        t_status = 3.0
        var/h_status = 0.0
        t_per = 50.0
        var/h_tar = 20.0
        c_per = 50.0
        c_status = 0.0
        holding = null
        anchored = 1.0
/obj/machinery/atmoalter/siphs
        name = "siphs"
        density = 1
        var/alterable = 1.0
        var/f_time = 1.0
        var/location = null
        maximum = 1.3E8
        holding = null
        t_status = 3.0
        t_per = 50.0
        c_per = 50.0
        c_status = 0.0
        weight = 1.0E7
        anchored = 1.0
/obj/machinery/atmoalter/siphs/fullairsiphon
        name = "Air siphon"
        icon = 'turfs.dmi'
        icon_state = "siphon:0"
/obj/machinery/atmoalter/siphs/fullairsiphon/air_vent
        name = "Air regulator"
        icon = 'aircontrol.dmi'
        icon_state = "vent2"
        t_status = 4.0
        alterable = 0.0
        density = 0	//*****
/obj/machinery/atmoalter/siphs/fullairsiphon/port
        name = "Portable Siphon"
        icon = 'stationobjs.dmi'
        flags = 320.0
        anchored = 0.0
/obj/machinery/atmoalter/siphs/scrubbers
        name = "scrubbers"
        icon = 'turfs2.dmi'
        icon_state = "siphon:0"
/obj/machinery/atmoalter/siphs/scrubbers/air_filter
        name = "air filter"
        icon = 'aircontrol.dmi'
        icon_state = "vent2"
        t_status = 4.0
        alterable = 0.0
        density = 0 //*****
/obj/machinery/atmoalter/siphs/scrubbers/port
        name = "Portable Siphon"
        icon = 'stationobjs.dmi'
        icon_state = "scrubber:0"
        flags = 320.0
        anchored = 0.0
/obj/machinery/autolathe
        name = "Autolathe"
        icon = 'stationobjs.dmi'
        icon_state = "autolathe"
        var/m_amount = 0.0
        var/g_amount = 0.0
        var/operating = 0.0
        var/opened = 0.0
        var/temp = null
/obj/machinery/camera
        name = "Security Camera"
        icon = 'stationobjs.dmi'
        icon_state = "camera"
        var/network = "SS13"
        var/c_tag = null
        var/status = 1.0
        anchored = 1.0
        var/invuln = null
/obj/machinery/computer
        name = "computer"
        density = 1
        anchored = 1.0
/obj/machinery/computer/airtunnel
        name = "Air Tunnel Control"
        icon = 'airtunnelcomputer.dmi'
        icon_state = "console00"
/obj/machinery/computer/atmosphere
        name = "atmosphere"
        icon = 'turfs.dmi'
/obj/machinery/computer/atmosphere/siphonswitch
        name = "Area Air Control"
        icon_state = "switch"
/obj/machinery/computer/atmosphere/siphonswitch/mastersiphonswitch
        name = "Master Air Control"
/obj/machinery/computer/card
        name = "Identification Computer"
        icon = 'stationobjs.dmi'
        icon_state = "id_computer"
        var/obj/item/weapon/card/id/scan = null
        var/obj/item/weapon/card/id/modify = null
        var/authenticated = 0.0
        var/mode = 0.0
        var/printing = null
/obj/machinery/computer/communications
        name = "communications"
        icon = 'stationobjs.dmi'
        icon_state = "comm_computer"
/obj/machinery/computer/data
        name = "data"
        icon = 'weap_sat.dmi'
        icon_state = "computer"

        var/list/topics = list(  )

/obj/machinery/computer/data/weapon
        name = "weapon"
/obj/machinery/computer/data/weapon/info
        name = "Research Computer"
/obj/machinery/computer/data/weapon/log
        name = "Log Computer"
/obj/machinery/computer/dna
        name = "DNA operations computer"
        icon = 'Cryogenic2.dmi'
        icon_state = "dna_computer"
        var/obj/item/weapon/card/data/scan = null
        var/obj/item/weapon/card/data/modify = null
        var/obj/item/weapon/card/data/modify2 = null
        var/mode = null
        var/temp = null
/obj/machinery/computer/engine
        name = "engine"
        icon = 'enginecomputer.dmi'
        var/temp = null
/obj/machinery/computer/hologram_comp
        name = "Hologram Computer"
        icon = 'stationobjs.dmi'
        icon_state = "holo_console0"
        var/obj/machinery/hologram_proj/projector = null
        var/temp = null
        var/lumens = 0.0
        var/h_r = 245.0
        var/h_g = 245.0
        var/h_b = 245.0
/obj/machinery/computer/med_data
        name = "Medical Records"
        icon = 'weap_sat.dmi'
        icon_state = "computer"
        var/obj/item/weapon/card/id/scan = null
        var/authenticated = null
        var/rank = null
        var/screen = null
        var/datum/data/record/active1 = null
        var/datum/data/record/active2 = null
        var/a_id = null
        var/temp = null
        var/printing = null
/obj/machinery/computer/pod
        name = "Pod Launch Control"
        icon = 'escapepod.dmi'
        icon_state = "computer"
        var/id = 1.0
        var/obj/machinery/mass_driver/connected = null
        var/timing = 0.0
        var/time = 30.0
/obj/machinery/computer/prison_shuttle
        name = "prison shuttle"
        icon = 'shuttle.dmi'
        icon_state = "shuttlecom"
/obj/machinery/computer/secure_data
        name = "Security Records"
        icon = 'weap_sat.dmi'
        icon_state = "computer"
        var/obj/item/weapon/card/id/scan = null
        var/authenticated = null
        var/rank = null
        var/screen = null
        var/datum/data/record/active1 = null
        var/datum/data/record/active2 = null
        var/a_id = null
        var/temp = null
        var/printing = null
/obj/machinery/computer/security
        name = "security"
        icon = 'stationobjs.dmi'
        icon_state = "sec_computer"
        var/obj/machinery/camera/current = null
        var/last_pic = 1.0
        var/network = "SS13"
/obj/machinery/computer/shuttle
        name = "shuttle"
        icon = 'shuttle.dmi'
        icon_state = "shuttlecom"
        //var/authorized = (List:20)
        var/auth_need = 3.0

        var/list/authorized = list(  )

/obj/machinery/computer/sleep_console
        name = "sleep console"
        icon = 'Cryogenic2.dmi'
        icon_state = "sleeperconsole"
        var/obj/machinery/sleeper/connected = null
/obj/machinery/computer/teleporter
        name = "teleporter"
        icon = 'stationobjs.dmi'
        icon_state = "tele_computer"
        var/locked = null
        var/id = null
/obj/machinery/connector
        name = "connector"
        icon = 'pipes.dmi'
        icon_state = "connector"
        anchored = 1.0
/obj/machinery/cryo_cell
        name = "cryo cell"
        icon = 'Cryogenic2.dmi'
        icon_state = "celltop"
        density = 1
        var/line_in = null
        var/mob/occupant = null
        var/obj/substance/gas/gas = null
        anchored = 1.0
        p_dir = 8.0
/obj/machinery/dispenser
        desc = "A simple yet bulky one-way storage device for gas tanks. Holds 10 plasma and 10 oxygen tanks."
        name = "Tank Storage Unit"
        icon = 'turfs2.dmi'
        icon_state = "dispenser"
        density = 1
        var/o2tanks = 10.0
        var/pltanks = 10.0
        anchored = 1.0
/obj/machinery/dna_scanner
        name = "DNA Scanner/Implanter"
        icon = 'Cryogenic2.dmi'
        icon_state = "scanner_0"
        density = 1
        var/locked = 0.0
        var/mob/occupant = null
        anchored = 1.0
/obj/machinery/door
        name = "door"
        icon = 'doors.dmi'
        icon_state = "door1"
        opacity = 1
        density = 1
        var/visible = 1.0
        var/r_air = 0.0
        var/r_engine = 0.0
        var/r_access = 0.0
        var/r_lab = 0.0
        var/p_open = 0.0
        var/operating = null
        anchored = 1.0
/obj/machinery/door/airlock
        name = "airlock"
        icon = 'Door1.dmi'
        var/blocked = null
        var/powered = 1.0
        var/locked = 0.0
        var/wires = 511.0
/obj/machinery/door/false_wall
        name = "wall"
        icon = 'Doorf.dmi'
/obj/machinery/door/firedoor
        name = "firedoor"
        icon = 'Door1.dmi'
        icon_state = "door0"
        var/blocked = null
        opacity = 0
        density = 0
/obj/machinery/door/poddoor
        name = "poddoor"
        icon = 'Door1.dmi'
        icon_state = "door1"
        var/id = 1.0
/obj/machinery/door/window
        name = "interior door"
        icon = 'windoor.dmi'
        visible = 0.0
        flags = 512.0
        opacity = 0
/obj/machinery/firealarm
        name = "firealarm"
        icon = 'items.dmi'
        icon_state = "firealarm"
        var/detecting = 1.0
        var/working = 1.0
        var/time = 10.0
        var/timing = 0.0
        anchored = 1.0
/obj/machinery/freezer
        name = "freezer"
        icon = 'Cryogenic2.dmi'
        icon_state = "freezer_0"
        density = 1
        var/connector = null
        var/obj/machinery/line_out = null
        var/c_used = 1.0
        var/status = 0.0
        var/t_flags = 3.0
        var/transfer = 0.0
        var/temperature = 60.0
        p_dir = 4.0
        anchored = 1.0
/obj/machinery/hologram_proj
        name = "Hologram Projector"
        icon = 'stationobjs.dmi'
        icon_state = "hologram0"
        var/atom/projection = null
        anchored = 1.0
/obj/machinery/igniter
        name = "igniter"
        icon = 'stationobjs.dmi'
        icon_state = "igniter1"
        var/on = 1.0
        anchored = 1.0
/obj/machinery/injector
        name = "injector"
        icon = 'stationobjs.dmi'
        icon_state = "injector"
        density = 1
        anchored = 1.0
        flags = 512.0
/obj/machinery/mass_driver
        name = "mass driver"
        icon = 'stationobjs.dmi'
        icon_state = "mass_driver"
        var/power = 1.0
        var/code = 1.0
        var/id = 1.0
        anchored = 1.0
/obj/machinery/meter
        name = "meter"
        icon = 'pipes.dmi'
        icon_state = "meter"
        var/obj/machinery/pipes/target = null
        anchored = 1.0
/obj/machinery/nuclearbomb
        desc = "Uh oh."
        name = "Nuclear Fission Explosive"
        icon = 'stationobjs.dmi'
        icon_state = "nuclearbomb0"
        density = 1
        var/extended = 0.0
        var/timeleft = 60.0
        var/timing = 0.0
        var/r_code = "ADMIN"
        var/code = ""
        var/yes_code = 0.0
        var/safety = 1.0
        var/obj/item/weapon/disk/nuclear/auth = null
        flags = 320.0
/obj/machinery/pipes
        name = "pipes"
        icon = 'reg_pipe.dmi'
        icon_state = "12"
        var/obj/substance/gas/gas = null
        var/capacity = 6000000.0
        var/obj/machinery/node1 = null
        var/obj/machinery/node2 = null
        anchored = 1.0
/obj/machinery/pipes/flexipipe
        desc = "This piping acts like a wire."
        name = "flexipipe"
        icon = 'wire.dmi'
        capacity = 10.0
        p_dir = 12.0
/obj/machinery/pipes/high_capacity
        desc = "O look this one is bigger than the others. Let's cheer... yaaaaaaaa."
        name = "high capacity"
        icon = 'hi_pipe.dmi'
        density = 1
        capacity = 1.8E7
/obj/machinery/pipes/regular
        desc = "A stretch of pipe... How exciting."
        name = "Normal pipe"
/obj/machinery/pod
        name = "Escape Pod"
        icon = 'escapepod.dmi'
        icon_state = "pod"
        density = 1
        var/id = 1.0
        var/speed = 10.0
        var/capacity = null
        flags = 320.0
        anchored = 1.0
/obj/machinery/recharger
        name = "recharger"
        icon = 'stationobjs.dmi'
        icon_state = "recharger0"
        var/obj/item/weapon/gun/energy/charging = null
        anchored = 1.0
/obj/machinery/recon
        name = "1-Person Reconaissance Pod"
        icon = 'escapepod.dmi'
        icon_state = "recon"
        density = 1
        var/speed = 1.0
        flags = 320.0
        anchored = 1.0
/obj/machinery/restruct
        name = "DNA Physical Restructurization Accelerator"
        icon = 'Cryogenic2.dmi'
        icon_state = "restruct_0"
        density = 1
        var/locked = 0.0
        var/mob/occupant = null
        anchored = 1.0
/obj/machinery/scan_console
        name = "DNA Scanner Access Console"
        icon = 'Cryogenic2.dmi'
        icon_state = "scannerconsole"
        density = 1
        var/obj/item/weapon/card/data/scan = null
        var/func = ""
        var/data = ""
        var/special = ""
        var/status = null
        var/prog_p1 = null
        var/prog_p2 = null
        var/prog_p3 = null
        var/prog_p4 = null
        var/temp = null
        var/obj/machinery/dna_scanner/connected = null
        anchored = 1.0
/obj/machinery/sec_lock
        name = "Security Pad"
        icon = 'stationobjs.dmi'
        icon_state = "sec_lock"
        var/obj/item/weapon/card/id/scan = null
        var/a_type = 0.0
        var/obj/machinery/door/d1 = null
        var/obj/machinery/door/d2 = null
        anchored = 1.0

/obj/machinery/shuttle
        name = "shuttle"
        icon = 'shuttle.dmi'
/obj/machinery/shuttle/engine
        name = "engine"
        density = 1
        anchored = 1.0
/obj/machinery/shuttle/engine/heater
        name = "heater"
        icon_state = "heater"
/obj/machinery/shuttle/engine/platform
        name = "platform"
        icon_state = "platform"
/obj/machinery/shuttle/engine/propulsion
        name = "propulsion"
        icon_state = "propulsion"
        opacity = 1
/obj/machinery/shuttle/engine/propulsion/burst
        name = "burst"
/obj/machinery/shuttle/engine/propulsion/burst/left
        name = "left"
        icon_state = "burst_l"
/obj/machinery/shuttle/engine/propulsion/burst/right
        name = "right"
        icon_state = "burst_r"
/obj/machinery/shuttle/engine/router
        name = "router"
        icon_state = "router"
/obj/machinery/sleeper
        name = "sleeper"
        icon = 'Cryogenic2.dmi'
        icon_state = "sleeper_0"
        density = 1
        var/mob/occupant = null
        anchored = 1.0
/obj/machinery/teleport
        name = "teleport"
        icon = 'stationobjs.dmi'
        density = 1
        anchored = 1.0
/obj/machinery/teleport/hub
        name = "hub"
        icon_state = "tele0"
/obj/machinery/teleport/station
        name = "station"
        icon_state = "controller"
/obj/machinery/wire
        name = "wire"
/obj/manifest
        name = "manifest"
        icon = 'screen1.dmi'
        icon_state = "x"
/obj/meteor
        name = "meteor"
        icon = 'meteor.dmi'
        density = 1
        var/steps = null
        var/hits = 3.0
        anchored = 1.0
/obj/meteor/small
        name = "small"
        icon_state = "small"
/obj/morgue
        name = "morgue"
        icon = 'stationobjs.dmi'
        icon_state = "morgue1"
        density = 1
        var/obj/m_tray/connected = null
        anchored = 1.0
/obj/move
        name = "move"
        icon = 'shuttle.dmi'
        var/master = null
        var/tx = null
        var/ty = null
        var/oxygen = 756000.0
        var/oldoxy = null
        var/tmpoxy = null
        var/oldpoison = null
        var/tmppoison = null
        var/poison = 0.0
        var/co2 = 0.0
        var/oldco2 = null
        var/tmpco2 = null
        var/sl_gas = 0.0
        var/osl_gas = null
        var/tsl_gas = null
        var/n2 = 2844000.0
        var/on2 = null
        var/tn2 = null
        var/heat = 9.8892006E8
        var/oheat = 9.8892006E8
        var/theat = 9.8892006E8
        var/firelevel = 0.0
        var/airdir = null
        var/airforce = null
        var/checkfire = 1.0
        var/updatecell = 1.0
        anchored = 1.0
/obj/move/airtunnel
        name = "airtunnel"
        icon = 'airtunnel.dmi'
        icon_state = "floor"
        var/deployed = 0.0
        var/obj/move/airtunnel/next = null
        var/obj/move/airtunnel/previous = null
        var/r_master = null
/obj/move/airtunnel/connector
        name = "connector"
        icon_state = "floor-c"
        var/obj/move/airtunnel/current = null
        deployed = 1.0
/obj/move/airtunnel/connector/wall
        name = "wall"
        icon_state = "wall-c"
        opacity = 1
        density = 1
        updatecell = 0.0
/obj/move/airtunnel/wall
        name = "wall"
        icon_state = "wall"
        opacity = 1
        density = 1
        updatecell = 0.0
/obj/move/floor
        name = "floor"
        icon_state = "floor"
/obj/move/wall
        name = "wall"
        icon_state = "wall"
        opacity = 1
        density = 1
        updatecell = 0.0
/obj/overlay
        name = "overlay"
/obj/point
        name = "point"
        icon = 'screen1.dmi'
        icon_state = "arrow"
        layer = 16.0
/obj/portal
        name = "portal"
        icon = 'stationobjs.dmi'
        icon_state = "portal"
        density = 1
        var/obj/target = null
        anchored = 1.0
/obj/projection
        name = "Projection"
        anchored = 1.0
/obj/rack
        name = "rack"
        icon = 'Icons.dmi'
        icon_state = "rack"
        density = 1
        flags = 320.0
        anchored = 1.0
/obj/screen
        name = "screen"
        icon = 'screen1.dmi'
        layer = 20.0
        var/id = 0.0
        var/obj/master
/obj/screen/close
        name = "close"
        master = null
/obj/screen/grab
        name = "grab"
        master = null
/obj/screen/screen2
        name = "screen2"
        icon = 'screen.dmi'
/obj/screen/storage
        name = "storage"
        master = null
/obj/screen/zone_sel
        name = "Damage Zone"
        icon = 'zone_sel.dmi'
        icon_state = "blank"
        var/selecting = "chest"
        screen_loc = "15,15"
/obj/secloset
        desc = "An immobile card-locked storage container. Works by position ... not access levels"
        name = "Security Locker"
        icon = 'stationobjs.dmi'
        icon_state = "1secloset0"
        density = 1
        var/opened = 0.0
        var/locked = 1.0
        var/allowed = null
        anchored = 1.0
/obj/secloset/animal
        name = "Animal Control"
/obj/secloset/highsec
        name = "Experimental Technology"
        allowed = "Captain,Head of Personnel,Head of Research"
/obj/secloset/medical1
        name = "Medicine Closet"
        allowed = "Medical Researcher,Prison Doctor,Medical Doctor,Captain,Head of Research"
/obj/secloset/medical2
        name = "Anesthetic"
        allowed = "Medical Researcher,Prison Doctor,Medical Doctor,Captain,Head of Research"
/obj/secloset/personal
        desc = "The first card swiped gains control."
        name = "Personal Closet"
        icon_state = "0secloset0"
/obj/secloset/security1
        name = "Security Equipment"
        allowed = "Prison Security,Prison Warden,Security Officer,Captain,Head of Personnel,Head of Research"
/obj/secloset/security2
        name = "Forensics Locker"
        allowed = "Prison Security,Prison Warden,Forensic Technician,Security Officer,Captain,Head of Personnel,Head of Research"
/obj/shut_controller
        name = "shut controller"
        //parts = (List:4)
        var/moving = null

        var/list/parts = list(  )

/obj/shuttle
        name = "shuttle"
/obj/shuttle/door
        name = "door"
        icon = 'shuttle.dmi'
        icon_state = "door1"
        opacity = 1
        density = 1
        var/visible = 1.0
        var/operating = null
        anchored = 1.0
/obj/sp_start
        name = "sp start"
        icon = 'human.dmi'
        icon_state = "male"
        var/special = null
        anchored = 1.0
/obj/start
        name = "start"
        icon = 'screen1.dmi'
        icon_state = "x"
        anchored = 1.0
/obj/stool
        name = "stool"
        icon = 'Icons.dmi'
        icon_state = "stool"
        flags = 320.0
/obj/stool/bed
        name = "bed"
        icon_state = "bed"
        anchored = 1.0
/obj/stool/chair
        name = "chair"
        icon_state = "chair"
        var/status = 0.0
        anchored = 1.0
/obj/stool/chair/e_chair
        name = "electrified chair"
        icon_state = "e_chair0"
        var/atom/movable/overlay/overl = null
        var/on = 0.0
        var/obj/item/weapon/assembly/shock_kit/part1 = null
        var/last_time = 1.0
/obj/substance
        name = "substance"
        var/maximum
        var/temperature
        var/co2
        var/n2
        var/oxygen
        var/plasma
        var/sl_gas
/obj/substance/chemical
        name = "chemical"
        maximum = null
        //chemicals = (List:30)

        var/list/chemicals = list(  )		// contains /datum/chemical


/obj/substance/gas
        name = "gas"
        temperature = 20.0
        co2 = 0.0
        n2 = 0.0
        oxygen = 0.0
        plasma = 0.0
        sl_gas = 0.0
        maximum = -1.0
/obj/table
        name = "table"
        icon = 'table.dmi'
        icon_state = "alone"
        density = 1
        anchored = 1.0
/obj/team
        name = "team"
        var/captain = null
        //members = (List:1)
        var/obj/ctf_assist/master = null
        var/color = null
        var/base = null
        var/max_players = 20.0

        var/list/members = list(  )

/obj/test
        name = "test"
        var/success = 1.0
/obj/watertank
        name = "watertank"
        icon = 'stationobjs.dmi'
        icon_state = "watertank"
        density = 1
        flags = 320.0
        weight = 5000000.0
/obj/weldfueltank
        name = "weldfueltank"
        icon = 'items.dmi'
        icon_state = "weldtank"
        density = 1
        flags = 320.0
        weight = 5000000.0
/obj/window
        name = "window"
        icon = 'turfs2.dmi'
        icon_state = "window"
        density = 1
        var/health = 14.0
        var/ini_dir = null
        weight = 2500000.0
        anchored = 1.0
        flags = 512.0

/turf
        icon = 'turfs.dmi'
        var/intact = 0.0
        var/firelevel = null
        var/oxygen = 756000.0
        var/oldoxy = null
        var/tmpoxy = null
        var/oldpoison = null
        var/tmppoison = null
        var/poison = 0.0
        var/co2 = 0.0
        var/oldco2 = null
        var/tmpco2 = null
        var/sl_gas = 0.0
        var/osl_gas = null
        var/tsl_gas = null
        var/n2 = 2844000.0
        var/on2 = null
        var/tn2 = null
        var/heat = 9.8892006E8
        var/oheat = 9.8892006E8
        var/theat = 9.8892006E8
        var/airdir = null
        var/airforce = null
        var/checkfire = 1.0
        var/atmoalt = null
        var/updatecell = null
        level = 1.0
/turf/space
        name = "space"
        icon_state = "space"
        updatecell = 1.0
        oxygen = 0.0
        n2 = 0.0
        checkfire = 0
        oldoxy = 0.0
        oldpoison = 0.0
/turf/station
        name = "station"
        intact = 1.0
/turf/station/command
        name = "command"
/turf/station/command/floor
        name = "floor"
        icon = 'Icons.dmi'
        icon_state = "Floor3"
        updatecell = 1.0
/turf/station/command/floor/other
        icon_state = "Floor"
/turf/station/command/wall
        name = "wall"
        icon = 'wall.dmi'
        icon_state = "CCWall"
        opacity = 1
        density = 1
        updatecell = 0.0
/turf/station/command/wall/other
        icon_state = "r_wall"
/turf/station/engine
        name = "engine"
        icon = 'engine.dmi'
/turf/station/engine/floor
        name = "floor"
        icon_state = "floor"
        updatecell = 1.0
/turf/station/floor
        name = "floor"
        icon = 'Icons.dmi'
        icon_state = "Floor"
        var/health = 150.0
        var/burnt = null
        updatecell = 1.0
/turf/station/floor/grid
        icon = 'weap_sat.dmi'
        icon_state = "grid"
/turf/station/floor/plasma_test
/turf/station/r_wall
        name = "r wall"
        icon = 'wall.dmi'
        icon_state = "r_wall"
        opacity = 1
        density = 1
        var/state = 2.0
        var/d_state = 0.0
        updatecell = 0.0
/turf/station/shuttle
        name = "shuttle"
        icon = 'shuttle.dmi'
/turf/station/shuttle/floor
        name = "floor"
        icon_state = "floor"
        updatecell = 1.0
/turf/station/shuttle/wall
        name = "wall"
        icon_state = "wall"
        opacity = 1
        density = 1
        updatecell = 0.0
/turf/station/wall
        name = "wall"
        icon = 'wall.dmi'
        opacity = 1
        density = 1
        var/state = 2.0
        updatecell = 0.0
