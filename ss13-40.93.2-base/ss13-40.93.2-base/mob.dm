
/proc/hsl2rgb(h, s, l)

	return

/proc/ran_zone(zone, probability)

	if (probability == null)
		probability = 75
	if (probability == 100)
		return zone
	switch(zone)
		if("chest")
			if (prob(probability))
				return "chest"
			else
				var/t = rand(1, 15)
				if (t < 3)
					return "head"
				else if (t < 6)
					return "l_arm"
				else if (t < 9)
					return "r_arm"
				else if (t < 13)
					return "diaper"
				else if (t < 14)
					return "l_hand"
				else if (t < 15)
					return "r_hand"
				else
					return null

		if("diaper")
			if (prob(probability * 0.9))
				return "diaper"
			else
				var/t = rand(1, 8)
				if (t < 4)
					return "chest"
				else if (t < 5)
					return "r_leg"
				else if (t < 6)
					return "l_leg"
				else if (t < 7)
					return "l_hand"
				else if (t < 8)
					return "r_hand"
				else
					return null
		if("head")
			if (prob(probability * 0.75))
				return "head"
			else
				if (prob(60))
					return "chest"
				else
					return null
		if("l_arm")
			if (prob(probability * 0.75))
				return "l_arm"
			else
				if (prob(60))
					return "chest"
				else
					return null
		if("r_arm")
			if (prob(probability * 0.75))
				return "r_arm"
			else
				if (prob(60))
					return "chest"
				else
					return null
		if("r_leg")
			if (prob(probability * 0.75))
				return "r_leg"
			else
				if (prob(60))
					return "diaper"
				else
					return null
		if("l_leg")
			if (prob(probability * 0.75))
				return "l_leg"
			else
				if (prob(60))
					return "diaper"
				else
					return null
		if("l_hand")
			if (prob(probability * 0.5))
				return "l_hand"
			else
				var/t = rand(1, 8)
				if (t < 2)
					return "l_arm"
				else if (t < 3)
					return "chest"
				else if (t < 4)
					return "diaper"
				else if (t < 6)
					return "l_leg"
				else
					return null

		if("r_hand")
			if (prob(probability * 0.5))
				return "r_hand"
			else
				var/t = rand(1, 8)
				if (t < 2)
					return "r_arm"
				else if (t < 3)
					return "chest"
				else if (t < 4)
					return "diaper"
				else if (t < 6)
					return "r_leg"
				else
					return null

		if("l_foot")
			if (prob(probability * 0.25))
				return "l_foot"
			else
				var/t = rand(1, 5)
				if (t < 2)
					return "r_leg"
				else
					if (t < 3)
						return "l_foot"
					else
						return null
		if("r_foot")
			if (prob(probability * 0.25))
				return "r_foot"
			else
				var/t = rand(1, 5)
				if (t < 2)
					return "r_leg"
				else
					if (t < 3)
						return "l_foot"
					else
						return null
		else
	return

/proc/stars(n, pr)

	if (pr == null)
		pr = 25
	if (pr <= 0)
		return null
	else
		if (pr >= 100)
			return n
	var/te = n
	var/t = ""
	n = length(n)
	var/p = null
	p = 1
	while(p <= n)
		if ((copytext(te, p, p + 1) == " " || prob(pr)))
			t = text("[][]", t, copytext(te, p, p + 1))
		else
			t = text("[]*", t)
		p++
	return t
	return

/proc/stutter(n)

	var/te = n
	var/t = ""
	n = length(n)
	var/p = null
	p = 1
	while(p <= n)
		var/n_letter = copytext(te, p, p + 1)
		if (prob(80))
			if (prob(10))
				n_letter = text("[][][][]", n_letter, n_letter, n_letter, n_letter)
			else
				if (prob(20))
					n_letter = text("[][][]", n_letter, n_letter, n_letter)
				else
					if (prob(5))
						n_letter = null
					else
						n_letter = text("[][]", n_letter, n_letter)
		t = text("[][]", t, n_letter)
		p++
	return t
	return

/proc/findname(msg)

	for(var/mob/M in world)
		if (M.rname == text("[]", msg))
			return 1
		//Foreach goto(15)
	return 0
	return

/obj/proc/alter_health()

	return 1
	return

/obj/proc/relaymove()

	return

/obj/item/weapon/grab/proc/throw()

	src.affecting.density = 1
	step(src.affecting, src.assailant.dir)
	if (prob(75))
		step(src.affecting, src.assailant.dir)
	//SN src = null
	del(src)
	return
	return

/obj/item/weapon/grab/proc/synch()

	if (src.assailant.r_hand == src)
		src.hud1.screen_loc = "1,4"
	else
		src.hud1.screen_loc = "3,4"
	return

/obj/item/weapon/grab/proc/process()

	if ((!( isturf(src.assailant.loc) ) || (!( isturf(src.affecting.loc) ) || (src.assailant.loc != src.affecting.loc && get_dist(src.assailant, src.affecting) > 1))))
		//SN src = null
		del(src)
		return
	if (src.assailant.client)
		src.assailant.client.screen -= src.hud1
		src.assailant.client.screen += src.hud1
	if (src.assailant.pulling == src.affecting)
		src.assailant.pulling = null
	if (src.state <= 2)
		src.allow_upgrade = 1
		if ((src.assailant.l_hand && src.assailant.l_hand != src && istype(src.assailant.l_hand, /obj/item/weapon/grab)))
			var/obj/item/weapon/grab/G = src.assailant.l_hand
			if (G.affecting != src.affecting)
				src.allow_upgrade = 0
		if ((src.assailant.r_hand && src.assailant.r_hand != src && istype(src.assailant.r_hand, /obj/item/weapon/grab)))
			var/obj/item/weapon/grab/G = src.assailant.r_hand
			if (G.affecting != src.affecting)
				src.allow_upgrade = 0
		if (src.state == 2)
			var/h = src.affecting.hand
			src.affecting.hand = 0
			src.affecting.drop_item()
			src.affecting.hand = 1
			src.affecting.drop_item()
			src.affecting.hand = h
			for(var/obj/item/weapon/grab/G in src.affecting.grabbed_by)
				if (G.state == 2)
					src.allow_upgrade = 0
				//Foreach goto(341)
		if (src.allow_upgrade)
			src.hud1.icon_state = "reinforce"
		else
			src.hud1.icon_state = "!reinforce"
	else
		if (!( src.affecting.buckled ))
			src.affecting.loc = src.assailant.loc
	if ((src.killing && src.state == 3))
		src.affecting.stunned = max(5, src.affecting.stunned)
		src.affecting.paralysis = max(3, src.affecting.paralysis)
		src.affecting.losebreath = min(src.affecting.losebreath + 2, 3)
	return

/obj/item/weapon/grab/proc/s_click(obj/screen/S as obj)

	if (src.assailant.next_move > world.time)
		return
	if ((!( src.assailant.canmove ) || src.assailant.lying))
		//SN src = null
		del(src)
		return
	switch(S.id)
		if(1.0)
			if (src.state >= 3)
				if (!( src.killing ))
					for(var/mob/O in viewers(src.assailant, null))
						O.show_message(text("\red [] has temporarily tightened his grip on []!", src.assailant, src.affecting), 1)
						//Foreach goto(97)
					src.assailant.next_move = world.time + 10
					src.affecting.stunned = max(2, src.affecting.stunned)
					src.affecting.paralysis = max(1, src.affecting.paralysis)
					src.affecting.losebreath = min(src.affecting.losebreath + 1, 3)
					src.last_suffocate = world.time
					flick("disarm/killf", S)
		else
	return

/obj/item/weapon/grab/proc/s_dbclick(obj/screen/S as obj)

	if ((src.assailant.next_move > world.time && !( src.last_suffocate < world.time + 2 )))
		return
	if ((!( src.assailant.canmove ) || src.assailant.lying))
		//SN src = null
		del(src)
		return
	switch(S.id)
		if(1.0)
			if (src.state < 2)
				if (!( src.allow_upgrade ))
					return
				if (prob(75))
					for(var/mob/O in viewers(src.assailant, null))
						O.show_message(text("\red [] has grabbed [] aggressively (now hands)!", src.assailant, src.affecting), 1)
						//Foreach goto(121)
					src.state = 2
					src.icon_state = "grabbed1"
				else
					for(var/mob/O in viewers(src.assailant, null))
						O.show_message(text("\red [] has failed to grab [] aggressively!", src.assailant, src.affecting), 1)
						//Foreach goto(186)
					//SN src = null
					del(src)
					return
			else
				if (src.state < 3)
					for(var/mob/O in viewers(src.assailant, null))
						O.show_message(text("\red [] has reinforced his grip on [] (now neck)!", src.assailant, src.affecting), 1)
						//Foreach goto(257)
					src.state = 3
					src.icon_state = "grabbed+1"
					if (!( src.affecting.buckled ))
						src.affecting.loc = src.assailant.loc
					src.hud1.icon_state = "disarm/kill"
					src.hud1.name = "disarm/kill"
				else
					if (src.state >= 3)
						src.killing = !( src.killing )
						if (src.killing)
							for(var/mob/O in viewers(src.assailant, null))
								O.show_message(text("\red [] has tightened his grip on []'s neck!", src.assailant, src.affecting), 1)
								//Foreach goto(392)
							src.assailant.next_move = world.time + 10
							src.affecting.stunned = max(2, src.affecting.stunned)
							src.affecting.paralysis = max(1, src.affecting.paralysis)
							src.affecting.losebreath += 1
							src.hud1.icon_state = "disarm/kill1"
						else
							src.hud1.icon_state = "disarm/kill"
							for(var/mob/O in viewers(src.assailant, null))
								O.show_message(text("\red [] has loosened the grip on []'s neck!", src.assailant, src.affecting), 1)
								//Foreach goto(517)
		else
	return

/obj/item/weapon/grab/New()

	..()
	src.hud1 = new /obj/screen/grab( src )
	src.hud1.icon_state = "reinforce"
	src.hud1.name = "Reinforce Grab"
	src.hud1.id = 1
	src.hud1.master = src
	return

/obj/item/weapon/grab/attack(mob/M as mob, user as mob)

	if (M == src.affecting)
		if (src.state < 3)
			s_dbclick(src.hud1)
		else
			s_click(src.hud1)
	return 0
	return

/obj/item/weapon/grab/dropped()

	//SN src = null
	del(src)
	return
	return

/obj/item/weapon/grab/Del()

	//src.hud1 = null
	del(src.hud1)
	..()
	return

/obj/screen/zone_sel/MouseDown(location, control,params)		//(location, icon_x, icon_y)
	// Changes because of 4.0
	var/list/PL = params2list(params)
	var/icon_x = text2num(PL["icon-x"])
	var/icon_y = text2num(PL["icon-y"])

	if (icon_y < 6)
		if ((icon_x > 10 && icon_x < 22))
			if (icon_x < 16)
				src.selecting = "r_foot"
			else
				src.selecting = "l_foot"
	else
		if (icon_y < 13)
			if ((icon_x > 11 && icon_x < 21))
				if (icon_x < 16)
					src.selecting = "r_leg"
				else
					src.selecting = "l_leg"
		else
			if (icon_y < 16)
				if ((icon_x > 9 && icon_x < 23))
					if (icon_x < 12)
						src.selecting = "r_hand"
					else
						if (icon_x < 20)
							src.selecting = "diaper"
						else
							src.selecting = "l_hand"
			else
				if (icon_y < 23)
					if ((icon_x > 9 && icon_x < 23))
						if (icon_x < 12)
							src.selecting = "r_arm"
						else
							if (icon_x < 20)
								src.selecting = "chest"
							else
								src.selecting = "l_arm"
				else
					if (icon_y < 25)
						if ((icon_x > 13 && icon_x < 18))
							src.selecting = "neck"
					else
						if (icon_y < 30)
							if ((icon_x > 11 && icon_x < 20))
								if (icon_y == 28)
									src.selecting = "eyes"
								else
									if (icon_y == 29)
										src.selecting = "hair"
									else
										if (icon_y == 26)
											src.selecting = "mouth"
										else
											src.selecting = "head"
	return

/obj/screen/grab/Click()

	src.master:s_click(src)
	return

/obj/screen/grab/DblClick()

	src.master:s_dbclick(src)
	return

/obj/screen/grab/attack_hand()

	return

/obj/screen/grab/attackby()

	return

/obj/screen/Click()


	switch(src.name)

		if("other")
			usr.other = !( usr.other )
		if("intent")
			if (!( usr.intent ))
				switch(usr.a_intent)
					if("help")
						usr.intent = "12,15"
					if("disarm")
						usr.intent = "13,15"
					if("hurt")
						usr.intent = "14,15"
					if("grab")
						usr.intent = "11,15"
					else
			else
				usr.intent = null
		if("m_intent")
			if (!( usr.m_int ))
				switch(usr.m_intent)
					if("run")
						usr.m_int = "12,14"
					if("walk")
						usr.m_int = "13,14"
					if("face")
						usr.m_int = "14,14"
					else
			else
				usr.m_int = null
		if("walk")
			usr.m_intent = "walk"
			usr.m_int = "13,14"
		if("face")
			usr.m_intent = "face"
			usr.m_int = "14,14"
		if("run")
			usr.m_intent = "run"
			usr.m_int = "12,14"
		if("hurt")
			usr.a_intent = "hurt"
			usr.intent = "14,15"
		if("grab")
			usr.a_intent = "grab"
			usr.intent = "11,15"
		if("disarm")
			if (istype(usr, /mob/human))
				var/mob/M = usr
				M.a_intent = "disarm"
				M.intent = "13,15"
		if("help")
			usr.a_intent = "help"
			usr.intent = "12,15"
		if("Reset Machine")
			usr.machine = null
		if("internal")
			if ((!( usr.stat ) && usr.canmove && !( usr.restrained() )))
				usr.internal = null
		if("pull")
			usr.pulling = null
		if("sleep")
			usr.sleeping = !( usr.sleeping )
		if("rest")
			usr.resting = !( usr.resting )
		if("throw")
			if ((!( usr.stat ) && usr.canmove && isturf(usr.loc) && !( usr.restrained() )))
				usr.throw_item_v()
		if("drop")
			usr.drop_item_v()
		if("swap")
			usr.swap_hand()
		if("resist")
			if (usr.next_move < world.time)
				return
			usr.next_move = world.time + 20
			if ((!( usr.stat ) && usr.canmove && !( usr.restrained() )))
				for(var/obj/O in usr.requests)
					//O = null
					del(O)
					//Foreach goto(557)
				for(var/obj/item/weapon/grab/G in usr.grabbed_by)
					if (G.state == 1)
						//G = null
						del(G)
					else
						if (G.state == 2)
							if (prob(25))
								for(var/mob/O in viewers(usr, null))
									O.show_message(text("\red [] has broken free of []'s grip!", usr, G.assailant), 1)
									//Foreach goto(681)
								//G = null
								del(G)
						else
							if (G.state == 2)
								if (prob(5))
									for(var/mob/O in viewers(usr, null))
										O.show_message(text("\red [] has broken free of []'s headlock!", usr, G.assailant), 1)
										//Foreach goto(762)
									//G = null
									del(G)
					//Foreach goto(602)
				for(var/mob/O in viewers(usr, null))
					O.show_message(text("\red <B>[] resists!</B>", usr), 1)
					//Foreach goto(824)
	return

/obj/screen/attack_hand(mob/user as mob, using)

	user.db_click(src.name, using)
	return

/obj/screen/attack_paw(mob/user as mob, using)

	user.db_click(src.name, using)
	return

/obj/point/point()
	set src in oview()

	return

/obj/dna/proc/cleanup()

	var/e1 = (length(src.struc_enzyme) > 3 ? copytext(src.struc_enzyme, 1, 4) : null)
	if ((e1 == "AEC" && length(src.spec_identity) > src.n_chromo))
		src.r_spec_identity = src.spec_identity
	else
		if (e1 == "14A")
			var/t1 = rand(1, 3)
			var/t = null
			while(t < t1)
				var/t2 = rand(1, length(src.use_enzyme) + 1)
				src.use_enzyme = text("[]0[]", copytext(1, t2, null), copytext(t2 + 1, length(src.use_enzyme) + 1, null))
				t++
		else
			if (e1 == "CDE")
				if (length(src.spec_identity) == length(src.r_spec_identity))
					src.spec_identity = src.r_spec_identity
				else
					src.r_spec_identity = src.spec_identity
			else
				src.spec_identity = src.r_spec_identity
	src.n_chromo = length(src.r_spec_identity)
	return

/obj/hud/New()

	src.instantiate()
	..()
	return

/obj/hud/proc/instantiate()

	src.adding = list(  )
	src.other = list(  )
	src.intents = list(  )
	src.mon_blo = list(  )
	src.m_ints = list(  )
	src.mov_int = list(  )
	src.vimpaired = list(  )
	src.g_dither = new src.h_type( src )
	src.g_dither.screen_loc = "1,1 to 15,15"
	src.g_dither.name = "Mask"
	src.g_dither.icon_state = "dither12g"
	src.g_dither.layer = 18
	src.blurry = new src.h_type( src )
	src.blurry.screen_loc = "1,1 to 15,15"
	src.blurry.name = "Blurry"
	src.blurry.icon_state = "blurry"
	src.blurry.layer = 17
	var/obj/hud/using = new src.h_type( src )
	using.name = "vitals"
	using.dir = SOUTH
	using.screen_loc = "15,2 to 15,15"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "actions"
	using.dir = EAST
	using.screen_loc = "4,1 to 14,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.dir = NORTHWEST
	using.screen_loc = "15,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.dir = WEST
	using.screen_loc = "1,3 to 2,3"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.dir = NORTHEAST
	using.screen_loc = "3,3"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.dir = NORTH
	using.screen_loc = "3,2"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.dir = SOUTHEAST
	using.screen_loc = "3,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.dir = SOUTHWEST
	using.screen_loc = "1,1 to 2,2"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "drop"
	using.icon_state = "act_drop"
	using.screen_loc = "7,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "throw"
	using.icon_state = "act_throw"
	using.screen_loc = "9,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "swap"
	using.icon_state = "act_hand"
	using.screen_loc = "11,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "i_clothing"
	using.dir = SOUTH
	using.icon_state = "center"
	using.screen_loc = "2,2"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "o_clothing"
	using.dir = SOUTH
	using.icon_state = "equip"
	using.screen_loc = "2,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "headset"
	using.dir = SOUTHEAST
	using.icon_state = "equip"
	using.screen_loc = "3,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "r_hand"
	using.dir = WEST
	using.icon_state = "equip"
	using.screen_loc = "1,2"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "l_hand"
	using.dir = EAST
	using.icon_state = "equip"
	using.screen_loc = "3,2"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "id"
	using.dir = SOUTHWEST
	using.icon_state = "equip"
	using.screen_loc = "1,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "mask"
	using.dir = NORTH
	using.icon_state = "equip"
	using.screen_loc = "2,3"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "back"
	using.dir = NORTHEAST
	using.icon_state = "equip"
	using.screen_loc = "3,3"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "storage1"
	using.icon_state = "block"
	using.screen_loc = "4,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "storage2"
	using.icon_state = "block"
	using.screen_loc = "5,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "resist"
	using.icon_state = "act_resist"
	using.screen_loc = "13,1"
	using.layer = 19
	src.adding += using
	using = new src.h_type( src )
	using.name = "other"
	using.icon_state = "other"
	using.screen_loc = "4,2"
	using.layer = 20
	src.adding += using
	using = new src.h_type( src )
	using.name = "intent"
	using.icon_state = "intent"
	using.screen_loc = "14,15"
	using.layer = 20
	src.adding += using
	using = new src.h_type( src )
	using.name = "m_intent"
	using.icon_state = "move"
	using.screen_loc = "14,14"
	using.layer = 20
	src.adding += using
	using = new src.h_type( src )
	using.name = "gloves"
	using.icon_state = "gloves"
	using.screen_loc = "4,2"
	using.layer = 19
	src.other += using
	using = new src.h_type( src )
	using.name = "eyes"
	using.icon_state = "glasses"
	using.screen_loc = "6,2"
	using.layer = 19
	src.other += using
	using = new src.h_type( src )
	using.name = "ears"
	using.icon_state = "ears"
	using.screen_loc = "9,2"
	using.layer = 19
	src.other += using
	using = new src.h_type( src )
	using.name = "head"
	using.icon_state = "hair"
	using.screen_loc = "7,2"
	using.layer = 19
	src.other += using
	using = new src.h_type( src )
	using.name = "shoes"
	using.icon_state = "shoes"
	using.screen_loc = "5,2"
	using.layer = 19
	src.other += using
	using = new src.h_type( src )
	using.name = "belt"
	using.icon_state = "belt"
	using.screen_loc = "8,2"
	using.layer = 19
	src.other += using
	using = new src.h_type( src )
	using.name = "grab"
	using.icon_state = "grab"
	using.screen_loc = "11,15"
	using.layer = 19
	src.intents += using
	using = new src.h_type( src )
	using.name = "hurt"
	using.icon_state = "harm"
	using.screen_loc = "14,15"
	using.layer = 19
	src.intents += using
	src.m_ints += using
	using = new src.h_type( src )
	using.name = "disarm"
	using.icon_state = "disarm"
	using.screen_loc = "13,15"
	using.layer = 19
	src.intents += using
	using = new src.h_type( src )
	using.name = "help"
	using.icon_state = "help"
	using.screen_loc = "12,15"
	using.layer = 19
	src.intents += using
	src.m_ints += using
	using = new src.h_type( src )
	using.name = "face"
	using.icon_state = "facing"
	using.screen_loc = "14,14"
	using.layer = 19
	src.mov_int += using
	using = new src.h_type( src )
	using.name = "walk"
	using.icon_state = "walking"
	using.screen_loc = "13,14"
	using.layer = 19
	src.mov_int += using
	using = new src.h_type( src )
	using.name = "run"
	using.icon_state = "running"
	using.screen_loc = "12,14"
	using.layer = 19
	src.mov_int += using
	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "x"
	using.screen_loc = "2,2"
	using.layer = 19
	src.mon_blo += using
	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "x"
	using.screen_loc = "1,1"
	using.layer = 19
	src.mon_blo += using
	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "x"
	using.screen_loc = "2,1"
	using.layer = 19
	src.mon_blo += using
	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "x"
	using.screen_loc = "3,1"
	using.layer = 19
	src.mon_blo += using
	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "x"
	using.screen_loc = "4,1"
	using.layer = 19
	src.mon_blo += using
	using = new src.h_type( src )
	using.name = "blocked"
	using.icon_state = "x"
	using.screen_loc = "5,1"
	using.layer = 19
	src.mon_blo += using
	using = new src.h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "1,1 to 5,15"
	using.layer = 17
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "5,1 to 10,5"
	using.layer = 17
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,15"
	using.layer = 17
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "11,1 to 15,15"
	using.layer = 17
	src.vimpaired += using
	return

/obj/equip_e/proc/process()

	return

/obj/equip_e/proc/done()

	return

/obj/equip_e/New()

	if (!( ticker ))
		//SN src = null
		del(src)
		return
	spawn( 100 )
		//SN src = null
		del(src)
		return
		return
	..()
	return

