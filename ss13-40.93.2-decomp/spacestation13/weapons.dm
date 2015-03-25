
/obj/machinery/nuclearbomb/New()

	if (nuke_code)
		src.r_code = text("[]", nuke_code)
	..()
	return

/obj/machinery/nuclearbomb/process()

	if (src.timing)
		src.timeleft--
		if (src.timeleft <= 0)
			src.explode()
		for(var/M as mob in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
			//Foreach goto(46)
	return

/obj/machinery/nuclearbomb/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/nuclearbomb/attack_hand(user as mob)

	if (src.extended)
		user.machine = src
		var/dat = text("<TT><B>Nuclear Fission Explosive</B><BR>\nAuth. Disk: <A href='?src=\ref[];auth=1'>[]</A><HR>", src, (src.auth ? "++++++++++" : "----------"))
		if (src.auth)
			if (src.yes_code)
				dat += text("\n<B>Status</B>: []-[]<BR>\n<B>Timer</B>: []<BR>\n<BR>\nTimer: [] <A href='?src=\ref[];timer=1'>Toggle</A><BR>\nTime: <A href='?src=\ref[];time=-10'>-</A> <A href='?src=\ref[];time=-1'>-</A> [] <A href='?src=\ref[];time=1'>+</A> <A href='?src=\ref[];time=10'>+</A><BR>\n<BR>\nSafety: [] <A href='?src=\ref[];safety=1'>Toggle</A><BR>\nAnchor: [] <A href='?src=\ref[];anchor=1'>Toggle</A><BR>\n", (src.timing ? "Func/Set" : "Functional"), (src.safety ? "Safe" : "Engaged"), src.timeleft, (src.timing ? "On" : "Off"), src, src, src, src.timeleft, src, src, (src.safety ? "On" : "Off"), src, (src.anchored ? "Engaged" : "Off"), src)
			else
				dat += text("\n<B>Status</B>: Auth. S2-[]<BR>\n<B>Timer</B>: []<BR>\n<BR>\nTimer: [] Toggle<BR>\nTime: - - [] + +<BR>\n<BR>\n[] Safety: Toggle<BR>\nAnchor: [] Toggle<BR>\n", (src.safety ? "Safe" : "Engaged"), src.timeleft, (src.timing ? "On" : "Off"), src.timeleft, (src.safety ? "On" : "Off"), (src.anchored ? "Engaged" : "Off"))
		else
			if (src.timing)
				dat += text("\n<B>Status</B>: Set-[]<BR>\n<B>Timer</B>: []<BR>\n<BR>\nTimer: [] Toggle<BR>\nTime: - - [] + +<BR>\n<BR>\nSafety: [] Toggle<BR>\nAnchor: [] Toggle<BR>\n", (src.safety ? "Safe" : "Engaged"), src.timeleft, (src.timing ? "On" : "Off"), src.timeleft, (src.safety ? "On" : "Off"), (src.anchored ? "Engaged" : "Off"))
			else
				dat += text("\n<B>Status</B>: Auth. S1-[]<BR>\n<B>Timer</B>: []<BR>\n<BR>\nTimer: [] Toggle<BR>\nTime: - - [] + +<BR>\n<BR>\nSafety: [] Toggle<BR>\nAnchor: [] Toggle<BR>\n", (src.safety ? "Safe" : "Engaged"), src.timeleft, (src.timing ? "On" : "Off"), src.timeleft, (src.safety ? "On" : "Off"), (src.anchored ? "Engaged" : "Off"))
		var/message = "AUTH"
		if (src.auth)
			message = text("[]", src.code)
			if (src.yes_code)
				message = "*****"
		dat += text("<HR>\n>[]<BR>\n<A href='?src=\ref[];type=1'>1</A>-<A href='?src=\ref[];type=2'>2</A>-<A href='?src=\ref[];type=3'>3</A><BR>\n<A href='?src=\ref[];type=4'>4</A>-<A href='?src=\ref[];type=5'>5</A>-<A href='?src=\ref[];type=6'>6</A><BR>\n<A href='?src=\ref[];type=7'>7</A>-<A href='?src=\ref[];type=8'>8</A>-<A href='?src=\ref[];type=9'>9</A><BR>\n<A href='?src=\ref[];type=R'>R</A>-<A href='?src=\ref[];type=0'>0</A>-<A href='?src=\ref[];type=E'>E</A><BR>\n</TT>", message, src, src, src, src, src, src, src, src, src, src, src, src)
		user << browse(dat, "window=nuclearbomb;size=300x400")
	else
		src.anchored = 1
		flick("nuclearbombc", src)
		src.icon_state = "nuclearbomb1"
		src.extended = 1
	return

/obj/machinery/nuclearbomb/Topic(href, href_list)

	if (usr.stat)
		return
	if ((!( istype(usr, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		usr << "\red You don't have the dexterity to do this!"
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["auth"])
			if (src.auth)
				src.auth.loc = src.loc
				src.yes_code = 0
				src.auth = null
			else
				var/I = usr.equipped()
				if (istype(I, /obj/item/weapon/disk/nuclear))
					usr.drop_item()
					I.loc = src
					src.auth = I
		if (src.auth)
			if (href_list["type"])
				if (href_list["type"] == "E")
					if (src.code == src.r_code)
						src.yes_code = 1
						src.code = null
					else
						src.code = "ERROR"
				else
					if (href_list["type"] == "R")
						src.yes_code = 0
						src.code = null
					else
						src.code += text("[]", href_list["type"])
						if (length(src.code) > 5)
							src.code = "ERROR"
			if (src.yes_code)
				if (href_list["time"])
					var/time = text2num(href_list["time"])
					src.timeleft += time
					src.timeleft = min(max(round(src.timeleft), 5), 600)
				if (href_list["timer"])
					if (src.timing == -1.0)
						return
					src.timing = !( src.timing )
					if (src.timing)
						src.icon_state = "nuclearbomb2"
					else
						src.icon_state = "nuclearbomb1"
				if (href_list["safety"])
					src.safety = !( src.safety )
				if (href_list["anchor"])
					src.anchored = !( src.anchored )
		src.add_fingerprint(usr)
		for(var/M as mob in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
			//Foreach goto(511)
	else
		usr << browse(null, "window=nuclearbomb")
		return
	return

/obj/machinery/nuclearbomb/ex_act()

	if (src.timing == -1.0)
		return
	else
		return ..()
	return

/obj/machinery/nuclearbomb/proc/explode()

	if (src.safety)
		src.timing = 0
		return
	src.timing = -1.0
	src.yes_code = 0
	src.icon_state = "nuclearbomb3"
	sleep(20)
	var/T = src.loc
	while(!( istype(T, /turf) ))
		T = T.loc
	var/min = 50
	var/med = 250
	var/max = 500
	var/sw = locate(1, 1, T.z)
	var/ne = locate(world.maxx, world.maxy, T.z)
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
			//Foreach goto(404)
		U.ex_act(zone)
		//Foreach goto(148)
	ticker.nuclear(src.z)
	src = null
	del(src)
	return
	return

/obj/item/weapon/infra_sensor/New()

	..()
	spawn( 0 )
		src.process()
		return
	return

/obj/item/weapon/infra_sensor/proc/process()

	if (src.passive)
		for(var/obj/beam/i_beam/I as obj in range(2, src.loc))
			I.left = 2
			//Foreach goto(30)
	spawn( 10 )
		src.process()
		return
	return

/obj/item/weapon/infra_sensor/proc/burst()

	for(var/obj/beam/i_beam/I as obj in range(src.loc, null))
		I.left = 10
		//Foreach goto(22)
	for(var/obj/item/weapon/infra/I as obj in range(src.loc, null))
		I.visible = 1
		spawn( 0 )
			if ((I && I.first))
				I.first.vis_spread(1)
			return
		//Foreach goto(69)
	for(var/obj/item/weapon/assembly/rad_infra/I as obj in range(src.loc, null))
		I.part2.visible = 1
		spawn( 0 )
			if ((I.part2 && I.part2.first))
				I.part2.first.vis_spread(1)
			return
		//Foreach goto(145)
	return

/obj/item/weapon/infra_sensor/attack_self(user as mob)

	user.machine = src
	var/dat = text("<TT><B>Infrared Sensor</B><BR>\n<B>Passive Emitter</B>: []<BR>\n<B>Active Emitter</B>: <A href='?src=\ref[];active=0'>Burst Fire</A>\n</TT>", (src.passive ? text("<A href='?src=\ref[];passive=0'>On</A>", src) : text("<A href='?src=\ref[];passive=1'>Off</A>", src)), src)
	user << browse(dat, "window=infra_sensor")
	return

/obj/item/weapon/infra_sensor/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (usr.contents.Find(src.master) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf)))))
		usr.machine = src
		if (href_list["passive"])
			src.passive = !( src.passive )
		if (href_list["active"])
			spawn( 0 )
				src.burst()
				return
		if (!( src.master ))
			if (istype(src.loc, /mob))
				attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(164)
		else
			if (istype(src.master.loc, /mob))
				src.attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src.master))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(240)
		src.add_fingerprint(usr)
	else
		usr << browse(null, "window=infra_sensor")
		return
	return

