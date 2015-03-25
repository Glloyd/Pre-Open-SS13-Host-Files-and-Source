
/obj/move/airtunnel/process()

	if (!( src.deployed ))
		return null
	else
		..()
	return

/obj/move/airtunnel/connector/create()

	src.current = src
	src.next = new /obj/move/airtunnel( null )
	src.next.master = src.master
	src.next.previous = src
	spawn( 0 )
		src.next.create(36, src.y)
		return
	return

/obj/move/airtunnel/connector/wall/create()

	src.current = src
	src.next = new /obj/move/airtunnel/wall( null )
	src.next.master = src.master
	src.next.previous = src
	spawn( 0 )
		src.next.create(36, src.y)
		return
	return

/obj/move/airtunnel/connector/wall/process()

	return

/obj/move/airtunnel/wall/create(num, y_coord)

	if (((num < 7 || (num > 14 && num < 21)) && y_coord == 72))
		src.next = new /obj/move/airtunnel( null )
	else
		src.next = new /obj/move/airtunnel/wall( null )
	src.next.master = src.master
	src.next.previous = src
	if (num > 1)
		spawn( 0 )
			src.next.create(num - 1, y_coord)
			return
	return

/obj/move/airtunnel/wall/move_right()

	flick("wall-m", src)
	return ..()
	return

/obj/move/airtunnel/wall/move_left()

	flick("wall-m", src)
	return ..()
	return

/obj/move/airtunnel/wall/process()

	return

/obj/move/airtunnel/proc/move_left()

	src.relocate(get_step(src, WEST))
	if ((src.next && src.next.deployed))
		return src.next.move_left()
	else
		return src.next
	return

/obj/move/airtunnel/proc/move_right()

	src.relocate(get_step(src, EAST))
	if ((src.previous && src.previous.deployed))
		src.previous.move_right()
	return src.previous
	return

/obj/move/airtunnel/proc/create(num, y_coord)

	if (y_coord == 72)
		if ((num < 7 || (num > 14 && num < 21)))
			src.next = new /obj/move/airtunnel( null )
		else
			src.next = new /obj/move/airtunnel/wall( null )
	else
		src.next = new /obj/move/airtunnel( null )
	src.next.master = src.master
	src.next.previous = src
	if (num > 1)
		spawn( 0 )
			src.next.create(num - 1, y_coord)
			return
	return

/obj/machinery/at_indicator/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				for(var/x in src.verbs)
					src.verbs -= x
					//Foreach goto(58)
				src.icon_state = "reader_broken"
		if(3.0)
			if (prob(25))
				for(var/x in src.verbs)
					src.verbs -= x
					//Foreach goto(109)
				src.icon_state = "reader_broken"
		else
	return

/obj/machinery/at_indicator/proc/update_icon()

	var/status = 0
	if (SS13_airtunnel.operating == 1)
		status = "r"
	else
		if (SS13_airtunnel.operating == 2)
			status = "e"
		else
			var/obj/move/airtunnel/connector/C = pick(SS13_airtunnel.connectors)
			if (C.current == C)
				status = 0
			else
				if (!( C.current.next ))
					status = 2
				else
					status = 1
	src.icon_state = text("reader[][]", (SS13_airtunnel.siphon_status == 2 ? "1" : "0"), status)
	return

/obj/machinery/at_indicator/process()

	src.update_icon()
	return

/obj/machinery/computer/airtunnel/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				for(var/x in src.verbs)
					src.verbs -= x
					//Foreach goto(58)
				src.icon_state = "broken"
		if(3.0)
			if (prob(25))
				for(var/x in src.verbs)
					src.verbs -= x
					//Foreach goto(109)
				src.icon_state = "broken"
		else
	return

