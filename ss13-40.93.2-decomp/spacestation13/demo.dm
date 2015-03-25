
/obj/machinery/door/meteorhit(M as obj)

	src.open()
	return

/obj/machinery/door/Move()

	..()
	if (src.density)
		var/location = src.loc
		if (istype(location, /turf))
			location.updatecell = 0
	return

/obj/machinery/door/attackby(I as obj, user as mob)

	if (src.operating)
		return
	src.add_fingerprint(user)
	if ((src.density && istype(I, /obj/item/weapon/card/emag)))
		src.operating = 1
		flick("door_spark", src)
		sleep(6)
		src.operating = null
		open()
		return 1
	if (istype(usr, /mob/human))
		var/H = usr
		var/card = H.wear_id
	if (istype(I, /obj/item/weapon/card/id))
		card = I
	else
		if (!( istype(card, /obj/item/weapon/card/id) ))
			return 0
	if ((card.air_access >= src.r_air && (card.lab_access >= src.r_lab && (card.engine_access >= src.r_engine && card.access_level >= src.r_access))))
		if (src.density)
			open()
		else
			close()
	else
		if (src.density)
			flick("door_deny", src)
	return

/obj/machinery/door/window/close()

	..()
	var/T = src.loc
	if (T)
		T.updatecell = 1
	return

/obj/machinery/door/window/New()

	..()
	var/T = src.loc
	if (T)
		T.updatecell = 1
	if ((src.r_air || (src.r_engine || (src.r_access || src.r_lab))))
		src.icon = 'security.dmi'
	return

/obj/machinery/door/window/Bumped(AM as mob|obj)

	if (!( ismob(AM) ))
		return
	if (!( ticker ))
		return
	if (src.operating)
		return
	if ((src.r_air == 0 && (src.r_engine == 0 && (src.r_lab == 0 && src.r_access == 0))))
		src.open()
		sleep(50)
		src.close()
	return

/obj/machinery/door/window/CheckPass(O as mob|obj, target as turf)

	if (src.density)
		var/direct = get_dir(O, target)
		if ((direct == NORTH && src.dir & 12))
			return 0
		else
			if ((direct == WEST && src.dir & 3))
				return 0
	return 1
	return

/obj/machinery/door/window/CheckExit(O as mob|obj, target as turf)

	if (src.density)
		var/direct = get_dir(O, target)
		if ((direct == SOUTH && src.dir & 12))
			return 0
		else
			if ((direct == EAST && src.dir & 3))
				return 0
	return 1
	return

/obj/machinery/door/false_wall/New()

	src.verbs -= /atom/movable/verb/pull
	return

/obj/machinery/door/false_wall/examine()
	set src in oview(1)

	usr << "It looks like a regular wall"
	return

/obj/machinery/door/false_wall/attack_paw(user as mob)

	if ((ticker && ticker.mode == "monkey"))
		return src.attack_hand(user)
	return

/obj/machinery/door/false_wall/attack_hand(user as mob)

	src.add_fingerprint(user)
	if (src.density)
		if (prob(25))
			src.open()
		else
			user << "\blue You push the wall but nothing happens!"
	else
		src.close()
	return

/obj/machinery/door/false_wall/attackby(S as obj, user as mob)

	src.add_fingerprint(user)
	if (istype(S, /obj/item/weapon/screwdriver))
		new /obj/item/weapon/sheet/metal( src.loc )
		new /obj/d_girders( src.loc )
		src = null
		del(src)
		return
	else
		..()
	return

/obj/machinery/door/airlock/proc/update()

	if (((!( src.wires & 2 ) || (!( src.wires & 8 ) || (!( src.wires & 32 ) || (!( src.wires & 64 ) || (!( src.wires & 128 ) || !( src.wires & 256 )))))) && src.powered))
		src.locked = 1
	if ((!( src.wires & 1 ) && (!( src.wires & 4 ) && !( src.wires & 16 ))))
		src.powered = 0
	else
		src.powered = 1
	var/d = src.density
	if (src.blocked)
		d = "l"
	src.icon_state = text("[]door[]", (src.p_open ? "o_" : null), d)
	return

/obj/machinery/door/airlock/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/door/airlock/attack_hand(user as mob)

	if (src.p_open)
		user.machine = src
		var/t1 = text("<B>Access Panel</B><br>\nOrange Wire: []<br>\nDark Red Wire:   []<br>\nWhite Wire:  []<br>\nYellow Wire: []<br>\nRed Wire:   []<br>\nBlue Wire:  []<br>\nGreen Wire: []<br>\nGrey Wire:   []<br>\nBlack Wire:  []<br>\n<br>\n[]<br>\n[]", (src.wires & 256 ? text("<A href='?src=\ref[];wires=256'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=256'>Mend Wire</A>", src)), (src.wires & 128 ? text("<A href='?src=\ref[];wires=128'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=128'>Mend Wire</A>", src)), (src.wires & 64 ? text("<A href='?src=\ref[];wires=64'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=64'>Mend Wire</A>", src)), (src.wires & 32 ? text("<A href='?src=\ref[];wires=32'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=32'>Mend Wire</A>", src)), (src.wires & 16 ? text("<A href='?src=\ref[];wires=16'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=16'>Mend Wire</A>", src)), (src.wires & 8 ? text("<A href='?src=\ref[];wires=8'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=8'>Mend Wire</A>", src)), (src.wires & 4 ? text("<A href='?src=\ref[];wires=4'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=4'>Mend Wire</A>", src)), (src.wires & 2 ? text("<A href='?src=\ref[];wires=2'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=2'>Mend Wire</A>", src)), (src.wires & 1 ? text("<A href='?src=\ref[];wires=1'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=1'>Mend Wire</A>", src)), (src.locked ? "The door bolts have fallen!" : "The door bolts look up."), (src.powered ? "The test light is on." : "The test light is off!"))
		user << browse(t1, "window=airlock")
	return

/obj/machinery/door/airlock/Topic(href, href_list)

	if (usr.stat)
		return
	if ((get_dist(src, usr) <= 1 && istype(src.loc, /turf)))
		usr.machine = src
		if (href_list["wires"])
			var/t1 = text2num(href_list["wires"])
			if (!( istype(usr.equipped(), /obj/item/weapon/wirecutters) ))
				return
			if (!( src.p_open ))
				return
			if (t1 & 1)
				if (src.wires & 1)
					src.wires &= 65534
				else
					src.wires |= 1
			else
				if (t1 & 2)
					if (src.wires & 2)
						src.wires &= 65533
					else
						src.wires |= 2
				else
					if (t1 & 4)
						if (src.wires & 4)
							src.wires &= 65531
						else
							src.wires |= 4
					else
						if (t1 & 8)
							if (src.wires & 8)
								src.wires &= 65527
							else
								src.wires |= 8
						else
							if (t1 & 16)
								if (src.wires & 16)
									src.wires &= 65519
								else
									src.wires |= 16
							else
								if (t1 & 32)
									if (src.wires & 32)
										src.wires &= 65503
									else
										src.wires |= 32
								else
									if (t1 & 64)
										if (src.wires & 64)
											src.wires &= 65471
										else
											src.wires |= 64
									else
										if (t1 & 128)
											if (src.wires & 128)
												src.wires &= 65407
											else
												src.wires |= 128
										else
											if (t1 & 256)
												if (src.wires & 256)
													src.wires &= 65279
												else
													src.wires |= 256
	src.update()
	src.add_fingerprint(usr)
	for(var/M as mob in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(477)
	return

/obj/machinery/door/airlock/attackby(C as obj, user as mob)

	src.add_fingerprint(user)
	if ((istype(C, /obj/item/weapon/weldingtool) && (!( src.operating ) && src.density)))
		var/W = C
		if (W.weldfuel > 2)
			W.weldfuel -= 2
		else
			user << "Need more wleding fuel!"
			return
		if (!( src.blocked ))
			src.blocked = 1
		else
			src.blocked = null
		src.update()
		return
	else
		if (istype(C, /obj/item/weapon/wrench))
			if (src.p_open)
				if (src.powered)
					src.locked = null
				else
					user << alert("You need power assist!", null, null, null, null, null)
			src.update()
		else
			if (istype(C, /obj/item/weapon/screwdriver))
				src.p_open = !( src.p_open )
				update()
			else
				if (istype(C, /obj/item/weapon/crowbar))
					if ((src.density && (!( src.blocked ) && (!( src.operating ) && (!( src.powered ) && !( src.locked ))))))
						spawn( 0 )
							src.operating = 1
							flick(text("[]doorc0", (src.p_open ? "o_" : null)), src)
							src.icon_state = text("[]door0", (src.p_open ? "o_" : null))
							sleep(15)
							src.density = 0
							src.opacity = 0
							var/T = src.loc
							if (istype(T, /turf))
								T.updatecell = 1
							src.operating = 0
							return
				else
					..()
	return

/obj/machinery/door/airlock/open()

	if ((src.blocked || (src.locked || !( src.powered ))))
		return
	..()
	return

/obj/machinery/door/airlock/close()

	if (!( src.powered ))
		return
	..()
	var/T = src.loc
	if (T)
		T.firelevel = 0
	return

/obj/machinery/door/firedoor/open()

	usr << "This is a remote firedoor!"
	return

/obj/machinery/door/firedoor/close()

	usr << "This is a remote firedoor!"
	return

/obj/machinery/door/firedoor/attackby(C as obj, user as mob)

	src.add_fingerprint(user)
	if ((istype(C, /obj/item/weapon/weldingtool) && (!( src.operating ) && src.density)))
		var/W = C
		if (W.weldfuel > 2)
			W.weldfuel -= 2
		if (!( src.blocked ))
			src.blocked = 1
			src.icon_state = "doorl"
		else
			src.blocked = 0
			src.icon_state = "door1"
		return
	else
		if (!( istype(C, /obj/item/weapon/crowbar) ))
			return
	if ((src.density && (!( src.blocked ) && !( src.operating ))))
		spawn( 0 )
			src.operating = 1
			flick("doorc0", src)
			src.icon_state = "door0"
			sleep(15)
			src.density = 0
			src.opacity = 0
			var/T = src.loc
			if (istype(T, /turf))
				T.updatecell = 1
			src.operating = 0
			return
	return

/obj/machinery/door/firedoor/proc/openfire()
	set src in oview(1)

	if ((src.operating || src.blocked))
		return
	src.operating = 1
	flick("doorc0", src)
	src.icon_state = "door0"
	sleep(15)
	src.density = 0
	src.opacity = 0
	var/T = src.loc
	if (istype(T, /turf))
		T.updatecell = 1
	src.operating = 0
	return

/obj/machinery/door/firedoor/proc/closefire()
	set src in oview(1)

	if (src.operating)
		return
	src.operating = 1
	flick("doorc1", src)
	src.icon_state = "door1"
	src.density = 1
	src.opacity = 1
	var/T = src.loc
	if (istype(T, /turf))
		T.updatecell = 0
		T.firelevel = 0
	sleep(15)
	src.operating = 0
	return

/obj/machinery/door/New()

	..()
	var/T = src.loc
	if (istype(T, /turf))
		if (src.density)
			T.updatecell = 0
	return

/obj/machinery/door/proc/open()

	if (src.operating)
		return
	src.operating = 1
	flick(text("[]doorc0", (src.p_open ? "o_" : null)), src)
	src.icon_state = text("[]door0", (src.p_open ? "o_" : null))
	sleep(15)
	src.density = 0
	src.opacity = 0
	var/T = src.loc
	if (istype(T, /turf))
		T.updatecell = 1
	src.operating = 0
	return

/obj/machinery/door/proc/close()

	if (src.operating)
		return
	src.operating = 1
	flick(text("[]doorc1", (src.p_open ? "o_" : null)), src)
	src.icon_state = text("[]door1", (src.p_open ? "o_" : null))
	src.density = 1
	if (src.visible)
		src.opacity = 1
	var/T = src.loc
	if (istype(T, /turf))
		T.updatecell = 0
	sleep(15)
	src.operating = 0
	return

/obj/machinery/igniter/attack_paw(user as mob)

	if ((ticker && ticker.mode == "monkey"))
		return src.attack_hand(user)
	return

/obj/machinery/igniter/attack_hand(user as mob)

	..()
	src.on = !( src.on )
	src.icon_state = text("igniter[]", src.on)
	src.add_fingerprint(user)
	return

/obj/machinery/igniter/process()

	if (src.on)
		var/T = src.loc
		if (locate(/obj/move, T))
			T = locate(/obj/move, T)
		if (T.firelevel < 900000.0)
			T.firelevel = T.poison
	return

/obj/machinery/firealarm/burn(fi_amount)

	src.alarm()
	return

/obj/machinery/firealarm/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/firealarm/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wirecutters))
		src.detecting = !( src.detecting )
		if (src.detecting)
			viewers(user, null) << text("\red [] has reconnected []'s detecting unit!", user, src)
		else
			viewers(user, null) << text("\red [] has disconnected []'s detecting unit!", user, src)
	else
		src.alarm()
	src.add_fingerprint(user)
	return