/obj/item/weapon/prox_sensor/dropped()

	spawn( 0 )
		src.sense()
		return
	return

/obj/item/weapon/prox_sensor/proc/sense()

	if (src.state)
		if (src.master)
			spawn( 0 )
				src.master.r_signal(1, src)
				return
		else
			for(var/O as mob in hearers(null, null))
				O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)
				//Foreach goto(58)
	return

/obj/item/weapon/prox_sensor/HasProximity(AM as mob|obj)

	if (istype(AM, /obj/beam))
		return
	if (AM.move_speed < 12)
		src.sense()
	return

/obj/item/weapon/prox_sensor/attackby(S as obj, user as mob)

	if ((!( istype(S, /obj/item/weapon/radio/signaler) ) || !( S.b_stat )))
		return
	var/obj/item/weapon/assembly/rad_prox/R = new /obj/item/weapon/assembly/rad_prox( user )
	S.loc = R
	R.part1 = S
	S.layer = S.initial(S.layer)
	if (user.client)
		user.client.screen -= S
	if (user.r_hand == S)
		u_equip(S)
		user.r_hand = R
	else
		u_equip(S)
		user.l_hand = R
	S.master = R
	src.master = R
	src.layer = initial(src.layer)
	user.u_equip(src)
	if (user.client)
		user.client.screen -= src
	src.loc = R
	R.part2 = src
	R.layer = 20
	R.loc = user
	R.dir = src.dir
	src.add_fingerprint(user)
	return