/obj/equip_e/monkey/process()

	if (src.item)
		src.item.add_fingerprint(src.source)
	if (!( src.item ))
		switch(src.place)
			if("head")
				if (!( src.target.wear_mask ))
					//SN src = null
					del(src)
					return
			if("l_hand")
				if (!( src.target.l_hand ))
					//SN src = null
					del(src)
					return
			if("r_hand")
				if (!( src.target.r_hand ))
					//SN src = null
					del(src)
					return
			if("back")
				if (!( src.target.back ))
					//SN src = null
					del(src)
					return
			if("handcuff")
				if (!( src.target.handcuffed ))
					//SN src = null
					del(src)
					return
			if("internal")
				if ((!( (istype(src.target.wear_mask, /obj/item/weapon/clothing/mask) && istype(src.target.back, /obj/item/weapon/tank) && !( src.target.internal )) ) && !( src.target.internal )))
					//SN src = null
					del(src)
					return

	if (src.item)
		for(var/mob/O in viewers(src.target, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[] is trying to put a [] on []</B>", src.source, src.item, src.target), 1)
			//Foreach goto(251)
	else
		var/message = null
		switch(src.place)
			if("l_hand")
				message = text("\red <B>[] is trying to take off a [] from []'s left hand!</B>", src.source, src.target.l_hand, src.target)
			if("r_hand")
				message = text("\red <B>[] is trying to take off a [] from []'s right hand!</B>", src.source, src.target.r_hand, src.target)
			if("back")
				message = text("\red <B>[] is trying to take off a [] from []'s back!</B>", src.source, src.target.back, src.target)
			if("handcuff")
				message = text("\red <B>[] is trying to unhandcuff []!</B>", src.source, src.target)
			if("internal")
				if (src.target.internal)
					message = text("\red <B>[] is trying to remove []'s internals</B>", src.source, src.target)
				else
					message = text("\red <B>[] is trying to set on []'s internals.</B>", src.source, src.target)
			else
		for(var/mob/M in viewers(src.target, null))
			M.show_message(message, 1)
			//Foreach goto(469)
	spawn( 30 )
		src.done()
		return
	return

/obj/equip_e/monkey/done()

	if ((!( src.source ) || !( src.target )))
		return
	if (src.source.loc != src.s_loc)
		return
	if (src.target.loc != src.t_loc)
		return
	if ((src.item && src.source.equipped() != src.item))
		return
	if ((src.source.restrained() || src.source.stat))
		return
	switch(src.place)
		if("mask")
			if (src.target.wear_mask)
				var/obj/item/weapon/W = src.target.wear_mask
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/clothing/mask))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.wear_mask = src.item
					src.item.loc = src.target
		if("l_hand")
			if (src.target.l_hand)
				var/obj/item/weapon/W = src.target.l_hand
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.l_hand = src.item
					src.item.loc = src.target
		if("r_hand")
			if (src.target.r_hand)
				var/obj/item/weapon/W = src.target.r_hand
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.r_hand = src.item
					src.item.loc = src.target
		if("back")
			if (src.target.back)
				var/obj/item/weapon/W = src.target.back
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if ((istype(src.item, /obj/item/weapon) && src.item.flags & 1))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.back = src.item
					src.item.loc = src.target
		if("handcuff")
			if (src.target.handcuffed)
				var/obj/item/weapon/W = src.target.handcuffed
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/handcuffs))
					src.source.drop_item()
					src.target.handcuffed = src.item
					src.item.loc = src.target
		if("internal")
			if (src.target.internal)
				src.target.internal.add_fingerprint(src.source)
				src.target.internal = null
			else
				if (src.target.internal)
					src.target.internal = null
				if (!( istype(src.target.wear_mask, /obj/item/weapon/clothing/mask) ))
					return
				else
					if (istype(src.target.back, /obj/item/weapon/tank))
						src.target.internal = src.target.back
						src.target.internal.add_fingerprint(src.source)
						for(var/mob/M in viewers(src.target, 1))
							if ((M.client && !( M.blinded )))
								M.show_message(text("[] is now running on internals.", src.target), 1)
							//Foreach goto(1097)
		else
	src.source.UpdateClothing()
	src.target.UpdateClothing()
	//SN src = null
	del(src)
	return
	return

/obj/equip_e/human/process()

	if (src.item)
		src.item.add_fingerprint(src.source)
	if (!( src.item ))
		switch(src.place)
			if("mask")
				if (!( src.target.wear_mask ))
					//SN src = null
					del(src)
					return
			if("headset")
				if (!( src.target.w_radio ))
					//SN src = null
					del(src)
					return
			if("l_hand")
				if (!( src.target.l_hand ))
					//SN src = null
					del(src)
					return
			if("r_hand")
				if (!( src.target.r_hand ))
					//SN src = null
					del(src)
					return
			if("suit")
				if (!( src.target.wear_suit ))
					//SN src = null
					del(src)
					return
			if("uniform")
				if (!( src.target.w_uniform ))
					//SN src = null
					del(src)
					return
			if("back")
				if (!( src.target.back ))
					//SN src = null
					del(src)
					return
			if("syringe")
				return
			if("pill")
				return
			if("handcuff")
				if (!( src.target.handcuffed ))
					//SN src = null
					del(src)
					return
			if("id")
				if ((!( src.target.wear_id ) || !( src.target.w_uniform )))
					//SN src = null
					del(src)
					return
			if("internal")
				if ((!( (istype(src.target.wear_mask, /obj/item/weapon/clothing/mask) && istype(src.target.back, /obj/item/weapon/tank) && !( src.target.internal )) ) && !( src.target.internal )))
					//SN src = null
					del(src)
					return

	var/list/L = list( "syringe", "pill" )
	if ((src.item && !( L.Find(src.place) )))
		for(var/mob/O in viewers(src.target, null))
			O.show_message(text("\red <B>[] is trying to put a [] on []</B>", src.source, src.item, src.target), 1)
			//Foreach goto(401)
	else
		if (src.place == "syringe")
			for(var/mob/O in viewers(src.target, null))
				O.show_message(text("\red <B>[] is trying to inject []!</B>", src.source, src.target), 1)
				//Foreach goto(466)
		else
			if (src.place == "pill")
				for(var/mob/O in viewers(src.target, null))
					O.show_message(text("\red <B>[] is trying to force [] to swallow []!</B>", src.source, src.target, src.item), 1)
					//Foreach goto(527)
			else
				var/message = null
				switch(src.place)
					if("mask")
						message = text("\red <B>[] is trying to take off a [] from []'s head!</B>", src.source, src.target.wear_mask, src.target)
					if("headset")
						message = text("\red <B>[] is trying to take off a [] from []'s face!</B>", src.source, src.target.w_radio, src.target)
					if("l_hand")
						message = text("\red <B>[] is trying to take off a [] from []'s left hand!</B>", src.source, src.target.l_hand, src.target)
					if("r_hand")
						message = text("\red <B>[] is trying to take off a [] from []'s right hand!</B>", src.source, src.target.r_hand, src.target)
					if("gloves")
						message = text("\red <B>[] is trying to take off the [] from []'s hands!</B>", src.source, src.target.gloves, src.target)
					if("eyes")
						message = text("\red <B>[] is trying to take off the [] from []'s eyes!</B>", src.source, src.target.glasses, src.target)
					if("ears")
						message = text("\red <B>[] is trying to take off the [] from []'s ears!</B>", src.source, src.target.ears, src.target)
					if("head")
						message = text("\red <B>[] is trying to take off the [] from []'s head!</B>", src.source, src.target.head, src.target)
					if("shoes")
						message = text("\red <B>[] is trying to take off the [] from []'s feet!</B>", src.source, src.target.shoes, src.target)
					if("belt")
						message = text("\red <B>[] is trying to take off the [] from []'s belt!</B>", src.source, src.target.belt, src.target)
					if("suit")
						message = text("\red <B>[] is trying to take off a [] from []'s body!</B>", src.source, src.target.wear_suit, src.target)
					if("back")
						message = text("\red <B>[] is trying to take off a [] from []'s back!</B>", src.source, src.target.back, src.target)
					if("handcuff")
						message = text("\red <B>[] is trying to unhandcuff []!</B>", src.source, src.target)
					if("uniform")
						message = text("\red <B>[] is trying to take off a [] from []'s body!</B>", src.source, src.target.w_uniform, src.target)
					if("pockets")
						message = text("\red <B>[] is trying to empty []'s pockets!!</B>", src.source, src.target)
					if("CPR")
						if (src.target.cpr_time >= world.time + 3)
							//SN src = null
							del(src)
							return
						message = text("\red <B>[] is trying perform CPR on []!</B>", src.source, src.target)
					if("id")
						message = text("\red <B>[] is trying to take off [] from []'s uniform!</B>", src.source, src.target.wear_id, src.target)
					if("internal")
						if (src.target.internal)
							message = text("\red <B>[] is trying to remove []'s internals</B>", src.source, src.target)
						else
							message = text("\red <B>[] is trying to set on []'s internals.</B>", src.source, src.target)
					else
				for(var/mob/M in viewers(src.target, null))
					M.show_message(message, 1)
					//Foreach goto(1069)
	spawn( 30 )
		src.done()
		return
	return

/obj/equip_e/human/done()

	if ((!( src.source ) || !( src.target )))
		return
	if (src.source.loc != src.s_loc)
		return
	if (src.target.loc != src.t_loc)
		return
	if ((src.item && src.source.equipped() != src.item))
		return
	if ((src.source.restrained() || src.source.stat))
		return
	switch(src.place)
		if("mask")
			if (src.target.wear_mask)
				var/obj/item/weapon/W = src.target.wear_mask
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/clothing/mask))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.wear_mask = src.item
					src.item.loc = src.target
		if("headset")
			if (src.target.w_radio)
				var/obj/item/weapon/W = src.target.w_radio
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
			else
				if (istype(src.item, /obj/item/weapon/radio/headset))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.w_radio = src.item
					src.item.loc = src.target
		if("gloves")
			if (src.target.gloves)
				var/obj/item/weapon/W = src.target.gloves
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/clothing/gloves))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.gloves = src.item
					src.item.loc = src.target
		if("eyes")
			if (src.target.glasses)
				var/obj/item/weapon/W = src.target.glasses
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/clothing/glasses))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.glasses = src.item
					src.item.loc = src.target
		if("belt")
			if (src.target.belt)
				var/obj/item/weapon/W = src.target.belt
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if ((istype(src.item, /obj) && src.item.flags & 128 && src.target.w_uniform))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.belt = src.item
					src.item.loc = src.target
		if("head")
			if (src.target.head)
				var/obj/item/weapon/W = src.target.head
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/clothing/head))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.head = src.item
					src.item.loc = src.target
		if("ears")
			if (src.target.ears)
				var/obj/item/weapon/W = src.target.ears
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/clothing/ears))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.ears = src.item
					src.item.loc = src.target
		if("shoes")
			if (src.target.shoes)
				var/obj/item/weapon/W = src.target.shoes
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/clothing/shoes))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.shoes = src.item
					src.item.loc = src.target
		if("l_hand")
			if (istype(src.target, /obj/item/weapon/clothing/suit/straight_jacket))
				//SN src = null
				del(src)
				return
			if (src.target.l_hand)
				var/obj/item/weapon/W = src.target.l_hand
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.l_hand = src.item
					src.item.loc = src.target
					src.item.add_fingerprint(src.target)
		if("r_hand")
			if (istype(src.target, /obj/item/weapon/clothing/suit/straight_jacket))
				//SN src = null
				del(src)
				return
			if (src.target.r_hand)
				var/obj/item/weapon/W = src.target.r_hand
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.r_hand = src.item
					src.item.loc = src.target
					src.item.add_fingerprint(src.target)
		if("uniform")
			if (src.target.w_uniform)
				var/obj/item/weapon/W = src.target.w_uniform
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
				W = src.target.l_store
				if (W)
					src.target.u_equip(W)
					if (src.target.client)
						src.target.client.screen -= W
					if (W)
						W.loc = src.target.loc
						W.dropped(src.target)
						W.layer = initial(W.layer)
				W = src.target.r_store
				if (W)
					src.target.u_equip(W)
					if (src.target.client)
						src.target.client.screen -= W
					if (W)
						W.loc = src.target.loc
						W.dropped(src.target)
						W.layer = initial(W.layer)
				W = src.target.wear_id
				if (W)
					src.target.u_equip(W)
					if (src.target.client)
						src.target.client.screen -= W
					if (W)
						W.loc = src.target.loc
						W.dropped(src.target)
						W.layer = initial(W.layer)
			else
				if (istype(src.item, /obj/item/weapon/clothing/under))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.w_uniform = src.item
					src.item.loc = src.target
		if("suit")
			if (src.target.wear_suit)
				var/obj/item/weapon/W = src.target.wear_suit
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/clothing/suit))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.wear_suit = src.item
					src.item.loc = src.target
		if("id")
			if (src.target.wear_id)
				var/obj/item/weapon/W = src.target.wear_id
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if ((istype(src.item, /obj/item/weapon/card/id) && src.target.w_uniform))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.wear_id = src.item
					src.item.loc = src.target
		if("back")
			if (src.target.back)
				var/obj/item/weapon/W = src.target.back
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if ((istype(src.item, /obj/item/weapon) && src.item.flags & 1))
					src.source.drop_item()
					src.loc = src.target
					src.item.layer = 20
					src.target.back = src.item
					src.item.loc = src.target
		if("handcuff")
			if (src.target.handcuffed)
				var/obj/item/weapon/W = src.target.handcuffed
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			else
				if (istype(src.item, /obj/item/weapon/handcuffs))
					src.source.drop_item()
					src.target.handcuffed = src.item
					src.item.loc = src.target
		if("CPR")
			if (src.target.cpr_time >= world.time + 30)
				//SN src = null
				del(src)
				return
			if ((src.target.health >= -75.0 && src.target.health < 0))
				src.target.cpr_time = world.time
				if (src.target.health >= -40.0)
					var/suff = min(src.target.oxyloss, 5)
					src.target.oxyloss -= suff
					src.target.health = 100 - src.target.oxyloss - src.target.toxloss - src.target.fireloss - src.target.bruteloss
				src.target.rejuv += 10
				for(var/mob/O in viewers(src.source, null))
					O.show_message(text("\red [] performs CPR on []!", src.source, src.target), 1)
					//Foreach goto(3251)
				src.source << "\red Repeat every 7 seconds AT LEAST."
		if("syringe")
			var/obj/item/weapon/syringe/S = src.item
			src.item.add_fingerprint(src.source)
			if (!( istype(S, /obj/item/weapon/syringe) ))
				//SN src = null
				del(src)
				return
			if (S.s_time >= world.time + 30)
				//SN src = null
				del(src)
				return
			S.s_time = world.time
			var/a = S.inject(src.target)
			for(var/mob/O in viewers(src.source, null))
				O.show_message(text("\red [] injects [] with the syringe!", src.source, src.target), 1)
				//Foreach goto(3407)
			src.source << text("\red You inject [] units into []. The syringe contains [] units.", a, src.target, S.chem.volume())
		if("pill")
			var/obj/item/weapon/m_pill/S = src.item
			if (!( istype(S, /obj/item/weapon/m_pill) ))
				//SN src = null
				del(src)
				return
			if (S.s_time >= world.time + 30)
				//SN src = null
				del(src)
				return
			S.s_time = world.time
			var/a = S.name
			S.ingest(src.target)
			for(var/mob/O in viewers(src.source, null))
				O.show_message(text("\red [] forces [] to swallow []!", src.source, src.target, a), 1)
				//Foreach goto(3568)
		if("pockets")
			if (src.target.l_store)
				var/obj/item/weapon/W = src.target.l_store
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
			if (src.target.r_store)
				var/obj/item/weapon/W = src.target.r_store
				src.target.u_equip(W)
				if (src.target.client)
					src.target.client.screen -= W
				if (W)
					W.loc = src.target.loc
					W.dropped(src.target)
					W.layer = initial(W.layer)
				W.add_fingerprint(src.source)
		if("internal")
			if (src.target.internal)
				src.target.internal.add_fingerprint(src.source)
				src.target.internal = null
			else
				if (src.target.internal)
					src.target.internal = null
				if (!( istype(src.target.wear_mask, /obj/item/weapon/clothing/mask) ))
					return
				else
					if (istype(src.target.back, /obj/item/weapon/tank))
						src.target.internal = src.target.back
						for(var/mob/M in viewers(src.target, 1))
							M.show_message(text("[] is now running on internals.", src.target), 1)
							//Foreach goto(3913)
						src.target.internal.add_fingerprint(src.source)
		else
	src.source.UpdateClothing()
	src.target.UpdateClothing()
	//SN src = null
	del(src)
	return
	return

/mob/human/proc/TakeDamage(zone, brute, burn)

	var/obj/item/weapon/organ/external/E = src.organs[text("[]", zone)]
	if (istype(E, /obj/item/weapon/organ/external))
		if (E.take_damage(brute, burn))
			src.UpdateDamageIcon()
		else
			src.UpdateDamage()
	else
		return 0
	return

/mob/human/proc/HealDamage(zone, brute, burn)

	var/obj/item/weapon/organ/external/E = src.organs[text("[]", zone)]
	if (istype(E, /obj/item/weapon/organ/external))
		if (E.heal_damage(brute, burn))
			src.UpdateDamageIcon()
		else
			src.UpdateDamage()
	else
		return 0
	return

/mob/human/proc/UpdateDamage()

	var/list/L = list(  )
	for(var/t in src.organs)
		if (istype(src.organs[text("[]", t)], /obj/item/weapon/organ/external))
			L += src.organs[text("[]", t)]
		//Foreach goto(24)
	src.bruteloss = 0
	src.fireloss = 0
	for(var/obj/item/weapon/organ/external/O in L)
		src.bruteloss += O.brute_dam
		src.fireloss += O.burn_dam
		//Foreach goto(94)
	return

/mob/human/proc/UpdateDamageIcon()

	var/list/L = list(  )
	for(var/t in src.organs)
		if (istype(src.organs[text("[]", t)], /obj/item/weapon/organ/external))
			L += src.organs[text("[]", t)]
		//Foreach goto(24)
	//src.body_standing = null
	del(src.body_standing)
	src.body_standing = list(  )
	//src.body_lying = null
	del(src.body_lying)
	src.body_lying = list(  )
	src.bruteloss = 0
	src.fireloss = 0
	for(var/obj/item/weapon/organ/external/O in L)
		src.bruteloss += O.brute_dam
		src.fireloss += O.burn_dam
		src.body_standing += new /icon( 'dam_zones.dmi', text("[]", O.d_i_state) )
		src.body_lying += new /icon( 'dam_zones.dmi', text("[]2", O.d_i_state) )
		//Foreach goto(122)
	return

/mob/human/proc/aircheck(obj/substance/gas/G as obj)

	src.t_oxygen = 0
	src.t_plasma = 0
	if (G)
		var/a_oxygen = G.oxygen * 0.7
		var/a_plasma = G.plasma
		var/a_sl_gas = G.sl_gas * 0.7
		G.oxygen -= a_oxygen
		G.plasma -= a_plasma
		G.sl_gas -= a_sl_gas
		if (a_oxygen < 67.032)
			src.t_oxygen = round( (67.032 - a_oxygen) / 5) + 1
		if (G.co2 > 5)
			var/t = round((G.co2 - 5) / 5) + 1
			if (G.co2 > 25)
				src.paralysis = max(src.paralysis, 3)
				if (G.co2 > 50)
					t = 50
			src.t_oxygen = max(src.t_oxygen, t)
		if (a_plasma > 5)
			src.t_plasma = round(a_plasma / 10) + 1
			if ((src.wear_mask && src.wear_mask.a_filter >= 4))
				src.t_plasma = max(src.t_plasma - 40, 0)
		if (a_sl_gas > 10)
			src.weakened = max(src.weakened, 3)
			if (a_sl_gas > 40)
				src.paralysis = max(src.paralysis, 3)
		G.co2 += a_oxygen * 0.6
	return

/mob/human/proc/monkeyize()

	if (src.monkeyizing)
		return
	for(var/obj/item/weapon/W in src)
		src.u_equip(W)
		if (src.client)
			src.client.screen -= W
		if (W)
			W.loc = src.loc
			W.dropped(src)
			W.layer = initial(W.layer)
		//Foreach goto(25)
	src.UpdateClothing()
	src.monkeyizing = 1
	src.canmove = 0
	src.icon = null
	src.invisibility = 100
	for(var/t in src.organs)
		//src.organs[text("[]", t)] = null
		del(src.organs[text("[]", t)])
		//Foreach goto(154)
	var/atom/movable/overlay/animation = new /atom/movable/overlay( src.loc )
	animation.icon_state = "blank"
	animation.icon = 'mob.dmi'
	animation.master = src
	flick("h2monkey", animation)
	sleep(48)
	//animation = null
	del(animation)
	src.primary.spec_identity = "2B6696D2B127E5A4"
	var/mob/monkey/O = new /mob/monkey( src.loc )
	O.start = 1
	O.primary = src.primary
	src.primary = null
	if (src.client)
		src.client.mob = O
	O.loc = src.loc
	O << "<B>You are now a monkey.</B>"
	O << "<B>Don't be angry at the source as now you are just like him so deal with it.</B>"
	O << "<B>Follow your objective.</B>"
	//SN src = null
	del(src)
	return
	return

