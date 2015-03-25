
/obj/machinery/computer/prison_shuttle/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
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

/obj/machinery/computer/prison_shuttle/verb/take_off()
	set src in oview(1)

	if ((usr.stat || usr.restrained()))
		return
	src.add_fingerprint(usr)
	if (prison_entered)
		var/A = locate(/area/shuttle)
		for(var/T as turf in A)
			if (T.z == 1)
				for(var/atom/movable/AM as mob|obj in T)
					AM.z = 12
					//Foreach goto(96)
				var/U = locate(T.x, T.y, 12)
				U.oxygen = T.oxygen
				U.oldoxy = T.oldoxy
				U.tmpoxy = T.tmpoxy
				U.poison = T.poison
				U.oldpoison = T.oldpoison
				U.tmppoison = T.tmppoison
				U.co2 = T.co2
				U.oldco2 = T.oldco2
				U.tmpco2 = T.tmpco2
				T = null
				del(T)
			//Foreach goto(62)
		prison_entered = null
	else
		if (!( prison_entered ))
			if (ticker.shuttle_location != 1)
				var/A = locate(/area/shuttle_prison)
				for(var/T as turf in A)
					if (T.z == 12)
						for(var/atom/movable/AM as mob|obj in T)
							AM.z = 1
							//Foreach goto(346)
						var/U = locate(T.x, T.y, 1)
						U.oxygen = T.oxygen
						U.oldoxy = T.oldoxy
						U.tmpoxy = T.tmpoxy
						U.poison = T.poison
						U.oldpoison = T.oldpoison
						U.tmppoison = T.tmppoison
						U.co2 = T.co2
						U.oldco2 = T.oldco2
						U.tmpco2 = T.tmpco2
						T = null
						del(T)
					//Foreach goto(312)
				prison_entered = 1
			else
				usr << "\blue There is an obstructing shuttle!"
				return
	return

/obj/machinery/computer/prison_shuttle/verb/restabalize()
	set src in oview(1)

	viewers(null, null) << "\red <B>Restabalizing prison shuttle atmosphere!</B>"
	var/A = locate(/area/shuttle_prison)
	for(var/obj/move/T as obj in A)
		T.firelevel = 0
		T.oxygen = 756000.0
		T.oldoxy = 756000.0
		T.tmpoxy = 756000.0
		T.poison = 0
		T.oldpoison = 0
		T.tmppoison = 0
		T.co2 = 0
		T.oldco2 = 0
		T.tmpco2 = 0
		T.sl_gas = 0
		T.osl_gas = 0
		T.tsl_gas = 0
		T.n2 = 2844000.0
		T.on2 = 2844000.0
		T.tn2 = 2844000.0
		T.heat = 9.8892006E8
		T.oheat = 9.8892006E8
		T.theat = 9.8892006E8
		//Foreach goto(40)
	viewers(null, null) << "\red <B>Prison shuttle Restabalized!</B>"
	src.add_fingerprint(usr)
	return

/obj/machinery/computer/shuttle/ex_act(severity)

	switch(severity)
		if(1.0)
			src = null
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

/obj/machinery/computer/shuttle/verb/restabalize()
	set src in oview(1)

	world << "\red <B>Restabalizing shuttle atmosphere!</B>"
	var/A = locate(/area/shuttle)
	for(var/obj/move/T as obj in A)
		T.firelevel = 0
		T.oxygen = 756000.0
		T.oldoxy = 756000.0
		T.tmpoxy = 756000.0
		T.poison = 0
		T.oldpoison = 0
		T.tmppoison = 0
		T.co2 = 0
		T.oldco2 = 0
		T.tmpco2 = 0
		T.sl_gas = 0
		T.osl_gas = 0
		T.tsl_gas = 0
		T.n2 = 2844000.0
		T.on2 = 2844000.0
		T.tn2 = 2844000.0
		T.heat = 9.8892006E8
		T.oheat = 9.8892006E8
		T.theat = 9.8892006E8
		//Foreach goto(35)
	world << "\red <B>Shuttle Restabalized!</B>"
	src.add_fingerprint(usr)
	return

/obj/machinery/computer/shuttle/verb/hijack()
	set src in oview(1)

	if ((!( ticker ) || ticker.shuttle_location != 10))
		return
	if (usr != ticker.killer)
		return
	world << "\blue <B>Alert: The shuttle is has been hijacked prematurely by the traitor!</B>"
	ticker.timing = 0
	ticker.check_win()
	src.add_fingerprint(usr)
	return