/obj/item/weapon/prox_sensor/attack_self(user as mob)

	user.machine = src
	var/dat = text("<TT><B>Proximity Sensor</B>\n<B>Status</B>: []<BR>\n[]\n</TT>", (src.state ? text("<A href='?src=\ref[];state=0'>On</A>", src) : text("<A href='?src=\ref[];state=1'>Off</A>", src)), (src.state ? "Time On (10)" : text("<A href='?src=\ref[];time=1'>Time On (10)</A>", src)))
	user << browse(dat, "window=prox")
	return

/obj/item/weapon/prox_sensor/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (usr.contents.Find(src.master) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf)))))
		usr.machine = src
		if (href_list["state"])
			src.state = !( src.state )
			src.icon_state = text("motion[]", src.state)
			if (src.master)
				src.master.c_state(src.state, src)
		if (href_list["time"])
			spawn( 100 )
				if (src.state == 0)
					src.state = !( src.state )
					src.icon_state = text("motion[]", src.state)
					if (src.master)
						src.master.c_state(src.state, src)
				return
		if (!( src.master ))
			if (istype(src.loc, /mob))
				attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(234)
		else
			if (istype(src.master.loc, /mob))
				src.attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src.master))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(310)
	else
		usr << browse(null, "window=prox")
		return
	return

/obj/item/weapon/prox_sensor/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/prox_sensor/Move()

	..()
	src.sense()
	return

/obj/item/weapon/infra/proc/hit()

	if (src.master)
		spawn( 0 )
			src.master.r_signal(1, src)
			return
	else
		for(var/O as mob in hearers(null, null))
			O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)
			//Foreach goto(51)
	return

/obj/item/weapon/infra/proc/process()

	if ((!( src.first ) && (src.state && (istype(src.loc, /turf) || (src.master && istype(src.master.loc, /turf))))))
		var/obj/beam/i_beam/I = new /obj/beam/i_beam( (src.master ? src.master.loc : src.loc) )
		I.master = src
		I.density = 1
		I.dir = src.dir
		step(I, I.dir)
		if (I)
			I.density = 0
			src.first = I
			I.vis_spread(src.visible)
			spawn( 0 )
				if (I)
					I.limit = 20
					I.process()
				return
	if (!( src.state ))
		src.first = null
		del(src.first)
	spawn( 10 )
		src.process()
		return
	return

