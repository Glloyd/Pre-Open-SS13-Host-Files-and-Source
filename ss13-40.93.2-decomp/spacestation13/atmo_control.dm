
/obj/machinery/proc/process()

	return

/obj/machinery/proc/receive_gas(gas as obj, machinery as obj)

	return

/obj/machinery/proc/orient_pipe(source as obj)

	return

/obj/machinery/proc/cut_pipes()

	return

/obj/machinery/proc/disc_pipe(target as obj)

	return

/obj/machinery/meter/New()

	..()
	src.target = locate(/obj/machinery/pipes, src.loc)
	return

/obj/machinery/meter/Click()

	if (get_dist(usr, src) <= 3)
		if (src.target)
			usr << text("\green <B>[] / []</B>", src.target.gas.tot_gas(), src.maximum)
		else
			usr << "\green <B>Results: Connection Error!</B>"
	else
		usr << "\green <B>You are too far away.</B>"
	return

/obj/machinery/connector/receive_gas(t_gas as obj)

	var/C = locate(/obj/machinery/atmoalter/canister, src.loc)
	if (C.destroyed)
		var/T = src.loc
		if (!( istype(T, /turf) ))
			return
		t_gas.turf_add(T, -1.0)
		return
	var/amount = C.gas.maximum - ((C.oxygen + C.co2) + C.plasma)
	if (((t_gas.co2 + t_gas.plasma) + t_gas.oxygen) < amount)
		amount = (t_gas.co2 + t_gas.plasma) + t_gas.oxygen
	C.gas.transfer_from(t_gas, amount)
	return

/obj/machinery/mass_driver/proc/drive(amount)

	for(var/obj/O as obj in src.loc)
		if (O.flags & 64)
			O.throwing = 1
			O.throwspeed = 100
			spawn( 0 )
				O.throwing(src.dir, src.power)
				return
		//Foreach goto(17)
	flick("mass_driver1", src)
	return

/obj/machinery/pipes/orient_pipe(P as obj)

	if (!( src.node1 ))
		src.node1 = P
	else
		if (!( src.node2 ))
			src.node2 = P
		else
			return 0
	return 1
	return

/obj/machinery/pipes/proc/update()

	var/T = src.loc
	if ((src.level == 1 && (isturf(src.loc) && T.intact)))
		src.invisibility = 100
	else
		src.invisibility = null
	if ((src.node1 && src.node2))
		src.icon_state = text("[]", get_dir(src, src.node1) | get_dir(src, src.node2))
	else
		var/con = 0
		var/dis = 0
		var/n1d = (src.node1 ? get_dir(src, src.node1) : null)
		var/n2d = (src.node2 ? get_dir(src, src.node2) : null)
		if (src.p_dir & 1)
			if ((n1d == 1 || n2d == 1))
				con |= 1
			else
				dis |= 1
		if (src.p_dir & 2)
			if ((n1d == 2 || n2d == 2))
				con |= 2
			else
				dis |= 2
		if (src.p_dir & 4)
			if ((n1d == 4 || n2d == 4))
				con |= 4
			else
				dis |= 4
		if (src.p_dir & 8)
			if ((n1d == 8 || n2d == 8))
				con |= 8
			else
				dis |= 8
		if (con == 0)
			con = null
		src.icon_state = text("[]-[]", con, dis)
	return

/obj/machinery/pipes/proc/explode()

	src.gas.turf_add(src.loc, -1.0)
	return