/obj/machinery/computer/airtunnel/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/computer/airtunnel/attack_hand(var/mob/user as mob)

	var/dat = "<HTML><BODY><TT><B>Air Tunnel Controls</B><BR>"
	user.machine = src
	if (SS13_airtunnel.operating == 1)
		dat += "<B>Status:</B> RETRACTING<BR>"
	else
		if (SS13_airtunnel.operating == 2)
			dat += "<B>Status:</B> EXPANDING<BR>"
		else
			var/obj/move/airtunnel/connector/C = pick(SS13_airtunnel.connectors)
			if (C.current == C)
				dat += "<B>Status:</B> Fully Retracted<BR>"
			else
				if (!( C.current.next ))
					dat += "<B>Status:</B> Fully Extended<BR>"
				else
					dat += "<B>Status:</B> Stopped Midway<BR>"
	dat += text("<A href='?src=\ref[];retract=1'>Retract</A> <A href='?src=\ref[];stop=1'>Stop</A> <A href='?src=\ref[];extend=1'>Extend</A><BR>", src, src, src)
	dat += text("<BR><B>Air Level:</B> []<BR>", (SS13_airtunnel.air_stat ? "Acceptable" : "DANGEROUS"))
	dat += "<B>Air System Status:</B> "
	switch(SS13_airtunnel.siphon_status)
		if(0.0)
			dat += "Stopped "
		if(1.0)
			dat += "Siphoning (Siphons only) "
		if(2.0)
			dat += "Regulating (BOTH) "
		if(3.0)
			dat += "RELEASING MAX (Siphons only) "
		else
	dat += text("<A href='?src=\ref[];refresh=1'>(Refresh)</A><BR>", src)
	dat += text("<A href='?src=\ref[];release=1'>RELEASE (Siphons only)</A> <A href='?src=\ref[];siphon=1'>Siphon (Siphons only)</A> <A href='?src=\ref[];stop_siph=1'>Stop</A> <A href='?src=\ref[];auto=1'>Regulate</A><BR>", src, src, src, src)
	dat += text("<BR><BR><A href='?src=\ref[];mach_close=computer'>Close</A></TT></BODY></HTML>", user)
	user << browse(dat, "window=computer;size=400x500")
	return

/obj/machinery/computer/airtunnel/proc/update_icon()

	var/status = 0
	if (SS13_airtunnel.operating == 1)
		status = "r"
	else
		if (SS13_airtunnel.operating == 2)
			status = "e"
		else
			var/obj/move/airtunnel/connector/C = pick(SS13_airtunnel.connectors)
			if (C.current == C)
				status = 0
			else
				if (!( C.current.next ))
					status = 2
				else
					status = 1
	src.icon_state = text("console[][]", (SS13_airtunnel.siphon_status >= 2 ? "1" : "0"), status)
	return

/obj/machinery/computer/airtunnel/process()

	src.update_icon()
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(27)
	return