/obj/item/weapon/infra/attackby(S as obj, user as mob)

	if ((!( istype(S, /obj/item/weapon/radio/signaler) ) || !( S.b_stat )))
		return
	var/obj/item/weapon/assembly/rad_infra/R = new /obj/item/weapon/assembly/rad_infra( user )
	S.loc = R
	R.part1 = S
	S.layer = S.initial(S.layer)
	if (user.client)
		user.client.screen -= S
	if (user.r_hand == S)
		u_equip(S)
		user.r_hand = R
	else
		u_equip(S)
		user.l_hand = R
	S.master = R
	src.master = R
	src.layer = initial(src.layer)
	user.u_equip(src)
	if (user.client)
		user.client.screen -= src
	src.loc = R
	R.part2 = src
	R.layer = 20
	R.loc = user
	R.dir = src.dir
	src.add_fingerprint(user)
	return

/obj/item/weapon/infra/New()

	spawn( 0 )
		src.process()
		return
	..()
	return

/obj/item/weapon/infra/attack_self(user as mob)

	user.machine = src
	var/dat = text("<TT><B>Infrared Laser</B>\n<B>Status</B>: []<BR>\n<B>Visibility</B>: []<BR>\n</TT>", (src.state ? text("<A href='?src=\ref[];state=0'>On</A>", src) : text("<A href='?src=\ref[];state=1'>Off</A>", src)), (src.visible ? text("<A href='?src=\ref[];visible=0'>Visible</A>", src) : text("<A href='?src=\ref[];visible=1'>Invisible</A>", src)))
	user << browse(dat, "window=infra")
	return

/obj/item/weapon/infra/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (usr.contents.Find(src.master) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf)))))
		usr.machine = src
		if (href_list["state"])
			src.state = !( src.state )
			src.icon_state = text("infrared[]", src.state)
			if (src.master)
				src.master.c_state(src.state, src)
		if (href_list["visible"])
			src.visible = !( src.visible )
			spawn( 0 )
				if (src.first)
					src.first.vis_spread(src.visible)
				return
		if (!( src.master ))
			if (istype(src.loc, /mob))
				attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(211)
		else
			if (istype(src.master.loc, /mob))
				src.attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src.master))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(287)
	else
		usr << browse(null, "window=infra")
		return
	return

/obj/item/weapon/infra/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/infra/attack_hand()

	src.first = null
	del(src.first)
	..()
	return

/obj/item/weapon/infra/Move()

	var/t = src.dir
	..()
	src.dir = t
	src.first = null
	del(src.first)
	return

/obj/item/weapon/infra/verb/rotate()
	set src in usr

	src.dir = turn(src.dir, 90)
	return

/obj/item/weapon/timer/proc/time()

	if (src.master)
		spawn( 0 )
			src.master.r_signal(1, src)
			return
	else
		for(var/O as mob in hearers(null, null))
			O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)
			//Foreach goto(51)
	return

/obj/item/weapon/timer/proc/process()

	if (src.timing)
		if (src.time > 0)
			src.time = round(src.time) - 1
		else
			time()
			src.time = 0
			src.timing = 0
		if (!( src.master ))
			if (istype(src.loc, /mob))
				attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(100)
		else
			if (istype(src.master.loc, /mob))
				src.attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src.master))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(176)
	spawn( 10 )
		src.process()
		return
	return

/obj/item/weapon/timer/attackby(S as obj, user as mob)

	if ((!( istype(S, /obj/item/weapon/radio/signaler) ) || !( S.b_stat )))
		return
	var/obj/item/weapon/assembly/rad_time/R = new /obj/item/weapon/assembly/rad_time( user )
	S.loc = R
	R.part1 = S
	S.layer = S.initial(S.layer)
	if (user.client)
		user.client.screen -= S
	if (user.r_hand == S)
		u_equip(S)
		user.r_hand = R
	else
		u_equip(S)
		user.l_hand = R
	S.master = R
	src.master = R
	src.layer = initial(src.layer)
	user.u_equip(src)
	if (user.client)
		user.client.screen -= src
	src.loc = R
	R.part2 = src
	R.layer = 20
	R.loc = user
	R.dir = src.dir
	src.add_fingerprint(user)
	R.add_fingerprint(user)
	return

/obj/item/weapon/timer/New()

	spawn( 0 )
		src.process()
		return
	..()
	return