/obj/machinery/firealarm/process()

	if (src.timing)
		if (src.time > 0)
			src.time = round(src.time) - 1
		else
			src.alarm()
			src.time = 0
			src.timing = 0
		for(var/M as mob in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
			//Foreach goto(68)
	return

/obj/machinery/firealarm/attack_hand(user as mob)

	user.machine = src
	var/A = src.loc
	if (istype(user, /mob/human))
		A = A.loc
		if (A.fire)
			var/d1 = text("<A href='?src=\ref[];reset=1'>Reset - Lockdown</A>", src)
		else
			d1 = text("<A href='?src=\ref[];alarm=1'>Alarm - Lockdown</A>", src)
		if (src.timing)
			var/d2 = text("<A href='?src=\ref[];time=0'>Stop Time Lock</A>", src)
		else
			d2 = text("<A href='?src=\ref[];time=1'>Initiate Time Lock</A>", src)
		var/second = src.time % 60
		var/minute = (src.time - second) / 60
		var/dat = text("<HTML><HEAD></HEAD><BODY><TT><B>Fire alarm</B> []\n<HR>\nTimer System: []<BR>\nTime Left: [][] <A href='?src=\ref[];tp=-30'>-</A> <A href='?src=\ref[];tp=-1'>-</A> <A href='?src=\ref[];tp=1'>+</A> <A href='?src=\ref[];tp=30'>+</A>\n</TT></BODY></HTML>", d1, d2, (minute ? text("[]:", minute) : null), second, src, src, src, src)
		user << browse(dat, "window=firealarm")
	else
		A = A.loc
		if (A.fire)
			d1 = text("<A href='?src=\ref[];reset=1'>[]</A>", src, stars("Reset - Lockdown"))
		else
			d1 = text("<A href='?src=\ref[];alarm=1'>[]</A>", src, stars("Alarm - Lockdown"))
		if (src.timing)
			d2 = text("<A href='?src=\ref[];time=0'>[]</A>", src, stars("Stop Time Lock"))
		else
			d2 = text("<A href='?src=\ref[];time=1'>[]</A>", src, stars("Initiate Time Lock"))
		var/second = src.time % 60
		var/minute = (src.time - second) / 60
		var/dat = text("<HTML><HEAD></HEAD><BODY><TT><B>[]</B> []\n<HR>\nTimer System: []<BR>\nTime Left: [][] <A href='?src=\ref[];tp=-30'>-</A> <A href='?src=\ref[];tp=-1'>-</A> <A href='?src=\ref[];tp=1'>+</A> <A href='?src=\ref[];tp=30'>+</A>\n</TT></BODY></HTML>", stars("Fire alarm"), d1, d2, (minute ? text("[]:", minute) : null), second, src, src, src, src)
		user << browse(dat, "window=firealarm")
	return

/obj/machinery/firealarm/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["reset"])
			src.reset()
		else
			if (href_list["alarm"])
				src.alarm()
			else
				if (href_list["time"])
					src.timing = text2num(href_list["time"])
				else
					if (href_list["tp"])
						var/tp = text2num(href_list["tp"])
						src.time += tp
						src.time = min(max(round(src.time), 0), 120)
		for(var/M as mob in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
			//Foreach goto(194)
		src.add_fingerprint(usr)
	else
		usr << browse(null, "window=firealarm")
		return
	return

/obj/machinery/firealarm/proc/reset()

	if (!( src.working ))
		return
	var/A = src.loc
	A = A.loc
	if (!( istype(A, /area) ))
		return
	A.fire = 0
	if (A.icon_state == "blue-red")
		A.icon_state = "red"
	else
		A.icon_state = null
	for(var/obj/machinery/door/firedoor/D as obj in A)
		if (D.density)
			spawn( 0 )
				openfire()
				return
		//Foreach goto(93)
	return

/obj/machinery/firealarm/proc/alarm()

	if (!( src.working ))
		return
	var/A = src.loc
	A = A.loc
	if (!( istype(A, /area) ))
		return
	A.firealert()
	return

/obj/machinery/dispenser/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				src = null
				del(src)
				return
		if(3.0)
			if (prob(25))
				while(src.o2tanks > 0)
					new /obj/item/weapon/tank/oxygentank( src.loc )
					src.o2tanks--
				while(src.pltanks > 0)
					new /obj/item/weapon/tank/plasmatank( src.loc )
					src.pltanks--
		else
	return

/obj/machinery/dispenser/meteorhit()

	while(src.o2tanks > 0)
		new /obj/item/weapon/tank/oxygentank( src.loc )
		src.o2tanks--
	while(src.pltanks > 0)
		new /obj/item/weapon/tank/plasmatank( src.loc )
		src.pltanks--
	src = null
	del(src)
	return
	return

/obj/machinery/dispenser/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/dispenser/attack_hand(user as mob)

	user.machine = src
	var/dat = text("<TT><B>Loaded Tank Dispensing Unit</B><BR>\n<FONT color = 'blue'><B>Oxygen</B>: []</FONT> []<BR>\n<FONT color = 'orange'><B>Plasma</B>: []</FONT> []<BR>\n</TT>", src.o2tanks, (src.o2tanks ? text("<A href='?src=\ref[];oxygen=1'>Dispense</A>", src) : "empty"), src.pltanks, (src.pltanks ? text("<A href='?src=\ref[];plasma=1'>Dispense</A>", src) : "empty"))
	user << browse(dat, "window=dispenser")
	return

/obj/machinery/dispenser/Topic(href, href_list)

	if (usr.stat)
		return
	if ((!( istype(usr, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		usr << "\red You don't have the dexterity to do this!"
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["oxygen"])
			if (text2num(href_list["oxygen"]))
				if (src.o2tanks > 0)
					new /obj/item/weapon/tank/oxygentank( src.loc )
					src.o2tanks--
			if (istype(src.loc, /mob))
				attack_hand(src.loc)
		else
			if (href_list["plasma"])
				if (text2num(href_list["plasma"]))
					if (src.pltanks > 0)
						new /obj/item/weapon/tank/plasmatank( src.loc )
						src.pltanks--
				if (istype(src.loc, /mob))
					attack_hand(src.loc)
		src.add_fingerprint(usr)
		for(var/M as mob in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
			//Foreach goto(275)
	else
		usr << browse(null, "window=dispenser")
		return
	return

/obj/item/weapon/clothing/burn(fi_amount)

	if (fi_amount > src.s_fire)
		spawn( 0 )
			var/t = src.icon_state
			src.icon_state = ""
			src.icon = 'b_items.dmi'
			flick(text("[]", t), src)
			spawn( 14 )
				src = null
				del(src)
				return
				return
			return
		return 0
	return 1
	return

/obj/item/weapon/clothing/gloves/examine()
	set src in usr

	..()
	return

/obj/item/weapon/clothing/shoes/orange/attack_self(user as mob)

	if (src.chained)
		src.chained = null
		new /obj/item/weapon/handcuffs( user.loc )
		src.icon_state = "o_shoes"
	return

/obj/item/weapon/clothing/shoes/orange/attackby(H as obj, loc)

	if ((istype(H, /obj/item/weapon/handcuffs) && !( src.chained )))
		H = null
		del(H)
		src.chained = 1
		src.icon_state = "o_shoes1"
	return

/obj/item/weapon/clothing/mask/muzzle/attack_paw(user as mob)

	if (src == user.wear_mask)
		return
	else
		..()
	return

/obj/item/weapon/tank/attack_self(user as mob)

	user.machine = src
	if (!( src.gas ))
		return
	var/dat = text("<TT><B>Tank</B><BR>\n<FONT color = 'blue'><B>Contains/Capacity</B> [] / []</FONT><BR>\nInterals Valve: <A href='?src=\ref[];stat=1'>[] Gas Flow</A><BR>\n\t<A href='?src=\ref[];cp=-50'>-</A> <A href='?src=\ref[];cp=-5'>-</A> <A href='?src=\ref[];cp=-1'>-</A> [] <A href='?src=\ref[];cp=1'>+</A> <A href='?src=\ref[];cp=5'>+</A> <A href='?src=\ref[];cp=50'>+</A><BR>\n<BR>\n<A href='?src=\ref[];mach_close=tank'>Close</A>\n</TT>", src.gas.tot_gas(), src.maximum, src, ((src.loc == user && user.internal == src) ? "Stop" : "Restore"), src, src, src, src.i_used, src, src, src, user)
	user << browse(dat, "window=tank;size=600x300")
	return

/obj/item/weapon/tank/Topic(href, href_list)

	if (usr.stat)
		return
	if (src.loc == usr)
		usr.machine = src
		if (href_list["cp"])
			var/cp = text2num(href_list["cp"])
			src.i_used += cp
			src.i_used = min(max(round(src.i_used), 0), 10000)
		if ((href_list["stat"] && src.loc == usr))
			if (usr.internal == src)
				usr.internal = null
				return
			if (usr.internal)
				usr.internal = null
			if ((!( usr.wear_mask ) || !( usr.wear_mask.flags & 8 )))
				return
			usr.internal = src
			usr << "\blue Now running on internals!"
		src.add_fingerprint(usr)
		for(var/M as mob in viewers(1, src.loc))
			if ((M.client && M.machine == src))
				src.attack_self(M)
			//Foreach goto(206)
	else
		usr << browse(null, "window=tank")
		return
	return

/obj/item/weapon/tank/proc/process(M as mob, G as obj)

	var/amount = src.i_used
	var/total = src.gas.tot_gas()
	if (amount > total)
		amount = total
	if (total > 0)
		G.transfer_from(src.gas, amount)
	return G
	return

/obj/item/weapon/tank/attack(M as mob, user as mob)

	..()
	if ((prob(30) && M.stat < 2))
		var/H = M
		if ((istype(H, /mob/human) && (istype(H, /obj/item/weapon/clothing/head) && (H.flags & 8 && prob(80)))))
			M << "\red The helmet protects you from being hit hard in the head!"
			return
		var/time = rand(10, 120)
		if (prob(90))
			if (M.paralysis < time)
				M.paralysis = time
		else
			if (M.stunned < time)
				M.stunned = time
		M.stat = 1
		for(var/O as mob in viewers(M, null))
			if ((O.client && !( O.blinded )))
				O << text("\red <B>[] has been knocked unconscious!</B>", M)
			//Foreach goto(169)
		M << text("\red <B>This was a []% hit. Roleplay it! (personality/memory change if the hit was severe enough)</B>", (time * 100) / 120)
	return

/obj/item/weapon/tank/New()

	..()
	src.gas = new /obj/substance/gas( src )
	src.gas.maximum = src.maximum
	return

/obj/item/weapon/tank/Del()

	src.gas = null
	del(src.gas)
	return
	return

/obj/item/weapon/tank/burn(fi_amount)

	if ((fi_amount * src.gas.tot_gas()) > (src.maximum * 3.75E7))
		src.turf_add(get_turf(src.loc), src.gas.tot_gas())
		src = null
		del(src)
		return
	return

/obj/item/weapon/tank/examine()
	set src in view(1)

	usr << text("\blue The \icon[] contains [] unit\s of gas.", src, src.gas.tot_gas())
	return

/obj/item/weapon/tank/oxygentank/New()

	..()
	src.gas.oxygen = src.maximum
	return

/obj/item/weapon/tank/jetpack/New()

	..()
	src.gas.oxygen = src.maximum
	return

/obj/item/weapon/tank/jetpack/verb/toggle()

	src.on = !( src.on )
	src.icon_state = text("jetpack[]", src.on)
	return

/obj/item/weapon/tank/jetpack/proc/allow_thrust(num, user as mob)

	if (!( src.on ))
		return 0
	if ((num < 1 || src.gas.tot_gas() < num))
		return 0
	var/obj/substance/gas/G = new /obj/substance/gas(  )
	G.transfer_from(src.gas, num)
	if (G.oxygen >= 100)
		return 1
	if (G.plasma > 10)
		if (user)
			var/d = G.plasma / 2
			d = min(abs(user.health + 100), d, 25)
			user.fireloss += d
			user.health = (((100 - user.oxyloss) - user.toxloss) - user.fireloss) - user.bruteloss
		return (G.oxygen >= 75 ? 0.5 : 0)
	else
		if (G.oxygen >= 75)
			return 0.5
		else
			return 0
	G = null
	del(G)
	return

/obj/item/weapon/tank/anesthetic/New()

	..()
	src.gas.sl_gas = 1000
	return

/obj/item/weapon/tank/plasmatank/proc/ignite()

	if ((src.gas.plasma < 1600000.0 || src.temperature < 500))
		var/T = get_turf(src.loc)
		T.poison += src.gas.plasma
		T.firelevel = T.poison
		T.res_vars()
		if ((src.gas.temperature > 450 && src.plasma == 1600000.0))
			var/sw = locate(max(T.x - 4, 1), max(T.y - 4, 1), T.z)
			var/ne = locate(min(T.x + 4, world.maxx), min(T.y + 4, world.maxy), T.z)
			for(var/U as turf in block(sw, ne))
				var/zone = 4
				if ((U.y <= (T.y + 1) && (U.y >= (T.y - 1) && (U.x <= (T.x + 2) && U.x >= (T.x - 2)))))
					zone = 3
				if ((U.y <= (T.y + 1) && (U.y >= (T.y - 1) && (U.x <= (T.x + 1) && U.x >= (T.x - 1)))))
					zone = 2
				for(var/atom/A as mob|obj|turf|area in U)
					A.ex_act(zone)
					//Foreach goto(342)
				U.ex_act(zone)
				//Foreach goto(170)
		else
			if ((src.gas.temperature > 300 && src.plasma == 1600000.0))
				var/sw = locate(max(T.x - 4, 1), max(T.y - 4, 1), T.z)
				var/ne = locate(min(T.x + 4, world.maxx), min(T.y + 4, world.maxy), T.z)
				for(var/U as turf in block(sw, ne))
					var/zone = 4
					if ((U.y <= (T.y + 2) && (U.y >= (T.y - 2) && (U.x <= (T.x + 2) && U.x >= (T.x - 2)))))
						zone = 3
					for(var/atom/A as mob|obj|turf|area in U)
						A.ex_act(zone)
						//Foreach goto(598)
					U.ex_act(zone)
					//Foreach goto(498)
		src.master = null
		del(src.master)
		src = null
		del(src)
		return
		return
	var/T = src.loc
	while(!( istype(T, /turf) ))
		T = T.loc
	src.master.loc = null
	for(var/M as mob in range(T, null))
		flick("flash", M.flash)
		//Foreach goto(732)
	var/m_range = 2
	for(var/obj/machinery/atmoalter/canister/C as obj in range(2, T))
		if (!( C.destroyed ))
			if (C.gas.plasma >= 35000)
				C.destroyed = 1
				m_range++
		//Foreach goto(776)
	var/min = m_range
	var/med = m_range * 2
	var/max = m_range * 3
	var/u_max = m_range * 4
	var/sw = locate(max(T.x - u_max, 1), max(T.y - u_max, 1), T.z)
	var/ne = locate(min(T.x + u_max, world.maxx), min(T.y + u_max, world.maxy), T.z)
	for(var/U as turf in block(sw, ne))
		var/zone = 4
		if ((U.y <= (T.y + max) && (U.y >= (T.y - max) && (U.x <= (T.x + max) && U.x >= (T.x - max)))))
			zone = 3
		if ((U.y <= (T.y + med) && (U.y >= (T.y - med) && (U.x <= (T.x + med) && U.x >= (T.x - med)))))
			zone = 2
		if ((U.y <= (T.y + min) && (U.y >= (T.y - min) && (U.x <= (T.x + min) && U.x >= (T.x - min)))))
			zone = 1
		for(var/atom/A as mob|obj|turf|area in U)
			A.ex_act(zone)
			//Foreach goto(1217)
		U.ex_act(zone)
		//Foreach goto(961)
	src.master = null
	del(src.master)
	src = null
	del(src)
	return
	return

/obj/item/weapon/tank/plasmatank/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/assembly/rad_ignite))
		var/S = W
		if (!( S.status ))
			return
		var/obj/item/weapon/assembly/r_i_ptank/R = new /obj/item/weapon/assembly/r_i_ptank( user )
		R.part1 = S.part1
		S.part1.loc = R
		S.part1.master = R
		R.part2 = S.part2
		S.part2.loc = R
		S.part2.master = R
		S.layer = S.initial(S.layer)
		if (user.client)
			user.client.screen -= S
		if (user.r_hand == S)
			u_equip(S)
			user.r_hand = R
		else
			u_equip(S)
			user.l_hand = R
		src.master = R
		src.layer = initial(src.layer)
		user.u_equip(src)
		if (user.client)
			user.client.screen -= src
		src.loc = R
		R.part3 = src
		R.layer = 20
		R.loc = user
		S.part1 = null
		S.part2 = null
		S = null
		del(S)
	if (istype(W, /obj/item/weapon/assembly/prox_ignite))
		var/S = W
		if (!( S.status ))
			return
		var/obj/item/weapon/assembly/m_i_ptank/R = new /obj/item/weapon/assembly/m_i_ptank( user )
		R.part1 = S.part1
		S.part1.loc = R
		S.part1.master = R
		R.part2 = S.part2
		S.part2.loc = R
		S.part2.master = R
		S.layer = S.initial(S.layer)
		if (user.client)
			user.client.screen -= S
		if (user.r_hand == S)
			u_equip(S)
			user.r_hand = R
		else
			u_equip(S)
			user.l_hand = R
		src.master = R
		src.layer = initial(src.layer)
		user.u_equip(src)
		if (user.client)
			user.client.screen -= src
		src.loc = R
		R.part3 = src
		R.layer = 20
		R.loc = user
		S.part1 = null
		S.part2 = null
		S = null
		del(S)
	return

/obj/item/weapon/tank/plasmatank/New()

	..()
	src.gas.plasma = src.maximum
	return

/obj/meteor/small/Move()

	if (src.steps < 7)
		src.steps++
		if (src.steps >= 7)
			src.icon_state = "smallf"
	else
		var/T = src.loc
		if (istype(T, /turf))
			T.firelevel = T.poison + 5
	..()
	if (src.z != 1)
		src = null
		del(src)
		return
	spawn( 3 )
		step(src, WEST)
		if (prob(30))
			step(src, pick(NORTH, SOUTH))
		return
	return

/obj/meteor/New()

	..()
	sleep(1)
	step(src, WEST)
	return

/obj/meteor/Move()

	if (src.steps < 7)
		src.steps++
		if (src.steps >= 7)
			src.icon_state = "flaming"
	else
		var/T = src.loc
		if (istype(T, /turf))
			T.firelevel = T.poison + 5
	..()
	if (src.z != 1)
		src = null
		del(src)
		return
	spawn( 3 )
		step(src, WEST)
		if (prob(30))
			step(src, pick(NORTH, SOUTH))
		return
	return

/obj/meteor/Bump(A as mob|obj|turf|area)

	spawn( 0 )
		if (A)
			A.meteorhit(src)
		if (--src.hits <= 0)
			src = null
			del(src)
			return
		return
	return

/obj/meteor/ex_act(severity)

	if (severity < 4)
		src = null
		del(src)
		return
	return

/obj/secloset/alter_health()

	return src.loc
	return

/obj/secloset/CheckPass(O as mob|obj, target as turf)

	if (!( src.opened ))
		return 0
	else
		return 1
	return

/obj/secloset/personal/New()

	..()
	sleep(2)
	new /obj/item/weapon/storage/backpack( src )
	new /obj/item/weapon/radio/headset( src )
	new /obj/item/weapon/radio/signaler( src )
	new /obj/item/weapon/pen( src )
	return

/obj/secloset/personal/attackby(W as obj, user as mob)

	if (src.opened)
		user.drop_item()
		W.loc = src.loc
	else
		if (istype(W, /obj/item/weapon/card/id))
			var/list/L = list(  )
			if (W.assignment == "Systems")
				src.allowed = null
				src.icon_state = "0secloset0"
				src.locked = 1
				src.desc = "The first card swiped gains control."
				return
			if (src.allowed)
				L = dd_text2list(src.allowed, ",")
			if ((L.Find(W.assignment) || (!( src.allowed ) || L.Find(text("m[]", W.registered)))))
				src.locked = !( src.locked )
				for(var/O as mob in viewers(user, 3))
					if ((O.client && !( O.blinded )))
						O << text("\blue The locker has been []locked by [].", (src.locked ? null : "un"), user)
					//Foreach goto(185)
				src.icon_state = text("[]secloset0", (src.locked ? "1" : null))
				if (!( src.allowed ))
					src.allowed = text("m[],Captain,Head of Personnel", W.registered)
					src.desc = text("Owned by [], Clear by using a card of rank 'Systems'", W.registered)
			else
				user << "\red Access Denied"
		else
			user << "\red It's closed..."
	return

/obj/secloset/security2/New()

	..()
	sleep(2)
	new /obj/item/weapon/clothing/under/red( src )
	new /obj/item/weapon/storage/fcard_kit( src )
	new /obj/item/weapon/storage/fcard_kit( src )
	new /obj/item/weapon/storage/fcard_kit( src )
	new /obj/item/weapon/storage/lglo_kit( src )
	new /obj/item/weapon/storage/lglo_kit( src )
	new /obj/item/weapon/fcardholder( src )
	new /obj/item/weapon/fcardholder( src )
	new /obj/item/weapon/fcardholder( src )
	new /obj/item/weapon/fcardholder( src )
	new /obj/item/weapon/camera( src )
	new /obj/item/weapon/f_print_scanner( src )
	new /obj/item/weapon/f_print_scanner( src )
	new /obj/item/weapon/f_print_scanner( src )
	return

/obj/secloset/security1/New()

	..()
	sleep(2)
	new /obj/item/weapon/storage/flashbang_kit( src )
	new /obj/item/weapon/storage/handcuff_kit( src )
	new /obj/item/weapon/gun/energy/taser_gun( src )
	new /obj/item/weapon/flash( src )
	new /obj/item/weapon/clothing/under/red( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/suit/armor( src )
	new /obj/item/weapon/clothing/head/helmet( src )
	new /obj/item/weapon/clothing/glasses/sunglasses( src )
	return

/obj/secloset/highsec/New()

	..()
	sleep(2)
	new /obj/item/weapon/gun/energy/laser_gun( src )
	new /obj/item/weapon/gun/energy/taser_gun( src )
	new /obj/item/weapon/flash( src )
	new /obj/item/weapon/storage/id_kit( src )
	new /obj/item/weapon/clothing/under/green( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/glasses/sunglasses( src )
	new /obj/item/weapon/clothing/suit/armor( src )
	new /obj/item/weapon/clothing/head/helmet( src )
	return

/obj/secloset/animal/New()

	..()
	sleep(2)
	new /obj/item/weapon/radio/signaler( src )
	new /obj/item/weapon/radio/electropack( src )
	new /obj/item/weapon/radio/electropack( src )
	new /obj/item/weapon/radio/electropack( src )
	new /obj/item/weapon/radio/electropack( src )
	new /obj/item/weapon/radio/electropack( src )
	return

/obj/secloset/medical1/New()

	..()
	sleep(2)
	new /obj/item/weapon/bottle/toxins( src )
	new /obj/item/weapon/bottle/rejuvenators( src )
	new /obj/item/weapon/bottle/s_tox( src )
	new /obj/item/weapon/bottle/s_tox( src )
	new /obj/item/weapon/bottle/toxins( src )
	new /obj/item/weapon/bottle/r_epil( src )
	new /obj/item/weapon/bottle/r_ch_cough( src )
	new /obj/item/weapon/pill_canister/Tourette( src )
	new /obj/item/weapon/pill_canister/cough( src )
	new /obj/item/weapon/pill_canister/epilepsy( src )
	new /obj/item/weapon/pill_canister/sleep( src )
	new /obj/item/weapon/pill_canister/antitoxin( src )
	new /obj/item/weapon/pill_canister/placebo( src )
	new /obj/item/weapon/storage/firstaid/syringes( src )
	new /obj/item/weapon/storage/gl_kit( src )
	new /obj/item/weapon/dropper( src )
	return

/obj/secloset/medical2/New()

	..()
	sleep(2)
	new /obj/item/weapon/tank/anesthetic( src )
	new /obj/item/weapon/tank/anesthetic( src )
	new /obj/item/weapon/tank/anesthetic( src )
	new /obj/item/weapon/tank/anesthetic( src )
	new /obj/item/weapon/tank/anesthetic( src )
	new /obj/item/weapon/clothing/mask/m_mask( src )
	new /obj/item/weapon/clothing/mask/m_mask( src )
	new /obj/item/weapon/clothing/mask/m_mask( src )
	new /obj/item/weapon/clothing/mask/m_mask( src )
	return

/obj/secloset/ex_act(severity)

	switch(severity)
		if(1.0)
			for(var/atom/movable/A as mob|obj in src)
				A.loc = src.loc
				ex_act(severity)
				//Foreach goto(35)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(108)
				src = null
				del(src)
				return
		if(3.0)
			if (prob(5))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(181)
				src = null
				del(src)
				return
		else
	return

/obj/secloset/meteorhit(O as obj)

	if (O.icon_state == "flaming")
		for(var/obj/item/I as obj in src)
			I.loc = src.loc
			//Foreach goto(29)
		for(var/M as mob in src)
			M.loc = src.loc
			if (M.client)
				M.eye = M.client.mob
				M.client.perspective = MOB_PERSPECTIVE
			//Foreach goto(71)
		src.icon_state = "secloset1"
		src = null
		del(src)
		return
	return

/obj/secloset/attackby(W as obj, user as mob)

	if (src.opened)
		user.drop_item()
		W.loc = src.loc
	else
		if (istype(W, /obj/item/weapon/card/id))
			var/list/L = list(  )
			if (W.allowed)
				L = dd_text2list(W.allowed, ",")
			if ((L.Find(W.assignment) || !( src.allowed )))
				src.locked = !( src.locked )
				for(var/O as mob in viewers(user, 3))
					if ((O.client && !( O.blinded )))
						O << text("\blue The locker has been []locked by [].", (src.locked ? null : "un"), user)
					//Foreach goto(121)
				src.icon_state = text("[]secloset0", (src.locked ? "1" : null))
			else
				user << "\red Access Denied"
		else
			user << "\red It's closed..."
	return

/obj/secloset/relaymove(user as mob)

	if (user.stat)
		return
	if (!( src.locked ))
		for(var/obj/item/I as obj in src)
			I.loc = src.loc
			//Foreach goto(36)
		for(var/M as mob in src)
			M.loc = src.loc
			if (M.client)
				M.eye = M.client.mob
				M.client.perspective = MOB_PERSPECTIVE
			//Foreach goto(78)
		src.icon_state = "secloset1"
		src.opened = 1
	else
		user << "\blue It's welded shut!"
		for(var/M as mob in hearers(src, null))
			M << text("<FONT size=[]>BANG, bang!</FONT>", max(0, 5 - get_dist(src, M)))
			//Foreach goto(170)
	return

/obj/secloset/MouseDrop_T(O as mob|obj, user as mob)

	if ((user.restrained() || user.stat))
		return
	if ((!( istype(O, /atom/movable) ) || (O.anchored || (get_dist(user, src) > 1 || (get_dist(user, O) > 1 || user.contents.Find(src))))))
		return
	step_towards(O, src.loc)
	if (user != O)
		for(var/B as mob in viewers(user, 3))
			if ((B.client && !( B.blinded )))
				B << text("\red [] stuffs [] into []!", user, O, src)
			//Foreach goto(115)
	src.add_fingerprint(user)
	return

/obj/secloset/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/secloset/attack_hand(user as mob)

	src.add_fingerprint(user)
	if (!( src.opened ))
		if (!( src.locked ))
			for(var/obj/item/I as obj in src)
				I.loc = src.loc
				//Foreach goto(43)
			for(var/M as mob in src)
				M.loc = src.loc
				if (M.client)
					M.eye = M.client.mob
					M.client.perspective = MOB_PERSPECTIVE
				//Foreach goto(85)
			src.icon_state = "secloset1"
			src.opened = 1
		else
			usr << "\blue It's locked tight!"
	else
		for(var/obj/item/I as obj in src.loc)
			if (!( I.anchored ))
				I.loc = src
			//Foreach goto(176)
		for(var/M as mob in src.loc)
			if (M.client)
				M.client.perspective = EYE_PERSPECTIVE
				M.client.eye = src
			M.loc = src
			//Foreach goto(226)
		src.icon_state = "secloset0"
		src.opened = 0
	return

/obj/morgue/proc/update()

	if (src.connected)
		src.icon_state = "morgue0"
	else
		if (src.contents.len)
			src.icon_state = "morgue2"
		else
			src.icon_state = "morgue1"
	return

/obj/morgue/alter_health()

	return src.loc
	return

/obj/morgue/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/morgue/attack_hand(user as mob)

	if (src.connected)
		for(var/atom/movable/A as mob|obj in src.connected.loc)
			if (!( A.anchored ))
				A.loc = src
			//Foreach goto(28)
		src.connected = null
		del(src.connected)
	else
		src.connected = new /obj/m_tray( src.loc )
		step(src.connected, EAST)
		src.connected.layer = OBJ_LAYER
		var/T = get_step(src, EAST)
		if (T.contents.Find(src.connected))
			src.connected.connected = src
			src.icon_state = "morgue0"
			for(var/atom/movable/A as mob|obj in src)
				A.loc = src.connected.loc
				//Foreach goto(168)
			src.connected.icon_state = "morguet"
		else
			src.connected = null
			del(src.connected)
	src.add_fingerprint(user)
	update()
	return

/obj/morgue/attackby(P as obj, user as mob)

	if (istype(P, /obj/item/weapon/pen))
		var/t = input(user, "What would you like the label to be?", text("[]", src.name), null)  as text
		if (user.equipped() != P)
			return
		if ((get_dist(src, usr) > 1 && src.loc != user))
			return
		t = html_encode(t)
		if (t)
			src.name = text("Morgue- '[]'", t)
		else
			src.name = "Morgue"
	src.add_fingerprint(user)
	return

/obj/morgue/relaymove(user as mob)

	if (user.stat)
		return
	src.connected = new /obj/m_tray( src.loc )
	step(src.connected, EAST)
	src.connected.layer = OBJ_LAYER
	var/T = get_step(src, EAST)
	if (T.contents.Find(src.connected))
		src.connected.connected = src
		src.icon_state = "morgue0"
		for(var/atom/movable/A as mob|obj in src)
			A.loc = src.connected.loc
			//Foreach goto(106)
		src.connected.icon_state = "morguet"
	else
		src.connected = null
		del(src.connected)
	return

/obj/m_tray/CheckPass(D as obj)

	if (istype(D, /obj/item/weapon/dummy))
		return 1
	else
		return ..()
	return

/obj/m_tray/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/m_tray/attack_hand(user as mob)

	if (src.connected)
		for(var/atom/movable/A as mob|obj in src.loc)
			if (!( A.anchored ))
				A.loc = src.connected
			//Foreach goto(26)
		src.connected.connected = null
		src.connected.update()
		src.add_fingerprint(user)
		src = null
		del(src)
		return
	return

/obj/m_tray/MouseDrop_T(O as mob|obj, user as mob)

	if ((!( istype(O, /atom/movable) ) || (O.anchored || (get_dist(user, src) > 1 || (get_dist(user, O) > 1 || user.contents.Find(src))))))
		return
	O.loc = src.loc
	if (user != O)
		for(var/B as mob in viewers(user, 3))
			if ((B.client && !( B.blinded )))
				B << text("\red [] stuffs [] into []!", user, O, src)
			//Foreach goto(99)
	return

/obj/closet/alter_health()

	return src.loc
	return

/obj/closet/CheckPass(O as mob|obj, target as turf)

	if (!( src.opened ))
		return 0
	else
		return 1
	return

/obj/closet/syndicate/nuclear/New()

	..()
	sleep(2)
	new /obj/item/weapon/ammo/a357( src )
	new /obj/item/weapon/ammo/a357( src )
	new /obj/item/weapon/ammo/a357( src )
	new /obj/item/weapon/storage/handcuff_kit( src )
	new /obj/item/weapon/storage/flashbang_kit( src )
	new /obj/item/weapon/gun/energy/taser_gun( src )
	new /obj/item/weapon/gun/energy/taser_gun( src )
	new /obj/item/weapon/gun/energy/taser_gun( src )
	var/obj/item/weapon/syndicate_uplink/U = new /obj/item/weapon/syndicate_uplink( src )
	U.uses = 5
	return

/obj/closet/emcloset/New()

	..()
	sleep(2)
	new /obj/item/weapon/tank/oxygentank( src )
	new /obj/item/weapon/clothing/mask/gasmask( src )
	return

/obj/closet/l3closet/New()

	..()
	sleep(2)
	new /obj/item/weapon/tank/oxygentank( src )
	new /obj/item/weapon/clothing/mask/gasmask( src )
	new /obj/item/weapon/clothing/suit/bio_suit( src )
	new /obj/item/weapon/clothing/under/white( src )
	new /obj/item/weapon/clothing/shoes/white( src )
	new /obj/item/weapon/clothing/gloves/latex( src )
	new /obj/item/weapon/clothing/head/bio_hood( src )
	return

/obj/closet/wardrobe/New()

	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	return

/obj/closet/wardrobe/red/New()

	new /obj/item/weapon/clothing/under/red( src )
	new /obj/item/weapon/clothing/under/red( src )
	new /obj/item/weapon/clothing/under/red( src )
	new /obj/item/weapon/clothing/under/red( src )
	new /obj/item/weapon/clothing/under/red( src )
	new /obj/item/weapon/clothing/under/red( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	return

/obj/closet/wardrobe/pink/New()

	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	return

/obj/closet/wardrobe/black/New()

	new /obj/item/weapon/clothing/under/black( src )
	new /obj/item/weapon/clothing/under/black( src )
	new /obj/item/weapon/clothing/under/black( src )
	new /obj/item/weapon/clothing/under/black( src )
	new /obj/item/weapon/clothing/under/black( src )
	new /obj/item/weapon/clothing/under/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	return

/obj/closet/wardrobe/green/New()

	new /obj/item/weapon/clothing/under/green( src )
	new /obj/item/weapon/clothing/under/green( src )
	new /obj/item/weapon/clothing/under/green( src )
	new /obj/item/weapon/clothing/under/green( src )
	new /obj/item/weapon/clothing/under/green( src )
	new /obj/item/weapon/clothing/under/green( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	new /obj/item/weapon/clothing/shoes/black( src )
	return

/obj/closet/wardrobe/orange/New()

	new /obj/item/weapon/clothing/under/orange( src )
	new /obj/item/weapon/clothing/under/orange( src )
	new /obj/item/weapon/clothing/under/orange( src )
	new /obj/item/weapon/clothing/under/orange( src )
	new /obj/item/weapon/clothing/under/orange( src )
	new /obj/item/weapon/clothing/under/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	return

/obj/closet/wardrobe/yellow/New()

	new /obj/item/weapon/clothing/under/yellow( src )
	new /obj/item/weapon/clothing/under/yellow( src )
	new /obj/item/weapon/clothing/under/yellow( src )
	new /obj/item/weapon/clothing/under/yellow( src )
	new /obj/item/weapon/clothing/under/yellow( src )
	new /obj/item/weapon/clothing/under/yellow( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	new /obj/item/weapon/clothing/shoes/orange( src )
	return

/obj/closet/wardrobe/mixed/New()

	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/under/blue( src )
	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/under/pink( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	new /obj/item/weapon/clothing/shoes/brown( src )
	return

/obj/closet/wardrobe/white/New()

	new /obj/item/weapon/clothing/under/white( src )
	new /obj/item/weapon/clothing/under/white( src )
	new /obj/item/weapon/clothing/under/white( src )
	new /obj/item/weapon/clothing/under/white( src )
	new /obj/item/weapon/clothing/under/white( src )
	new /obj/item/weapon/clothing/shoes/white( src )
	new /obj/item/weapon/clothing/shoes/white( src )
	new /obj/item/weapon/clothing/shoes/white( src )
	new /obj/item/weapon/clothing/shoes/white( src )
	new /obj/item/weapon/clothing/shoes/white( src )
	new /obj/item/weapon/storage/lglo_kit( src )
	new /obj/item/weapon/storage/stma_kit( src )
	return

/obj/closet/ex_act(severity)

	switch(severity)
		if(1.0)
			for(var/atom/movable/A as mob|obj in src)
				A.loc = src.loc
				ex_act(severity)
				//Foreach goto(35)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(108)
				src = null
				del(src)
				return
		if(3.0)
			if (prob(5))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(181)
				src = null
				del(src)
				return
		else
	return

/obj/closet/meteorhit(O as obj)

	if (O.icon_state == "flaming")
		for(var/obj/item/I as obj in src)
			I.loc = src.loc
			//Foreach goto(29)
		for(var/M as mob in src)
			M.loc = src.loc
			if (M.client)
				M.eye = M.client.mob
				M.client.perspective = MOB_PERSPECTIVE
			//Foreach goto(71)
		src.icon_state = "emcloset1"
		src = null
		del(src)
		return
	return

/obj/closet/attackby(W as obj, user as mob)

	if ((src.opened || (W.damtype != "fire" || !( istype(W, /obj/item/weapon/weldingtool) ))))
		user.drop_item()
		W.loc = src.loc
	else
		src.welded = !( src.welded )
		for(var/M as mob in viewers(user, null))
			if (M.client)
				M.show_message(text("\red [] has been [] by [].", src, (src.welded ? "welded shut" : "unwelded"), user), 3, "\red You hear welding.", 2)
			//Foreach goto(82)
	return

/obj/closet/relaymove(user as mob)

	if (user.stat)
		return
	if (!( src.welded ))
		for(var/obj/item/I as obj in src)
			I.loc = src.loc
			//Foreach goto(36)
		for(var/M as mob in src)
			M.loc = src.loc
			if (M.client)
				M.eye = M.client.mob
				M.client.perspective = MOB_PERSPECTIVE
			//Foreach goto(78)
		src.icon_state = "emcloset1"
		src.opened = 1
	else
		user << "\blue It's welded shut!"
		for(var/M as mob in hearers(src, null))
			M << text("<FONT size=[]>BANG, bang!</FONT>", max(0, 5 - get_dist(src, M)))
			//Foreach goto(170)
	return

/obj/closet/MouseDrop_T(O as mob|obj, user as mob)

	if ((user.restrained() || user.stat))
		return
	if ((!( istype(O, /atom/movable) ) || (O.anchored || (get_dist(user, src) > 1 || (get_dist(user, O) > 1 || user.contents.Find(src))))))
		return
	step_towards(O, src.loc)
	for(var/M as mob in viewers(user, null))
		if ((M.client && !( M.blinded )))
			M << text("\red [] stuffs [] into []!", user, O, src)
		//Foreach goto(104)
	src.add_fingerprint(user)
	return

/obj/closet/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/closet/attack_hand(user as mob)

	src.add_fingerprint(user)
	if (!( src.opened ))
		if (!( src.welded ))
			for(var/obj/item/I as obj in src)
				I.loc = src.loc
				//Foreach goto(43)
			for(var/M as mob in src)
				if (!( M.buckled ))
					M.loc = src.loc
					if (M.client)
						M.eye = M.client.mob
						M.client.perspective = MOB_PERSPECTIVE
				//Foreach goto(85)
			src.icon_state = "emcloset1"
			src.opened = 1
		else
			usr << "\blue It's welded shut!"
	else
		for(var/obj/item/I as obj in src.loc)
			if (!( I.anchored ))
				I.loc = src
			//Foreach goto(187)
		for(var/M as mob in src.loc)
			if (M.client)
				M.client.perspective = EYE_PERSPECTIVE
				M.client.eye = src
			M.loc = src
			//Foreach goto(237)
		src.icon_state = src.original
		src.opened = 0
	return

/obj/closet/CheckPass(O as mob|obj, target as turf)

	if (!( src.opened ))
		return 0
	else
		return 1
	return

/obj/stool/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				src = null
				del(src)
				return
		if(3.0)
			if (prob(5))
				src = null
				del(src)
				return
		else
	return

/obj/stool/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/weapon/sheet/metal( src.loc )
		src = null
		del(src)
		return
		return
	return

/obj/stool/bed/attackby(W as obj, user as mob)

	return

/obj/stool/chair/attackby(W as obj, user as mob)

	..()
	if (istype(W, /obj/item/weapon/assembly/shock_kit))
		var/obj/stool/chair/e_chair/E = new /obj/stool/chair/e_chair( src.loc )
		E.dir = src.dir
		E.part1 = W
		W.loc = E
		W.master = E
		user.u_equip(W)
		W.layer = W.initial(W.layer)
		src = null
		del(src)
		return
	return

/obj/stool/chair/e_chair/New()

	src.overl = new /atom/movable/overlay( src.loc )
	src.overl.icon = 'Icons.dmi'
	src.overl.icon_state = "e_chairo0"
	src.overl.layer = 5
	src.overl.name = "electrified chair"
	src.overl.master = src
	return

/obj/stool/chair/e_chair/Del()

	src.overl = null
	del(src.overl)
	..()
	return

/obj/stool/chair/e_chair/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wrench))
		var/obj/stool/chair/C = new /obj/stool/chair( src.loc )
		C.dir = src.dir
		src.part1.loc = src.loc
		src.part1.master = null
		src.part1 = null
		src = null
		del(src)
		return
	return

/obj/stool/chair/e_chair/verb/toggle_power()
	set src in oview(1)

	if ((usr.stat || (usr.restrained() || (!( usr.canmove ) || usr.lying))))
		return
	src.on = !( src.on )
	src.icon_state = text("e_chair[]", src.on)
	src.overl.icon_state = text("e_chairo[]", src.on)
	return

/obj/stool/chair/e_chair/proc/shock()

	if (!( src.on ))
		return
	if ((src.last_time + 50) > world.time)
		return
	src.last_time = world.time
	flick("e_chairs", src)
	flick("e_chairos", src.overl)
	for(var/M as mob in src.loc)
		M.burn(7.5E7)
		M << "\red <B>You feel a deep shock curse through your body!</B>"
		sleep(1)
		burn(7.5E7)
		M.stunned = 600
		//Foreach goto(72)
	for(var/M as mob in hearers(src, null))
		if (!( M.blinded ))
			M << "\red The electric chair went off!"
		else
			M << "\red You hear a deep sharp shock."
		//Foreach goto(142)
	return

/obj/stool/chair/ex_act(severity)

	if (severity < 4)
		for(var/M as mob in src.loc)
			M.buckled = null
			//Foreach goto(28)
	switch(severity)
		if(1.0)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				src = null
				del(src)
				return
		if(3.0)
			if (prob(5))
				src = null
				del(src)
				return
		else
	return

/obj/stool/chair/New()

	src.verbs -= /atom/movable/verb/pull
	if (src.dir == NORTH)
		src.layer = FLY_LAYER
	..()
	return

/obj/stool/chair/Del()

	for(var/M as mob in src.loc)
		if (M.buckled == src)
			M.buckled = null
		//Foreach goto(17)
	..()
	return

/obj/stool/chair/verb/rotate()
	set src in oview(1)

	src.dir = turn(src.dir, 90)
	if (src.dir == NORTH)
		src.layer = FLY_LAYER
	else
		src.layer = OBJ_LAYER
	return

/obj/stool/chair/MouseDrop_T(M as mob, user as mob)

	if ((!( istype(M, /mob) ) || (get_dist(src, user) > 1 || (M.loc != src.loc || (user.restrained() || usr.stat)))))
		return
	if (M == usr)
		for(var/O as mob in viewers(user, null))
			if ((O.client && !( O.blinded )))
				O << text("\blue [] buckles in!", user)
			//Foreach goto(83)
	else
		for(var/O as mob in viewers(user, null))
			if ((O.client && !( O.blinded )))
				O << text("\blue [] is buckled in by []!", M, user)
			//Foreach goto(137)
	M.anchored = 1
	M.buckled = src
	M.loc = src.loc
	src.add_fingerprint(user)
	return

/obj/stool/chair/attack_paw(user as mob)

	if ((ticker && ticker.mode == "monkey"))
		return src.attack_hand(user)
	return

/obj/stool/chair/attack_hand(user as mob)

	for(var/M as mob in src.loc)
		if (M.buckled)
			if (M != user)
				for(var/O as mob in viewers(user, null))
					if ((O.client && !( O.blinded )))
						O << text("\blue [] is unbuckled by [].", M, user)
					//Foreach goto(64)
			else
				for(var/O as mob in viewers(user, null))
					if ((O.client && !( O.blinded )))
						O << text("\blue [] unbuckles.", M)
					//Foreach goto(123)
			M.anchored = 0
			M.buckled = null
			src.add_fingerprint(user)
		//Foreach goto(17)
	return

/obj/grille/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				src = null
				del(src)
				return
		if(3.0)
			if (prob(25))
				src.health -= 11
				src.healthcheck()
		else
	return

/obj/grille/meteorhit()

	if (src.icon_state == "flaming")
		src.health -= 3
		src.healthcheck()
	return

/obj/grille/CheckPass(B as obj)

	if ((istype(B, /obj/effects) || (istype(B, /obj/item/weapon/dummy) || (istype(B, /obj/beam) || istype(B, /obj/meteor/small)))))
		return 1
	else
		if (istype(B, /obj/bullet))
			return prob(30)
		else
			return !( src.density )
	return

/obj/grille/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wirecutters))
		src.health = 0
	else
		if ((istype(W, /obj/item/weapon/screwdriver) && (istype(src.loc, /turf/station) || src.anchored)))
			src.anchored = !( src.anchored )
			user << (src.anchored ? "You have fastened the grille to the floor." : "You have unfastened the grill.")
		else
			switch(W.damtype)
				if("fire")
					src.health -= W.force
				if("brute")
					src.health -= src.force * 0.1
				else
	src.healthcheck()
	..()
	return

/obj/grille/proc/healthcheck()

	if (src.health <= 0)
		if (!( src.destroyed ))
			src.icon_state = "brokengrille"
			src.density = 0
			src.destroyed = 1
			new /obj/item/weapon/rods( src.loc )
		else
			if (src.health <= -10.0)
				new /obj/item/weapon/rods( src.loc )
				src = null
				del(src)
				return
	return

/obj/window/las_act(flag)

	if (flag == "bullet")
		new /obj/item/weapon/shard( src.loc )
		src = null
		del(src)
		return
	return

/obj/window/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
			del(src)
			return
		if(2.0)
			new /obj/item/weapon/shard( src.loc )
			src = null
			del(src)
			return
		if(3.0)
			if (prob(50))
				new /obj/item/weapon/shard( src.loc )
				src = null
				del(src)
				return
		else
	return

/obj/window/CheckPass(O as mob|obj, target as turf)

	if (istype(O, /obj/beam))
		return 1
	if (src.dir == SOUTHWEST)
		return 0
	else
		if (get_dir(target, O.loc) == src.dir)
			return 0
	return 1
	return

/obj/window/CheckExit(O as mob|obj, target as turf)

	if (istype(O, /obj/beam))
		return 1
	if (get_dir(O.loc, target) == src.dir)
		return 0
	return 1
	return

/obj/window/meteorhit()

	src.health = 0
	new /obj/item/weapon/shard( src.loc )
	src = null
	del(src)
	return
	return

/obj/window/hitby(W as obj)

	..()
	src.health = max(0, src.health - W.throwforce)
	if (src.health <= 7)
		src.anchored = 0
		step(src, get_dir(W, src))
	if (src.health <= 0)
		new /obj/item/weapon/shard( src.loc )
		src = null
		del(src)
		return
	..()
	return

/obj/window/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/screwdriver))
		src.anchored = !( src.anchored )
		user << (src.anchored ? "You have fastened the window to the floor." : "You have unfastened the window.")
	else
		src.health = max(0, src.health - W.force)
		if (src.health <= 7)
			src.anchored = 0
			step(src, get_dir(user, src))
		if (src.health <= 0)
			if (src.dir == SOUTHWEST)
				var/index = null
				index = 0
				while(index < 2)
					new /obj/item/weapon/shard( src.loc )
					index++
			else
				new /obj/item/weapon/shard( src.loc )
			src = null
			del(src)
			return
		..()
	return

/obj/window/verb/rotate()
	set src in oview(1)

	if (src.anchored)
		usr << "It is fastened to the floor; therefore, you can't rotate it!"
		return 0
	else
		if (src.dir == SOUTHWEST)
			usr << "You can't rotate this! "
			return 0
	src.dir = turn(src.dir, 90)
	src.ini_dir = src.dir
	return

/obj/window/New()

	..()
	src.ini_dir = src.dir
	return

/obj/window/Move()

	..()
	src.dir = src.ini_dir
	return

/atom/proc/meteorhit(meteor as obj)

	return
	return

/atom/proc/allow_drop()

	return 1
	return

/atom/proc/CheckPass(O as mob|obj|turf|area)

	return (!( O.density ) || !( src.density ))
	return

/atom/proc/CheckExit()

	return 1
	return

/atom/proc/HasEntered(AM as mob|obj)

	return

/atom/proc/HasProximity(AM as mob|obj)

	return

/atom/movable/overlay/attackby(a, b)

	if (src.master)
		return src.master.attackby(a, b)
	return

/atom/movable/overlay/attack_paw(a, b, c)

	if (src.master)
		return src.master.attack_paw(a, b, c)
	return

/atom/movable/overlay/attack_hand(a, b, c)

	if (src.master)
		return src.master.attack_hand(a, b, c)
	return

/atom/movable/overlay/New()

	for(var/x in src.verbs)
		src.verbs -= x
		//Foreach goto(17)
	return

/turf/CheckPass(O as mob|obj|turf|area)

	return !( src.density )
	return

/turf/New()

	..()
	for(var/atom/movable/AM as mob|obj in src)
		spawn( 0 )
			src.Entered(AM)
			return
		//Foreach goto(19)
	return

/turf/Enter(O as mob|obj, forget as mob|obj|turf|area)

	if (!( isturf(O.loc) ))
		return 1
	for(var/atom/A as mob|obj|turf|area in O.loc)
		if ((!( A.CheckExit(O, src) ) && (O != A && A != forget)))
			if (O)
				O.Bump(A, 1)
			return 0
		//Foreach goto(34)
	for(var/atom/A as mob|obj|turf|area in src)
		if ((A.flags & 512 && get_dir(A, O) & A.dir))
			if ((!( A.CheckPass(O, src) ) && (A != src && A != forget)))
				if (O)
					O.Bump(A, 1)
				return 0
		//Foreach goto(127)
	for(var/atom/A as mob|obj|turf|area in src)
		if ((!( A.CheckPass(O, src) ) && A != forget))
			if (O)
				O.Bump(A, 1)
			return 0
		//Foreach goto(244)
	if (src != forget)
		if (!( src.CheckPass(O, src) ))
			if (O)
				O.Bump(src, 1)
			return 0
	return 1
	return

/turf/Entered(M as mob|obj)

	..()
	for(var/atom/A as mob|obj|turf|area in src)
		spawn( 0 )
			if ((A && M))
				A.HasEntered(M, 1)
			return
		//Foreach goto(19)
	for(var/atom/A as mob|obj|turf|area in range(1, null))
		spawn( 0 )
			if ((A && M))
				A.HasProximity(M, 1)
			return
		//Foreach goto(86)
	return

/turf/station/r_wall/updatecell()

	if (src.state == 2)
		return
	else
		..()
	return

/turf/station/r_wall/proc/update()

	if (src.d_state > 6)
		src.d_state = 0
		src.state = 1
	if (src.state == 2)
		src.icon_state = text("r_wall[]", (src.d_state > 0 ? text("-[]", src.d_state) : null))
		src.opacity = 1
		src.density = 1
		src.updatecell = 0
	else
		src.icon_state = "r_girder"
		src.opacity = 0
		src.density = 1
		src.updatecell = 1
	return

/turf/station/r_wall/unburn()

	src.update()
	return

/turf/station/r_wall/meteorhit(M as obj)

	if ((M.icon_state == "flaming" && prob(30)))
		if (src.state == 2)
			src.state = 1
			new /obj/item/weapon/sheet/metal( src )
			new /obj/item/weapon/sheet/metal( src )
			update()
		else
			if ((prob(20) && src.state == 1))
				src.state = 0
				var/turf/station/floor/F = new /turf/station/floor( locate(src.x, src.y, src.z) )
				F.oxygen = 756000.0
				new /obj/item/weapon/sheet/metal( F )
				new /obj/item/weapon/sheet/metal( F )
	return

/turf/station/r_wall/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(75))
				src.opacity = 0
				src.updatecell = 1
				src.state = 1
				src.intact = 0
				new /obj/item/weapon/sheet/metal( src )
				new /obj/item/weapon/sheet/metal( src )
			else
				src.state = 0
				var/turf/station/floor/F = new /turf/station/floor( locate(src.x, src.y, src.z) )
				F.burnt = 1
				F.health = 30
				F.icon_state = "Floor1"
				new /obj/item/weapon/sheet/metal( F )
				new /obj/item/weapon/sheet/metal( F )
		if(3.0)
			if (prob(15))
				src.opacity = 0
				src.updatecell = 1
				src.intact = 0
				src.state = 1
				new /obj/item/weapon/sheet/metal( src )
				new /obj/item/weapon/sheet/metal( src )
				src.icon_state = "girder"
				update()
		else
	return

/turf/station/r_wall/attackby(W as obj, user as mob)

	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	if (src.state == 2)
		if (istype(W, /obj/item/weapon/wrench))
			if (src.d_state == 4)
				var/T = user.loc
				user << "\blue Cutting support rods."
				sleep(40)
				if ((user.loc == T && (equipped() == W && !( user.stat ))))
					src.d_state = 5
		else
			if (istype(W, /obj/item/weapon/wirecutters))
				if (src.d_state == 0)
					src.d_state = 1
					new /obj/item/weapon/rods( src )
			else
				if (istype(W, /obj/item/weapon/weldingtool))
					if (src.d_state == 2)
						var/T = user.loc
						user << "\blue Slicing metal cover."
						sleep(60)
						if ((user.loc == T && (equipped() == W && !( user.stat ))))
							src.d_state = 3
					else
						if (src.d_state == 5)
							var/T = user.loc
							user << "\blue Removing support rods."
							sleep(100)
							if ((user.loc == T && (equipped() == W && !( user.stat ))))
								src.d_state = 6
								new /obj/item/weapon/rods( src )
				else
					if (istype(W, /obj/item/weapon/screwdriver))
						if (src.d_state == 1)
							var/T = user.loc
							user << "\blue Removing support lines."
							sleep(40)
							if ((user.loc == T && (equipped() == W && !( user.stat ))))
								src.d_state = 2
					else
						if (istype(W, /obj/item/weapon/crowbar))
							if (src.d_state == 3)
								var/T = user.loc
								user << "\blue Prying cover off."
								sleep(100)
								if ((user.loc == T && (equipped() == W && !( user.stat ))))
									src.d_state = 4
							else
								if (src.d_state == 6)
									var/T = user.loc
									user << "\blue Prying outer sheath off."
									sleep(100)
									if ((user.loc == T && (equipped() == W && !( user.stat ))))
										src.d_state = 7
										new /obj/item/weapon/sheet/metal( src )
						else
							if (istype(W, /obj/item/weapon/sheet/metal))
								var/T = user.loc
								user << "\blue Repairing wall."
								sleep(100)
								if ((user.loc == T && (equipped() == W && (!( user.stat ) && src.state == 2))))
									src.d_state = 0
									if (W.amount > 1)
										W.amount--
									else
										W = null
										del(W)
	if (src.state == 1)
		if (istype(W, /obj/item/weapon/wrench))
			user << "\blue Now dismantling girders."
			var/T = user.loc
			sleep(100)
			if ((user.loc == T && (equipped() == W && !( user.stat ))))
				src.state = 0
				var/turf/station/floor/F = new /turf/station/floor( locate(src.x, src.y, src.z) )
				F.oxygen = 756000.0
				new /obj/item/weapon/sheet/metal( F )
				new /obj/item/weapon/sheet/metal( F )
				new /obj/item/weapon/sheet/metal( F )
				new /obj/item/weapon/sheet/metal( F )
		else
			if (istype(W, /obj/item/weapon/sheet/r_metal))
				F.state = 2
				F.d_state = 0
				W = null
				del(W)
	src.update()
	return

/turf/station/wall/examine()
	set src in oview(1)

	usr << "It looks like a regular wall."
	return

/turf/station/wall/updatecell()

	if (src.state == 2)
		return
	else
		..()
	return

/turf/station/wall/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				src.opacity = 0
				src.updatecell = 1
				src.state = 1
				src.intact = 0
				new /obj/item/weapon/sheet/metal( src )
				new /obj/item/weapon/sheet/metal( src )
				src.icon_state = "girder"
			else
				src.state = 0
				var/turf/station/floor/F = new /turf/station/floor( locate(src.x, src.y, src.z) )
				F.burnt = 1
				F.health = 30
				F.icon_state = "Floor1"
				new /obj/item/weapon/sheet/metal( F )
				new /obj/item/weapon/sheet/metal( F )
		if(3.0)
			if (prob(25))
				src.opacity = 0
				src.updatecell = 1
				src.intact = 0
				src.state = 1
				new /obj/item/weapon/sheet/metal( src )
				new /obj/item/weapon/sheet/metal( src )
				src.icon_state = "girder"
		else
	return

/turf/station/wall/unburn()

	if (src.state == 1)
		src.icon_state = "girder"
	else
		src.icon_state = ""
	return

/turf/station/wall/attack_paw(user as mob)

	if ((ticker && ticker.mode == "monkey"))
		return src.attack_hand(user)
	return

/turf/station/wall/attack_hand(user as mob)

	user << "\blue You push the wall but nothing happens!"
	src.add_fingerprint(user)
	return

/turf/station/wall/attackby(W as obj, user as mob)

	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	if ((istype(W, /obj/item/weapon/wrench) && src.state == 1))
		var/T = user.loc
		if (!( istype(T, /turf) ))
			return
		user << "\blue Now dissembling the reinforced girders. Please stand still. This is a long process."
		sleep(100)
		if (!( istype(src, /turf/station/wall) ))
			return
		if ((user.loc == T && (src.state == 1 && user.equipped() == W)))
			src.state = 0
			var/turf/station/floor/F = new /turf/station/floor( locate(src.x, src.y, src.z) )
			F.oxygen = 756000.0
			new /obj/item/weapon/sheet/metal( F )
			new /obj/item/weapon/sheet/metal( F )
	else
		if ((istype(W, /obj/item/weapon/screwdriver) && src.state == 1))
			var/T = user.loc
			if (!( istype(T, /turf) ))
				return
			user << "\blue Now dislodging girders."
			sleep(100)
			if (!( istype(src, /turf/station/wall) ))
				return
			if ((user.loc == T && (src.state == 1 && user.equipped() == W)))
				src.state = 0
				var/turf/station/floor/F = new /turf/station/floor( locate(src.x, src.y, src.z) )
				F.oxygen = 756000.0
				new /obj/d_girders( F )
				new /obj/item/weapon/sheet/metal( F )
		else
			if ((istype(W, /obj/item/weapon/sheet/r_metal) && src.state == 1))
				var/T = user.loc
				if (!( istype(T, /turf) ))
					return
				user << "\blue Now reinforcing girders."
				sleep(100)
				if (!( istype(src, /turf/station/wall) ))
					return
				if ((user.loc == T && (src.state == 1 && user.equipped() == W)))
					src.state = 0
					var/turf/station/r_wall/F = new /turf/station/r_wall( locate(src.x, src.y, src.z) )
					F.oxygen = 756000.0
					F.icon_state = "r_girder"
					F.state = 1
					F.opacity = 0
					F.updatecell = 1
			else
				if ((istype(W, /obj/item/weapon/weldingtool) && src.state == 2))
					var/T = user.loc
					if (!( istype(T, /turf) ))
						return
					var/WT = W
					if (WT.weldfuel < 5)
						user << "\blue You need more welding fuel to complete this task."
						return
					WT.weldfuel -= 5
					user << "\blue Now dissembling the outer wall plating. Please stand still."
					sleep(50)
					if ((user.loc == T && (src.state == 2 && user.equipped() == W)))
						src.opacity = 0
						src.updatecell = 1
						src.state = 1
						src.intact = 0
						new /obj/item/weapon/sheet/metal( src )
						new /obj/item/weapon/sheet/metal( src )
						src.icon_state = "girder"
	return

/turf/station/wall/meteorhit(M as obj)

	if (M.icon_state == "flaming")
		src.icon_state = "girder"
		if (src.state == 2)
			src.state = 1
			src.opacity = 0
			src.updatecell = 1
			src.firelevel = 11
			new /obj/item/weapon/sheet/metal( src )
			new /obj/item/weapon/sheet/metal( src )
		else
			if ((prob(20) && src.state == 1))
				src.state = 0
				var/turf/station/floor/F = new /turf/station/floor( locate(src.x, src.y, src.z) )
				F.oxygen = 756000.0
				new /obj/item/weapon/sheet/metal( F )
				new /obj/item/weapon/sheet/metal( F )
	return

/turf/station/floor/CheckPass(O as mob|obj)

	if ((istype(O, /obj/machinery/pod) && !( src.burnt )))
		if (!( locate(/obj/machinery/mass_driver, src) ))
			return 0
	return 1
	return

/turf/station/floor/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				src = null
				del(src)
				return
			else
				src.icon_state = "burning"
				src.burnt = 1
				src.health = 30
				src.intact = 0
				src.firelevel = 1800000.0
		if(3.0)
			if (prob(50))
				src.burnt = 1
				src.health = 1
				src.intact = 0
				src.icon_state = "Floor1"
		else
	return

/turf/station/floor/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/turf/station/floor/attack_hand(user as mob)

	if ((!( user.canmove ) || (restrained() || !( user.pulling ))))
		return
	if (user.pulling.anchored)
		return
	if ((user.pulling.loc != user.loc && get_dist(user, user.pulling) > 1))
		return
	if (ismob(user.pulling))
		var/M = user.pulling
		var/t = M.pulling
		M.pulling = null
		step(user.pulling, get_dir(user.pulling.loc, src))
		M.pulling = t
	else
		step(M.pulling, get_dir(user.pulling.loc, src))
	return

/turf/station/floor/attackby(C as obj, user as mob)

	if (istype(C, /obj/item/weapon/crowbar))
		if (src.health > 100)
			src.health = 100
			src.burnt = 1
			src.intact = 0
			new /obj/item/weapon/tile( src )
			src.icon_state = text("Floor[]", (src.burnt ? "1" : ""))
	else
		if (istype(C, /obj/item/weapon/tile))
			if (src.health <= 100)
				src.intact = 1
				src.health = 150
				src.burnt = 0
				if (src.firelevel >= 900000.0)
					src.icon_state = "burning"
				else
					src.icon_state = "Floor"
				var/T = C
				T.amount--
				if (T.amount < 1)
					T = null
					del(T)
	return

/turf/station/floor/unburn()

	src.icon_state = text("Floor[]", (src.burnt ? "1" : ""))
	return

/turf/station/floor/updatecell()

	..()
	if (src.checkfire)
		if (src.firelevel >= 2700000.0)
			src.health--
		if (src.health <= 0)
			src.burnt = 1
			src.intact = 0
			src = null
			del(src)
			return
		else
			if (src.health <= 100)
				src.burnt = 1
				src.intact = 0
	return

/turf/station/floor/plasma_test/updatecell()

	..()
	src.poison = 7.5E7
	src.res_vars()
	return

/area/New()

	..()
	src.icon = 'alert.dmi'
	src.layer = 10
	return

/area/vehicles/New()

	..()
	sleep(1)
	var/obj/shut_controller/S = new /obj/shut_controller(  )
	shuttles += S
	for(var/obj/move/O as obj in src)
		S.parts += O
		O.master = S
		//Foreach goto(42)
	spawn( 5 )
		world << "Vehicle loaded!"
		return
	return

/area/proc/firealert()

	if (!( src.fire ))
		if ((src.icon_state == "red" || src.icon_state == "blue-red"))
			src.icon_state = "blue-red"
		else
			src.icon_state = "blue"
		src.fire = 1
		for(var/obj/machinery/door/firedoor/D as obj in src)
			if (!( D.density ))
				spawn( 0 )
					closefire()
					return
			//Foreach goto(74)
	return