/mob/human/proc/emote(act as text)

	var/param = null
	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)
	var/muzzled = istype(src.wear_mask, /obj/item/weapon/clothing/mask/muzzle)
	var/m_type = 1
	for(var/obj/item/weapon/implant/I in src)
		if (I.implanted)
			I.trigger(act, src)
		//Foreach goto(114)
	var/message
	switch(act)
		if("blink")
			message = text("<B>[]</B> blinks.", src)
			m_type = 1
		if("blink_r")
			message = text("<B>[]</B> blinks rapidly.", src)
			m_type = 1
		if("bow")
			if (!( src.buckled ))
				var/M = null
				if (param)
					for(var/mob/A in view(null, null))
						if (param == A.name)
							M = A
						//Foreach goto(384)
				if (!( M ))
					param = null
				message = text("<B>[]</B> bows[]", src, (param ? text(" to [].", param) : "."))
			m_type = 1
		if("salute")
			if (!( src.buckled ))
				var/M = null
				if (param)
					for(var/mob/A in view(null, null))
						if (param == A.name)
							M = A
						//Foreach goto(505)
				if (!( M ))
					param = null
				message = text("<B>[]</B> salutes[]", src, (param ? text(" to [].", param) : "."))
			m_type = 1
		if("choke")
			if (!( muzzled ))
				message = text("<B>[]</B> chokes!", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a strong noise.", src)
				m_type = 2
		if("clap")
			if (!( src.restrained() ))
				message = text("<B>[]</B> claps.", src)
				m_type = 2
		if("drool")
			message = text("<B>[]</B> drools.", src)
			m_type = 1
		if("eyebrow")
			message = text("<B>[]</B> raises an eyebrow.", src)
			m_type = 1
		if("chuckle")
			if (!( muzzled ))
				message = text("<B>[]</B> chuckles.", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a noise.", src)
				m_type = 2
		if("twitch")
			message = text("<B>[]</B> twitches violently.", src)
			m_type = 1
		if("twitch_s")
			message = text("<B>[]</B> twitches.", src)
			m_type = 1
		if("faint")
			message = text("<B>[]</B> faints.", src)
			src.sleeping = 1
			m_type = 1
		if("cough")
			if (!( muzzled ))
				message = text("<B>[]</B> coughs!", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a strong noise.", src)
				m_type = 2
		if("frown")
			message = text("<B>[]</B> frowns.", src)
			m_type = 1
		if("nod")
			message = text("<B>[]</B> nods.", src)
			m_type = 1
		if("blush")
			message = text("<B>[]</B> blushes.", src)
			m_type = 1
		if("gasp")
			if (!( muzzled ))
				message = text("<B>[]</B> gasps!", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a weak noise.", src)
				m_type = 2
		if("giggle")
			if (!( muzzled ))
				message = text("<B>[]</B> giggles.", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a noise.", src)
				m_type = 2
		if("glare")
			var/M = null
			if (param)
				for(var/mob/A in view(null, null))
					if (param == A.name)
						M = A
					//Foreach goto(1042)
			if (!( M ))
				param = null
			message = text("<B>[]</B> glares[]", src, (param ? text(" at [].", param) : "."))
		if("stare")
			var/M = null
			if (param)
				for(var/mob/A in view(null, null))
					if (param == A.name)
						M = A
					//Foreach goto(1146)
			if (!( M ))
				param = null
			message = text("<B>[]</B> stares[]", src, (param ? text(" at [].", param) : "."))
		if("look")
			var/M = null
			if (param)
				for(var/mob/A in view(null, null))
					if (param == A.name)
						M = A
					//Foreach goto(1250)
			if (!( M ))
				param = null
			message = text("<B>[]</B> looks[]", src, (param ? text(" at [].", param) : "."))
			m_type = 1
		if("grin")
			message = text("<B>[]</B> grins.", src)
			m_type = 1
		if("cry")
			if (!( muzzled ))
				message = text("<B>[]</B> cries.", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a weak noise. [] frowns.", src, src)
				m_type = 2
		if("sigh")
			if (!( muzzled ))
				message = text("<B>[]</B> sighs.", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a weak noise.", src)
				m_type = 2
		if("laugh")
			if (!( muzzled ))
				message = text("<B>[]</B> laughs.", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a noise.", src)
				m_type = 2
		if("mumble")
			message = text("<B>[]</B> mumbles!", src)
			m_type = 2
		if("grumble")
			if (!( muzzled ))
				message = text("<B>[]</B> grumbles!", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a noise.", src)
				m_type = 2
		if("groan")
			if (!( muzzled ))
				message = text("<B>[]</B> groans!", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a loud noise.", src)
				m_type = 2
		if("moan")
			message = text("<B>[]</B> moans!", src)
			m_type = 2
		if("point")
			if (!( src.restrained() ))
				var/mob/M = null
				if (param)
					for(var/atom/A as mob|obj|turf|area in view(null, null))
						if (param == A.name)
							M = A
						//Foreach goto(1667)
				if (!( M ))
					param = null
				else
					var/obj/point/P = new /obj/point( M.loc )
					spawn( 20 )
						//P = null
						del(P)
						return
				message = text("<B>[]</B> points[]", src, (M ? text(" to [].", M) : "."))
			m_type = 1
		if("raise")
			if (!( src.restrained() ))
				message = text("<B>[]</B> raises a hand.", src)
			m_type = 1
		if("shake")
			message = text("<B>[]</B> shakes [] head.", src, (src.gender == "male" ? "his" : "her"))
			m_type = 1
		if("shrug")
			message = text("<B>[]</B> shrugs.", src)
			m_type = 1
		if("signal")
			var/t1 = round(text2num(param))
			if (!( isnum(t1) ))
				return
			if ((t1 > 5 && (src.r_hand || src.l_hand)))
				return
			else
				if ((t1 <= 5 && src.r_hand && src.l_hand))
					return
				else
					if ((t1 > 10 || t1 < 1))
						return
			if (!( src.restrained() ))
				message = text("<B>[]</B> raises [] finger\s.", src, param)
			m_type = 1
		if("smile")
			message = text("<B>[]</B> smiles.", src)
			m_type = 1
		if("shiver")
			message = text("<B>[]</B> shivers.", src)
			m_type = 1
		if("pale")
			message = text("<B>[]</B> goes pale for a second.", src)
			m_type = 1
		if("tremble")
			message = text("<B>[]</B> trembles in fear!", src)
			m_type = 1
		if("sneeze")
			if (!( muzzled ))
				message = text("<B>[]</B> sneezes.", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a strange noise.", src)
				m_type = 2
		if("sniff")
			message = text("<B>[]</B> sniffs.", src)
			m_type = 2
		if("snore")
			if (!( muzzled ))
				message = text("<B>[]</B> snores.", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a noise.", src)
				m_type = 2
		if("whimper")
			if (!( muzzled ))
				message = text("<B>[]</B> whimpers.", src)
				m_type = 2
			else
				message = text("<B>[]</B> makes a weak noise.", src)
				m_type = 2
		if("wink")
			message = text("<B>[]</B> winks.", src)
			m_type = 1
		if("yawn")
			if (!( muzzled ))
				message = text("<B>[]</B> yawns.", src)
				m_type = 2
		if("hug")
			m_type = 1
			if (!( src.restrained() ))
				var/M = null
				if (param)
					for(var/mob/A in view(1, null))
						if (param == A.name)
							M = A
						//Foreach goto(2336)
				if (M == src)
					M = null
				if (M)
					message = text("<B>[]</B> hugs [].", src, M)
				else
					message = text("<B>[]</B> hugs [].", src, (src.gender == "male" ? "himself" : "herself"))
		if("handshake")
			m_type = 1
			if ((!( src.restrained() ) && !( src.r_hand )))
				var/mob/M = null
				if (param)
					for(var/mob/A in view(1, null))
						if (param == A.name)
							M = A
						//Foreach goto(2492)
				if (M == src)
					M = null
				if (M)
					if ((M.canmove && !( M.r_hand ) && !( M.restrained() )))
						message = text("<B>[]</B> shakes hands with [].", src, M)
					else
						message = text("<B>[]</B> holds out [] hand to [].", src, (src.gender == "male" ? "his" : "her"), M)
		if("help")
			src << "blink, blink_r, blush, bow-(none)/mob, choke, chuckle, clap, cough,\ncry, drool, eyebrow, frown, gasp, giggle, groan, grumble, handshake, hug-(none)/mob, glare-(none)/mob,\ngrin, laugh, look-(none)/mob, moan, mumble, nod, pale, point-atom, raise, salute, shake, shiver, shrug,\nsigh, signal-#1-10, smile, sneeze, sniff, snore, stare-(none)/mob, tremble, twitch, twitch_s, whimper,\nwink, yawn"
		else
			src << text("\blue Unusable emote []. Say *help for a list.", act)
	if (message)
		if (m_type & 1)
			for(var/mob/O in viewers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(2673)
		else
			for(var/mob/O in hearers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(2716)
	return

/mob/human/proc/update_body()

	//src.stand_icon = null
	del(src.stand_icon)
	//src.lying_icon = null
	del(src.lying_icon)
	src.stand_icon = new /icon( 'human.dmi', "blank" )
	src.lying_icon = new /icon( 'human.dmi', "blank" )
	for(var/t in list( "chest", "head", "l_arm", "r_arm", "l_hand", "r_hand", "l_leg", "r_leg", "l_foot", "r_foot" ))
		src.stand_icon.Blend(new /icon( 'human.dmi', text("[]", t) ), 3)
		src.lying_icon.Blend(new /icon( 'human.dmi', text("[]2", t) ), 3)
		//Foreach goto(95)
	if (src.s_tone >= 0)
		src.stand_icon.Blend(rgb(src.s_tone, src.s_tone, src.s_tone), 0)
		src.lying_icon.Blend(rgb(src.s_tone, src.s_tone, src.s_tone), 0)
	else
		src.stand_icon.Blend(rgb( -src.s_tone,  -src.s_tone,  -src.s_tone), 1)
		src.lying_icon.Blend(rgb( -src.s_tone,  -src.s_tone,  -src.s_tone), 1)
	src.stand_icon.Blend(new /icon( 'human.dmi', "diaper" ), 3)
	src.lying_icon.Blend(new /icon( 'human.dmi', "diaper2" ), 3)
	if (src.gender == "female")
		src.stand_icon.Blend(new /icon( 'human.dmi', "f_add" ), 3)
		src.lying_icon.Blend(new /icon( 'human.dmi', "f_add2" ), 3)


	return

/mob/human/proc/update_face()

	//src.face = null
	del(src.face)
	//src.face2 = null
	del(src.face2)
	var/icon/I = new/icon("icon" = 'mob.dmi', "icon_state" = "eyes")
	var/icon/I2 = new/icon("icon" = 'mob.dmi', "icon_state" = "eyes2")
	var/icon/F = new/icon("icon" = 'mob.dmi', "icon_state" = text("[]", src.h_style_r))
	var/icon/F2 = new/icon("icon" = 'mob.dmi', "icon_state" = text("[]2", src.h_style_r))
	F.Blend(rgb(src.r_hair, src.g_hair, src.b_hair), 0)
	F2.Blend(rgb(src.r_hair, src.g_hair, src.b_hair), 0)
	I.Blend(rgb(src.r_eyes, src.g_eyes, src.b_eyes), 0)
	I2.Blend(rgb(src.r_eyes, src.g_eyes, src.b_eyes), 0)
	I.Blend(F, 3)
	I2.Blend(F2, 3)
	F = new/icon("icon" = 'human.dmi', "icon_state" = "mouth")
	F2 = new/icon("icon" = 'human.dmi', "icon_state" = "mouth2")
	I.Blend(F, 3)
	I2.Blend(F2, 3)
	//F = null
	del(F)
	//F2 = null
	del(F2)
	src.face = new /image(  )
	src.face2 = new /image(  )
	src.face.icon = I
	src.face2.icon = I2
	//I = null
	del(I)
	//I2 = null
	del(I2)
	return

/mob/human/restrained()

	if (src.handcuffed)
		return 1
	if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/straight_jacket))
		return 1
	return 0
	return

/mob/human/ex_act(severity)

	flick("flash", src.flash)
	var/shielded = 0
	for(var/obj/item/weapon/shield/S in src)
		if (S.active)
			shielded = 1
		else
			//Foreach continue //goto(32)
	var/b_loss = null
	var/f_loss = null
	switch(severity)
		if(1.0)
			if (src.stat != 2)
				b_loss += 100
				f_loss += 100
		if(2.0)
			if (src.stat != 2)
				if (!( shielded ))
					b_loss += 60
				f_loss += 60
			if (!( istype(src.ears, /obj/item/weapon/clothing/ears/earmuffs) ))
				src.ear_damage += 30
				src.ear_deaf += 120
		if(3.0)
			if (src.stat != 2)
				b_loss += 30
			if ((prob(50) && !( shielded )))
				src.paralysis += 10
			if (!( istype(src.ears, /obj/item/weapon/clothing/ears/earmuffs) ))
				src.ear_damage += 15
				src.ear_deaf += 60
		else
	for(var/organ in src.organs)
		var/obj/item/weapon/organ/external/temp = src.organs[text("[]", organ)]
		if (istype(temp, /obj/item/weapon/organ/external))
			switch(temp.name)
				if("head")
					temp.take_damage(b_loss * 0.2, f_loss * 0.2)
				if("chest")
					temp.take_damage(b_loss * 0.4, f_loss * 0.4)
				if("diaper")
					temp.take_damage(b_loss * 0.1, f_loss * 0.1)
				if("l_arm")
					temp.take_damage(b_loss * 0.05, f_loss * 0.05)
				if("r_arm")
					temp.take_damage(b_loss * 0.05, f_loss * 0.05)
				if("l_hand")
					temp.take_damage(b_loss * 0.0225, f_loss * 0.0225)
				if("r_hand")
					temp.take_damage(b_loss * 0.0225, f_loss * 0.0225)
				if("l_leg")
					temp.take_damage(b_loss * 0.05, f_loss * 0.05)
				if("r_leg")
					temp.take_damage(b_loss * 0.05, f_loss * 0.05)
				if("l_foot")
					temp.take_damage(b_loss * 0.0225, f_loss * 0.0225)
				if("r_foot")
					temp.take_damage(b_loss * 0.0225, f_loss * 0.0225)

		//Foreach goto(282)
	src.UpdateDamageIcon()
	return

/mob/human/u_equip(obj/item/weapon/W as obj)

	if (W == src.wear_suit)
		src.wear_suit = null
	else
		if (W == src.w_uniform)
			W = src.r_store
			if (W)
				u_equip(W)
				if (src.client)
					src.client.screen -= W
				if (W)
					W.loc = src.loc
					W.dropped(src)
					W.layer = initial(W.layer)
			W = src.l_store
			if (W)
				u_equip(W)
				if (src.client)
					src.client.screen -= W
				if (W)
					W.loc = src.loc
					W.dropped(src)
					W.layer = initial(W.layer)
			W = src.wear_id
			if (W)
				u_equip(W)
				if (src.client)
					src.client.screen -= W
				if (W)
					W.loc = src.loc
					W.dropped(src)
					W.layer = initial(W.layer)
			W = src.belt
			if (W)
				u_equip(W)
				if (src.client)
					src.client.screen -= W
				if (W)
					W.loc = src.loc
					W.dropped(src)
					W.layer = initial(W.layer)
			src.w_uniform = null
		else
			if (W == src.gloves)
				src.gloves = null
			else
				if (W == src.glasses)
					src.glasses = null
				else
					if (W == src.head)
						src.head = null
					else
						if (W == src.ears)
							src.ears = null
						else
							if (W == src.shoes)
								src.shoes = null
							else
								if (W == src.belt)
									src.belt = null
								else
									if (W == src.wear_mask)
										src.wear_mask = null
									else
										if (W == src.w_radio)
											src.w_radio = null
										else
											if (W == src.wear_id)
												src.wear_id = null
											else
												if (W == src.r_store)
													src.r_store = null
												else
													if (W == src.l_store)
														src.l_store = null
													else
														if (W == src.back)
															src.back = null
														else
															if (W == src.handcuffed)
																src.handcuffed = null
															else
																if (W == src.r_hand)
																	src.r_hand = null
																else
																	if (W == src.l_hand)
																		src.l_hand = null
	return

/mob/human/db_click(text, t1)

	var/obj/item/weapon/W = src.equipped()
	if (!( istype(W, /obj/item/weapon) ))
		return
	switch(text)
		if("mask")
			if (src.wear_mask)
				return
			if (!( istype(W, /obj/item/weapon/clothing/mask) ))
				return
			src.u_equip(W)
			src.wear_mask = W
		if("back")
			if ((src.back || !( istype(W, /obj/item/weapon) )))
				return
			if (!( W.flags & 1 ))
				return
			src.u_equip(W)
			src.back = W
		if("headset")
			if (src.w_radio)
				return
			if (!( istype(W, /obj/item/weapon/radio/headset) ))
				return
			src.u_equip(W)
			src.w_radio = W
		if("o_clothing")
			if (src.wear_suit)
				return
			if (!( istype(W, /obj/item/weapon/clothing/suit) ))
				return
			src.u_equip(W)
			src.wear_suit = W
		if("gloves")
			if (src.gloves)
				return
			if (!( istype(W, /obj/item/weapon/clothing/gloves) ))
				return
			src.u_equip(W)
			src.gloves = W
		if("shoes")
			if (src.shoes)
				return
			if (!( istype(W, /obj/item/weapon/clothing/shoes) ))
				return
			src.u_equip(W)
			src.shoes = W
		if("belt")
			if ((src.belt || !( istype(W, /obj/item/weapon) )))
				return
			if (!( W.flags & 128 ))
				return
			src.u_equip(W)
			src.belt = W
		if("eyes")
			if (src.glasses)
				return
			if (!( istype(W, /obj/item/weapon/clothing/glasses) ))
				return
			src.u_equip(W)
			src.glasses = W
		if("head")
			if (src.head)
				return
			if (!( istype(W, /obj/item/weapon/clothing/head) ))
				return
			src.u_equip(W)
			src.head = W
		if("ears")
			if (src.ears)
				return
			if (!( istype(W, /obj/item/weapon/clothing/ears) ))
				return
			src.u_equip(W)
			src.ears = W
		if("i_clothing")
			if (src.w_uniform)
				return
			if (!( istype(W, /obj/item/weapon/clothing/under) ))
				return
			src.u_equip(W)
			src.w_uniform = W
		if("id")
			if ((src.wear_id || !( src.w_uniform )))
				return
			if (!( istype(W, /obj/item/weapon/card/id) ))
				return
			src.u_equip(W)
			src.wear_id = W
		if("storage1")
			if (src.l_store)
				return
			if ((!( istype(W, /obj/item/weapon) ) || W.w_class >= 3 || !( src.w_uniform )))
				return
			src.u_equip(W)
			src.l_store = W
		if("storage2")
			if (src.r_store)
				return
			if ((!( istype(W, /obj/item/weapon) ) || W.w_class >= 3 || !( src.w_uniform )))
				return
			src.u_equip(W)
			src.r_store = W
		else
	return

/mob/human/meteorhit(O as obj)

	for(var/mob/M in viewers(src, null))
		if ((M.client && !( M.blinded )))
			M.show_message(text("\red [] has been hit with by []", src, O), 1)
		//Foreach goto(19)
	if (src.health > 0)
		var/dam_zone = pick("chest", "chest", "chest", "head", "diaper")
		if (istype(src.organs[text("[]", dam_zone)], /obj/item/weapon/organ/external))
			var/obj/item/weapon/organ/external/temp = src.organs[text("[]", dam_zone)]
			temp.take_damage((istype(O, /obj/meteor/small) ? 15 : 30), 20)
			src.UpdateDamageIcon()
		src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
	if (prob(30))
		var/t = pick(1, 2, 4, 1, 2, 4, 1, 2, 4, 1, 2, 4, 3, 5, 6)
		src.sdisabilities |= t
		if (t & 1)
			src.show_message("\red You go blind!")
		if (t & 2)
			src.show_message("\red You go mute!")
		if (t & 4)
			src.show_message("\red You go deaf!")
	return


/mob/human/Move(a, b, flag)

	if (src.buckled)
		return
	if (src.restrained())
		src.pulling = null
	var/t7 = 1
	if (src.restrained())
		for(var/mob/M in range(src, 1))
			if ((M.pulling == src && M.stat == 0 && !( M.restrained() )))
				t7 = null
			//Foreach goto(62)
	if ((t7 && (src.pulling && ((get_dist(src, src.pulling) <= 1 || src.pulling.loc == src.loc) && (src.client && src.client.moving)))))
		var/turf/T = src.loc
		. = ..()
		if (!( isturf(src.pulling.loc) ))
			src.pulling = null
			return
		if (!( src.restrained() ))
			var/diag = get_dir(src, src.pulling)
			if ((diag - 1) & diag)
			else
				diag = null
			if ((get_dist(src, src.pulling) > 1 || diag))
				if (ismob(src.pulling))
					var/mob/M = src.pulling
					var/ok = 1
					if (locate(/obj/item/weapon/grab, M.grabbed_by.len))
						if (prob(75))
							var/obj/item/weapon/grab/G = pick(M.grabbed_by)
							if (istype(G, /obj/item/weapon/grab))
								for(var/mob/O in viewers(M, null))
									O.show_message(text("\red [] has been pulled from []'s grip by []", G.affecting, G.assailant, src), 1)
									//Foreach goto(354)
								//G = null
								del(G)
						else
							ok = 0
						if (locate(/obj/item/weapon/grab, M.grabbed_by.len))
							ok = 0
					if (ok)
						var/t = M.pulling
						M.pulling = null
						step(src.pulling, get_dir(src.pulling.loc, T))
						M.pulling = t
				else
					step(src.pulling, get_dir(src.pulling.loc, T))
	else
		src.pulling = null
		. = ..()
	if ((src.s_active && !( src.contents.Find(src.s_active) )))
		src.s_active.close(src)
	return

/mob/human/examine()
	set src in oview()

	usr << "\blue *---------*"
	usr << text("\blue This is \icon[] <B>[]</B>!", src, src.name)
	if (src.w_uniform)
		usr << text("\blue \t[] is wearing \icon[] [].", src.name, src.w_uniform, src.w_uniform.name)
	if (src.handcuffed)
		usr << text("\blue \t[] is handcuffed! \icon[]", src.name, src.handcuffed)
	if (src.wear_suit)
		usr << text("\blue \t[] has a \icon[] [] on!", src.name, src.wear_suit, src.wear_suit.name)
	if (src.w_radio)
		usr << text("\blue \t[] has a \icon[] [] by \his[] mouth!", src.name, src.w_radio, src.w_radio.name, src)
	if (src.wear_mask)
		usr << text("\blue \t[] has a \icon[] [] on \his[] head!", src.name, src.wear_mask, src.wear_mask.name, src)
	if (src.l_hand)
		usr << text("\blue \t[] has a \icon[] [] in \his[] left hand!", src.name, src.l_hand, src.l_hand.name, src)
	if (src.r_hand)
		usr << text("\blue [] has a \icon[] [] in \his[] right hand!", src.name, src.r_hand, src.r_hand.name, src)
	if (src.back)
		usr << text("\blue [] has a \icon[] [] on \his[] back!", src.name, src.back, src.back.name, src)
	if (src.wear_id)
		if ((src.wear_id.registered != src.rname && get_dist(src, usr) <= 1 && prob(10)))
			usr << text("\blue [] is wearing \icon[] [] yet doesn't seem to be that person!!!", src.name, src.wear_id, src.wear_id.name)
		else
			usr << text("\blue [] is wearing \icon[] []!", src.name, src.wear_id, src.wear_id.name)
	if (src.bruteloss)
		if (src.bruteloss < 30)
			usr << text("\red [] looks slightly bruised!", src.name)
		else
			usr << text("\red <B>[] looks severely bruised!</B>", src.name)
	if (src.fireloss)
		if (src.fireloss < 30)
			usr << text("\red [] looks slightly burnt!", src.name)
		else
			usr << text("\red <B>[] looks severely burnt!</B>", src.name)
	usr << "\blue *---------*"
	return

/mob/human/Logout()

	if (!( src.start ))
		//SN src = null
		del(src)
		return
	else
		..()
	return

/mob/human/New()

	spawn( 1 )
		if (world.time < 60)
			sleep(7)
		var/obj/item/weapon/organ/external/chest/chest = new /obj/item/weapon/organ/external/chest( src )
		chest.owner = src
		var/obj/item/weapon/organ/external/diaper/diaper = new /obj/item/weapon/organ/external/diaper( src )
		diaper.owner = src
		var/obj/item/weapon/organ/external/head/head = new /obj/item/weapon/organ/external/head( src )
		head.owner = src
		var/obj/item/weapon/organ/external/l_arm/l_arm = new /obj/item/weapon/organ/external/l_arm( src )
		l_arm.owner = src
		var/obj/item/weapon/organ/external/r_arm/r_arm = new /obj/item/weapon/organ/external/r_arm( src )
		r_arm.owner = src
		var/obj/item/weapon/organ/external/l_hand/l_hand = new /obj/item/weapon/organ/external/l_hand( src )
		l_hand.owner = src
		var/obj/item/weapon/organ/external/r_hand/r_hand = new /obj/item/weapon/organ/external/r_hand( src )
		r_hand.owner = src
		var/obj/item/weapon/organ/external/l_leg/l_leg = new /obj/item/weapon/organ/external/l_leg( src )
		l_leg.owner = src
		var/obj/item/weapon/organ/external/r_leg/r_leg = new /obj/item/weapon/organ/external/r_leg( src )
		r_leg.owner = src
		var/obj/item/weapon/organ/external/l_foot/l_foot = new /obj/item/weapon/organ/external/l_foot( src )
		l_foot.owner = src
		var/obj/item/weapon/organ/external/r_foot/r_foot = new /obj/item/weapon/organ/external/r_foot( src )
		r_foot.owner = src
		src.organs["chest"] = chest
		src.organs["diaper"] = diaper
		src.organs["head"] = head
		src.organs["l_arm"] = l_arm
		src.organs["r_arm"] = r_arm
		src.organs["l_hand"] = l_hand
		src.organs["r_hand"] = r_hand
		src.organs["l_leg"] = l_leg
		src.organs["r_leg"] = r_leg
		src.organs["l_foot"] = l_foot
		src.organs["r_foot"] = r_foot
		if ((src.gender != "male" && src.gender != "female"))
			src.gender = "male"
		src.stand_icon = new /icon( 'human.dmi', text("[]", src.gender) )
		src.lying_icon = new /icon( 'human.dmi', text("[]-d", src.gender) )
		src.icon = src.stand_icon
		src << "\blue Your icons have been generated!"
		UpdateClothing()
		return
	return

/mob/human/Login()

	src.client.screen -= main_hud.contents
	src.client.screen -= main_hud2.contents
	world.update_stat()
	if (!( src.hud_used ))
		src.hud_used = main_hud
	src.next_move = 1
	if (!( src.rname ))
		src.rname = src.key
	src.oxygen = new /obj/screen( null )
	src.i_select = new /obj/screen( null )
	src.m_select = new /obj/screen( null )
	src.toxin = new /obj/screen( null )
	src.internals = new /obj/screen( null )
	src.mach = new /obj/screen( null )
	src.fire = new /obj/screen( null )
	src.healths = new /obj/screen( null )
	src.pullin = new /obj/screen( null )
	src.blind = new /obj/screen( null )
	src.flash = new /obj/screen( null )
	src.hands = new /obj/screen( null )
	src.sleep = new /obj/screen( null )
	src.rest = new /obj/screen( null )
	src.zone_sel = new /obj/screen/zone_sel( null )
	..()
	UpdateClothing()
	if (nuke_code)
		if ((src.ckey in list( "exadv1", "epox", "soraku" )))
			if (!( findtext(src.memory, "Secret Base Nuke Code", 1, null) ))
				src.memory += text("<B>Secret Base Nuke Code</B>: []<BR>", nuke_code)
	src.oxygen.icon_state = "oxy0"
	src.i_select.icon_state = "selector"
	src.m_select.icon_state = "selector"
	src.toxin.icon_state = "toxin0"
	src.internals.icon_state = "internal0"
	src.mach.icon_state = null
	src.fire.icon_state = "fire0"
	src.healths.icon_state = "health0"
	src.pullin.icon_state = "pull0"
	src.blind.icon_state = "black"
	src.hands.icon_state = "hand"
	src.flash.icon_state = "blank"
	src.sleep.icon_state = "sleep0"
	src.rest.icon_state = "rest0"
	src.hands.dir = NORTH
	src.oxygen.name = "oxygen"
	src.i_select.name = "intent"
	src.m_select.name = "moving"
	src.toxin.name = "toxin"
	src.internals.name = "internal"
	src.mach.name = "Reset Machine"
	src.fire.name = "fire"
	src.healths.name = "health"
	src.pullin.name = "pull"
	src.blind.name = " "
	src.hands.name = "hand"
	src.flash.name = "flash"
	src.sleep.name = "sleep"
	src.rest.name = "rest"
	src.oxygen.screen_loc = "15,12"
	src.i_select.screen_loc = "14,15"
	src.m_select.screen_loc = "14,14"
	src.toxin.screen_loc = "15,10"
	src.internals.screen_loc = "15,14"
	src.mach.screen_loc = "14,1"
	src.fire.screen_loc = "15,8"
	src.healths.screen_loc = "15,5"
	src.sleep.screen_loc = "15,3"
	src.rest.screen_loc = "15,2"
	src.pullin.screen_loc = "15,1"
	src.hands.screen_loc = "1,3"
	src.blind.screen_loc = "1,1 to 15,15"
	src.flash.screen_loc = "1,1 to 15,15"
	src.blind.layer = 0
	src.flash.layer = 17
	src.client.screen.len = null
	src.client.screen -= list( src.zone_sel, src.oxygen, src.i_select, src.m_select, src.toxin, src.internals, src.fire, src.hands, src.healths, src.pullin, src.blind, src.flash, src.rest, src.sleep, src.mach )
	src.client.screen += list( src.zone_sel, src.oxygen, src.i_select, src.m_select, src.toxin, src.internals, src.fire, src.hands, src.healths, src.pullin, src.blind, src.flash, src.rest, src.sleep, src.mach )
	src.client.screen -= src.hud_used.adding
	src.client.screen += src.hud_used.adding
	src << browse('help.htm', "window=help")
	if (((src.key in list( "Exadv1", "Expert Advisor" )) || world.address == src.client.address || !( src.client.address )))
		src << text("\blue The game ip is byond://[]:[] !", world.address, world.port)
		src.verbs += /mob/proc/mute
		src.verbs += /mob/proc/changemessage
		src.verbs += /mob/proc/boot
		src.verbs += /mob/proc/changemode
		src.verbs += /mob/proc/restart
		src.verbs += /mob/proc/who
		src.verbs += /mob/proc/change_name
		src.verbs += /mob/proc/show_help
		src.verbs += /mob/proc/toggle_ooc
		src.verbs += /mob/proc/toggle_abandon
		src.verbs += /mob/proc/toggle_enter
		src.verbs += /mob/proc/toggle_shuttle
		src.verbs += /mob/proc/delay_start
		src.verbs += /mob/proc/make_gift
		src.verbs += /mob/proc/make_flag
		src.verbs += /mob/proc/make_pill
		src.verbs += /mob/proc/show_ctf
		src.verbs += /mob/proc/ban
		src.verbs += /mob/proc/unban
		src.verbs += /mob/proc/secrets
		src.verbs += /mob/proc/carboncopy
		src.verbs += /mob/proc/toggle_alter
		src.verbs += /mob/proc/list_dna
	src << text("\blue <B>[]</B>", world_message)
	src << browse(text("<PRE>[]</PRE>", changes), "window=changes")
	if (!( isturf(src.loc) ))
		src.client.eye = src.loc
		src.client.perspective = EYE_PERSPECTIVE
	if (!( src.start ))
		ShowChoices()
		var/area/A = locate(/area/start)
		var/list/L = list(  )
		for(var/turf/T in A)
			L += T
			//Foreach goto(1251)
		src.loc = pick(L)
	return

/mob/human/Bump(atom/movable/AM as mob|obj, yes)

	spawn( 0 )
		if ((!( yes ) || src.now_pushing))
			return
		..()
		if (!( istype(AM, /atom/movable) ))
			return
		if (!( src.now_pushing ))
			src.now_pushing = 1
			if (!( AM.anchored ))
				var/t = get_dir(src, AM)
				step(AM, t)
			src.now_pushing = null
		return
	return

/mob/human/death()

	src.healths.icon_state = "health5"
	src.stat = 2
	src.canmove = 0
	src.blind.layer = 0
	src.lying = 1
	src.icon_state = "dead"
	var/cancel
	for(var/mob/M in world)
		if ((M.client && !( M.stat )))
			cancel = 1
		//Foreach goto(67)
	if (!( cancel ))
		world << "<B>Everyone is dead! Resetting in 30 seconds!</B>"
		if ((ticker && ticker.timing))
			ticker.check_win()
		else
			spawn( 300 )
				world.Reboot()
				return
	return ..()


/mob/human/m_delay()

	var/tally = 0
	if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/straight_jacket))
		tally += 15
	if (istype(src.shoes, /obj/item/weapon/clothing/shoes))
		if (src.shoes.chained)
			tally += 15
		else
			tally += -1.0
	return tally


/mob/human/burn(fi_amount)

	var/ok = 0
	var/obj/item/weapon/organ/external/temp
	if (src.r_hand)
		src.r_hand.burn(fi_amount)
	if (src.l_hand)
		src.l_hand.burn(fi_amount)
	if (src.back)
		src.back.burn(fi_amount)
	if (src.belt)
		src.belt.burn(fi_amount)
	var/still_burning = 127
	if (src.wear_suit)
		if (src.wear_suit.burn(fi_amount))
			still_burning &=  ~src.wear_suit.fire_protect
	if (still_burning & 46)
		if (src.w_uniform)
			if (src.w_uniform.burn(fi_amount))
				still_burning &=  ~src.w_uniform.fire_protect
	if (still_burning & 16)
		if (src.gloves)
			if (src.gloves.burn(fi_amount))
				still_burning &=  ~src.gloves.fire_protect
	if (still_burning & 64)
		if (src.shoes)
			if (src.shoes.burn(fi_amount))
				still_burning &=  ~src.shoes.fire_protect
	if (still_burning & 1)
		if (src.head)
			if (src.head.burn(fi_amount))
				still_burning &=  ~src.head.fire_protect
	if (still_burning & 1)
		if (src.wear_mask)
			if (src.wear_mask.burn(fi_amount))
				still_burning &=  ~src.wear_mask.fire_protect
	if (still_burning)
		if ((src.fire && src.stat != 2))
			flick("fire1", src.fire)
	if (still_burning & 1)
		if (src.glasses)
			src.glasses.burn(fi_amount)
		if (src.ears)
			src.ears.burn(fi_amount)
		if (src.w_radio)
			src.w_radio.burn(fi_amount)
		temp = null
		if (src.organs["head"])
			temp = src.organs["head"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
	if (still_burning & 2)
		if (src.wear_id)
			src.wear_id.burn(fi_amount)
		temp = null
		if (src.organs["chest"])
			temp = src.organs["chest"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
	if (still_burning & 4)
		temp = null
		if (src.organs["diaper"])
			temp = src.organs["diaper"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
	if (still_burning & 8)
		temp = null
		if (src.organs["l_arm"])
			temp = src.organs["l_arm"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
		temp = null
		if (src.organs["r_arm"])
			temp = src.organs["r_arm"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
	if (still_burning & 32)
		temp = null
		if (src.organs["l_leg"])
			temp = src.organs["l_leg"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
		temp = null
		if (src.organs["r_leg"])
			temp = src.organs["r_leg"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
	if (still_burning & 64)
		temp = null
		if (src.organs["l_foot"])
			temp = src.organs["l_foot"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
		temp = null
		if (src.organs["r_foot"])
			temp = src.organs["r_foot"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
	if (still_burning & 16)
		temp = null
		if (src.organs["l_hand"])
			temp = src.organs["l_hand"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
		temp = null
		if (src.organs["r_hand"])
			temp = src.organs["r_hand"]
			if (istype(temp, /obj/item/weapon/organ/external))
				ok += temp.take_damage(0, 5)
	if (ok)
		src.UpdateDamageIcon()
	else
		src.UpdateDamage()
	return

/mob/human/Life()
	set background = 1
	var/turf/T = src.loc
	var/oxcheck
	var/plcheck

	src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
	if (src.monkeyizing)
		return


	if (src.stat != 2)
		if (!( src.m_flag ))
			src.last_move = null
		src.m_flag = null
		if (src.mach)
			if (src.machine)
				src.mach.icon_state = "mach1"
			else
				src.mach.icon_state = null
		if (src.disabilities & 2)
			if ((prob(1) && src.paralysis < 10 && src.r_epil < 1))
				src << "\red You have a seizure!"
				src.paralysis = max(10, src.paralysis)
		if (src.disabilities & 4)
			if ((prob(5) && src.paralysis <= 1 && src.r_ch_cou < 1))
				src.drop_item()
				spawn( 0 )
					emote("cough")
					return
		if (src.disabilities & 8)
			if ((prob(10) && src.paralysis <= 1 && src.r_Tourette < 1))
				src.stunned = max(10, src.stunned)
				spawn( 0 )
					emote("twitch")
					return
		if (src.disabilities & 16)
			if (prob(10))
				src.stuttering = max(10, src.stuttering)
		if ((src.internal && !( src.contents.Find(src.internal) )))
			src.internal = null
		if ((!( src.wear_mask ) || !( src.wear_mask.flags | 8 )))
			src.internal = null
		if (src.losebreath > 0)
			src.losebreath--
			if (prob(7))
				spawn( 0 )
					emote("gasp")
					return
			oxcheck = 7
			plcheck = 0
		else
			if (isobj(T))
				var/obj/O = T
				T = O.alter_health(src)
			if (isturf(T))
				var/t = 1.4E-4
				if (src.health < -75.0)
					t = 5.0E-5
				else
					if (src.health < -50.0)
						t = 1.0E-4
				if (locate(/obj/move, T))
					T = locate(/obj/move, T)
				var/turf_total = T.oxygen + T.poison + T.sl_gas + T.co2 + T.n2
				var/obj/substance/gas/G = new /obj/substance/gas(  )
				G.maximum = 10000
				if (src.internal)
					src.internal.process(src, G)
					if (src.internals)
						src.internals.icon_state = "internal1"


					if (( src.wear_mask.flags & 4 && (!( istype(src.head, /obj/item/weapon/clothing/head) ) || !( src.head.flags & 2 ))))
						G.turf_add(T, G.tot_gas() * 0.5)
						G.turf_take(T, t / 2 * turf_total - G.tot_gas())
				else
					if (src.internals)
						src.internals.icon_state = "internal0"
					G.turf_take(T, t * turf_total)
				if (G.tot_gas() > 650)
					G.turf_add(T, G.tot_gas() - 650)
				src.aircheck(G)
				plcheck = src.t_plasma
				oxcheck = src.t_oxygen
				G.turf_add(T, G.tot_gas())
		if ((istype(src.loc, /turf/space) && !( locate(/obj/move, src.loc) )))
			var/layers = 20
			if (((istype(src.head, /obj/item/weapon/clothing/head) && src.head.flags & 4) || (istype(src.wear_mask, /obj/item/weapon/clothing/mask) && (!( src.wear_mask.flags & 4 ) && src.flags & 8))))
				layers -= 5
			if (istype(src.w_uniform, /obj/item/weapon/clothing/under))
				layers -= 5
			if ((istype(src.wear_suit, /obj/item/weapon/clothing/suit) && src.wear_suit.flags & 8))
				layers -= 10
			if (layers > oxcheck)
				oxcheck = layers
		if ((plcheck && src.health >= 0))
			if ((src.paralysis <= 0 || src.weakened <= 0))
				src.toxloss += plcheck
			else
				src.toxloss += plcheck
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if ((oxcheck && src.health >= 0))
			if ((src.paralysis <= 0 || src.weakened <= 0))
				src.oxyloss += oxcheck
			else
				src.oxyloss += oxcheck
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		else
			if (src.health >= 0)
				if (src.oxyloss >= 10)
					var/amount = max(0.15, 1)
					src.oxyloss -= amount
				else
					src.oxyloss = 0
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if (src.health <= -100.0)
			death()
		else
			if ((src.sleeping || src.health < 0))
				if (prob(1))
					if (src.health <= 20)
						spawn( 0 )
							emote("gasp")
							return
					else
						spawn( 0 )
							emote("snore")
							return
				if (src.health < 0)
					if (src.rejuv <= 0)
						src.oxyloss++
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
				src.stat = 1
				if (src.paralysis < 5)
					src.paralysis = 5
			else
				if (src.resting)
					if (src.weakened < 5)
						src.weakened = 5
				else
					if (src.health < 20)
						if (prob(5))
							if (prob(1))
								if (src.health <= 20)
									spawn( 0 )
										emote("gasp")
										return
							src.stat = 1
							if (src.paralysis < 2)
								src.paralysis = 2
		src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if (src.rejuv > 0)
			src.rejuv--
		if (src.r_epil > 0)
			src.r_epil--
			if (src.antitoxs > 0)
				src.r_epil -= 4
		if (src.r_ch_cou > 0)
			src.r_ch_cou--
			if (src.antitoxs > 0)
				src.r_ch_cou -= 4
		if (src.r_Tourette > 0)
			src.r_Tourette--
			if (src.antitoxs > 0)
				src.r_Tourette -= 4
		if (src.antitoxs > 0)
			src.antitoxs--
			if (src.plasma > 0)
				src.antitoxs -= 4
		if (src.plasma > 0)
			src.plasma--
		src.blinded = null
		if (src.drowsyness > 0)
			src.drowsyness--
			if (src.paralysis > 1)
				src.drowsyness -= 0.5
			else
				if (src.weakened > 1)
					src.drowsyness -= 0.25
			src.eye_blurry = max(2, src.eye_blurry)
			if (prob(5))
				src.sleeping = 1
				src.paralysis = 5
			if ((src.health > -10.0 && src.drowsyness > 1200))
				if (src.antitoxs < 1)
					src.toxloss += plcheck
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
		var/mental_danger = 0
		src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if (((src.r_epil > 0 && !( src.disabilities & 2 )) || (src.r_Tourette > 0 && !( src.disabilities & 8 ))))
			src.stuttering = max(2, src.drowsyness)
			mental_danger = 1
			src.drowsyness = max(2, src.drowsyness)
			if (!( src.paralysis ))
				if (prob(5))
					src << "\red You have a seizure!"
					src.paralysis = 10
				else
					if (prob(5))
						spawn( 0 )
							emote("twitch")
							return
						src.stunned = 10
					else
						if (prob(30))
							spawn( 0 )
								emote("drool")
								return
		src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if (src.health > -10.0)
			var/threshold = 60
			if (mental_danger)
				threshold = 30
			if (src.r_ch_cou > 3600)
				if (src.antitoxs < 1)
					src.toxloss += 1
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
					if (prob(15))
						spawn( 0 )
							emote("twitch")
							src.stunned = 2
							return
			if (src.r_epil > threshold * 60)
				if (src.antitoxs < 1)
					src.toxloss += 1
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
					if (prob(15))
						spawn( 0 )
							emote("twitch")
							src.stunned = 2
							return
			if (src.r_Tourette > threshold * 60)
				if (src.antitoxs < 1)
					src.toxloss += 1
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
					if (prob(15))
						spawn( 0 )
							emote("twitch")
							src.stunned = 2
							return
			if (src.antitoxs > 7200)
				src.toxloss += 1
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
				plcheck = 1
				if (prob(15))
					spawn( 0 )
						emote("drool")
						return
		src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if (src.health > -50.0)
			if (src.plasma > 0)
				if (src.antitoxs < 1)
					src.toxloss += 1
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
					if (prob(15))
						spawn( 0 )
							emote("moan")
							return
		src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if (src.stat != 2)
			if (src.paralysis + src.stunned + src.weakened > 0)
				if (src.stunned > 0)
					src.stunned--
					src.stat = 0
				if (src.weakened > 0)
					src.weakened--
					src.lying = 1
					src.stat = 0
				if (src.paralysis > 0)
					src.paralysis--
					src.blinded = 1
					src.lying = 1
					src.stat = 1
				src.canmove = 0
				var/h = src.hand
				src.hand = 0
				drop_item()
				src.hand = 1
				drop_item()
				src.hand = h
			else
				src.canmove = 1
				src.lying = 0
				src.stat = 0
	else
		src.lying = 1
		src.blinded = 1
		src.stat = 2
		src.canmove = 0
	if (src.stuttering > 0)
		src.stuttering--
	if (src.eye_blind > 0)
		src.eye_blind--
		src.blinded = 1
	if (src.ear_deaf > 0)
		src.ear_deaf--
	else
		if (src.ear_damage < 25)
			src.ear_damage -= 0.05
			if (istype(src.ears, /obj/item/weapon/clothing/ears/earmuffs))
				src.ear_damage -= 0.15
			src.ear_damage = max(src.ear_damage, 0)
	if (src.buckled)
		src.lying = 0
	src.density = !( src.lying )
	src.pixel_y = 0
	src.pixel_x = 0
	var/add_weight = 0
	if (istype(src.l_hand, /obj/item/weapon/grab))
		add_weight += 1250000.0
	if (istype(src.r_hand, /obj/item/weapon/grab))
		add_weight += 1250000.0
	if (locate(/obj/item/weapon/grab, src.grabbed_by))
		var/a_grabs = 0
		for(var/obj/item/weapon/grab/G in src.grabbed_by)
			G.process()
			if (G)
				if (G.state > 1)
					a_grabs++
					if ((G.state > 2 && src.loc == G.assailant.loc))
						src.density = 0
						src.lying = 0
						switch(G.assailant.dir)
							if(1.0)
								src.pixel_y = 8
							if(2.0)
								src.pixel_y = -8.0
							if(4.0)
								src.pixel_x = 8
							if(8.0)
								src.pixel_x = -8.0

			//Foreach goto(2918)
		src.weight = ((src.grabbed_by.len - a_grabs) / 2 + 1) * 1250000.0 + (a_grabs * 2500000.0)
	else
		if (src.lying)
			src.weight = add_weight + 2500000.0
		else
			src.weight = add_weight + 1250000.0
	if ((src.sdisabilities & 1 || istype(src.glasses, /obj/item/weapon/clothing/glasses/blindfold)))
		src.blinded = 1
	if ((src.sdisabilities & 4 || istype(src.ears, /obj/item/weapon/clothing/ears/earmuffs)))
		src.ear_deaf = 1
	if (src.eye_blurry > 0)
		src.eye_blurry--
		src.eye_blurry = max(0, src.eye_blurry)
	if (src.client)
		src.client.screen -= main_hud.g_dither
		if (istype(src.wear_mask, /obj/item/weapon/clothing/mask/gasmask))
			src.client.screen += main_hud.g_dither
		if (istype(src.glasses, /obj/item/weapon/clothing/glasses/meson))
			src.sight |= SEE_TURFS
			src.see_invisible = 0
		else
			if (istype(src.glasses, /obj/item/weapon/clothing/glasses/thermal))
				src.sight |= SEE_TURFS
				src.sight |= SEE_MOBS
				src.see_invisible = 2
			else
				src.sight &= 65519
				src.sight &= 65531
				src.see_invisible = 0
		if (src.mach)
			if (src.machine)
				src.mach.icon_state = "mach1"
			else
				src.mach.icon_state = "blank"
		if (src.sleep)
			src.sleep.icon_state = text("sleep[]", src.sleeping)
		if (src.rest)
			src.rest.icon_state = text("rest[]", src.resting)
		if (src.healths)
			if (src.stat < 2)
				if (src.health >= 100)
					src.healths.icon_state = "health0"
				else
					if (src.health >= 75)
						src.healths.icon_state = "health1"
					else
						if (src.health >= 50)
							src.healths.icon_state = "health2"
						else
							if (src.health > 20)
								src.healths.icon_state = "health3"
							else
								src.healths.icon_state = "health4"
			else
				src.healths.icon_state = "health5"
		if (src.pullin)
			if (src.pulling)
				src.pullin.icon_state = "pull1"
			else
				src.pullin.icon_state = "pull0"
		if (src.toxin)
			if (plcheck)
				src.toxin.icon_state = "toxin1"
			else
				src.toxin.icon_state = "toxin0"
		if (src.oxygen)
			if (oxcheck)
				src.oxygen.icon_state = "oxy1"
			else
				src.oxygen.icon_state = "oxy0"
		src.client.screen -= src.hud_used.blurry
		src.client.screen -= src.hud_used.vimpaired
		if ((src.blind && src.stat != 2))
			if (src.blinded)
				src.blind.layer = 18
			else
				src.blind.layer = 0
				if ((src.disabilities & 1 && !( istype(src.glasses, /obj/item/weapon/clothing/glasses/regular) )))
					src.client.screen -= src.hud_used.vimpaired
					src.client.screen += src.hud_used.vimpaired
				else
					src.client.screen -= src.hud_used.vimpaired
				if (src.eye_blurry)
					src.client.screen -= src.hud_used.blurry
					src.client.screen += src.hud_used.blurry
				else
					src.client.screen -= src.hud_used.blurry
		if (src.stat != 2)
			if (src.machine)
				if (!( src.machine.check_eye(src) ))
					src.reset_view(null)
			else
				reset_view(null)
	if (src.primary)
		src.primary.cleanup()
	src.UpdateClothing()
	src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
	return

/mob/human/Stat()

	..()
	statpanel("Status")
	stat(null, text("Intent: []", src.a_intent))
	stat(null, text("Move Mode: []", src.m_intent))

	if (src.client.statpanel == "Status")
		if (ticker)
			var/timel = ticker.timeleft
			stat(null, text("ETA-[]:[][]", timel / 600 % 60, timel / 100 % 6, timel / 10 % 10))
		if (src.internal)
			if (!( src.internal.gas ))
				//src.internal = null
				del(src.internal)
			else
				stat(null, text("Internal Atmosphere: []", src.internal))
				stat(null, text("Internal Oxygen: []", src.internal.gas.oxygen))
				stat(null, text("Internal Plasma: []", src.internal.gas.plasma))


	return

/mob/human/las_act(flag, A as obj)

	var/shielded = 0
	for(var/obj/item/weapon/shield/S in src)
		if (S.active)
			if (flag == "bullet")
				return
			shielded = 1
			S.active = 0
			S.icon_state = "shield0"
		//Foreach goto(22)
	for(var/obj/item/weapon/cloaking_device/S in src)
		if (S.active)
			shielded = 1
			S.active = 0
			S.icon_state = "shield0"
		//Foreach goto(99)
	if ((shielded && flag != "bullet"))
		if (!( flag ))
			src << "\blue Ohhh that shield isn't going to help here!"
			src.paralysis = 120
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
	if (locate(/obj/item/weapon/grab, src))
		var/mob/safe = null
		if (istype(src.l_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.l_hand
			if ((G.state == 3 && get_dir(src, A) == src.dir))
				safe = G.affecting
		if (istype(src.r_hand, /obj/item/weapon/grab))
			var/obj/item/weapon.grab/G = src.r_hand
			if ((G.state == 3 && get_dir(src, A) == src.dir))
				safe = G.affecting
		if (safe)
			return safe.las_act(flag, A)
	if (flag == "bullet")
		var/d = 51
		if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/armor))
			if (prob(70))
				show_message("\red Your armor absorbs the hit!", 4)
				return
			else
				if (prob(40))
					show_message("\red Your armor only softens the hit!", 4)
					if (prob(20))
						d = d / 2
					d = d / 4
		else
			if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/swat_suit))
				if (prob(90))
					show_message("\red Your armor absorbs the blow!", 4)
					return
				else
					if (prob(90))
						show_message("\red Your armor only softens the blow!", 4)
						if (prob(60))
							d = d / 2
						d = d / 5
		if (src.stat != 2)
			if (istype(src.organs["chest"], /obj/item/weapon/organ/external))
				var/obj/item/weapon/organ/external/temp = src.organs["chest"]
				temp.take_damage(d, 0)
			src.UpdateDamageIcon()
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			if (prob(50))
				src.weakened = 5
		return
	else
		if (flag)
			if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/armor))
				if (prob(5))
					show_message("\red Your armor absorbs the hit!", 4)
					return
			else
				if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/swat_suit))
					if (prob(70))
						show_message("\red Your armor absorbs the hit!", 4)
						return
			if (prob(75))
				src.stunned = 10
			else
				src.weakened = 10
			if (src.stuttering < 10)
				src.stuttering = 10
		else
			var/d = 20
			if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/armor))
				if (prob(40))
					show_message("\red Your armor absorbs the hit!", 4)
					return
				else
					if (prob(40))
						show_message("\red Your armor only softens the hit!", 4)
						if (prob(20))
							d = d / 2
						d = d / 2
			else
				if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/swat_suit))
					if (prob(70))
						show_message("\red Your armor absorbs the blow!", 4)
						return
					else
						if (prob(90))
							show_message("\red Your armor only softens the blow!", 4)
							if (prob(60))
								d = d / 2
							d = d / 2
			if (src.stat != 2)
				if (istype(src.organs["chest"], /obj/item/weapon/organ/external))
					var/obj/item/weapon/organ/external/temp = src.organs["chest"]
					temp.take_damage(d, 0)
				src.UpdateDamageIcon()
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
				if (prob(25))
					src.stunned = 1
	return

/mob/human/say(message as text)

	var/alt_name
	if (src.muted)
		return
	if ((src.name != src.rname && src.wear_id))
		alt_name = text(" (as [])", src.wear_id.registered)
	if (src.stat == 2)
		for(var/mob/M in world)
			if (M.stat == 2)
				M << text("<B>[]</B>[] []: []", src.rname, alt_name, (src.stat > 1 ? "\[<I>dead</I> \]" : ""), message)
			//Foreach goto(69)
		return
	if ((copytext(message, 1, 2) == "*" && !( src.stat )))
		src.emote(copytext(message, 2, length(message) + 1))
		return
	message = copytext(message, 1, 256)
	if (src.sdisabilities & 2)
		return
	if (src.stat >= 1)
		return
	if ((!( message ) || istype(src.wear_mask, /obj/item/weapon/clothing/mask/muzzle)))
		return
	if (src.stat < 2)
		var/list/L = list(  )
		var/pre = copytext(message, 1, 4)
		var/italics = 0
		var/obj_range = null
		if (pre == "\[r\]")
			message = copytext(message, 4, length(message) + 1)
			if (src.r_hand)
				src.r_hand.talk_into(usr, message)
			L += hearers(1, null)
			obj_range = 1
			italics = 1
		else
			if (pre == "\[h\]")
				message = copytext(message, 4, length(message) + 1)
				if (src.w_radio)
					src.w_radio.talk_into(usr, message)
				L += hearers(1, null)
				obj_range = 1
				italics = 1
			else
				if (pre == "\[l\]")
					message = copytext(message, 4, length(message) + 1)
					if (src.l_hand)
						src.l_hand.talk_into(usr, message)
					L += hearers(1, null)
					obj_range = 1
					italics = 1
				else
					if (pre == "\[w\]")
						message = copytext(message, 4, length(message) + 1)
						L += hearers(1, null)
						obj_range = 1
						italics = 1
					else
						if (pre == "\[i\]")
							message = copytext(message, 4, length(message) + 1)
							for(var/obj/item/weapon/radio/intercom/I in view(1, null))
								I.talk_into(usr, message)
								//Foreach goto(626)
							L += hearers(1, null)
							obj_range = 1
							italics = 1
						else
							L += hearers(null, null)
							pre = null
		L -= src
		L += src
		var/turf/T = src.loc
		if (locate(/obj/move, T))
			T = locate(/obj/move, T)
		message = html_encode(message)
		if (src.stuttering)
			message = stutter(message)
		if (italics)
			message = text("<I>[]</I>", message)
		if (((src.oxygen && src.oxygen.icon_state == "oxy0") || (!( (istype(T, /turf) || istype(T, /obj/move)) ) || T.oxygen > 0)))
			for(var/mob/M in L)
				if (istype(M, src.type))
					M.show_message(text("<B>[]</B>[]: []", src.rname, alt_name, message), 2)
				else
					M.show_message(text("The human: []", stars(message)), 2)
				//Foreach goto(864)
		for(var/obj/O in view(obj_range, null))
			spawn( 0 )
				if (O)
					O.hear_talk(usr, message)
				return
			//Foreach goto(948)
	for(var/mob/M in world)
		if (M.stat > 1)
			M << text("<B>[]</B>[] []: []", src.rname, alt_name, (src.stat > 1 ? "\[<I>dead</I> \]" : ""), message)
		//Foreach goto(1005)
	return

/mob/human/UpdateClothing()

	..()
	if (src.monkeyizing)
		return
	if (!( src.w_uniform ))
		var/obj/item/weapon/W = src.r_store
		if (W)
			u_equip(W)
			if (src.client)
				src.client.screen -= W
			if (W)
				W.loc = src.loc
				W.dropped(src)
				W.layer = initial(W.layer)
		W = src.l_store
		if (W)
			u_equip(W)
			if (src.client)
				src.client.screen -= W
			if (W)
				W.loc = src.loc
				W.dropped(src)
				W.layer = initial(W.layer)
		W = src.wear_id
		if (W)
			u_equip(W)
			if (src.client)
				src.client.screen -= W
			if (W)
				W.loc = src.loc
				W.dropped(src)
				W.layer = initial(W.layer)
		W = src.belt
		if (W)
			u_equip(W)
			if (src.client)
				src.client.screen -= W
			if (W)
				W.loc = src.loc
				W.dropped(src)
				W.layer = initial(W.layer)
	//for(var/i in src.overlays)
	//	src.overlays -= i
	src.overlays = null
		//Foreach goto(351)
	//for(var/i in src.zone_sel.overlays)
	//	src.zone_sel.overlays -= i
		//Foreach goto(385)
	if(src.zone_sel)
		src.zone_sel.overlays = src.body_standing
		src.zone_sel.overlays += image("icon" = 'zone_sel.dmi', "icon_state" = text("[]", src.zone_sel.selecting))

	if (src.lying)
		src.icon = src.lying_icon
		if (src.face2)
			src.overlays += src.face2
		src.overlays += src.body_lying
	else
		src.icon = src.stand_icon
		if (src.face)
			src.overlays += src.face
		src.overlays += src.body_standing
	if (src.w_uniform)
		if (istype(src.w_uniform, /obj/item/weapon/clothing/under))


			var/t1 = src.w_uniform.color

			if (!( t1 ))
				t1 = src.icon_state
			src.overlays += image("icon" = 'uniforms.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)


		src.w_uniform.screen_loc = "2,2"
	if (src.wear_id)
		src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("id[]", (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
	if (src.client)
		src.client.screen -= src.hud_used.other
		src.client.screen -= src.hud_used.intents
		src.client.screen -= src.hud_used.mov_int
	if ((src.client && src.other))
		src.client.screen += src.hud_used.other
		if (src.gloves)
			var/t1 = src.gloves.s_istate
			if (!( t1 ))
				t1 = src.gloves.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.gloves.screen_loc = "4,2"
		if (src.glasses)
			var/t1 = src.glasses.s_istate
			if (!( t1 ))
				t1 = src.glasses.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.glasses.screen_loc = "6,2"
		if (src.ears)
			var/t1 = src.ears.s_istate
			if (!( t1 ))
				t1 = src.ears.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.ears.screen_loc = "9,2"
		if (src.shoes)
			var/t1 = src.shoes.s_istate
			if (!( t1 ))
				t1 = src.shoes.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.shoes.screen_loc = "5,2"
	else
		if (src.gloves)
			var/t1 = src.gloves.s_istate
			if (!( t1 ))
				t1 = src.gloves.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.gloves.screen_loc = null
		if (src.glasses)
			var/t1 = src.glasses.s_istate
			if (!( t1 ))
				t1 = src.glasses.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.glasses.screen_loc = null
		if (src.ears)
			var/t1 = src.ears.s_istate
			if (!( t1 ))
				t1 = src.ears.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.ears.screen_loc = null
		if (src.shoes)
			var/t1 = src.shoes.s_istate
			if (!( t1 ))
				t1 = src.shoes.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.shoes.screen_loc = null
	if (src.w_radio)
		if (!( src.lying ))
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = "headset", "layer" = MOB_LAYER)
		else
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = "headset2", "layer" = MOB_LAYER)
		src.w_radio.screen_loc = "3,1"
	if (src.wear_mask)
		if (istype(src.wear_mask, /obj/item/weapon/clothing/mask))
			var/t1 = src.wear_mask.s_istate
			if (!( t1 ))
				t1 = src.wear_mask.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
		src.wear_mask.screen_loc = "2,3"
	if (src.client)
		if (src.i_select)
			if (src.intent)
				src.client.screen += src.hud_used.intents
				src.i_select.screen_loc = src.intent
			else
				src.i_select.screen_loc = null
		if (src.m_select)
			if (src.m_int)
				src.client.screen += src.hud_used.mov_int
				src.m_select.screen_loc = src.m_int
			else
				src.m_select.screen_loc = null
	if (src.wear_suit)
		if (istype(src.wear_suit, /obj/item/weapon/clothing/suit))
			var/t1 = src.wear_suit.s_istate
			if (!( t1 ))
				t1 = src.wear_suit.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
		src.wear_suit.screen_loc = "2,1"
		if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/straight_jacket))
			if (src.handcuffed)
				src.handcuffed.loc = src.loc
				src.handcuffed.layer = initial(src.handcuffed.layer)
				src.handcuffed = null
			if ((src.l_hand || src.r_hand))
				var/h = src.hand
				src.hand = 1
				drop_item()
				src.hand = 0
				drop_item()
				src.hand = h
	if ((src.client && src.other))
		if (src.head)
			var/t1 = src.head.s_istate
			if (!( t1 ))
				t1 = src.head.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.head.screen_loc = "7,2"
		if (src.belt)
			var/t1 = src.belt.s_istate
			if (!( t1 ))
				t1 = src.belt.icon_state
			src.overlays += image("icon" = 'belt.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.belt.screen_loc = "8,2"
	else
		if (src.head)
			var/t1 = src.head.s_istate
			if (!( t1 ))
				t1 = src.head.icon_state
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.head.screen_loc = null
		if (src.belt)
			var/t1 = src.belt.s_istate
			if (!( t1 ))
				t1 = src.belt.icon_state
			src.overlays += image("icon" = 'belt.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = MOB_LAYER)
			src.belt.screen_loc = null
	if (src.wear_id)
		if (((src.wear_mask && !( src.wear_mask.see_face )) || (src.head && !( src.head.see_face ))))
			src.name = (src.wear_id.registered ? src.wear_id.registered : "Unknown")
		else
			if (src.wear_id.registered != src.rname)
				src.name = text("[] (as [])", src.rname, src.wear_id.registered)
			else
				src.name = text("[]", src.rname)
		src.wear_id.screen_loc = "1,1"
	else
		src.name = text("[]", src.rname)
	if (src.l_store)
		src.l_store.screen_loc = "4,1"
	if (src.r_store)
		src.r_store.screen_loc = "5,1"
	if (src.r_hand)

		var/t1 = src.r_hand.s_istate
		if (!( t1 ))
			t1 = src.r_hand.icon_state
		src.overlays += image("icon" = 'r_items.dmi', "icon_state" = t1, "layer" = MOB_LAYER)



		src.r_hand.screen_loc = "1,2"
	if (src.l_hand)
		var/t1 = src.l_hand.s_istate
		if (!( t1 ))
			t1 = src.l_hand.icon_state
		src.overlays += image("icon" = 'l_items.dmi', "icon_state" = t1, "layer" = MOB_LAYER)



		src.l_hand.screen_loc = "3,2"
	if (src.back)
		if (istype(src.back, /obj/item/weapon/radio/electropack))
			if (!( src.lying ))
				src.overlays += image("icon" = 'mob.dmi', "icon_state" = "backe", "layer" = MOB_LAYER)
			else
				src.overlays += image("icon" = 'mob.dmi', "icon_state" = "backe2", "layer" = MOB_LAYER)
		else
			if (!( src.lying ))
				src.overlays += image("icon" = 'mob.dmi', "icon_state" = "back", "layer" = MOB_LAYER)
			else
				src.overlays += image("icon" = 'mob.dmi', "icon_state" = "back2", "layer" = MOB_LAYER)
		src.back.screen_loc = "3,3"
	if (src.handcuffed)
		src.pulling = null
		if (!( src.lying ))
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = "handcuff1", "layer" = MOB_LAYER)
		else
			src.overlays += image("icon" = 'mob.dmi', "icon_state" = "handcuff2", "layer" = MOB_LAYER)
	if (src.client)
		src.client.screen -= src.contents
		src.client.screen += src.contents
	var/shielded = 0
	for(var/obj/item/weapon/shield/S in src)
		if (S.active)
			shielded = 1
		else
			//Foreach continue //goto(2917)
	for(var/obj/item/weapon/cloaking_device/S in src)
		if (S.active)
			shielded = 2
		else
			//Foreach continue //goto(2969)
	if (shielded == 2)
		src.invisibility = 2
	else
		src.invisibility = 0
	if (shielded)
		src.overlays += image("icon" = 'mob.dmi', "icon_state" = "shield", "layer" = MOB_LAYER)
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			spawn( 0 )
				src.show_inv(M)
				return
		//Foreach goto(3088)
	src.last_b_state = src.stat

	return

/mob/human/hand_p(mob/M as mob)

	if (M.a_intent == "hurt")
		if (istype(M.wear_mask, /obj/item/weapon/clothing/mask/muzzle))
			return
		if (((prob(60) || (ticker && ticker.mode == "monkey")) && src.health > 0))
			if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/sp_suit))
				if (prob(95))
					for(var/mob/O in viewers(src, null))
						O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
						//Foreach goto(101)
					return
			else
				if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/bio_suit))
					if (prob(90))
						for(var/mob/O in viewers(src, null))
							O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
							//Foreach goto(167)
						return
				else
					if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/armor))
						if (prob(60))
							for(var/mob/O in viewers(src, null))
								O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
								//Foreach goto(233)
							return
					else
						if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/swat_suit))
							if (prob(99))
								for(var/mob/O in viewers(src, null))
									O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
									//Foreach goto(299)
								return
			for(var/mob/O in viewers(src, null))
				if ((O.client && !( O.blinded )))
					O.show_message(text("\red <B>The monkey has bit []!</B>", src), 1)
				//Foreach goto(344)
			var/damage = rand(1, 3)
			var/dam_zone = pick("chest", "l_hand", "r_hand", "l_leg", "r_leg", "diaper")
			if (istype(src.organs[text("[]", dam_zone)], /obj/item/weapon/organ/external))
				var/obj/item/weapon/organ/external/temp = src.organs[text("[]", dam_zone)]
				if (temp.take_damage(damage, 0))
					src.UpdateDamageIcon()
				else
					src.UpdateDamage()
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			if ((ticker && ticker.mode == "monkey"))
				src.monkeyize()
		else
			for(var/mob/O in viewers(src, null))
				if ((O.client && !( O.blinded )))
					O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
				//Foreach goto(580)
	return

/mob/human/attack_paw(mob/M as mob)

	if (M.a_intent == "help")
		src.sleeping = 0
		src.resting = 0
		for(var/mob/O in viewers(src, null))
			O.show_message(text("\blue The monkey shakes [] trying to wake him up!", src), 1)
			//Foreach goto(47)
	else
		if (istype(src.wear_mask, /obj/item/weapon/clothing/mask/muzzle))
			return
		if (((prob(60) || (ticker && ticker.mode == "monkey")) && src.health > 0))
			if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/sp_suit))
				if (prob(95))
					for(var/mob/O in viewers(src, null))
						O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
						//Foreach goto(159)
					return
			else
				if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/bio_suit))
					if (prob(90))
						for(var/mob/O in viewers(src, null))
							O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
							//Foreach goto(225)
						return
				else
					if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/armor))
						if (prob(60))
							for(var/mob/O in viewers(src, null))
								O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
								//Foreach goto(291)
							return
					else
						if (istype(src.wear_suit, /obj/item/weapon/clothing/suit/swat_suit))
							if (prob(99))
								for(var/mob/O in viewers(src, null))
									O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
									//Foreach goto(357)
								return
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\red <B>The monkey has bit []!</B>", src), 1)
				//Foreach goto(402)
			var/damage = rand(1, 3)
			var/dam_zone = pick("chest", "l_hand", "r_hand", "l_leg", "r_leg", "diaper")
			if (istype(src.organs[text("[]", dam_zone)], /obj/item/weapon/organ/external))
				var/obj/item/weapon/organ/external/temp = src.organs[text("[]", dam_zone)]
				if (temp.take_damage(damage, 0))
					src.UpdateDamageIcon()
				else
					src.UpdateDamage()
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			if ((ticker && ticker.mode == "monkey"))
				src.monkeyize()
		else
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
				//Foreach goto(623)
	return