/obj/item/weapon/timer/attack_self(user as mob)

	user.machine = src
	var/second = src.time % 60
	var/minute = (src.time - second) / 60
	var/dat = text("<TT><B>Timing Unit</B>\n[] []:[]\n<A href='?src=\ref[];tp=-30'>-</A> <A href='?src=\ref[];tp=-1'>-</A> <A href='?src=\ref[];tp=1'>+</A> <A href='?src=\ref[];tp=30'>+</A>\n</TT>", (src.timing ? text("<A href='?src=\ref[];time=0'>Timing</A>", src) : text("<A href='?src=\ref[];time=1'>Not Timing</A>", src)), minute, second, src, src, src, src)
	user << browse(dat, "window=timer")
	return

/obj/item/weapon/timer/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (usr.contents.Find(src.master) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf)))))
		usr.machine = src
		if (href_list["time"])
			src.timing = text2num(href_list["time"])
		if (href_list["tp"])
			var/tp = text2num(href_list["tp"])
			src.time += tp
			src.time = min(max(round(src.time), 0), 600)
		if (!( src.master ))
			if (istype(src.loc, /mob))
				attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(192)
		else
			if (istype(src.master.loc, /mob))
				src.attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src.master))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(268)
		src.add_fingerprint(usr)
	else
		usr << browse(null, "window=timer")
		return
	return

/obj/item/weapon/assembly/proc/r_signal(signal)

	return

/obj/item/weapon/assembly/proc/c_state(n, O as obj)

	return

/obj/item/weapon/assembly/shock_kit/Del()

	src.part1 = null
	del(src.part1)
	src.part2 = null
	del(src.part2)
	..()
	return

/obj/item/weapon/assembly/shock_kit/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/wrench) && !( src.status )))
		var/T = src.loc
		if (ismob(T))
			T = T.loc
		src.part1.loc = T
		src.part2.loc = T
		src.part1.master = null
		src.part2.master = null
		src.part1 = null
		src.part2 = null
		src = null
		del(src)
		return
	if (!( istype(W, /obj/item/weapon/screwdriver) ))
		return
	src.status = !( src.status )
	if (src.status)
		user.show_message("\blue The shock pack is now secured!", 1)
	else
		user.show_message("\blue The shock pack is now unsecured!", 1)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/shock_kit/attack_self(user as mob)

	src.part1.attack_self(user, src.status)
	src.part2.attack_self(user, src.status)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/shock_kit/r_signal(n, source)

	if (istype(src.loc, /obj/stool/chair/e_chair))
		var/C = src.loc
		C.shock()
	return

/obj/item/weapon/assembly/rad_time/Del()

	src.part1 = null
	del(src.part1)
	src.part2 = null
	del(src.part2)
	..()
	return

/obj/item/weapon/assembly/rad_time/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/wrench) && !( src.status )))
		var/T = src.loc
		if (ismob(T))
			T = T.loc
		src.part1.loc = T
		src.part2.loc = T
		src.part1.master = null
		src.part2.master = null
		src.part1 = null
		src.part2 = null
		src = null
		del(src)
		return
	if (!( istype(W, /obj/item/weapon/screwdriver) ))
		return
	src.status = !( src.status )
	if (src.status)
		user.show_message("\blue The signaler is now secured!", 1)
	else
		user.show_message("\blue The signaler is now unsecured!", 1)
	src.part1.b_stat = !( src.status )
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/rad_time/attack_self(user as mob)

	src.part1.attack_self(user, src.status)
	src.part2.attack_self(user, src.status)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/rad_time/r_signal(n, source)

	if (source == src.part2)
		src.part1.s_signal(1)
	return

/obj/item/weapon/assembly/rad_prox/c_state(n)

	src.icon_state = text("motion[]", n)
	return

/obj/item/weapon/assembly/rad_prox/Del()

	src.part1 = null
	del(src.part1)
	src.part2 = null
	del(src.part2)
	..()
	return

/obj/item/weapon/assembly/rad_prox/HasProximity(AM as mob|obj)

	if (istype(AM, /obj/beam))
		return
	if (AM.move_speed < 12)
		src.part2.sense()
	return