/obj/machinery/pipes/New()

	..()
	src.gas = new /obj/substance/gas( src )
	src.gas.maximum = src.capacity
	if (world.time > 100)
		return
	spawn( 50 )
		if (src.p_dir & 1)
			if (!( var/b1 ))
				b1 = 1
			else
				if (!( var/b2 ))
					b2 = 1
		if (src.p_dir & 2)
			if (!( b1 ))
				b1 = 2
			else
				if (!( b2 ))
					b2 = 2
		if (src.p_dir & 4)
			if (!( b1 ))
				b1 = 4
			else
				if (!( b2 ))
					b2 = 4
		if (src.p_dir & 8)
			if (!( b1 ))
				b1 = 8
			else
				if (!( b2 ))
					b2 = 8
		for(var/obj/machinery/M as obj in orange(src, 1))
			var/ob1 = null
			var/ob2 = null
			if (M.p_dir & 1)
				if (!( ob1 ))
					ob1 = 1
				else
					if (!( ob2 ))
						ob2 = 1
			if (M.p_dir & 2)
				if (!( ob1 ))
					ob1 = 2
				else
					if (!( ob2 ))
						ob2 = 2
			if (M.p_dir & 4)
				if (!( ob1 ))
					ob1 = 4
				else
					if (!( ob2 ))
						ob2 = 4
			if (M.p_dir & 8)
				if (!( ob1 ))
					ob1 = 8
				else
					if (!( ob2 ))
						ob2 = 8
			var/t1 = get_dir(src, M)
			var/t2 = get_dir(M, src)
			if ((M.level == src.level && ((b1 == t1 || b2 == t1) && (ob1 == t2 || ob2 == t2))))
				if (src.node1)
					if (!( src.node2 ))
						src.node2 = M
				else
					src.node1 = M
			//Foreach goto(253)
		src.update()
		return
	return

/obj/machinery/pipes/receive_gas(t_gas as obj, from as obj)

	if (t_gas.tot_gas() > src.gas.maximum)
		src.merge_into(t_gas)
		src.explode()
		return
	spawn( 1 )
		if (from == src.node1)
			spawn( 0 )
				src.node2.receive_gas(t_gas, src)
				return
		else
			spawn( 0 )
				src.node1.receive_gas(t_gas, src)
				return
		return
	return
	return

/obj/machinery/atmoalter/siphs/New()

	..()
	src.gas = new /obj/substance/gas( src )
	src.gas.maximum = src.maximum
	return

/obj/machinery/atmoalter/siphs/proc/releaseall()

	src.t_status = 1
	src.t_per = 1000000.0
	return

/obj/machinery/atmoalter/siphs/proc/reset(valve, auto)

	if (valve < 0)
		src.t_per =  -valve
		src.t_status = 1
	else
		if (valve > 0)
			src.t_per = valve
			src.t_status = 2
		else
			src.t_status = 3
	if (auto)
		src.t_status = 4
	src.setstate()
	return

/obj/machinery/atmoalter/siphs/proc/release(amount, flag)

	var/T = src.loc
	if (!( istype(T, /turf) ))
		return
	if (locate(/obj/move, T))
		T = locate(/obj/move, T)
	if (!( amount ))
		return
	if (!( flag ))
		amount = min(amount, 1000000.0)
	src.gas.turf_add(T, amount)
	return

/obj/machinery/atmoalter/siphs/proc/siphon(amount, flag)

	var/T = src.loc
	if (!( istype(T, /turf) ))
		return
	if (locate(/obj/move, T))
		T = locate(/obj/move, T)
	if (!( amount ))
		return
	if (!( flag ))
		amount = min(amount, 900000.0)
	src.gas.turf_take(T, amount)
	return

/obj/machinery/atmoalter/siphs/proc/setstate()

	if (src.holding)
		src.icon_state = "siphon:T"
	else
		if (src.t_status != 3)
			src.icon_state = "siphon:1"
		else
			src.icon_state = "siphon:0"
	return

/obj/machinery/atmoalter/siphs/fullairsiphon/New()

	..()
	src.gas.oxygen = 2.73E7
	src.gas.n2 = 1.027E8
	return

/obj/machinery/atmoalter/siphs/fullairsiphon/port/reset(valve, auto)

	if (valve < 0)
		src.t_per =  -valve
		src.t_status = 1
	else
		if (valve > 0)
			src.t_per = valve
			src.t_status = 2
		else
			src.t_status = 3
	if (auto)
		src.t_status = 4
	src.setstate()
	return

/obj/machinery/atmoalter/siphs/fullairsiphon/air_vent/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.c_status)
			src.anchored = 0
			src.c_status = 0
		else
			if (locate(/obj/machinery/connector, src.loc))
				src.anchored = 1
				src.c_status = 3
	else
		if (istype(W, /obj/item/weapon/wrench))
			src.alterable = !( src.alterable )
	return