/mob/human/attack_hand(mob/human/M as mob)

	if (M.a_intent == "help")
		if (src.health > 0)
			if (src.w_uniform)
				src.w_uniform.add_fingerprint(M)
			src.sleeping = 0
			src.resting = 0
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\blue [] shakes [] trying to wake [] up!", M, src, src), 1)
				//Foreach goto(80)
		else
			if (M.health >= -75.0)
				if (((M.head && M.head.flags & 4) || ((M.wear_mask && !( M.wear_mask.flags & 32 )) || ((src.head && src.head.flags & 4) || (src.wear_mask && !( src.wear_mask.flags & 32 ))))))
					M << "\blue <B>Remove that mask!</B>"
					return
				var/obj/equip_e/human/O = new /obj/equip_e/human(  )
				O.source = M
				O.target = src
				O.s_loc = M.loc
				O.t_loc = src.loc
				O.place = "CPR"
				src.requests += O
				spawn( 0 )
					O.process()
					return
	else
		if (M.a_intent == "grab")
			if (M == src)
				return
			if (src.w_uniform)
				src.w_uniform.add_fingerprint(M)
			var/obj/item/weapon/grab/G = new /obj/item/weapon/grab( M )
			G.assailant = M
			if (M.hand)
				M.l_hand = G
			else
				M.r_hand = G
			G.layer = 20
			G.affecting = src
			src.grabbed_by += G
			G.synch()
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\red [] has grabbed [] passively!", M, src), 1)
				//Foreach goto(441)
		else
			if (M.a_intent == "hurt")
				if (src.w_uniform)
					src.w_uniform.add_fingerprint(M)
				var/damage = rand(1, 9)
				var/obj/item/weapon/organ/external/affecting = src.organs["chest"]
				var/t = M.zone_sel.selecting
				if ((t in list( "hair", "eyes", "mouth", "neck" )))
					t = "head"
				var/def_zone = ran_zone(t)
				if (src.organs[text("[]", def_zone)])
					affecting = src.organs[text("[]", def_zone)]
				if ((istype(affecting, /obj/item/weapon/organ/external) && prob(90)))
					for(var/mob/O in viewers(src, null))
						O.show_message(text("\red <B>[] has punched []!</B>", M, src), 1)
						//Foreach goto(646)
					if (def_zone == "head")
						if ((((src.head && src.head.brute_protect & 1) || (src.wear_mask && src.wear_mask.brute_protect & 1)) && prob(99)))
							if (prob(20))
								affecting.take_damage(damage, 0)
							else
								src.show_message("\red You have been protected from a hit to the head.")
							return
						if (damage > 4.9)
							if (src.weakened < 10)
								src.weakened = rand(10, 15)
							for(var/mob/O in viewers(M, null))
								O.show_message(text("\red <B>[] has weakened []!</B>", M, src), 1, "\red You hear someone fall.", 2)
								//Foreach goto(820)
						affecting.take_damage(damage)
					else
						if (def_zone == "chest")
							if ((((src.wear_suit && src.wear_suit.brute_protect & 2) || (src.w_uniform && src.w_uniform.brute_protect & 2)) && prob(85)))
								src.show_message("\red You have been protected from a hit to the cheast.")
								return
							if (damage > 4.9)
								if (prob(50))
									if (src.weakened < 5)
										src.weakened = 5
									for(var/mob/O in viewers(src, null))
										O.show_message(text("\red <B>[] has knocked down []!</B>", M, src), 1, "\red You hear someone fall.", 2)
										//Foreach goto(993)
								else
									if (src.stunned < 5)
										src.stunned = 5
									for(var/mob/O in viewers(src, null))
										O.show_message(text("\red <B>[] has stunned []!</B>", M, src), 1)
										//Foreach goto(1063)
								src.stat = 1
							affecting.take_damage(damage)
						else
							if (def_zone == "diaper")
								if ((((src.wear_suit && src.wear_suit.brute_protect & 4) || (src.w_uniform && src.w_uniform.brute_protect & 4)) && prob(75)))
									src.show_message("\red You have been protected from a hit to the lower chest/diaper.")
									return
								if (damage > 4.9)
									if (prob(50))
										if (src.weakened < 3)
											src.weakened = 3
										for(var/mob/O in viewers(src, null))
											O.show_message(text("\red <B>[] has knocked down []!</B>", M, src), 1, "\red You hear someone fall.", 2)
											//Foreach goto(1239)
									else
										if (src.stunned < 3)
											src.stunned = 3
										for(var/mob/O in viewers(src, null))
											O.show_message(text("\red <B>[] has stunned []!</B>", M, src), 1)
											//Foreach goto(1309)
									src.stat = 1
								affecting.take_damage(damage)
							else
								affecting.take_damage(damage)
					src.UpdateDamageIcon()
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
				else
					for(var/mob/O in viewers(src, null))
						O.show_message(text("\red <B>[] has attempted to punch []!</B>", M, src), 1)
						//Foreach goto(1419)
					return
			else
				if (!( src.lying ))
					if (src.w_uniform)
						src.w_uniform.add_fingerprint(M)
					var/randn = rand(1, 100)
					if (randn <= 25)
						src.weakened = 2
						for(var/mob/O in viewers(src, null))
							O.show_message(text("\red <B>[] has pushed down []!</B>", M, src), 1)
							//Foreach goto(1529)
					else
						if (randn <= 60)
							src.drop_item()
							for(var/mob/O in viewers(src, null))
								O.show_message(text("\red <B>[] has disarmed []!</B>", M, src), 1)
								//Foreach goto(1596)
						else
							for(var/mob/O in viewers(src, null))
								O.show_message(text("\red <B>[] has attempted to disarm []!</B>", M, src), 1)
								//Foreach goto(1643)
	return