/obj/item/weapon/assembly/rad_prox/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/wrench) && !( src.status )))
		var/T = src.loc
		if (ismob(T))
			T = T.loc
		src.part1.loc = T
		src.part2.loc = T
		src.part1.master = null
		src.part2.master = null
		src.part1 = null
		src.part2 = null
		src = null
		del(src)
		return
	if (!( istype(W, /obj/item/weapon/screwdriver) ))
		return
	src.status = !( src.status )
	if (src.status)
		user.show_message("\blue The proximity sensor is now secured!", 1)
	else
		user.show_message("\blue The proximity sensor is now unsecured!", 1)
	src.part1.b_stat = !( src.status )
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/rad_prox/attack_self(user as mob)

	src.part1.attack_self(user, src.status)
	src.part2.attack_self(user, src.status)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/rad_prox/r_signal(n, source)

	if (source == src.part2)
		src.part1.s_signal(1)
	return

/obj/item/weapon/assembly/rad_prox/Move()

	..()
	src.part2.sense()
	return

/obj/item/weapon/assembly/rad_prox/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/assembly/rad_prox/dropped()

	spawn( 0 )
		src.part2.sense()
		return
	return

/obj/item/weapon/assembly/rad_infra/c_state(n)

	src.icon_state = text("infrared[]", n)
	return

/obj/item/weapon/assembly/rad_infra/Del()

	src.part1 = null
	del(src.part1)
	src.part2 = null
	del(src.part2)
	..()
	return

/obj/item/weapon/assembly/rad_infra/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/wrench) && !( src.status )))
		var/T = src.loc
		if (ismob(T))
			T = T.loc
		src.part1.loc = T
		src.part2.loc = T
		src.part1.master = null
		src.part2.master = null
		src.part1 = null
		src.part2 = null
		src = null
		del(src)
		return
	if (!( istype(W, /obj/item/weapon/screwdriver) ))
		return
	src.status = !( src.status )
	if (src.status)
		user.show_message("\blue The infrared laser is now secured!", 1)
	else
		user.show_message("\blue The infrared laser is now unsecured!", 1)
	src.part1.b_stat = !( src.status )
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/rad_infra/attack_self(user as mob)

	src.part1.attack_self(user, src.status)
	src.part2.attack_self(user, src.status)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/rad_infra/r_signal(n, source)

	if (source == src.part2)
		src.part1.s_signal(1)
	return

/obj/item/weapon/assembly/rad_infra/verb/rotate()
	set src in usr

	src.dir = turn(src.dir, 90)
	src.part2.dir = src.dir
	src.add_fingerprint(usr)
	return

/obj/item/weapon/assembly/rad_infra/Move()

	var/t = src.dir
	..()
	src.dir = t
	src.first = null
	del(src.part2.first)
	return

/obj/item/weapon/assembly/rad_infra/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/assembly/rad_infra/attack_hand(M)

	src.first = null
	del(src.part2.first)
	..()
	return

/obj/item/weapon/assembly/prox_ignite/HasProximity(AM as mob|obj)

	if (istype(AM, /obj/beam))
		return
	if (AM.move_speed < 12)
		src.part1.sense()
	return

/obj/item/weapon/assembly/prox_ignite/dropped()

	spawn( 0 )
		src.part1.sense()
		return
	return

/obj/item/weapon/assembly/prox_ignite/Del()

	src.part1 = null
	del(src.part1)
	src.part2 = null
	del(src.part2)
	..()
	return

/obj/item/weapon/assembly/prox_ignite/c_state(n)

	src.icon_state = text("prox_igniter[]", n)
	return

/obj/item/weapon/assembly/prox_ignite/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/wrench) && !( src.status )))
		var/T = src.loc
		if (ismob(T))
			T = T.loc
		src.part1.loc = T
		src.part2.loc = T
		src.part1.master = null
		src.part2.master = null
		src.part1 = null
		src.part2 = null
		src = null
		del(src)
		return
	if (!( istype(W, /obj/item/weapon/screwdriver) ))
		return
	src.status = !( src.status )
	if (src.status)
		user.show_message("\blue The proximity sensor is now secured! The igniter now works!", 1)
	else
		user.show_message("\blue The proximity sensor is now unsecured! The igniter will not work.", 1)
	src.part2.status = src.status
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/prox_ignite/attack_self(user as mob)

	src.part1.attack_self(user, src.status)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/prox_ignite/r_signal()

	for(var/O as mob in hearers(1, src.loc))
		O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)
		//Foreach goto(20)
	src.part2.ignite()
	return

/obj/item/weapon/assembly/rad_ignite/Del()

	src.part1 = null
	del(src.part1)
	src.part2 = null
	del(src.part2)
	..()
	return