/obj/machinery/atmoalter/siphs/fullairsiphon/air_vent/setstate()

	if (src.t_status == 4)
		src.icon_state = "vent2"
	else
		if (src.t_status == 3)
			src.icon_state = "vent0"
		else
			src.icon_state = "vent1"
	return

/obj/machinery/atmoalter/siphs/fullairsiphon/air_vent/reset(valve, auto)

	if (auto)
		src.t_status = 4
	return

/obj/machinery/atmoalter/siphs/scrubbers/process()

	if (src.t_status != 3)
		var/T = src.loc
		if (istype(T, /turf))
			if (locate(/obj/move, T))
				T = locate(/obj/move, T)
			if (T.firelevel < 900000.0)
				T.oxygen += src.gas.oxygen
				src.gas.oxygen = 0
		else
			T = null
		switch(src.t_status)
			if(1.0)
				if (src.holding)
					var/t1 = src.gas.tot_gas()
					var/t2 = t1
					var/t = src.t_per
					if (src.t_per > t2)
						t = t2
					src.holding.gas.transfer_from(src.gas, t)
				else
					if (T)
						var/t1 = src.gas.tot_gas()
						var/t2 = t1
						var/t = src.t_per
						if (src.t_per > t2)
							t = t2
						src.gas.turf_add(T, t)
			if(2.0)
				if (src.holding)
					var/t1 = src.gas.tot_gas()
					var/t2 = src.maximum - t1
					var/t = src.t_per
					if (src.t_per > t2)
						t = t2
					src.gas.transfer_from(src.holding.gas, t)
				else
					if (T)
						var/t1 = src.gas.tot_gas()
						var/t2 = src.maximum - t1
						var/t = src.t_per
						if (t > t2)
							t = t2
						src.gas.turf_take(T, t)
			if(4.0)
				if (T)
					if (T.firelevel > 900000.0)
						src.f_time = world.time + 400
					else
						if (world.time > src.f_time)
							src.gas.extract_toxs(T)
							var/contain = tot_gas()
							if (contain > 1.3E8)
								src.turf_add(T, 1.3E8 - contain)
		else
	if (src.c_status == 1)
		var/C = locate(/obj/machinery/connector, src.loc)
		if (C)
			var/obj/substance/gas/G = new /obj/substance/gas(  )
			G.transfer_from(src.gas, src.c_per)
			spawn( 0 )
				C.receive_gas(G, null)
				return
		else
			C.c_status = 0
	src.setstate()
	for(var/M as mob in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(654)
	return

/obj/machinery/atmoalter/siphs/scrubbers/air_filter/setstate()

	if (src.t_status == 4)
		src.icon_state = "vent2"
	else
		if (src.t_status == 3)
			src.icon_state = "vent0"
		else
			src.icon_state = "vent1"
	return

/obj/machinery/atmoalter/siphs/scrubbers/air_filter/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.c_status)
			src.anchored = 0
			src.c_status = 0
		else
			if (locate(/obj/machinery/connector, src.loc))
				src.anchored = 1
				src.c_status = 3
	else
		if (istype(W, /obj/item/weapon/wrench))
			src.alterable = !( src.alterable )
	return

/obj/machinery/atmoalter/siphs/scrubbers/air_filter/reset(valve, auto)

	if (auto)
		src.t_status = 4
	src.setstate()
	return

/obj/machinery/atmoalter/siphs/scrubbers/port/setstate()

	if (src.holding)
		src.icon_state = "scrubber:T"
	else
		if (src.t_status != 3)
			src.icon_state = "scrubber:1"
		else
			src.icon_state = "scrubber:0"
	return

/obj/machinery/atmoalter/siphs/scrubbers/port/reset(valve, auto)

	if (valve < 0)
		src.t_per =  -valve
		src.t_status = 1
	else
		if (valve > 0)
			src.t_per = valve
			src.t_status = 2
		else
			src.t_status = 3
	if (auto)
		src.t_status = 4
	src.setstate()
	return