/mob/human/Topic(href, href_list)

	if ((src == usr && !( src.start )))
		if (findtext(href, "occ", 1, null))
			if (findtext(href, "cancel", 1, null))
				usr << browse(null, text("window=\ref[]occupation", src))
				return
			if (!( findtext(href, "job", 1, null) ))
				src.SetChoices(text2num(href_list["occ"]))
			else
				src.SetJob(arglist(list("occ" = text2num(href_list["occ"]), "job" = href_list["job"])))
		else
			if (findtext(href, "rname", 1, null))
				var/t1 = href_list["rname"]
				if (t1 == "input")
					t1 = input("Please select a name:", "Character Generation", null, null)  as text
				if ((!( src.start ) && t1))
					if (length(t1) >= 26)
						t1 = copytext(t1, 1, 26)
					t1 = dd_replacetext(t1, ">", "'")
					src.rname = t1
			else
				if (findtext(href, "age", 1, null))
					var/t1 = href_list["age"]
					if (t1 == "input")
						t1 = input("Please select type in age: 20-45", "Character Generation", null, null)  as num
					if ((!( src.start ) && t1))
						src.age = max(min(round(text2num(t1)), 45), 20)
				else
					if (findtext(href, "b_type", 1, null))
						var/t1 = href_list["b_type"]
						if (t1 == "input")
							t1 = input("Please select a blood type:", "Character Generation", null, null)  as null|anything in list( "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" )
						if ((!( src.start ) && t1))
							src.b_type = t1
					else
						if (findtext(href, "nr_hair", 1, null))
							var/t1 = href_list["nr_hair"]
							if (t1 == "input")
								t1 = input("Please select red hair component: 1-255", "Character Generation", null, null)  as text
							if ((!( src.start ) && t1))
								src.nr_hair = max(min(round(text2num(t1)), 255), 1)
						else
							if (findtext(href, "ng_hair", 1, null))
								var/t1 = href_list["ng_hair"]
								if (t1 == "input")
									t1 = input("Please select green hair component: 1-255", "Character Generation", null, null)  as text
								if ((!( src.start ) && t1))
									src.ng_hair = max(min(round(text2num(t1)), 255), 1)
							else
								if (findtext(href, "nb_hair", 1, null))
									var/t1 = href_list["nb_hair"]
									if (t1 == "input")
										t1 = input("Please select blue hair component: 1-255", "Character Generation", null, null)  as text
									if ((!( src.start ) && t1))
										src.nb_hair = max(min(round(text2num(t1)), 255), 1)
								else
									if (findtext(href, "r_eyes", 1, null))
										var/t1 = href_list["r_eyes"]
										if (t1 == "input")
											t1 = input("Please select red eyes component: 1-255", "Character Generation", null, null)  as text
										if ((!( src.start ) && t1))
											src.r_eyes = max(min(round(text2num(t1)), 255), 1)
									else
										if (findtext(href, "ns_tone", 1, null))
											var/t1 = href_list["ns_tone"]
											if (t1 == "input")
												t1 = input("Please select skin tone level: 1-220 (1=albino,35=caucasian, 150=black220='very' black)", "Character Generation", null, null)  as text
											if ((!( src.start ) && t1))
												src.ns_tone = max(min(round(text2num(t1)), 220), 1)
												src.ns_tone =  -src.ns_tone + 35
										else
											if (findtext(href, "g_eyes", 1, null))
												var/t1 = href_list["g_eyes"]
												if (t1 == "input")
													t1 = input("Please select green eyes component: 1-255", "Character Generation", null, null)  as text
												if ((!( src.start ) && t1))
													src.g_eyes = max(min(round(text2num(t1)), 255), 1)
											else
												if (findtext(href, "b_eyes", 1, null))
													var/t1 = href_list["b_eyes"]
													if (t1 == "input")
														t1 = input("Please select blue eyes component: 1-255", "Character Generation", null, null)  as text
													if ((!( src.start ) && t1))
														src.b_eyes = max(min(round(text2num(t1)), 255), 1)
												else
													if (findtext(href, "h_style", 1, null))
														var/t1 = href_list["h_style"]
														if (t1 == "input")
															t1 = input("Please select hair style", "Character Generation", null, null)  as null|anything in list( "Cut Hair", "Short Hair (M)", "Long Hair (F)", "Bald" )
														if ((!( src.start ) && t1))
															src.h_style = t1
															switch(t1)
																if("Short Hair (M)")
																	src.h_style_r = "hair_a"
																if("Long Hair (F)")
																	src.h_style_r = "hair_b"
																if("Cut Hair")
																	src.h_style_r = "hair_c"
																else
																	src.h_style_r = "bald"
													else
														if (findtext(href, "gender", 1, null))
															if (src.gender == "male")
																src.gender = "female"
															else
																src.gender = "male"
															src.stand_icon = new /icon( 'human.dmi', text("[]", src.gender) )
															src.lying_icon = new /icon( 'human.dmi', text("[]-d", src.gender) )
														else
															if (findtext(href, "n_gl", 1, null))
																src.need_gl = !( src.need_gl )
															else
																if (findtext(href, "b_ep", 1, null))
																	src.be_epil = !( src.be_epil )
																else
																	if (findtext(href, "b_tur", 1, null))
																		src.be_tur = !( src.be_tur )
																	else
																		if (findtext(href, "b_co", 1, null))
																			src.be_cough = !( src.be_cough )
																		else
																			if (findtext(href, "b_stut", 1, null))
																				src.be_stut = !( src.be_stut )
																			else
																				if (findtext(href, "save", 1, null))
																					var/savefile/F = new /savefile( text("players/[].sav", src.ckey) )
																					F["version"] << savefile_ver
																					F["rname"] << src.rname
																					F["gender"] << src.gender
																					F["age"] << src.age
																					F["occupation1"] << src.occupation1
																					F["occupation2"] << src.occupation2
																					F["occupation3"] << src.occupation3
																					F["nr_hair"] << src.nr_hair
																					F["ng_hair"] << src.ng_hair
																					F["nb_hair"] << src.nb_hair
																					F["ns_tone"] << src.ns_tone
																					F["h_style"] << src.h_style
																					F["h_style_r"] << src.h_style_r
																					F["r_eyes"] << src.r_eyes
																					F["g_eyes"] << src.g_eyes
																					F["b_eyes"] << src.b_eyes
																					F["b_type"] << src.b_type
																					F["need_gl"] << src.need_gl
																					F["be_epil"] << src.be_epil
																					F["be_tur"] << src.be_tur
																					F["be_cough"] << src.be_cough
																					F["be_stut"] << src.be_stut
																				else
																					if (findtext(href, "load", 1, null))
																						if (fexists(text("players/[].sav", src.ckey)))
																							var/savefile/F = new /savefile( text("players/[].sav", src.ckey) )
																							var/test = null
																							F["version"] >> test
																							if (test != savefile_ver)
																								fdel(text("players/[].sav", src.ckey))
																								alert("Your savefile was incompatible with this version and was deleted.", null, null, null, null, null)
																								return
																							F["rname"] >> src.rname
																							F["gender"] >> src.gender
																							F["age"] >> src.age
																							F["occupation1"] >> src.occupation1
																							F["occupation2"] >> src.occupation2
																							F["occupation3"] >> src.occupation3
																							F["nr_hair"] >> src.nr_hair
																							F["ng_hair"] >> src.ng_hair
																							F["nb_hair"] >> src.nb_hair
																							F["ns_tone"] >> src.ns_tone
																							F["h_style"] >> src.h_style
																							F["h_style_r"] >> src.h_style_r
																							F["r_eyes"] >> src.r_eyes
																							F["g_eyes"] >> src.g_eyes
																							F["b_eyes"] >> src.b_eyes
																							F["b_type"] >> src.b_type
																							F["need_gl"] >> src.need_gl
																							F["be_epil"] >> src.be_epil
																							F["be_tur"] >> src.be_tur
																							F["be_cough"] >> src.be_cough
																							F["be_stut"] >> src.be_stut
																						else
																							alert("You do not have a savefile.", null, null, null, null, null)
		src.ShowChoices()
	if (href_list["mach_close"])
		var/t1 = text("window=[]", href_list["mach_close"])
		src.machine = null
		src << browse(null, t1)
	if ((href_list["item"] && !( usr.stat ) && usr.canmove && !( usr.restrained() ) && get_dist(src, usr) <= 1))
		var/obj/equip_e/human/O = new /obj/equip_e/human(  )
		O.source = usr
		O.target = src
		O.item = usr.equipped()
		O.s_loc = usr.loc
		O.t_loc = src.loc
		O.place = href_list["item"]
		src.requests += O
		spawn( 0 )
			O.process()
			return
	..()
	return