/obj/item/weapon/assembly/rad_ignite/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/wrench) && !( src.status )))
		var/T = src.loc
		if (ismob(T))
			T = T.loc
		src.part1.loc = T
		src.part2.loc = T
		src.part1.master = null
		src.part2.master = null
		src.part1 = null
		src.part2 = null
		src = null
		del(src)
		return
	if (!( istype(W, /obj/item/weapon/screwdriver) ))
		return
	src.status = !( src.status )
	if (src.status)
		user.show_message("\blue The radio is now secured! The igniter now works!", 1)
	else
		user.show_message("\blue The radio is now unsecured! The igniter will not work.", 1)
	src.part2.status = src.status
	src.part1.b_stat = !( src.status )
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/rad_ignite/attack_self(user as mob)

	src.part1.attack_self(user, src.status)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/rad_ignite/r_signal()

	for(var/O as mob in hearers(1, src.loc))
		O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)
		//Foreach goto(20)
	src.part2.ignite()
	return

/obj/item/weapon/assembly/m_i_ptank/c_state(n)

	src.icon_state = text("m_i_ptank[]", n)
	return

/obj/item/weapon/assembly/m_i_ptank/HasProximity(AM as mob|obj)

	if (istype(AM, /obj/beam))
		return
	if (AM.move_speed < 12)
		src.part1.sense()
	return

/obj/item/weapon/assembly/m_i_ptank/dropped()

	spawn( 0 )
		src.part1.sense()
		return
	return

/obj/item/weapon/assembly/m_i_ptank/Del()

	src.part1 = null
	del(src.part1)
	src.part2 = null
	del(src.part2)
	src.part3 = null
	del(src.part3)
	..()
	return

/obj/item/weapon/assembly/m_i_ptank/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/wrench) && !( src.status )))
		var/obj/item/weapon/assembly/prox_ignite/R = new /obj/item/weapon/assembly/prox_ignite(  )
		R.part1 = src.part1
		R.part2 = src.part2
		R.loc = src.loc
		if (user.r_hand == src)
			user.r_hand = R
			R.layer = 20
		else
			if (R.l_hand == src)
				R.l_hand = R
				R.layer = 20
		src.part1.loc = R
		src.part2.loc = R
		src.part1.master = R
		src.part2.master = R
		var/T = src.loc
		if (!( istype(T, /turf) ))
			T = T.loc
		if (!( istype(T, /turf) ))
			T = T.loc
		src.part3.loc = T
		src.part1 = null
		src.part2 = null
		src.part3 = null
		src = null
		del(src)
		return
	if (!( istype(W, /obj/item/weapon/weldingtool) ))
		return
	if (!( src.status ))
		src.status = 1
		bombers -= user.ckey
		bombers += user.ckey
		show_message("\blue A pressure hole has been bored to the plasma tank valve. The plasma tank can now be ignited.", 1)
	else
		user.status = 0
		user << "\blue The hole has been closed."
	src.part2.status = src.status
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/m_i_ptank/attack_self(user as mob)

	src.part1.attack_self(user, 1)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/m_i_ptank/r_signal()

	for(var/O as mob in hearers(1, null))
		O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)
		//Foreach goto(19)
	if ((src.status && prob(90)))
		src.part3.ignite()
	return

/obj/item/weapon/assembly/r_i_ptank/Del()

	src.part1 = null
	del(src.part1)
	src.part2 = null
	del(src.part2)
	src.part3 = null
	del(src.part3)
	..()
	return

/obj/item/weapon/assembly/r_i_ptank/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/wrench) && !( src.status )))
		var/obj/item/weapon/assembly/rad_ignite/R = new /obj/item/weapon/assembly/rad_ignite(  )
		R.part1 = src.part1
		R.part2 = src.part2
		R.loc = src.loc
		if (user.r_hand == src)
			user.r_hand = R
			R.layer = 20
		else
			if (R.l_hand == src)
				R.l_hand = R
				R.layer = 20
		src.part1.loc = R
		src.part2.loc = R
		src.part1.master = R
		src.part2.master = R
		var/T = src.loc
		if (!( istype(T, /turf) ))
			T = T.loc
		if (!( istype(T, /turf) ))
			T = T.loc
		src.part3.loc = T
		src.part1 = null
		src.part2 = null
		src.part3 = null
		src = null
		del(src)
		return
	if (!( istype(W, /obj/item/weapon/weldingtool) ))
		return
	if (!( src.status ))
		src.status = 1
		bombers -= user.ckey
		bombers += user.ckey
		show_message("\blue A pressure hole has been bored to the plasma tank valve. The plasma tank can now be ignited.", 1)
	else
		user.status = 0
		user << "\blue The hole has been closed."
	src.part2.status = src.status
	src.part1.b_stat = !( src.status )
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/r_i_ptank/attack_self(user as mob)

	if (src.part1)
		src.part1.attack_self(user, 1)
	src.add_fingerprint(user)
	return