/obj/machinery/computer/shuttle/attackby(W as obj, user as mob)

	if ((!( istype(W, /obj/item/weapon/card/id) ) || (!( ticker ) || (ticker.shuttle_location == 10 || !( user )))))
		return
	if (W.access_level < 1)
		user << text("The access level ([]) of [] card is not high enough. (It must be at least level 1.)", W.access_level, W.registered)
		return
	var/choice = alert(user, text("Would you like to (un)authorize a shortened launch time? [] authorization\s are still needed. Use abort to cancel all authorizations.", src.auth_need - src.authorized.len), "Shuttle Launch", "Authorize", "Repeal", "Abort")
	switch(choice)
		if("Authorize")
			src.authorized -= W.registered
			src.authorized += W.registered
			if ((src.auth_need - src.authorized.len) > 0)
				world << text("\blue <B>Alert: [] authorizations needed until shuttle is launched early</B>", src.auth_need - src.authorized.len)
			else
				world << "\blue <B>Alert: Shuttle launch time shortened to 10 seconds!</B>"
				ticker.timeleft = 100
				src.authorized = null
				del(src.authorized)
				src.authorized = list(  )
		if("Repeal")
			src.authorized -= W.registered
			world << text("\blue <B>Alert: [] authorizations needed until shuttle is launched early</B>", src.auth_need - src.authorized.len)
		if("Abort")
			world << "\blue <B>All authorizations to shorting time for shuttle launch have been revoked!</B>"
			src.len = 0
			src.authorized = list(  )
		else
	return

/obj/shut_controller/proc/rotate(direct)

	var/SE_X = 1
	var/SE_Y = 1
	var/SW_X = 1
	var/SW_Y = 1
	var/NE_X = 1
	var/NE_Y = 1
	var/NW_X = 1
	var/NW_Y = 1
	for(var/obj/move/M as obj in src.parts)
		if (M.x < SW_X)
			SW_X = M.x
		if (M.x > SE_X)
			SE_X = M.x
		if (M.y < SW_Y)
			SW_Y = M.y
		if (M.y > NW_Y)
			NW_Y = M.y
		if (M.y > NE_Y)
			NE_Y = M.y
		if (M.y < SE_Y)
			SE_Y = M.y
		if (M.x > NE_X)
			NE_X = M.x
		if (M.x < NW_X)
			NW_X = M.y
		//Foreach goto(75)
	var/length = abs(NE_X - NW_X)
	var/width = abs(NE_Y - SE_Y)
	var/random = pick(src.parts)
	var/s_direct = null
	switch(s_direct)
		if(1.0)
			switch(direct)
				if(90.0)
					var/tx = SE_X
					var/ty = SE_Y
					var/t_z = random.z
					for(var/obj/move/M as obj in src.parts)
						M.ty =  -M.x - tx
						M.tx =  -M.y - ty
						var/T = locate(M.x, M.y, 11)
						relocate(T)
						M.ty =  -M.ty
						M.tx += length
						//Foreach goto(374)
					for(var/obj/move/M as obj in src.parts)
						M.tx += tx
						M.ty += ty
						var/T = locate(M.tx, M.ty, t_z)
						relocate(T, 90)
						//Foreach goto(468)
				if(-90.0)
					var/tx = SE_X
					var/ty = SE_Y
					var/t_z = random.z
					for(var/obj/move/M as obj in src.parts)
						M.ty = M.x - tx
						M.tx = M.y - ty
						var/T = locate(M.x, M.y, 11)
						relocate(T)
						M.ty =  -M.ty
						M.ty += width
						//Foreach goto(571)
					for(var/obj/move/M as obj in src.parts)
						M.tx += tx
						M.ty += ty
						var/T = locate(M.tx, M.ty, t_z)
						relocate(T, -90.0)
						//Foreach goto(663)
				else
		else
	return

/obj/shuttle/door/verb/open()
	set src in oview(1)

	src.add_fingerprint(usr)
	if (src.operating)
		return
	src.operating = 1
	flick("doorc0", src)
	src.icon_state = "door0"
	sleep(15)
	src.density = 0
	src.opacity = 0
	src.verbs -= /obj/shuttle/door/verb/open
	src.verbs += /obj/shuttle/door/proc/close
	src.operating = 0
	return

/obj/shuttle/door/proc/close()
	set src in oview(1)

	src.add_fingerprint(usr)
	if (src.operating)
		return
	src.operating = 1
	flick("doorc1", src)
	src.icon_state = "door1"
	src.density = 1
	if (src.visible)
		src.opacity = 1
	sleep(15)
	src.verbs += /obj/shuttle/door/verb/open
	src.verbs -= /obj/shuttle/door/proc/close
	src.operating = 0
	return

/turf/station/shuttle/ex_act(severity)

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
	return