/obj/machinery/atmoalter/siphs/process()

	if (src.t_status != 3)
		var/T = src.loc
		if (istype(T, /turf))
			if (locate(/obj/move, T))
				T = locate(/obj/move, T)
		else
			T = null
		switch(src.t_status)
			if(1.0)
				if (src.holding)
					var/t1 = src.gas.tot_gas()
					var/t2 = t1
					var/t = src.t_per
					if (src.t_per > t2)
						t = t2
					src.holding.gas.transfer_from(src.gas, t)
				else
					if (T)
						var/t1 = src.gas.tot_gas()
						var/t2 = t1
						var/t = src.t_per
						if (src.t_per > t2)
							t = t2
						src.gas.turf_add(T, t)
			if(2.0)
				if (src.holding)
					var/t1 = src.gas.tot_gas()
					var/t2 = src.maximum - t1
					var/t = src.t_per
					if (src.t_per > t2)
						t = t2
					src.gas.transfer_from(src.holding.gas, t)
				else
					if (T)
						var/t1 = src.gas.tot_gas()
						var/t2 = src.maximum - t1
						var/t = src.t_per
						if (t > t2)
							t = t2
						src.gas.turf_take(T, t)
			if(4.0)
				if (T)
					if (T.firelevel > 900000.0)
						src.f_time = world.time + 300
					else
						if (world.time > src.f_time)
							var/difference = 3600000.0 - (T.oxygen + T.n2)
							if (difference > 0)
								var/t1 = src.gas.tot_gas()
								if (difference > t1)
									difference = t1
								src.gas.turf_add(T, difference)
		else
	if (src.c_status == 1)
		var/C = locate(/obj/machinery/connector, src.loc)
		if (C)
			var/obj/substance/gas/G = new /obj/substance/gas(  )
			G.transfer_from(src.gas, src.c_per)
			spawn( 0 )
				C.receive_gas(G, null)
				return
		else
			C.c_status = 0
	for(var/M as mob in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(632)
	src.setstate()
	return

/obj/machinery/atmoalter/siphs/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/atmoalter/siphs/attack_hand(user as mob)

	user.machine = src
	switch(src.t_status)
		if(1.0)
			var/tt = text("Releasing <A href='?src=\ref[];t=2'>Siphon</A> <A href='?src=\ref[];t=3'>Stop</A>", src, src)
		if(2.0)
			tt = text("<A href='?src=\ref[];t=1'>Release</A> Siphoning <A href='?src=\ref[];t=3'>Stop</A>", src, src)
		if(3.0)
			tt = text("<A href='?src=\ref[];t=1'>Release</A> <A href='?src=\ref[];t=2'>Siphon</A> Stopped <A href='?src=\ref[];t=4'>Automatic</A>", src, src, src)
		else
			tt = "Automatic equalizers are on!"
	var/ct = null
	switch(src.c_status)
		if(1.0)
			ct = text("Releasing <A href='?src=\ref[];c=2'>Accept</A> <A href='?src=\ref[];ct=3'>Stop</A>", src, src)
		if(2.0)
			ct = text("<A href='?src=\ref[];c=1'>Release</A> Accepting <A href='?src=\ref[];c=3'>Stop</A>", src, src)
		if(3.0)
			ct = text("<A href='?src=\ref[];c=1'>Release</A> <A href='?src=\ref[];c=2'>Accept</A> Stopped", src, src)
		else
			ct = "Disconnected"
	var/at = null
	if (src.t_status == 4)
		at = text("Automatic On <A href='?src=\ref[];t=3'>Stop</A>", src)
	var/dat = text("<TT><B>Canister Valves</B> []<BR>\n\t<FONT color = 'blue'><B>Contains/Capacity</B> [] / []</FONT><BR>\n\tUpper Valve Status: [] []<BR>\n\t\t<A href='?src=\ref[];tp=-[]'>M</A> <A href='?src=\ref[];tp=-10000'>-</A> <A href='?src=\ref[];tp=-1000'>-</A> <A href='?src=\ref[];tp=-100'>-</A> <A href='?src=\ref[];tp=-1'>-</A> [] <A href='?src=\ref[];tp=1'>+</A> <A href='?src=\ref[];tp=100'>+</A> <A href='?src=\ref[];tp=1000'>+</A> <A href='?src=\ref[];tp=10000'>+</A> <A href='?src=\ref[];tp=[]'>M</A><BR>\n\tPipe Valve Status: []<BR>\n\t\t<A href='?src=\ref[];cp=-[]'>M</A> <A href='?src=\ref[];cp=-10000'>-</A> <A href='?src=\ref[];cp=-1000'>-</A> <A href='?src=\ref[];cp=-100'>-</A> <A href='?src=\ref[];cp=-1'>-</A> [] <A href='?src=\ref[];cp=1'>+</A> <A href='?src=\ref[];cp=100'>+</A> <A href='?src=\ref[];cp=1000'>+</A> <A href='?src=\ref[];cp=10000'>+</A> <A href='?src=\ref[];cp=[]'>M</A><BR>\n<BR>\n\n<A href='?src=\ref[];mach_close=siphon'>Close</A><BR>\n\t</TT>", (!( src.alterable ) ? "<B>Valves are locked. Unlock with wrench!</B>" : "You can lock this interface with a wrench."), num2text(src.gas.tot_gas(), 10), num2text(src.maximum, 10), (src.t_status == 4 ? text("[]", at) : text("[]", tt)), (src.holding ? text("<BR>(<A href='?src=\ref[];tank=1'>Tank ([]</A>)", src, src.holding.gas.tot_gas()) : null), src, num2text(1000000.0, 7), src, src, src, src, src.t_per, src, src, src, src, src, num2text(1000000.0, 7), ct, src, num2text(1000000.0, 7), src, src, src, src, src.c_per, src, src, src, src, src, num2text(1000000.0, 7), user)
	user << browse(dat, "window=siphon;size=600x300")
	return

/obj/machinery/atmoalter/siphs/Topic(href, href_list)

	if (usr.stat)
		return
	if (!( src.alterable ))
		return
	if ((get_dist(src, usr) <= 1 && istype(src.loc, /turf)))
		usr.machine = src
		if (href_list["c"])
			var/c = text2num(href_list["c"])
			switch(c)
				if(1.0)
					src.c_status = 1
				if(2.0)
					src.c_status = 2
				if(3.0)
					src.c_status = 3
				else
		else
			if (href_list["t"])
				var/t = text2num(href_list["t"])
				if (src.t_status == 0)
					return
				switch(t)
					if(1.0)
						src.t_status = 1
					if(2.0)
						src.t_status = 2
					if(3.0)
						src.t_status = 3
					if(4.0)
						src.t_status = 4
						src.f_time = 1
					else
			else
				if (href_list["tp"])
					var/tp = text2num(href_list["tp"])
					src.t_per += tp
					src.t_per = min(max(round(src.t_per), 0), 1000000.0)
				else
					if (href_list["cp"])
						var/cp = text2num(href_list["cp"])
						src.c_per += cp
						src.c_per = min(max(round(src.c_per), 0), 1000000.0)
					else
						if (href_list["tank"])
							var/cp = text2num(href_list["tank"])
							if (cp == 1)
								src.holding.loc = src.loc
								src.holding = null
								if (src.t_status == 2)
									src.t_status = 3
		for(var/M as mob in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
			//Foreach goto(433)
		src.add_fingerprint(usr)
	else
		usr << browse(null, "window=canister")
		return
	return

/obj/machinery/atmoalter/siphs/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/tank))
		if (src.holding)
			return
		var/T = W
		user.drop_item()
		T.loc = src
		src.holding = T
	else
		if (istype(W, /obj/item/weapon/screwdriver))
			if (src.c_status)
				src.anchored = 0
				src.c_status = 0
			else
				if (locate(/obj/machinery/connector, src.loc))
					src.anchored = 1
					src.c_status = 3
		else
			if (istype(W, /obj/item/weapon/wrench))
				src.alterable = !( src.alterable )
				if (src.alterable)
					user << "\blue You unlock the interface!"
				else
					user << "\blue You lock the interface!"
	return