/obj/item/weapon/assembly/r_i_ptank/r_signal()

	for(var/O as mob in hearers(1, null))
		O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)
		//Foreach goto(19)
	if ((src.status && prob(90)))
		src.part3.ignite()
	return

/obj/bullet/Bump(A as mob|obj|turf|area)

	spawn( 0 )
		A.las_act("bullet", src)
		src = null
		del(src)
		return
		return
	return

/obj/bullet/CheckPass(B as obj)

	if (istype(B, /obj/bullet))
		return prob(95)
	else
		return 1
	return

/obj/bullet/proc/process()

	if ((!( src.current ) || src.loc == src.current))
		src.current = locate(min(max(src.x + src.xo, 1), world.maxx), min(max(src.y + src.yo, 1), world.maxy), src.z)
	if ((src.x == 1 || (src.x == world.maxx || (src.y == 1 || src.y == world.maxy))))
		src = null
		del(src)
		return
	step_towards(src, src.current)
	spawn( 1 )
		src.process()
		return
	return

/obj/beam/a_laser/Bump(A as mob|obj|turf|area)

	spawn( 0 )
		A.las_act(null, src)
		src = null
		del(src)
		return
		return
	return

/obj/beam/a_laser/proc/process()

	if ((!( src.current ) || src.loc == src.current))
		src.current = locate(min(max(src.x + src.xo, 1), world.maxx), min(max(src.y + src.yo, 1), world.maxy), src.z)
	if ((src.x == 1 || (src.x == world.maxx || (src.y == 1 || src.y == world.maxy))))
		src = null
		del(src)
		return
	step_towards(src, src.current)
	src.life--
	if (src.life <= 0)
		src = null
		del(src)
		return
	spawn( 1 )
		src.process()
		return
	return

/obj/beam/a_laser/s_laser/Bump(A as mob|obj|turf|area)

	spawn( 0 )
		A.las_act(1)
		src = null
		del(src)
		return
		return
	return

/obj/beam/i_beam/proc/hit()

	if (src.master)
		src.master.hit()
	src = null
	del(src)
	return
	return

/obj/beam/i_beam/proc/vis_spread(v)

	src.visible = v
	spawn( 0 )
		if (src.next)
			src.next.vis_spread(v)
		return
	return

/obj/beam/i_beam/proc/process()

	if ((src.loc.density || !( src.master )))
		src = null
		del(src)
		return
	if (src.left > 0)
		src.left--
	if (src.left < 1)
		if (!( src.visible ))
			src.invisibility = 100
		else
			src.invisibility = 0
	else
		src.invisibility = 0
	var/obj/beam/i_beam/I = new /obj/beam/i_beam( src.loc )
	I.master = src.master
	I.density = 1
	I.dir = src.dir
	step(I, I.dir)
	if (I)
		if (!( src.next ))
			I.density = 0
			I.vis_spread(src.visible)
			src.next = I
			spawn( 0 )
				if ((I && src.limit > 0))
					I.limit = src.limit - 1
					I.process()
				return
		else
			I = null
			del(I)
	else
		src.next = null
		del(src.next)
	spawn( 10 )
		src.process()
		return
	return

/obj/beam/i_beam/Bump()

	src = null
	del(src)
	return
	return

/obj/beam/i_beam/Bumped()

	src.hit()
	return

/obj/beam/i_beam/HasEntered(AM as mob|obj)

	if (istype(AM, /obj/beam))
		return
	spawn( 0 )
		src.hit()
		return
	return

/obj/beam/i_beam/Del()

	src.next = null
	del(src.next)
	..()
	return

/atom/proc/ex_act()

	return

/atom/proc/las_act()

	return

/turf/Entered(A as mob|obj)

	..()
	if ((A && (A.density && !( istype(A, /obj/beam) ))))
		for(var/obj/beam/i_beam/I as obj in src)
			spawn( 0 )
				if (I)
					I.hit()
				return
			//Foreach goto(44)
	return