/obj/machinery/computer/airtunnel/Topic(href, href_list)

	if ((!( istype(usr, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		usr << "\red You don't have the dexterity to do this!"
		return
	if ((usr.stat || usr.restrained()))
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["retract"])
			SS13_airtunnel.retract()
		else
			if (href_list["stop"])
				SS13_airtunnel.operating = 0
			else
				if (href_list["extend"])
					SS13_airtunnel.extend()
				else
					if (href_list["release"])
						SS13_airtunnel.siphon_status = 3
						SS13_airtunnel.siphons()
					else
						if (href_list["siphon"])
							SS13_airtunnel.siphon_status = 1
							SS13_airtunnel.siphons()
						else
							if (href_list["stop_siph"])
								SS13_airtunnel.siphon_status = 0
								SS13_airtunnel.siphons()
							else
								if (href_list["auto"])
									SS13_airtunnel.siphon_status = 2
									SS13_airtunnel.siphons()
								else
									if (href_list["refresh"])
										SS13_airtunnel.siphons()
		src.add_fingerprint(usr)
		for(var/mob/M in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
			//Foreach goto(346)
	return

/obj/machinery/camera/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wirecutters))
		src.status = !( src.status )
		if (!( src.status ))
			for(var/mob/O in viewers(user, null))
				O.show_message(text("\red [] has deactivated []!", user, src), 1)
				//Foreach goto(49)
			src.icon_state = "camera1"
		else
			for(var/mob/O in viewers(user, null))
				O.show_message(text("\red [] has reactivated []!", user, src), 1)
				//Foreach goto(106)
			src.icon_state = "camera"
	return


/obj/machinery/sec_lock/attack_paw(user as mob)

	return src.attack_hand(user)


/obj/machinery/sec_lock/attack_hand(var/mob/user as mob)

	if (src.loc == user.loc)
		var/dat = text("<B>Security Pad:</B><BR>\nKeycard: []<BR>\n<A href='?src=\ref[];door1=1'>Toggle Outer Door</A><BR>\n<A href='?src=\ref[];door2=1'>Toggle Inner Door</A><BR>\n<BR>\n<A href='?src=\ref[];em_cl=1'>Emergency Close</A><BR>\n<A href='?src=\ref[];em_op=1'>Emergency Open</A><BR>", (src.scan ? text("<A href='?src=\ref[];card=1'>[]</A>", src, src.scan.name) : text("<A href='?src=\ref[];card=1'>-----</A>", src)), src, src, src, src)
		user << browse(dat, "window=sec_lock")
	return

/obj/machinery/sec_lock/attackby(nothing, user as mob)

	return src.attack_hand(user)


/obj/machinery/sec_lock/New()

	..()
	spawn( 2 )
		if (src.a_type == 1)
			src.d2 = locate(/obj/machinery/door, locate(src.x - 2, src.y - 1, src.z))
			src.d1 = locate(/obj/machinery/door, get_step(src, SOUTHWEST))
		else
			if (src.a_type == 2)
				src.d2 = locate(/obj/machinery/door, locate(src.x - 2, src.y + 1, src.z))
				src.d1 = locate(/obj/machinery/door, get_step(src, NORTHWEST))
			else
				src.d1 = locate(/obj/machinery/door, get_step(src, SOUTH))
				src.d2 = locate(/obj/machinery/door, get_step(src, SOUTHEAST))
		return
	return

/obj/machinery/sec_lock/Topic(href, href_list)

	if ((!( istype(usr, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		usr << "\red You don't have the dexterity to do this!"
		return
	if ((usr.stat || usr.restrained()))
		return
	if ((!( src.d1 ) || !( src.d2 )))
		usr << "\red Error: Cannot interface with door security!"
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["card"])
			if (src.scan)
				src.scan.loc = src.loc
				src.scan = null
			else
				var/obj/item/weapon/card/id/I = usr.equipped()
				if (istype(I, /obj/item/weapon/card/id))
					usr.drop_item()
					I.loc = src
					src.scan = I
		if (href_list["door1"])
			if (src.scan)
				var/list/L = list( "Prison Security", "Prison Warden", "Security Officer", "Head of Personnel", "Captain" )
				if ((L.Find(src.scan.assignment) || (src.scan.lab_access > 4 && src.scan.access_level > 4)))
					if (src.d1.density)
						spawn( 0 )
							src.d1.open()
							return
					else
						spawn( 0 )
							src.d1.close()
							return
		if (href_list["door2"])
			if (src.scan)
				var/list/L = list( "Prison Security", "Prison Warden", "Security Officer", "Head of Personnel", "Captain" )
				if ((L.Find(src.scan.assignment) || (src.scan.lab_access > 4 && src.scan.access_level > 4)))
					if (src.d2.density)
						spawn( 0 )
							src.d2.open()
							return
					else
						spawn( 0 )
							src.d2.close()
							return
		if (href_list["em_cl"])
			if (src.scan)
				var/list.L = list( "Prison Security", "Prison Warden", "Security Officer", "Head of Personnel", "Captain" )
				if ((L.Find(src.scan.assignment) || (src.scan.lab_access > 4 && src.scan.access_level > 4)))
					spawn( 0 )
						if (!( src.d1.density ))
							src.d1.close()
						return
					sleep(1)
					spawn( 0 )
						if (!( src.d2.density ))
							src.d2.close()
						return
		if (href_list["em_op"])
			if (src.scan)
				var/list/L = list( "Prison Security", "Prison Warden", "Security Officer", "Head of Personnel", "Captain" )
				if ((L.Find(src.scan.assignment) || (src.scan.lab_access > 4 && src.scan.access_level > 4)))
					spawn( 0 )
						if (src.d1.density)
							src.d1.open()
						return
					sleep(1)
					spawn( 0 )
						if (src.d2.density)
							src.d2.open()
						return
		src.add_fingerprint(usr)
		for(var/mob/M in src.loc)
			if ((M.client && M.machine == src))
				spawn( 0 )
					src.attack_hand(M)
					return
			//Foreach goto(737)
	return

/obj/machinery/autolathe/attackby(var/obj/item/weapon/O as obj, var/mob/user as mob)

	if (istype(O, /obj/item/weapon/sheet/metal))
		if (src.m_amount < 150000.0)
			src.m_amount += O:height * O:width * O:length * 1000000.0
			O:amount--
			if (O:amount < 1)
				//O = null
				del(O)
	else
		if (istype(O, /obj/item/weapon/sheet/glass))
			if (src.g_amount < 75000.0)
				src.g_amount += O:height * O:width * O:length * 1000000.0
				O:amount--
				if (O:amount < 1)
					//O = null
					del(O)
		else
			if (istype(O, /obj/item/weapon/screwdriver))
				if (!( src.operating ))
					src.opened = !( src.opened )
					src.icon_state = text("autolathe[]", (src.opened ? "f" : null))
				else
					user << "\red The machine is in use. You can not maintain it now."
			else
				spawn( 0 )
					src.attack_hand(user)
					return
	return

/obj/machinery/autolathe/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/autolathe/attack_hand(user as mob)

	var/dat
	if (src.temp)
		dat = text("<TT>[]</TT><BR><BR><A href='?src=\ref[];temp=1'>Clear Screen</A>", src.temp, src)
	else
		dat = text("<B>Metal Amount:</B> [] cubic centimeters (MAX: 150,000)<BR>\n<FONT color = blue><B>Glass Amount:</B></FONT> [] cubic centimeters (MAX: 75,000)<HR>", src.m_amount, src.g_amount)
		var/list/L = list(  )
		L["screwdriver"] = "Make Screwdriver {40 cc}"
		L["wirecutters"] = "Make Wirecutters {80 cc}"
		L["wrench"] = "Make Wrench {150 cc}"
		L["crowbar"] = "Make Crowbar {150 cc}"
		L["screw"] = "Make Screw (1) {3 cc}"
		L["5screws"] = "Make Screws (5) {14 cc}"
		L["rod_t"] = "Make Rod (1x20) {20 cc}"
		L["rod_l"] = "Make Rod (5x250) {1250 cc}"
		L["grille_1"] = "Make Grille (250x250x1) {27345 cc}"
		L["sheet_1"] = "Make Sheet (20x10x.01) {2 cc}"
		L["sheet_2"] = "Make Sheet (30x10x.01) {3 cc}"
		L["sheet_3"] = "Make Sheet (30x20x.01) {6 cc}"
		L["sheet_4"] = "Make Sheet (30x30x.01) {9 cc}"
		L["sheet_5"] = "Make Sheet (62.5x62.5x4) {15625 cc}"
		for(var/t in L)
			dat += text("<A href='?src=\ref[];make=[]'>[]<BR>", src, t, L[text("[]", t)])
			//Foreach goto(230)
	user << browse(text("<HEAD><TITLE>Autolathe Control Panel</TITLE></HEAD><TT>[]</TT>", dat), "window=autolathe")
	return

/obj/machinery/autolathe/Topic(href, href_list)

	if ((usr.stat || usr.restrained()))
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["temp"])
			src.temp = null
		src.add_fingerprint(usr)
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(108)
	return

/obj/machinery/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				//SN src = null
				del(src)
				return
		if(3.0)
			if (prob(25))
				//SN src = null
				del(src)
				return
		else
	return

/obj/machinery/injector/attackby(var/obj/item/weapon/tank/W as obj, var/mob/user as mob)

	var/obj/item/weapon/tank/ptank = W
	if (!( istype(ptank, /obj/item/weapon/tank) ))
		return
	var/turf/T = get_step(src.loc, get_dir(user, src))
	ptank.gas.turf_add(T, -1.0)
	src.add_fingerprint(user)
	return

/obj/machinery/alarm/process()

	var/safe = 1
	var/turf/T = src.loc
	if (!( istype(T, /turf) ))
		return
	if (locate(/obj/move, T))
		T = locate(/obj/move, T)
	var/turf_total = T.co2 + T.oxygen + T.poison + T.sl_gas + T.n2
	turf_total = max(turf_total, 1)
	var/t1 = turf_total / 3600000.0 * 100
	if (!( (90 < t1 && t1 < 110) ))
		safe = 0
	t1 = T.oxygen / turf_total * 100
	if (!( (20 < t1 && t1 < 30) ))
		safe = 0
	src.icon_state = text("alarm:[]", !( safe ))
	return



/obj/machinery/alarm/indicator/process()

	var/safe = 1
	var/turf/T = src.loc
	if (!( istype(T, /turf) ))
		return
	if (locate(/obj/move, T))
		T = locate(/obj/move, T)
	var/turf_total = T.co2 + T.oxygen + T.poison + T.sl_gas + T.n2
	turf_total = max(turf_total, 1)
	var/t1 = turf_total / 3600000.0 * 100
	if (!( (90 < t1 && t1 < 110) ))
		safe = 0
	t1 = T.oxygen / turf_total * 100
	if (!( (20 < t1 && t1 < 30) ))
		safe = 0
	src.icon_state = text("indicator[]", safe)
	SS13_airtunnel.air_stat = safe
	return

/datum/air_tunnel/air_tunnel1/New()

	..()
	for(var/obj/move/airtunnel/A in locate(/area/airtunnel1))
		A.master = src
		A.create()
		src.connectors += A
		//Foreach goto(21)
	return

/datum/air_tunnel/proc/siphons()

	switch(src.siphon_status)
		if(0.0)
			for(var/obj/machinery/atmoalter/siphs/S in locate(/area/airtunnel1))
				S.t_status = 3
				//Foreach goto(42)
		if(1.0)
			for(var/obj/machinery/atmoalter/siphs/fullairsiphon/S in locate(/area/airtunnel1))
				S.t_status = 2
				S.t_per = 1000000.0
				//Foreach goto(86)
			for(var/obj/machinery/atmoalter/siphs/scrubbers/S in locate(/area/airtunnel1))
				S.t_status = 3
				//Foreach goto(136)
		if(2.0)
			for(var/obj/machinery/atmoalter/siphs/S in locate(/area/airtunnel1))
				S.t_status = 4
				//Foreach goto(180)
		if(3.0)
			for(var/obj/machinery/atmoalter/siphs/fullairsiphon/S in locate(/area/airtunnel1))
				S.t_status = 1
				S.t_per = 1000000.0
				//Foreach goto(224)
			for(var/obj/machinery/atmoalter/siphs/scrubbers/S in locate(/area/airtunnel1))
				S.t_status = 3
				//Foreach goto(274)
		else
	return

/datum/air_tunnel/proc/stop()

	src.operating = 0
	return

/datum/air_tunnel/proc/extend()

	if (src.operating)
		return
	src.operating = 2
	while(src.operating == 2)
		var/ok = 1
		for(var/obj/move/airtunnel/connector/A in src.connectors)
			if (!( A.current.next ))
				src.operating = 0
				return
			if (!( A.move_left() ))
				ok = 0
			//Foreach goto(56)
		if (!( ok ))
			src.operating = 0
		else
			for(var/obj/move/airtunnel/connector/A in src.connectors)
				if (A.current)
					A.current.next.loc = get_step(A.current.loc, EAST)
					A.current = A.current.next
					A.current.deployed = 1
				else
					src.operating = 0
				//Foreach goto(150)
		sleep(20)
	return

/datum/air_tunnel/proc/retract()

	if (src.operating)
		return
	src.operating = 1
	while(src.operating == 1)
		var/ok = 1
		for(var/obj/move/airtunnel/connector/A in src.connectors)
			if (A.current == A)
				src.operating = 0
				return
			if (A.current)
				A.current.loc = null
				A.current.deployed = 0
				A.current = A.current.previous
			else
				ok = 0
			//Foreach goto(56)
		if (!( ok ))
			src.operating = 0
		else
			for(var/obj/move/airtunnel/connector/A in src.connectors)
				if (!( A.current.move_right() ))
					src.operating = 0
				//Foreach goto(188)
		sleep(20)
	return