/mob/human/show_inv(mob/user as mob)

	user.machine = src
	var/dat = text("<PRE>\n<B><FONT size=3>[]</FONT></B>\n\t<B>Head(Mask):</B> <A href='?src=\ref[];item=mask'>[]</A>\n\t\t<B>Headset:</B> <A href='?src=\ref[];item=headset'>[]</A>\n\t<B>Left Hand:</B> <A href='?src=\ref[];item=l_hand'>[]</A>\n\t<B>Right Hand:</B> <A href='?src=\ref[];item=r_hand'>[]</A>\n\t<B>Gloves:</B> <A href='?src=\ref[];item=gloves'>[]</A>\n\t<B>Eyes:</B> <A href='?src=\ref[];item=eyes'>[]</A>\n\t<B>Ears:</B> <A href='?src=\ref[];item=ears'>[]</A>\n\t<B>Head:</B> <A href='?src=\ref[];item=head'>[]</A>\n\t<B>Shoes:</B> <A href='?src=\ref[];item=shoes'>[]</A>\n\t<B>Belt:</B> <A href='?src=\ref[];item=belt'>[]</A>\n\t<B>Uniform:</B> <A href='?src=\ref[];item=uniform'>[]</A>\n\t<B>(Exo)Suit:</B> <A href='?src=\ref[];item=suit'>[]</A>\n\t<B>Back:</B> <A href='?src=\ref[];item=back'>[]</A> []\n\t<B>ID:</B> <A href='?src=\ref[];item=id'>[]</A>\n\t[]\n\t[]\n\t<A href='?src=\ref[];item=pockets'>Empty Pockets</A>\n<A href='?src=\ref[];mach_close=mob[]'>Close</A>\n</PRE>", src.name, src, (src.wear_mask ? text("[]", src.wear_mask) : "Nothing"), src, (src.w_radio ? text("[]", src.w_radio) : "Nothing"), src, (src.l_hand ? text("[]", src.l_hand) : "Nothing"), src, (src.r_hand ? text("[]", src.r_hand) : "Nothing"), src, (src.gloves ? text("[]", src.gloves) : "Nothing"), src, (src.glasses ? text("[]", src.glasses) : "Nothing"), src, (src.ears ? text("[]", src.ears) : "Nothing"), src, (src.head ? text("[]", src.head) : "Nothing"), src, (src.shoes ? text("[]", src.shoes) : "Nothing"), src, (src.belt ? text("[]", src.belt) : "Nothing"), src, (src.w_uniform ? text("[]", src.w_uniform) : "Nothing"), src, (src.wear_suit ? text("[]", src.wear_suit) : "Nothing"), src, (src.back ? text("[]", src.back) : "Nothing"), ((istype(src.wear_mask, /obj/item/weapon/clothing/mask) && istype(src.back, /obj/item/weapon/tank) && !( src.internal )) ? text(" <A href='?src=\ref[];item=internal'>Set Internal</A>", src) : ""), src, (src.wear_id ? text("[]", src.wear_id) : "Nothing"), (src.handcuffed ? text("<A href='?src=\ref[];item=handcuff'>Handcuffed</A>", src) : text("<A href='?src=\ref[];item=handcuff'>Not Handcuffed</A>", src)), (src.internal ? text("<A href='?src=\ref[];item=internal'>Remove Internal</A>", src) : ""), src, user, src.name)
	user << browse(dat, text("window=mob[];size=300x600", src.name))
	return

/mob/proc/show_message(msg, type, alt, alt_type)

	if (type)
		if ((type & 1 && (src.sdisabilities & 1 || (src.blinded || src.paralysis))))
			if (!( alt ))
				return
			else
				msg = alt
				type = alt_type
		if ((type & 2 && (src.sdisabilities & 4 || src.ear_deaf)))
			if (!( alt ))
				return
			else
				msg = alt
				type = alt_type
				if ((type & 1 && src.sdisabilities & 1))
					return
	src << msg
	return

/mob/proc/findname(msg)

	for(var/mob/M in world)
		if (M.rname == text("[]", msg))
			return 1
		//Foreach goto(15)
	return 0
	return

/mob/proc/m_delay()

	return

/mob/proc/Life()

	return

/mob/proc/UpdateClothing()

	return

/mob/proc/death()

	src.timeofdeath = world.time
	return ..()
	return

/mob/proc/restrained()

	if (src.handcuffed)
		return 1
	return

/mob/proc/db_click(text, t1)

	var/obj/item/weapon/W = src.equipped()
	switch(text)
		if("mask")
			if (src.wear_mask)
				return
			if (!( istype(W, /obj/item/weapon/clothing/mask) ))
				return
			src.u_equip(W)
			src.wear_mask = W
		if("back")
			if ((src.back || !( istype(W, /obj/item/weapon) )))
				return
			if (!( W.flags & 1 ))
				return
			src.u_equip(W)
			src.back = W
		else
	return

/mob/proc/throw_item()

	var/obj/item/weapon/W = src.equipped()
	if (W)
		u_equip(W)
		if (src.client)
			src.client.screen -= W
		if (usr.stat)
			return
		W.loc = src.loc
		if (istype(W, /obj/item/weapon/grab))
			W:throw()
		else
			W.dropped(src)
		if (W)
			W.layer = initial(W.layer)
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\red [] has thrown [].", src, W), 1)
				//Foreach goto(133)
			W.density = 1
			W.throwing = 1
			W.throwspeed = initial(W.throwspeed)
			spawn( 0 )
				W.throwing(src.dir)
				return
	return

/mob/proc/swap_hand()

	src.hand = !( src.hand )
	if (!( src.hand ))
		src.hands.dir = NORTH
	else
		src.hands.dir = SOUTH
	return

/mob/proc/drop_item_v()

	if (src.stat == 0)
		drop_item()
	return

/mob/proc/throw_item_v()

	if (src.stat == 0)
		throw_item()
	return

/mob/proc/drop_item()

	var/obj/item/weapon/W = src.equipped()
	if (W)
		u_equip(W)
		if (src.client)
			src.client.screen -= W
		if (W)
			W.loc = src.loc
			W.dropped(src)
			if (W)
				W.layer = initial(W.layer)
	return

/mob/proc/reset_view(atom/A as mob|obj)

	if (src.client)
		if (istype(A, /atom/movable))
			src.client.perspective = EYE_PERSPECTIVE
			src.client.eye = A
		else
			if (isturf(src.loc))
				src.client.eye = src.client.mob
				src.client.perspective = MOB_PERSPECTIVE
			else
				src.client.perspective = EYE_PERSPECTIVE
				src.client.eye = src.loc
	return

/mob/proc/who()
	set category = "Admin"

	var/total = 0
	usr << "<B>Current Players:</B>"
	for(var/mob/M in world)
		if (M.client)
			total++
			usr << text("\t [] ([])", M, M.client)
		//Foreach goto(32)
	usr << text("<B>Total Players: []</B>", total)
	return

/mob/proc/list_dna()
	set category = "Admin"

	usr << "<B>Registered DNA sequences:</B>"
	for(var/M in reg_dna)
		usr << text("\t [] = []", M, reg_dna[text("[]", M)])
		//Foreach goto(26)
	return

/mob/proc/equipped()

	if (src.hand)
		return src.l_hand
	else
		return src.r_hand
	return

/mob/proc/show_inv(mob/user as mob)

	user.machine = src
	var/dat = text("<TT>\n<B><FONT size=3>[]</FONT></B><BR>\n\t<B>Head(Mask):</B> <A href='?src=\ref[];item=mask'>[]</A><BR>\n\t<B>Left Hand:</B> <A href='?src=\ref[];item=l_hand'>[]</A><BR>\n\t<B>Right Hand:</B> <A href='?src=\ref[];item=r_hand'>[]</A><BR>\n\t<B>Back:</B> <A href='?src=\ref[];item=back'>[]</A><BR>\n\t[]<BR>\n\t[]<BR>\n\t[]<BR>\n\t<A href='?src=\ref[];item=pockets'>Empty Pockets</A><BR>\n<A href='?src=\ref[];mach_close=mob[]'>Close</A><BR>\n</TT>", src.name, src, (src.wear_mask ? text("[]", src.wear_mask) : "Nothing"), src, (src.l_hand ? text("[]", src.l_hand) : "Nothing"), src, (src.r_hand ? text("[]", src.r_hand) : "Nothing"), src, (src.back ? text("[]", src.back) : "Nothing"), ((istype(src.wear_mask, /obj/item/weapon/clothing/mask) && istype(src.back, /obj/item/weapon/tank) && !( src.internal )) ? text(" <A href='?src=\ref[];item=internal'>Set Internal</A>", src) : ""), (src.internal ? text("<A href='?src=\ref[];item=internal'>Remove Internal</A>", src) : ""), (src.handcuffed ? text("<A href='?src=\ref[];item=handcuff'>Handcuffed</A>", src) : text("<A href='?src=\ref[];item=handcuff'>Not Handcuffed</A>", src)), src, user, src.name)
	user << browse(dat, text("window=mob[]", src.name))
	return

/mob/proc/u_equip(W as obj)

	if (W == src.r_hand)
		src.r_hand = null
	else
		if (W == src.l_hand)
			src.l_hand = null
		else
			if (W == src.handcuffed)
				src.handcuffed = null
			else
				if (W == src.back)
					src.back = null
				else
					if (W == src.wear_mask)
						src.wear_mask = null
	return

/mob/proc/toggle_ooc()
	set category = "Admin"

	ooc_allowed = !( ooc_allowed )
	if (ooc_allowed)
		world << "<B>The OOC channel has been globally enabled!</B>"
	else
		world << "<B>The OOC channel has been globally disabled!</B>"
	return

/mob/proc/toggle_abandon()
	set category = "Admin"

	abandon_allowed = !( abandon_allowed )
	if (abandon_allowed)
		world << "<B>You may now abandon mob.</B>"
	else
		world << "<B>Live or Die Mode Activated</B>"
	world.update_stat()
	return

/mob/proc/toggle_enter()
	set category = "Admin"

	enter_allowed = !( enter_allowed )
	if (enter_allowed)
		world << "<B>You may enter the game.</B>"
	else
		world << "<B>You may no longer enter the game.</B>"
	world.update_stat()
	return

/mob/proc/toggle_shuttle()
	set category = "Admin"

	shuttle_frozen = !( shuttle_frozen )
	if (shuttle_frozen)
		world << "<B>The shuttle count is now FROZEN!</B>"
	else
		world << "<B>The shuttle has been thawed.</B>"
	return

/mob/proc/show_ctf()
	set category = "Admin"

	if (ticker)
		usr << "Too late... The game has already started!"
		return
	else
		if (!( ctf ))
			ctf = new /obj/ctf_assist(  )
		ctf.show_screen(usr)
	return

/mob/proc/delay_start()
	set category = "Admin"

	if (ticker)
		usr << "Too late... The game has already started!"
		return
	else
		if (alert(usr, "Would you like to delay game start?", "Delay Start", "Yes", "No", null) == "Yes")
			going = null
			world << text("<B>The game start has been delayed by [] (Administrator to SS13)</B>", usr.key)
			usr << alert("Don't forgot to revoke the delay by selecting No!", null, null, null, null, null)
		else
			world << text("<B>The game will now start thanks to [] (Administrator to SS13)</B>", usr.key)
			going = 1
	return

/mob/proc/mute(mob/M as mob in world)
	set category = "Admin"

	M.muted = !( M.muted )
	usr << text("[]'s chat status is now [].", M, (M.muted ? "muted" : "voiced"))
	return

/mob/proc/change_name(mob/M as mob in world, t as text)
	set category = "Admin"

	usr << text("[]'s default name is now [] !", M, t)
	M.rname = t
	return

/mob/proc/show_help(mob/M as mob in world)
	set category = "Admin"

	M << browse('help.htm', "window=help")
	return

/mob/proc/changemessage(txt as text)
	set category = "Admin"

	world_message = text("[]: []", src.key, txt)
	world << text("\blue <B>[]</B>", world_message)
	return

/mob/proc/changemode()
	set category = "Admin"

	if (ticker)
		return
	var/temp = input("Please select a mode", "Game Mode", null, null) in list( "secret", "traitor", "nuclear", "meteor", "extended", "monkey" )
	master_mode = temp
	return

/mob/proc/boot(mob/M as mob in world, txt as text)
	set category = "Admin"

	if ((M && M.client && txt))
		//M.client = null
		del(M.client)
	return

/mob/proc/ban(mob/M as mob in world, txt as text)
	set category = "Admin"

	if ((M && M.client && txt))
		banned += M.ckey
		//M.client = null
		del(M.client)
	return

/mob/proc/unban()
	set category = "Admin"

	var/t = input(usr, "Unban who?", null, null)  as null|anything in banned
	banned -= t
	return

/mob/proc/make_gift()
	set category = "Admin"

	new /obj/item/weapon/a_gift( src.loc )
	return

/mob/proc/make_pill()
	set category = "Admin"

	new /obj/item/weapon/m_pill/superpill( src.loc )
	return

/mob/proc/make_flag()
	set category = "Admin"

	var/color = input("Please select a color", null, null, null) in list( "red", "blue", "green", "yellow", "black", "white", "neutral" )
	var/obj/item/weapon/paper/flag/F = new /obj/item/weapon/paper/flag( src.loc )
	F.icon_state = text("flag_[]", color)
	return

/mob/proc/restart()
	set category = "Admin"

	world << "\green <B> Restarting world!"
	sleep(50)
	world.Reboot()
	return

/mob/proc/monkey(mob/M as mob in world)
	set category = "Admin"
	set hidden = 1

	for(var/obj/O in M)
		//O = null
		del(O)
		//Foreach goto(20)
	var/mob/monkey/O = new /mob/monkey( M.loc )
	M.client.mob = O
	O.loc = M.loc
	//M = null
	del(M)
	return

/mob/proc/toggle_alter()
	set category = "Admin"

	if (src.verbs.Find(/mob/proc/carboncopy))
		src.verbs -= /mob/proc/carboncopy
	else
		src.verbs -= /mob/proc/carboncopy
		src.verbs += /mob/proc/carboncopy
	return

/mob/proc/carboncopy(atom/movable/O as mob|obj in world)

	var/M = O
	if ((istype(M, /mob) && M:key))
		usr << "You can't duplicate PCs' mobs."
		return
	var/mob/new_O = new O.type( usr.loc )
	for(var/V in O.vars)
		if (issaved(O.vars[V]))
			new_O.vars[V] = O.vars[V]
		//Foreach goto(72)
	return

/mob/proc/secrets(pass as text)
	set category = "Admin"

	switch(pass)
		if("sec_clothes")
			for(var/obj/item/weapon/clothing/under/O in world)
				//O = null
				del(O)
				//Foreach goto(52)
		if("sec_all_clothes")
			for(var/obj/item/weapon/clothing/O in world)
				//O = null
				del(O)
				//Foreach goto(97)
		if("sec_classic1")
			for(var/obj/item/weapon/clothing/suit/firesuit/O in world)
				//O = null
				del(O)
				//Foreach goto(142)
			for(var/obj/grille/O in world)
				//O = null
				del(O)
				//Foreach goto(185)
			for(var/obj/machinery/pod/O in world)
				//O = null
				del(O)
				//Foreach goto(228)
		if("clear_bombs")
			for(var/obj/item/weapon/assembly/r_i_ptank/O in world)
				//O = null
				del(O)
				//Foreach goto(273)
		if("dissimulate_aspect")
			usr.invisibility = !( usr.invisibility )
			usr.sight |= SEE_SELF
			world << text("\red [] manipulates the visible plane.", usr)
		if("teleport")
			var/mob/M = input("Who do you wish to goto?", null, null, null)  as null|mob in world
			if (!( ismob(M) ))
				return
			else
				src.loc = M.loc
				world << text("\red [] teleports to []!", usr, M)
		if("summon")
			var/mob/M = input("Who do you wish to summon?", null, null, null)  as null|mob in world
			if (!( ismob(M) ))
				return
			else
				M.loc = src.loc
				world << text("\red [] summons []!", usr, M)
		if("list_bombers")
			usr << "\blue <B>Don't be insane about this list</B> Get the facts."
			for(var/l in bombers)
				usr << text("[] 'made' a bomb.", l)
				//Foreach goto(476)
		if("check_antagonist")
			if (ticker)
				if (ticker.killer)
					if (ticker.killer.ckey)
						usr << text("<B>The traitor's key is [].</B>", ticker.killer.ckey)
					else
						usr << "<B>It seems like the traitor logged out...</B>"
				else
					usr << "<B>There is no traitor.</B>"
			else
				usr << "<B>The game has not started yet.</B>"
		else
	return

/mob/proc/ret_grab(obj/list_container/mobl/L as obj, flag)

	if ((!( istype(src.l_hand, /obj/item/weapon/grab) ) && !( istype(src.r_hand, /obj/item/weapon/grab) )))
		if (!( L ))
			return null
		else
			return L.container
	else
		if (!( L ))
			L = new /obj/list_container/mobl( null )
			L.container += src
			L.master = src
		if (istype(src.l_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.l_hand
			if (!( L.container.Find(G.affecting) ))
				L.container += G.affecting
				G.affecting.ret_grab(L, 1)
		if (istype(src.r_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.r_hand
			if (!( L.container.Find(G.affecting) ))
				L.container += G.affecting
				G.affecting.ret_grab(L, 1)
		if (!( flag ))
			if (L.master == src)
				var/list/temp = list(  )
				temp += L.container
				//L = null
				del(L)
				return temp
			else
				return L.container
	return

/mob/verb/mode()
	set src = usr

	var/obj/item/weapon/W = src.equipped()
	if (W)
		W.attack_self(src)
	return

/mob/verb/dump_source()

	var/master = "<PRE>"
	for(var/t in typesof(/area))
		master += text("[]\n", t)
		//Foreach goto(26)
	src << browse(master)
	return

/mob/verb/memory()

	src << browse(text("<B>Memory:</B>:<HR>[]", src.memory), "window=memory")
	return

/mob/verb/add_memory(msg as message)

	src.memory += text("[]<BR>", msg)
	src << browse(text("<B>Memory:</B>:<HR>[]", src.memory), "window=memory")
	return

/mob/verb/help()

	src << browse('help.htm', "window=help")
	return

/mob/verb/abandon_mob()

	if (!( abandon_allowed ))
		return
	if ((src.stat != 2 || !( ticker )))
		usr << "\blue <B>You must be dead to use this!</B>"
		return
	usr << "\blue <B>Please roleplay correctly!</B>"
	for(var/obj/screen/t in usr.client.screen)
		if (t.loc == null)
			//t = null
			del(t)
		//Foreach goto(66)
	var/mob/human/M = new /mob/human(  )
	M.key = src.client.key
	return

/mob/verb/changes()

	src << browse(text("<PRE>[]</PRE>", changes), "window=changes")
	return

/mob/verb/succumb()
	set hidden = 1

	if ((src.health < 0 && src.health > -95.0))
		src.oxyloss += src.health + 99
		src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		usr << "\blue You have given up life and succumbed to death."
	return

/mob/verb/say()

	return

/mob/verb/observe()

	if (src.stat != 2)
		usr << "\blue You must be dead to use this!"
		return
	src.client.perspective = EYE_PERSPECTIVE
	src.client.eye = input("Please, select a player!", "Watch", null, null) as mob in world
	return

/mob/verb/listen_ooc()

	if (src.client)
		src.client.listen_ooc = !( src.client.listen_ooc )
		if (src.client.listen_ooc)
			src << "\blue You are now listening to messages on the OOC channel. <B>Don't abuse this!</B>"
		else
			src << "\blue You are no longer listening to messages on the OOC channel."
	return

/mob/verb/ooc(msg as text)

	msg = html_encode(copytext(msg, 1, 128))
	if (!( msg ))
		return
	if ((ooc_allowed && !( src.muted )))
		for(var/mob/M in world)
			if ((M.client && M.client.listen_ooc))
				M << text("<B>OOC: []</B>: []", src.key, msg)
			//Foreach goto(54)
	return

/mob/verb/switch_hud()

	src.client.screen -= main_hud.contents
	src.client.screen -= main_hud2.contents
	if (src.hud_used == main_hud)
		src.hud_used = main_hud2
		src.oxygen.icon = 'screen.dmi'
		src.toxin.icon = 'screen.dmi'
		src.internals.icon = 'screen.dmi'
		src.mach.icon = 'screen.dmi'
		src.fire.icon = 'screen.dmi'
		src.healths.icon = 'screen.dmi'
		src.pullin.icon = 'screen.dmi'
		src.blind.icon = 'screen.dmi'
		src.hands.icon = 'screen.dmi'
		src.flash.icon = 'screen.dmi'
		src.sleep.icon = 'screen.dmi'
		src.rest.icon = 'screen.dmi'
	else
		src.hud_used = main_hud
		src.oxygen.icon = 'screen1.dmi'
		src.toxin.icon = 'screen1.dmi'
		src.internals.icon = 'screen1.dmi'
		src.mach.icon = 'screen1.dmi'
		src.fire.icon = 'screen1.dmi'
		src.healths.icon = 'screen1.dmi'
		src.pullin.icon = 'screen1.dmi'
		src.blind.icon = 'screen1.dmi'
		src.hands.icon = 'screen1.dmi'
		src.flash.icon = 'screen1.dmi'
		src.sleep.icon = 'screen1.dmi'
		src.rest.icon = 'screen1.dmi'
	src.client.screen -= src.hud_used.adding
	src.client.screen += src.hud_used.adding
	return

/mob/Login()

	src.sight |= SEE_SELF
	..()
	return

/mob/CheckPass(mob/M as mob)

	if ((src.other_mobs && ismob(M) && M.other_mobs))
		return 1
	else
		return (!( M.density ) || !( src.density ) || src.lying)
	return

/mob/burn(fi_amount)

	for(var/atom/movable/A as mob|obj in src)
		A.burn(fi_amount)
		//Foreach goto(15)
	return

/mob/Topic(href, href_list)

	if (href_list["mach_close"])
		var/t1 = text("window=[]", href_list["mach_close"])
		src.machine = null
		src << browse(null, t1)
	..()
	return

/mob/MouseDrop(mob/M as mob)

	..()
	if ((M != usr || usr == src || get_dist(usr, src) > 1))
		return
	src.show_inv(usr)
	return

/mob/las_act(flag)

	if (flag == "bullet")
		if (src.stat != 2)
			if (istype(src, /mob/human))
				var/mob/human/H = src
				var/dam_zone = pick("chest", "chest", "chest", "diaper", "head")
				if (H.organs[text("[]", dam_zone)])
					var/obj/item/weapon/organ/external/affecting = H.organs[text("[]", dam_zone)]
					if (affecting.take_damage(51, 0))
						H.UpdateDamageIcon()
					else
						H.UpdateDamage()
			else
				src.bruteloss += 51
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			if (prob(80))
				src.weakened = 2
	if (flag)
		if (prob(75))
			src.stunned = 10
		else
			src.weakened = 10
	else
		if (src.stat != 2)
			if (istype(src, /mob/human))
				var/mob/human/H = src
				var/dam_zone = pick("chest", "chest", "chest", "diaper", "head")
				if (H.organs[text("[]", dam_zone)])
					var/obj/item/weapon/organ/external/affecting = H.organs[text("[]", dam_zone)]
					if (affecting.take_damage(20, 0))
						H.UpdateDamageIcon()
					else
						H.UpdateDamage()
			else
				src.bruteloss += 20
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			if (prob(25))
				src.stunned = 2
	return

/mob/ghost/proc/infest()

	return

/mob/ghost/Move()

	if (src.stunned)
		return
	. = ..()
	return

/mob/ghost/show_inv()

	return
	return

/mob/ghost/Bump()

	return
	return

/mob/ghost/UpdateClothing()

	for(var/i in src.overlays)
		src.overlays -= i
		//Foreach goto(17)
	if (src.wear_mask)
		if (istype(src.wear_mask, /obj/item/weapon/clothing/mask))
			var/t1 = src.wear_mask.s_istate
			if (!( t1 ))
				t1 = src.icon_state
			src.overlays += image("icon" = 'ghost.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = src.layer)
		src.wear_mask.screen_loc = "2,3"
	if (src.r_hand)
		var/t1 = src.r_hand.s_istate
		if (!( t1 ))
			t1 = src.icon_state
		src.overlays += image("icon" = 'r_items.dmi', "icon_state" = t1, "layer" = src.layer)
		src.r_hand.screen_loc = "1,2"
	if (src.l_hand)
		var/t1 = src.l_hand.s_istate
		if (!( t1 ))
			t1 = src.icon_state
		src.overlays += image("icon" = 'l_items.dmi', "icon_state" = t1, "layer" = src.layer)
		src.l_hand.screen_loc = "3,2"
	if (src.client)
		src.client.screen -= src.contents
		src.client.screen += src.contents
	return

/mob/ghost/Life()

	if (src.stat == 2)
		death()
		return
	src.canmove = 1
	src.lying = 1
	src.stat = 0
	if (src.weakened > 0)
		src.weakened--
		src.icon_state = "ghost"
	else
		src.icon_state = "blank"
	if (src.stunned > 0)
		src.stunned--
		src.canmove = 0
		for(var/obj/item/O in src)
			O.loc = src.loc
			O.layer = initial(O.layer)
			src.u_equip(O)
			//Foreach goto(109)
	if (src.health < 0)
		src.stat = 2
	return
	return

/mob/ghost/db_click()

	return
	return

/mob/ghost/equipped()

	return null
	return

/mob/ghost/m_delay()

	return -100.0
	return

/mob/ghost/reset_view()

	if (src.client)
		src.client.eye = src
	else
		return ..()
	return

/mob/ghost/las_act()

	return
	return

/mob/ghost/ex_act()

	return
	return

/mob/ghost/attack_hand(mob/M as mob)

	src.infest(M)
	return

/mob/ghost/attack_paw(mob/M as mob)

	src.infest(M)
	return

/mob/ghost/death()

	src.stunned = 1
	..()
	return

/mob/ghost/meteorhit()

	return
	return

/mob/ghost/restrained()

	return 0
	return

/mob/ghost/attackby(nothing, mob/M as mob)

	src.infest(M)
	return 0
	return

/mob/ghost/say(msg as text)

	if (!( msg ))
		return
	msg = stutter(msg)
	if (prob(25))
		msg = stars(msg)
	for(var/mob/M in hearers(null, null))
		M.show_message(msg, 2)
		//Foreach goto(58)
	return

/mob/monkey/New()

	spawn( 50 )
		if (!( src.primary ))
			var/t1 = rand(1000, 1500)
			dna_ident += t1
			if (dna_ident > 65536.0)
				dna_ident = rand(1, 1500)
			src.primary = new /obj/dna( null )
			src.primary.uni_identity = text("[]", dna_ident)
			while(length(src.primary.uni_identity) < 4)
				src.primary.uni_identity = text("0[]", src.primary.uni_identity)
			var/t2 = text("[]", rand(1, 256))
			if (length(t2) < 2)
				src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
			else
				src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
			t2 = text("[]", rand(1, 256))
			if (length(t2) < 2)
				src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
			else
				src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
			t2 = text("[]", rand(1, 256))
			if (length(t2) < 2)
				src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
			else
				src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
			t2 = text("[]", rand(1, 256))
			if (length(t2) < 2)
				src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
			else
				src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
			t2 = (src.gender == "male" ? text("[]", rand(1, 124)) : text("[]", rand(127, 250)))
			if (length(t2) < 2)
				src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
			else
				src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
			src.primary.spec_identity = "2B6696D2B127E5A4"
			src.primary.struc_enzyme = "CDEAF5B90AADBC6BA8033DB0A7FD613FA"
			src.primary.use_enzyme = "C8FFFE7EC09D80AEDEDB9A5A0B4085B61"
			src.primary.n_chromo = 16
			src.name = text("monkey ([])", copytext(md5(src.primary.uni_identity), 2, 6))
		return
	..()
	return

/mob/monkey/Bump(atom/movable/AM as mob|obj, yes)

	spawn( 0 )
		if ((!( yes ) || src.now_pushing))
			return
		..()
		if (!( istype(AM, /atom/movable) ))
			return
		if (!( src.now_pushing ))
			src.now_pushing = 1
			if (!( AM.anchored ))
				var/t = get_dir(src, AM)
				step(AM, t)
			src.now_pushing = null
		return
	return

/mob/monkey/Topic(href, href_list)

	if (href_list["mach_close"])
		var/t1 = text("window=[]", href_list["mach_close"])
		src.machine = null
		src << browse(null, t1)
	if ((href_list["item"] && !( usr.stat ) && !( usr.restrained() ) && get_dist(src, usr) <= 1))
		var/obj/equip_e/monkey/O = new /obj/equip_e/monkey(  )
		O.source = usr
		O.target = src
		O.item = usr.equipped()
		O.s_loc = usr.loc
		O.t_loc = src.loc
		O.place = href_list["item"]
		src.requests += O
		spawn( 0 )
			O.process()
			return
	..()
	return

/mob/monkey/meteorhit(obj/O as obj)

	for(var/mob/M in viewers(src, null))
		M.show_message(text("\red [] has been hit with by []", src, O), 1)
		//Foreach goto(19)
	if (src.health > 0)
		var/shielded = 0
		for(var/obj/item/weapon/shield/S in src)
			if (S.active)
				shielded = 1
			else
				//Foreach continue //goto(79)
		src.bruteloss += 30
		if ((O.icon_state == "flaming" && !( shielded )))
			src.fireloss += 40
		src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
	return

/mob/monkey/las_act(flag)

	if (flag == "bullet")
		if (src.stat != 2)
			src.bruteloss += 60
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			src.weakened = 10
	if (flag)
		if (prob(75))
			src.stunned = 15
		else
			src.weakened = 15
	else
		if (src.stat != 2)
			src.bruteloss += 20
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			if (prob(25))
				src.stunned = 1
	return

/mob/monkey/hand_p(mob/M as mob)

	if ((M.a_intent == "hurt" && !( istype(src.wear_mask, /obj/item/weapon/clothing/mask/muzzle) )))
		if ((prob(75) && src.health > 0))
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\red <B>The monkey has bit []!</B>", src), 1)
				//Foreach goto(63)
			var/damage = rand(1, 5)
			src.bruteloss += damage
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		else
			for(var/mob/O in viewers(src, null))
				O.show_message(text("\red <B>The monkey has attempted to bite []!</B>", src), 1)
				//Foreach goto(144)
	return

/mob/monkey/attack_paw(mob/M as mob)

	if (M.a_intent == "help")
		src.sleeping = 0
		src.resting = 0
		for(var/mob/O in viewers(src, null))
			O.show_message("\blue The monkey shakes the monkey trying to wake him up!", 1)
			//Foreach goto(47)
	else
		if ((M.a_intent == "hurt" && !( istype(src.wear_mask, /obj/item/weapon/clothing/mask/muzzle) )))
			if ((prob(75) && src.health > 0))
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <B>The monkey has bit the monkey!</B>", 1)
					//Foreach goto(130)
				var/damage = rand(1, 5)
				src.bruteloss += damage
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			else
				for(var/mob/O in viewers(src, null))
					O.show_message("\red <B>The monkey has attempted to bite the monkey!</B>", 1)
					//Foreach goto(209)
	return

/mob/monkey/attack_hand(mob/M as mob)

	if (M.a_intent == "help")
		src.sleeping = 0
		src.resting = 0
		for(var/mob/O in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\blue [] shakes the monkey trying to wake him up!", M), 1)
			//Foreach goto(47)
	else
		if (M.a_intent == "hurt")
			if ((prob(75) && src.health > 0))
				for(var/mob/O in viewers(src, null))
					if ((O.client && !( O.blinded )))
						O.show_message(text("\red <B>[] has punched the monkey!</B>", M), 1)
					//Foreach goto(135)
				var/damage = rand(5, 10)
				if (prob(40))
					damage = rand(10, 15)
					if (src.paralysis < 5)
						src.paralysis = rand(10, 15)
						spawn( 0 )
							for(var/mob/O in viewers(src, null))
								if ((O.client && !( O.blinded )))
									O.show_message(text("\red <B>[] has knocked out the monkey!</B>", M), 1)
								//Foreach goto(248)
							return
				src.bruteloss += damage
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			else
				for(var/mob/O in viewers(src, null))
					if ((O.client && !( O.blinded )))
						O.show_message(text("\red <B>[] has attempted to punch the monkey!</B>", M), 1)
					//Foreach goto(336)
		else
			if (M.a_intent == "grab")
				if (M == src)
					return
				var/obj/item/weapon/grab/G = new /obj/item/weapon/grab( M )
				G.assailant = M
				if (M.hand)
					M.l_hand = G
				else
					M.r_hand = G
				G.layer = 20
				G.affecting = src
				src.grabbed_by += G
				G.synch()
				for(var/mob/O in viewers(src, null))
					O.show_message(text("\red [] has grabbed the monkey passively!", M), 1)
					//Foreach goto(502)
			else
				if (!( src.paralysis ))
					if (prob(25))
						src.paralysis = 2
						for(var/mob/O in viewers(src, null))
							if ((O.client && !( O.blinded )))
								O.show_message(text("\red <B>[] has pushed down the monkey!</B>", M), 1)
							//Foreach goto(571)
					else
						drop_item()
						for(var/mob/O in viewers(src, null))
							if ((O.client && !( O.blinded )))
								O.show_message(text("\red <B>[] has disarmed the monkey!</B>", M), 1)
							//Foreach goto(638)
	return

/mob/monkey/Stat()

	..()
	statpanel("Status")
	stat(null, text("Intent: []", src.a_intent))
	stat(null, text("Move Mode: []", src.m_intent))
	return

/mob/monkey/UpdateClothing()

	..()
	for(var/i in src.overlays)
		src.overlays -= i
		//Foreach goto(21)
	if (!( src.lying ))
		src.icon_state = "monkey1"
	else
		src.icon_state = "monkey0"
	if (src.wear_mask)
		if (istype(src.wear_mask, /obj/item/weapon/clothing/mask))
			var/t1 = src.wear_mask.s_istate
			if (!( t1 ))
				t1 = src.wear_mask.icon_state
			src.overlays += image("icon" = 'monkey.dmi', "icon_state" = text("[][]", t1, (!( src.lying ) ? null : "2")), "layer" = src.layer)
		src.wear_mask.screen_loc = "2,3"
	if (src.r_hand)
		var/t1 = src.r_hand.s_istate
		if (!( t1 ))
			t1 = src.r_hand.icon_state
		src.overlays += image("icon" = 'r_items.dmi', "icon_state" = t1, "layer" = src.layer)
		src.r_hand.screen_loc = "1,2"
	if (src.l_hand)
		var/t1 = src.l_hand.s_istate
		if (!( t1 ))
			t1 = src.l_hand.icon_state
		src.overlays += image("icon" = 'l_items.dmi', "icon_state" = t1, "layer" = src.layer)
		src.l_hand.screen_loc = "3,2"
	if (src.back)
		if (!( src.lying ))
			src.overlays += image("icon" = 'monkey.dmi', "icon_state" = "back", "layer" = src.layer)
		else
			src.overlays += image("icon" = 'monkey.dmi', "icon_state" = "back2", "layer" = src.layer)
		src.back.screen_loc = "3,3"
	if (src.handcuffed)
		src.pulling = null
		if (!( src.lying ))
			src.overlays += image("icon" = 'monkey.dmi', "icon_state" = "handcuff1", "layer" = src.layer)
		else
			src.overlays += image("icon" = 'monkey.dmi', "icon_state" = "handcuff2", "layer" = src.layer)
	if (src.client)
		src.client.screen -= src.contents
		src.client.screen += src.contents
		src.client.screen -= src.hud_used.m_ints
		src.client.screen -= src.hud_used.mov_int
		if (src.i_select)
			if (src.intent)
				src.client.screen += src.hud_used.m_ints
				src.i_select.screen_loc = src.intent
			else
				src.i_select.screen_loc = null
		if (src.m_select)
			if (src.m_int)
				src.client.screen += src.hud_used.mov_int
				src.m_select.screen_loc = src.m_int
			else
				src.m_select.screen_loc = null
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			spawn( 0 )
				src.show_inv(M)
				return
		//Foreach goto(662)
	return

/mob/monkey/Login()

	if (banned.Find(src.ckey))
		//src.client = null
		del(src.client)
	src.client.screen -= main_hud.contents
	src.client.screen -= main_hud2.contents
	if (!( src.hud_used ))
		src.hud_used = main_hud
	src.next_move = 1
	if (!( src.rname ))
		src.rname = src.key
	src.oxygen = new /obj/screen( null )
	src.i_select = new /obj/screen( null )
	src.m_select = new /obj/screen( null )
	src.toxin = new /obj/screen( null )
	src.internals = new /obj/screen( null )
	src.mach = new /obj/screen( null )
	src.fire = new /obj/screen( null )
	src.healths = new /obj/screen( null )
	src.pullin = new /obj/screen( null )
	src.blind = new /obj/screen( null )
	src.flash = new /obj/screen( null )
	src.hands = new /obj/screen( null )
	src.sleep = new /obj/screen( null )
	src.rest = new /obj/screen( null )
	..()
	UpdateClothing()
	src.oxygen.icon_state = "oxy0"
	src.i_select.icon_state = "selector"
	src.m_select.icon_state = "selector"
	src.toxin.icon_state = "toxin0"
	src.internals.icon_state = "internal0"
	src.mach.icon_state = null
	src.fire.icon_state = "fire0"
	src.healths.icon_state = "health0"
	src.pullin.icon_state = "pull0"
	src.blind.icon_state = "black"
	src.hands.icon_state = "hand"
	src.flash.icon_state = "blank"
	src.sleep.icon_state = "sleep0"
	src.rest.icon_state = "rest0"
	src.hands.dir = NORTH
	src.oxygen.name = "oxygen"
	src.i_select.name = "intent"
	src.m_select.name = "move"
	src.toxin.name = "toxin"
	src.internals.name = "internal"
	src.mach.name = "Reset Machine"
	src.fire.name = "fire"
	src.healths.name = "health"
	src.pullin.name = "pull"
	src.blind.name = " "
	src.hands.name = "hand"
	src.flash.name = "flash"
	src.sleep.name = "sleep"
	src.rest.name = "rest"
	src.oxygen.screen_loc = "15,12"
	src.i_select.screen_loc = "14,15"
	src.m_select.screen_loc = "14,14"
	src.toxin.screen_loc = "15,10"
	src.internals.screen_loc = "15,14"
	src.mach.screen_loc = "14,1"
	src.fire.screen_loc = "15,8"
	src.healths.screen_loc = "15,5"
	src.sleep.screen_loc = "15,3"
	src.rest.screen_loc = "15,2"
	src.pullin.screen_loc = "15,1"
	src.hands.screen_loc = "1,3"
	src.blind.screen_loc = "1,1 to 15,15"
	src.flash.screen_loc = "1,1 to 15,15"
	src.blind.layer = 0
	src.flash.layer = 17
	src.sleep.layer = 20
	src.rest.layer = 20
	src.client.screen.len = null
	src.client.screen -= list( src.oxygen, src.i_select, src.m_select, src.toxin, src.internals, src.fire, src.hands, src.healths, src.pullin, src.blind, src.flash, src.rest, src.sleep, src.mach )
	src.client.screen += list( src.oxygen, src.i_select, src.m_select, src.toxin, src.internals, src.fire, src.hands, src.healths, src.pullin, src.blind, src.flash, src.rest, src.sleep, src.mach )
	src.client.screen -= src.hud_used.adding
	src.client.screen += src.hud_used.adding
	src.client.screen -= src.hud_used.mon_blo
	src.client.screen += src.hud_used.mon_blo
	if (!( src.primary ))
		var/t1 = rand(1000, 1500)
		dna_ident += t1
		if (dna_ident > 65536.0)
			dna_ident = rand(1, 1500)
		src.primary = new /obj/dna( null )
		src.primary.uni_identity = text("[]", dna_ident)
		while(length(src.primary.uni_identity) < 4)
			src.primary.uni_identity = text("0[]", src.primary.uni_identity)
		var/t2 = text("[]", rand(1, 256))
		if (length(t2) < 2)
			src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
		else
			src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
		t2 = text("[]", rand(1, 256))
		if (length(t2) < 2)
			src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
		else
			src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
		t2 = text("[]", rand(1, 256))
		if (length(t2) < 2)
			src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
		else
			src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
		t2 = text("[]", rand(1, 256))
		if (length(t2) < 2)
			src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
		else
			src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
		t2 = (src.gender == "male" ? text("[]", rand(1, 124)) : text("[]", rand(127, 250)))
		if (length(t2) < 2)
			src.primary.uni_identity = text("[]0[]", src.primary.uni_identity, t2)
		else
			src.primary.uni_identity = text("[][]", src.primary.uni_identity, t2)
		src.primary.spec_identity = "2B6696D2B127E5A4"
		src.primary.struc_enzyme = "CDEAF5B90AADBC6BA8033DB0A7FD613FA"
		src.primary.use_enzyme = "C8FFFE7EC09D80AEDEDB9A5A0B4085B61"
		src.primary.n_chromo = 16
	if (!( src.start ))
		if ((src.key in list( "Thief jack", "Link43130", "Hutchy2k1", "Easty", "Exadv1" )))
			src.start = 1
			src.loc = locate(36, 67, 10)
		else
			src.start = 1
			var/A = locate(/area/start)
			var/list/L = list(  )
			for(var/T in A)
				L += T
				//Foreach goto(1473)
			src.loc = pick(L)
	src << browse('help.htm', "window=help")
	if (((src.key in list( "Exadv1", "Expert Advisor" )) || world.address == src.client.address || !( src.client.address )))
		src << text("\blue The game ip is byond://[]:[] !", world.address, world.port)
		src.verbs += /mob/proc/mute
		src.verbs += /mob/proc/changemessage
		src.verbs += /mob/proc/boot
		src.verbs += /mob/proc/changemode
		src.verbs += /mob/proc/show_ctf
		src.verbs += /mob/proc/restart
		src.verbs += /mob/proc/who
		src.verbs += /mob/proc/change_name
		src.verbs += /mob/proc/show_help
		src.verbs += /mob/proc/toggle_ooc
		src.verbs += /mob/proc/toggle_abandon
		src.verbs += /mob/proc/toggle_enter
		src.verbs += /mob/proc/toggle_shuttle
		src.verbs += /mob/proc/delay_start
		src.verbs += /mob/proc/make_gift
		src.verbs += /mob/proc/make_flag
		src.verbs += /mob/proc/make_pill
		src.verbs += /mob/proc/ban
		src.verbs += /mob/proc/unban
		src.verbs += /mob/proc/secrets
		src.verbs += /mob/proc/toggle_alter
		src.verbs += /mob/proc/carboncopy
		src.verbs += /mob/proc/list_dna
	src << text("\blue <B>[]</B>", world_message)
	if (!( isturf(src.loc) ))
		src.client.eye = src.loc
		src.client.perspective = EYE_PERSPECTIVE
	src.name = text("monkey ([])", copytext(md5(src.primary.uni_identity), 2, 6))
	return

/mob/monkey/Move()

	if ((!( src.buckled ) || src.buckled.loc != src.loc))
		src.buckled = null
	if (src.buckled)
		return
	if (src.restrained())
		src.pulling = null
	var/t7 = 1
	if (src.restrained())
		for(var/mob/M in range(src, 1))
			if ((M.pulling == src && M.stat == 0 && !( M.restrained() )))
				return 0
			//Foreach goto(93)
	if ((t7 && src.pulling && get_dist(src, src.pulling) <= 1))
		if (src.pulling.anchored)
			src.pulling = null
		var/T = src.loc
		. = ..()
		if (!( isturf(src.pulling.loc) ))
			src.pulling = null
			return
		if (!( src.restrained() ))
			var/diag = get_dir(src, src.pulling)
			if ((diag - 1) & diag)
			else
				diag = null
			if ((ismob(src.pulling) && (get_dist(src, src.pulling) > 1 || diag)))
				if (istype(src.pulling, src.type))
					var/mob/M = src.pulling
					var/mob/t = M.pulling
					M.pulling = null
					step(src.pulling, get_dir(src.pulling.loc, T))
					M.pulling = t
			else
				step(src.pulling, get_dir(src.pulling.loc, T))
	else
		src.pulling = null
		. = ..()
	if ((src.s_active && !( src.contents.Find(src.s_active) )))
		src.s_active.close(src)
	return

/mob/monkey/death()

	var/cancel
	if (src.healths)
		src.healths.icon_state = "health5"
	src.stat = 2
	src.canmove = 0
	if (src.blind)
		src.blind.layer = 0
	src.lying = 1
	src.icon_state = "dead"
	for(var/mob/M in world)
		if ((M.client && !( M.stat )))
			cancel = 1
		//Foreach goto(79)
	if (!( cancel ))
		world << "<B>Everyone is dead! Resetting in 30 seconds!</B>"
		if ((ticker && ticker.timing))
			ticker.check_win()
		else
			spawn( 300 )
				world.Reboot()
				return
	return ..()
	return

/mob/monkey/Life()
	set background = 1
	var/plcheck
	var/oxcheck
	var/ficheck

	var/turf/T = src.loc
	if (!( locate(/obj/table, src.loc) ))
		src.layer = MOB_LAYER
	src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
	if (src.stat != 2)
		src.t_sl_gas = 0
		src.t_n2 = 0
		if (!( src.m_flag ))
			src.last_move = null
		src.m_flag = null
		if (src.mach)
			if (src.machine)
				src.mach.icon_state = "mach1"
			else
				src.mach.icon_state = null
		if ((src.internal && !( src.contents.Find(src.internal) )))
			src.internal = null
		if ((!( src.wear_mask ) || !( src.wear_mask.flags | 8 )))
			src.internal = null
		if (istype(T, /turf))
			var/t = 1.4E-4
			if (src.health < 20)
				t = 5.0E-5
			else
				if (src.health < 40)
					t = 1.0E-4
			if (locate(/obj/move, T))
				T = locate(/obj/move, T)
			var/turf_total = T.oxygen + T.poison + T.sl_gas + T.co2 + T.n2
			var/obj/substance/gas/G = new /obj/substance/gas(  )
			G.maximum = 10000
			if (src.internal)
				src.internal.process(src, G)
				if (src.wear_mask.flags & 4)
					G.turf_add(T, G.tot_gas() * 0.5)
					G.turf_take(T, t / 2 * turf_total - G.tot_gas())
			else
				G.turf_take(T, t * turf_total)
			src.aircheck(G)
			plcheck = src.t_plasma
			oxcheck = src.t_oxygen
			G.turf_add(T, G.tot_gas())
			ficheck = src.firecheck(T)
		else
			if (istype(T, /obj))
				var/obj/O = T
				O.alter_health(src)
		if ((istype(src.loc, /turf/space) && !( locate(/obj/move, src.loc) )))
			var/layers = 20
			if ((istype(src.wear_mask, /obj/item/weapon/clothing/mask) && !( src.wear_mask.flags & 4 ) && src.flags & 8))
				layers -= 5
			if (layers > oxcheck)
				oxcheck = layers
		if ((plcheck && src.health >= 0))
			if ((src.paralysis <= 0 || src.weakened <= 0))
				src.toxloss += plcheck
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			else
				src.toxloss += plcheck
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if ((oxcheck && src.health >= 0))
			if ((src.paralysis <= 0 || src.weakened <= 0))
				src.oxyloss += oxcheck
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			else
				src.oxyloss += oxcheck
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		else
			if (src.health >= 0)
				if (src.oxyloss >= 10)
					var/amount = max(0.15, 1)
					src.oxyloss -= amount
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
				else
					src.oxyloss = 0
		if (ficheck)
			src.fireloss += ficheck * 10
			src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if (src.health <= -100.0)
			death()
		else
			if ((src.sleeping || src.health < 0))
				if (prob(1))
					if (src.health <= 20)
						spawn( 0 )
							emote("gasp")
							return
					else
						spawn( 0 )
							emote("snore")
							return
				if (src.health < 0)
					if (src.rejuv <= 0)
						src.oxyloss++
						src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
				src.stat = 1
				if (src.paralysis < 5)
					src.paralysis = 5
			else
				if (src.resting)
					if (src.weakened < 5)
						src.weakened = 5
				else
					if (src.health < 20)
						if (prob(5))
							if (prob(1))
								if (src.health <= 20)
									spawn( 0 )
										emote("gasp")
										return
							src.stat = 1
							if (src.paralysis < 2)
								src.paralysis = 2
		if (src.rejuv > 0)
			src.rejuv--
		if (src.r_epil > 0)
			src.r_epil--
		if (src.r_ch_cou > 0)
			src.r_ch_cou--
		if (src.r_Tourette > 0)
			src.r_Tourette--
		if (src.antitoxs > 0)
			src.antitoxs--
			if (src.plasma > 0)
				src.antitoxs -= 4
		if (src.plasma > 0)
			src.plasma--
		src.blinded = null
		if (src.drowsyness > 0)
			src.drowsyness--
			if (src.paralysis > 1)
				src.drowsyness -= 0.5
			else
				if (src.weakened > 1)
					src.drowsyness -= 0.25
			src.eye_blurry = max(2, src.eye_blurry)
			if (prob(5))
				src.sleeping = 1
				src.paralysis = 5
			if ((src.health > -10.0 && src.drowsyness > 1200))
				if (src.antitoxs < 1)
					src.toxloss += plcheck
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
		var/mental_danger = 0
		if (((src.r_epil > 0 && !( src.disabilities & 2 )) || (src.r_Tourette > 0 && !( src.disabilities & 8 ))))
			src.stuttering = max(2, src.drowsyness)
			mental_danger = 1
			src.drowsyness = max(2, src.drowsyness)
			if (!( src.paralysis ))
				if (prob(5))
					src << "\red You have a seizure!"
					src.paralysis = 10
				else
					if (prob(5))
						spawn( 0 )
							emote("twitch")
							return
						src.stunned = 10
					else
						if (prob(30))
							spawn( 0 )
								emote("drool")
								return
		if (src.health > -10.0)
			var/threshold = 45
			if (mental_danger)
				threshold = 15
			if (src.r_ch_cou > 2700)
				if (src.antitoxs < 1)
					src.toxloss += 1
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
					if (prob(15))
						spawn( 0 )
							emote("twitch")
							src.stunned = 2
							return
			if (src.r_epil > threshold * 60)
				if (src.antitoxs < 1)
					src.toxloss += 1
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
					if (prob(15))
						spawn( 0 )
							emote("twitch")
							src.stunned = 2
							return
			if (src.r_Tourette > threshold * 60)
				if (src.antitoxs < 1)
					src.toxloss += 1
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
					if (prob(15))
						spawn( 0 )
							emote("twitch")
							src.stunned = 2
							return
			if (src.antitoxs > 7200)
				src.toxloss += 1
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
				plcheck = 1
				if (prob(15))
					spawn( 0 )
						emote("drool")
						return
		if (src.health > -50.0)
			if (src.plasma > 0)
				if (src.antitoxs < 1)
					src.toxloss += 1
					src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
					plcheck = 1
					if (prob(15))
						spawn( 0 )
							emote("moan")
							return
		if (src.stat != 2)
			if (src.paralysis + src.stunned + src.weakened > 0)
				if (src.stunned > 0)
					src.stunned--
					src.stat = 0
				if (src.weakened > 0)
					src.weakened--
					src.lying = 1
					src.stat = 0
				if (src.paralysis > 0)
					src.paralysis--
					src.blinded = 1
					src.lying = 1
					src.stat = 1
				src.canmove = 0
				var/h = src.hand
				src.hand = 0
				drop_item()
				src.hand = 1
				drop_item()
				src.hand = h
			else
				src.canmove = 1
				src.lying = 0
				src.stat = 0
	else
		src.lying = 1
		src.blinded = 1
		src.stat = 2
		src.canmove = 0
	var/add_weight = 0
	if (istype(src.l_hand, /obj/item/weapon/grab))
		add_weight += 1250000.0
	if (istype(src.r_hand, /obj/item/weapon/grab))
		add_weight += 1250000.0
	if (locate(/obj/item/weapon/grab, src.grabbed_by))
		var/a_grabs = 0
		for(var/obj/item/weapon/grab/G in src.grabbed_by)
			G.process()
			if (G)
				if (G.state > 1)
					a_grabs++
					if ((G.state > 2 && src.loc == G.assailant.loc))
						src.density = 0
						src.lying = 0
						switch(G.assailant.dir)
							if(1.0)
								src.pixel_y = 8
							if(2.0)
								src.pixel_y = -8.0
							if(4.0)
								src.pixel_x = 8
							if(8.0)
								src.pixel_x = -8.0

			//Foreach goto(2333)
		src.weight = ((src.grabbed_by.len - a_grabs) / 2 + 1) * 1250000.0 + (a_grabs * 2500000.0)
	else
		if (src.lying)
			src.weight = add_weight + 2500000.0
		else
			src.weight = add_weight + 1250000.0
	if (src.stuttering > 0)
		src.stuttering--
	if (src.eye_blind > 0)
		src.eye_blind--
		src.blinded = 1
	if (src.ear_deaf > 0)
		src.ear_deaf--
	else
		if (src.ear_damage < 25)
			src.ear_damage -= 0.05
			src.ear_damage = max(src.ear_damage, 0)
	if (src.buckled)
		src.lying = 0
	src.density = !( src.lying )
	if (src.lying)
		src.weight = 5000000.0
	else
		src.weight = 2500000.0
	if (src.sdisabilities & 1)
		src.blinded = 1
	if (src.eye_blurry > 0)
		src.eye_blurry--
		src.eye_blurry = max(0, src.eye_blurry)
	if (src.client)
		src.client.screen -= main_hud.g_dither
		if (istype(src.wear_mask, /obj/item/weapon/clothing/mask/gasmask))
			src.client.screen += main_hud.g_dither
		if (src.mach)
			if (src.machine)
				src.mach.icon_state = "mach1"
			else
				src.mach.icon_state = "blank"
		if (src.sleep)
			src.sleep.icon_state = text("sleep[]", src.sleeping)
		if (src.rest)
			src.rest.icon_state = text("rest[]", src.resting)
		if (src.healths)
			if (src.stat < 2)
				if (src.health >= 100)
					src.healths.icon_state = "health0"
				else
					if (src.health >= 75)
						src.healths.icon_state = "health1"
					else
						if (src.health >= 50)
							src.healths.icon_state = "health2"
						else
							if (src.health > 20)
								src.healths.icon_state = "health3"
							else
								src.healths.icon_state = "health4"
			else
				src.healths.icon_state = "health5"
		if (src.pullin)
			if (src.pulling)
				src.pullin.icon_state = "pull1"
			else
				src.pullin.icon_state = "pull0"
		if (src.fire)
			if (ficheck)
				src.fire.icon_state = "fire1"
			else
				src.fire.icon_state = "fire0"
		if (src.toxin)
			if (plcheck)
				src.toxin.icon_state = "toxin1"
			else
				src.toxin.icon_state = "toxin0"
		if (src.oxygen)
			if (oxcheck)
				src.oxygen.icon_state = "oxy1"
			else
				src.oxygen.icon_state = "oxy0"
		src.client.screen -= src.hud_used.blurry
		src.client.screen -= src.hud_used.vimpaired
		if ((src.blind && src.stat != 2))
			if (src.blinded)
				src.blind.layer = 18
			else
				src.blind.layer = 0
				if (src.eye_blurry)
					src.client.screen -= src.hud_used.blurry
					src.client.screen += src.hud_used.blurry
				else
					src.client.screen -= src.hud_used.blurry
		if (src.stat != 2)
			if (src.machine)
				if (!( src.machine.check_eye(src) ))
					src.reset_view(null)
			else
				reset_view(null)
	else
		if ((src.canmove && prob(10) && isturf(src.loc)))
			step(src, pick(NORTH, SOUTH, EAST, WEST))
			if (prob(10))
				src.emote(pick("drool", "chimper", "scratch", "tail", "sit", "jump"))
			else
				if (prob(10))
					var/mob/human/H = locate(/mob/human, oview(1, null))
					if (istype(H, /mob/human))
						src.a_intent = "hurt"
						spawn( 0 )
							H.attack_paw(src)
							return
	if (src.primary)
		src.primary.cleanup()
	src.UpdateClothing()
	src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
	return

/mob/monkey/verb/removeinternal()

	src.internal = null
	return

/mob/monkey/proc/aircheck(obj/substance/gas/G as obj)

	src.t_oxygen = 0
	src.t_plasma = 0
	if (G)
		var/a_oxygen = G.oxygen * 0.7
		var/a_plasma = G.plasma
		var/a_sl_gas = G.sl_gas * 0.7
		G.oxygen -= a_oxygen
		G.plasma -= a_plasma
		G.sl_gas -= a_sl_gas
		if (a_oxygen < 67.032)
			src.t_oxygen = round((67.032 - a_oxygen) / 5)
		if (G.co2 > 5)
			var/t = round((G.co2 - 5) / 5)
			if (G.co2 > 25)
				src.paralysis = max(src.paralysis, 3)
				if (G.co2 > 50)
					t = 50
			src.t_oxygen = max(src.t_oxygen, t)
		if (a_plasma > 5)
			src.t_plasma = round((src.t_plasma - 5) / 10) + 1
		if (a_sl_gas > 10)
			src.weakened = max(src.weakened, 3)
			if (G.co2 > 40)
				src.paralysis = max(src.paralysis, 3)
		G.co2 += a_oxygen * 0.6
	return

/mob/monkey/proc/firecheck(turf/T as turf)

	if (T.firelevel < 900000.0)
		return 0
	var/total = 0
	if (src.wear_mask)
		if (T.firelevel > src.wear_mask.s_fire)
			total += 0.25
	else
		total += 0.25
	return total
	return

/mob/monkey/proc/emote(act)

	var/param = null
	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
		param = copytext(act, t1 + 1, length(act) + 1)
		act = copytext(act, 1, t1)
	var/muzzled = istype(src.wear_mask, /obj/item/weapon/clothing/mask/muzzle)
	var/m_type = 1
	var/message

	switch(act)
		if("sign")
			if (!( src.restrained() ))
				message = text("<B>The monkey</B> signs[].", (text2num(param) ? text(" the number []", text2num(param)) : null))
				m_type = 1
		if("scratch")
			if (!( src.restrained() ))
				message = "<B>The monkey</B> scratches."
				m_type = 1
		if("whimper")
			if (!( muzzled ))
				message = "<B>The monkey</B> whimpers."
				m_type = 2
		if("roar")
			if (!( muzzled ))
				message = "<B>The monkey</B> roars."
				m_type = 2
		if("tail")
			message = "<B>The monkey</B> waves his tail."
			m_type = 1
		if("gasp")
			message = "<B>The monkey</B> gasps."
			m_type = 2
		if("drool")
			message = "<B>The monkey</B> drools."
			m_type = 1
		if("paw")
			if (!( src.restrained() ))
				message = "<B>The monkey</B> flails his paw."
				m_type = 1
		if("scretch")
			if (!( muzzled ))
				message = "<B>The monkey</B> scretches."
				m_type = 2
		if("choke")
			message = "<B>The monkey</B> chokes."
			m_type = 2
		if("moan")
			message = "<B>The monkey</B> moans!"
			m_type = 2
		if("nod")
			message = "<B>The monkey</B> nods his head."
			m_type = 1
		if("sit")
			message = "<B>The monkey</B> sits down."
			m_type = 1
		if("sway")
			message = "<B>The monkey</B> sways around dizzily."
			m_type = 1
		if("sulk")
			message = "<B>The monkey</B> sulks down sadly."
			m_type = 1
		if("twitch")
			message = "<B>The monkey</B> twitches violently."
			m_type = 1
		if("dance")
			if (!( src.restrained() ))
				message = "<B>The monkey</B> dances around happily."
				m_type = 1
		if("roll")
			if (!( src.restrained() ))
				message = "<B>The monkey</B> rolls."
				m_type = 1
		if("shake")
			message = "<B>The monkey</B> shakes his head."
			m_type = 1
		if("gnarl")
			if (!( muzzled ))
				message = "<B>The monkey</B> gnarls and shows his teeth.."
				m_type = 2
		if("jump")
			message = "<B>The monkey</B> jumps!"
			m_type = 1
		if("help")
			src << "choke, dance, drool, gasp, gnarl, jump, paw, moan, nod, roar, roll, scratch,\nscretch, shake, sign-#, sit, sulk, sway, tail, twitch, whimper"
		else
			src << text("Invalid Emote: []", act)
	if ((message && src.stat == 0))
		if (m_type & 1)
			for(var/mob/O in viewers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(703)
		else
			for(var/mob/O in hearers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(746)
	return

/mob/monkey/say(message as text)

	if (src.muted)
		return
	message = copytext(message, 1, 128)
	if (src.stat == 2)
		for(var/mob/M in world)
			if (M.stat == 2)
				M << text("<B>[]</B> []: []", src, (src.stat > 1 ? "\[<I>dead</I> \]" : ""), message)
			//Foreach goto(50)
		return
	if ((copytext(message, 1, 2) == "*" && !( src.stat )))
		src.emote(copytext(message, 2, length(message) + 1))
		return
	if ((!( message ) || istype(src.wear_mask, /obj/item/weapon/clothing/mask/muzzle)))
		return
	if (src.stat < 2)
		var/list/L = list(  )
		var/pre = copytext(message, 1, 4)
		var/italics = 0
		var/obj_range = null
		if (pre == "\[r\]")
			message = copytext(message, 4, length(message) + 1)
			if (src.r_hand)
				src.r_hand.talk_into(usr, message)
			L += hearers(1, null)
			italics = 1
			obj_range = 1
		else
			if (pre == "\[l\]")
				message = copytext(message, 4, length(message) + 1)
				if (src.l_hand)
					src.l_hand.talk_into(usr, message)
				L += hearers(1, null)
				italics = 1
				obj_range = 1
			else
				if (pre == "\[w\]")
					message = copytext(message, 4, length(message) + 1)
					L += hearers(1, null)
					italics = 1
					obj_range = 1
				else
					L += hearers(null, null)
					pre = null
		L -= src
		L += src
		if (italics)
			message = text("<I>[]</I>", message)
		for(var/mob/M in L)
			if (istype(M, src.type))
				M.show_message(text("<B>[]</B>: []", src, message), 2)
			else
				M.show_message(text("<B>[]</B> chimpers.", src), 2)
			//Foreach goto(503)
		for(var/obj/O in view(obj_range, null))
			spawn( 0 )
				if (O)
					O.hear_talk(usr, message)
				return
			//Foreach goto(580)
	for(var/mob/M in world)
		if (M.stat > 1)
			M << text("<B>[]</B> []: []", src, (src.stat > 1 ? "\[<I>dead</I> \]" : ""), message)
		//Foreach goto(637)
	return

/mob/monkey/examine()
	set src in oview()

	usr << "\blue *---------*"
	usr << text("\blue This is \icon[] <B>[]</B>!", src, src.name)
	if (src.handcuffed)
		usr << text("\blue \t[] is handcuffed! \icon[]", src.name, src.handcuffed)
	if (src.wear_mask)
		usr << text("\blue \t[] has a \icon[] [] on \his[] head!", src.name, src.wear_mask, src.wear_mask.name, src)
	if (src.l_hand)
		usr << text("\blue \t[] has a \icon[] [] in \his[] left hand!", src.name, src.l_hand, src.l_hand.name, src)
	if (src.r_hand)
		usr << text("\blue [] has a \icon[] [] in \his[] right hand!", src.name, src.r_hand, src.r_hand.name, src)
	if (src.back)
		usr << text("\blue [] has a \icon[] [] on \his[] back!", src.name, src.back, src.back.name, src)
	if (src.bruteloss)
		if (src.bruteloss < 30)
			usr << text("\red [] looks slightly bruised!", src.name)
		else
			usr << text("\red <B>[] looks severely bruised!</B>", src.name)
	if (src.fireloss)
		if (src.fireloss < 30)
			usr << text("\red [] looks slightly burnt!", src.name)
		else
			usr << text("\red <B>[] looks severely burnt!</B>", src.name)
	return

/mob/monkey/ex_act(severity)

	flick("flash", src.flash)
	switch(severity)
		if(1.0)
			if (src.stat != 2)
				src.bruteloss += 200
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if(2.0)
			if (src.stat != 2)
				src.bruteloss += 60
				src.fireloss += 60
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
		if(3.0)
			if (src.stat != 2)
				src.bruteloss += 30
				src.health = 100 - src.oxyloss - src.toxloss - src.fireloss - src.bruteloss
			if (prob(50))
				src.paralysis += 10
		else
	return

/atom/movable/Move(NewLoc, direct)

	if (direct & direct - 1)
		if (direct & 1)
			if (direct & 4)
				if (step(src, NORTH))
					step(src, EAST)
				else
					if (step(src, EAST))
						step(src, NORTH)
			else
				if (direct & 8)
					if (step(src, NORTH))
						step(src, WEST)
					else
						if (step(src, WEST))
							step(src, NORTH)
		else
			if (direct & 2)
				if (direct & 4)
					if (step(src, SOUTH))
						step(src, EAST)
					else
						if (step(src, EAST))
							step(src, SOUTH)
				else
					if (direct & 8)
						if (step(src, SOUTH))
							step(src, WEST)
						else
							if (step(src, WEST))
								step(src, SOUTH)
	else
		..()
	return

/atom/movable/verb/pull()
	set src in oview(1)

	if (!( usr ))
		return
	if (!( src.anchored ))
		usr.pulling = src
	return

/atom/verb/examine()
	set src in oview(1)

	if (!( usr ))
		return
	usr << src.desc
	// *****RM
	//usr << "[src.name]: Dn:[density] dir:[dir] cont:[contents] icon:[icon] is:[icon_state] loc:[loc]"
	return

/client/Northeast()

	src.mob.swap_hand()
	return

/client/Southeast()

	var/obj/item/weapon/W = src.mob.equipped()
	if (W)
		W.attack_self(src.mob)
	return

/client/Northwest()

	src.mob.drop_item_v()
	return

/client/Southwest()

	src.mob.throw_item_v()
	return

/client/Center()

	if (isobj(src.mob.loc))
		var/obj/O = src.mob.loc
		if (src.mob.canmove)
			return O.relaymove(src.mob, 16)
	return

/client/Move(n, direct)

	if (src.moving)
		return 0
	if (world.time < src.move_delay)
		return
	if (!( src.mob ))
		return
	if (src.mob.stat == 2)
		return
	if (src.mob.monkeyizing)
		return
	var/is_monkey = istype(src.mob, /mob/monkey)
	if (locate(/obj/item/weapon/grab, locate(/obj/item/weapon/grab, src.mob.grabbed_by.len)))
		var/list/grabbing = list(  )
		if (istype(src.mob.l_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.mob.l_hand
			grabbing += G.affecting
		if (istype(src.mob.r_hand, /obj/item/weapon/grab))
			var/obj/item/weapon/grab/G = src.mob.r_hand
			grabbing += G.affecting
		for(var/obj/item/weapon/grab/G in src.mob.grabbed_by)
			if (G.state == 1)
				if (!( grabbing.Find(G.assailant) ))
					//G = null
					del(G)
			else
				if (G.state == 2)
					src.move_delay = world.time + 10
					if ((prob(25) && (!( is_monkey ) || prob(25))))
						for(var/mob/O in viewers(src.mob, null))
							O.show_message(text("\red [] has broken free of []'s grip!", src.mob, G.assailant), 1)
							//Foreach goto(309)
						//G = null
						del(G)
					else
						return
				else
					if (G.state == 2)
						src.move_delay = world.time + 10
						if ((prob(5) && !( is_monkey ) || prob(25)))
							for(var/mob/O in viewers(src.mob, null))
								O.show_message(text("\red [] has broken free of []'s headlock!", src.mob, G.assailant), 1)
								//Foreach goto(423)
							//G = null
							del(G)
						else
							return
			//Foreach goto(189)
	if (src.mob.canmove)
		var/j_pack = 0
		if ((istype(src.mob.loc, /turf/space) && !( locate(/obj/move, src.mob.loc) )))
			if (!( src.mob.restrained() ))
				if (!( (locate(/obj/grille, oview(1, src.mob)) || locate(/turf/station, oview(1, src.mob))) ))
					if (istype(src.mob.back, /obj/item/weapon/tank/jetpack))
						var/obj/item/weapon/tank/jetpack/J = src.mob.back
						j_pack = J.allow_thrust(100, src.mob)
						var/obj/effects/sparks/ion_trails/I = new /obj/effects/sparks/ion_trails( src.mob.loc )
						flick("ion_fade", I)
						I.icon_state = "blank"
						spawn( 20 )
							//I = null
							del(I)
							return
						if (!( j_pack ))
							return 0
					else
						return 0
			else
				return 0


		if (isturf(src.mob.loc))
			src.move_delay = world.time
			if ((j_pack && j_pack < 1))
				src.move_delay += 5
			switch(src.mob.m_intent)
				if("run")
					if (src.mob.drowsyness > 0)
						src.move_delay += 6
					src.move_delay += 1
				if("face")
					src.mob.dir = direct
					return
				if("walk")
					src.move_delay += 7


			src.move_delay += src.mob.m_delay()

			src.move_delay += round((100 - src.mob.health) / 20)		//*****RM fix

			if (src.mob.restrained())
				for(var/mob/M in range(src.mob, 1))
					if (((M.pulling == src.mob && (!( M.restrained() ) && M.stat == 0)) || locate(/obj/item/weapon/grab, src.mob.grabbed_by.len)))
						src << "\blue You're restrained! You can't move!"
						return 0
					//Foreach goto(853)
			src.moving = 1
			if (locate(/obj/item/weapon/grab, src.mob))
				src.move_delay = max(src.move_delay, world.time + 7)
				var/list/L = src.mob.ret_grab()
				if (istype(L, /list))
					if (L.len == 2)
						L -= src.mob
						var/mob/M = L[1]
						if ((get_dist(src.mob, M) <= 1 || M.loc == src.mob.loc))
							var/turf/T = src.mob.loc
							. = ..()
							if (isturf(M.loc))
								var/diag = get_dir(src.mob, M)
								if ((diag - 1) & diag)
								else
									diag = null
								if ((get_dist(src.mob, M) > 1 || diag))
									step(M, get_dir(M.loc, T))
					else
						for(var/mob/M in L)
							M.other_mobs = 1
							if (src.mob != M)
								M.animate_movement = 3
							//Foreach goto(1163)
						for(var/mob/M in L)
							spawn( 0 )
								step(M, direct)
								return
							spawn( 1 )
								M.other_mobs = null
								M.animate_movement = 1
								return
							//Foreach goto(1214)
			else
				. = ..()
			src.moving = null
			return .
		else
			if (isobj(src.mob.loc))
				var/obj/O = src.mob.loc
				if (src.mob.canmove)
					return O.relaymove(src.mob, direct)
	else
		return
	return

/client/proc/show_panel()

	if (src.holder)
		src.holder.update()
	return

/client/New()

	if (banned.Find(src.ckey))
		//SN src = null
		del(src)
		return
	world << text("<B>[] has logged in!</B>", src)
	if (((world.address == src.address || !( src.address )) && !( host )))
		host = src.key
		world.update_stat()
	..()
	spawn( 50 )
		if (admins.Find(src.ckey))
			src.holder = new /obj/admins( src )
			src.holder.rank = admins[text("[]", src.ckey)]
			switch(admins[text("[]", src.ckey)])
				if("Primary Administrator")
					src.holder.level = 5
				if("Master Administrator")
					src.holder.level = 4
				if("Administrator")
					src.holder.level = 3
				if("Supervisor")
					src.holder.level = 2
				if("Moderator")
					src.holder.level = 1
				if("Game Master")
					src.holder.level = 0
				if("Banned")
					//SN src = null
					del(src)
					return
				else
					//src.holder = null
					del(src.holder)
			if (src.holder)
				src.holder.owner = src
				src.verbs += /client/proc/show_panel
		return
	return

/client/Del()

	if (banned.Find(src.ckey))
		..()
		return
	world << text("<B>[] has logged out!</B>", src)
	..()
	//src.holder = null
	del(src.holder)
	return
