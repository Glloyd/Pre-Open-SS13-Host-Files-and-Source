
/obj/move/CheckPass(O as mob|obj)

	return !( src.density )


/obj/move/attack_paw(user as mob)

	return src.attack_hand(user)


/obj/move/attack_hand(var/mob/user as mob)

	if ((!( user.canmove ) || user.restrained() || !( user.pulling )))
		return
	if (user.pulling.anchored)
		return
	if ((user.pulling.loc != user.loc && get_dist(user, user.pulling) > 1))
		return
	if (ismob(user.pulling))
		var/mob/M = user.pulling
		var/mob/t = M.pulling
		M.pulling = null
		step(user.pulling, get_dir(user.pulling.loc, src))
		M.pulling = t
	else
		step(user.pulling, get_dir(user.pulling.loc, src))
	return

/obj/move/proc/res_vars()

	src.oldoxy = src.oxygen
	src.tmpoxy = src.oxygen
	src.oldpoison = src.poison
	src.tmppoison = src.poison
	src.oldco2 = src.co2
	src.tmpco2 = src.co2
	src.osl_gas = src.sl_gas
	src.tsl_gas = src.sl_gas
	src.on2 = src.n2
	src.tn2 = src.n2
	src.oheat = src.heat
	src.theat = src.heat
	return

/obj/move/proc/relocate(T as turf, degree)

	if (degree)
		for(var/atom/movable/A as mob|obj in src.loc)
			A.dir = turn(A.dir, degree)
			//*****RM as 4.1beta
			A.loc = T

			//Foreach goto(25)
	else
		for(var/atom/movable/A as mob|obj in src.loc)
			A.loc = T
			//Foreach goto(73)
	return

/obj/move/proc/unburn()

	src.icon_state = initial(src.icon_state)
	return


/obj/move/proc/Neighbors()

	var/list/L = list( NORTH, SOUTH, EAST, WEST )
	for(var/obj/machinery/door/window/D in src.loc)
		if(!( D.density ))
			goto Label_98


		if (D.dir & 12)
			L -= SOUTH
		else
			L -= EAST


		Label_98:
		//Foreach goto(36)

	for(var/obj/window/D in src.loc)
		if(!( D.density ))
			goto Label_182
		L -= D.dir
		if (D.dir == SOUTHWEST)
			L.len = null
			return L
		Label_182:
		//Foreach goto(115)
	return L

/obj/move/proc/FindTurfs()

	var/list/L = list(  )
	for(var/dir in src.Neighbors())
		var/turf/T = get_step(src.loc, dir)
		//++++++

		if(!( T ))
			goto Label_299
		L += T
		var/direct = flipdir(dir)
		//*****RM as 4.1beta

		for(var/obj/machinery/door/window/D in T)
			if(!( D.density ))
				goto Label_181
			//var/direct = get_dir(src, T)
			if ((D.dir & 12))
				if (dir & 1)	// was direct&1
					L -= T
					goto Label_181
			else
				if(dir & 8) // was direct&8
					L -= T
					goto Label_181
			Label_181:
			//Foreach goto(81)

		for(var/obj/window/D in T)
			if(!( D.density ))
				goto Label_294
			//var/direct = get_dir(T, src.loc)
			if (D.dir == SOUTHWEST)
				L -= T
				goto Label_294
			else
				if(direct == D.dir)
					L -= T


			Label_294:
			//Foreach goto(199)

		//*****
		Label_299:
		if ((locate(/obj/move, T) && L.Find(T)))
			L -= T
			var/obj/move/O = locate(/obj/move, T)
			if (O.updatecell)
				L += O
		else
			if ((isturf(T) && !( T.updatecell )))
				L -= T
		//Foreach goto(26)
	return L


/obj/move/proc/process()

	if (locate(/obj/shuttle/door, src.loc))
		var/obj/shuttle/door/D = locate(/obj/shuttle/door, src.loc)
		src.updatecell = !( D.density )
		if (!( src.updatecell ))
			return
	src.checkfire = !( src.checkfire )
	if (src.checkfire)
		if (cellcontrol.var_swap)
			var/divideby = 1
			var/total = src.oxygen
			var/tpoison = src.poison
			var/tco2 = src.co2
			var/tosl_gas = src.sl_gas
			var/ton2 = src.n2
			var/toheat = src.heat
			var/space = 0
			var/burn = src.firelevel >= 10
			for(var/turf/S in src.FindTurfs())
				var/turf/T = S
				if (istype(T, /turf/space))
					space = 1
				else
					divideby++
					total += T.oldoxy
					tpoison += T.oldpoison
					tco2 += T.oldco2
					tosl_gas += T.osl_gas
					ton2 += T.on2
					toheat += T.oheat
					if (T.firelevel >= 900000.0)
						burn = 1
					//Foreach continue //goto(158)
			if (space)
				src.oxygen = 0
				src.poison = 0
				src.co2 = 0
				src.sl_gas = 0
				src.n2 = 0
				src.heat = 0
			else
				src.oxygen = total / divideby
				src.poison = tpoison / divideby
				src.co2 = tco2 / divideby
				src.sl_gas = tosl_gas / divideby
				src.n2 = ton2 / divideby
				src.heat = toheat / divideby
			if (src.sl_gas > 0)
				src.sl_gas--
			if (src.poison > 100000.0)
				src.overlays = list( plmaster )
			else
				if (src.sl_gas > 101000.0)
					src.overlays = list( slmaster )
				else
					src.overlays = null
			if (burn)
				src.firelevel = src.oxygen + src.poison
			if (src.firelevel >= 900000.0)
				src.icon_state = "burning"
				if (src.oxygen > 5000)
					src.co2 += 2500
					src.oxygen -= 5000
				else
					src.oxygen = 0
				src.poison = max(0, src.poison - 1000)
				if (locate(/obj/effects/water, src))
					src.firelevel = 0
				for(var/atom/movable/A as mob|obj in src)
					A.burn(src.firelevel)
					//Foreach goto(561)
			else
				src.firelevel = 0
				if (src.icon_state == "burning")
					unburn()
			src.tmpoxy = src.oxygen
			src.tmppoison = src.poison
			src.tmpco2 = src.co2
			src.tsl_gas = src.sl_gas
			src.tn2 = src.n2
			src.theat = src.heat
		else
			var/divideby = 1
			var/total = src.oxygen
			var/tpoison = src.poison
			var/tco2 = src.co2
			var/tosl_gas = src.sl_gas
			var/ton2 = src.n2
			var/toheat = src.heat
			var/space = 0
			var/burn = src.firelevel >= 10
			for(var/turf/S in src.FindTurfs())
				var/turf/T = S
				if (istype(T, /turf/space))
					space = 1
				else
					divideby++
					total += T.tmpoxy
					tpoison += T.tmppoison
					tco2 += T.tmpco2
					tosl_gas += T.tsl_gas
					ton2 += T.tn2
					toheat += T.theat
					if (T.firelevel >= 900000.0)
						burn = 1
					//Foreach continue //goto(744)
			if (space)
				src.oxygen = 0
				src.poison = 0
				src.co2 = 0
				src.sl_gas = 0
				src.n2 = 0
				src.heat = 0
			else
				src.oxygen = total / divideby
				src.poison = tpoison / divideby
				src.co2 = tco2 / divideby
				src.sl_gas = tosl_gas / divideby
				src.n2 = ton2 / divideby
				src.heat = toheat / divideby
			if (src.sl_gas > 0)
				src.sl_gas--
			if (src.poison > 100000.0)
				src.overlays = list( plmaster )
			else
				if (src.sl_gas > 101000.0)
					src.overlays = list( slmaster )
				else
					src.overlays = null
			if (burn)
				src.firelevel = src.oxygen + src.poison
			if (src.firelevel >= 900000.0)
				src.icon_state = "burning"
				if (src.oxygen > 5000)
					src.co2 += 2500
					src.oxygen -= 5000
				else
					src.oxygen = 0
				src.poison = max(0, src.poison - 1000)
				src.co2 += 2500
				if (locate(/obj/effects/water, src))
					src.firelevel = 0
				for(var/atom/movable/A as mob|obj in src)
					A.burn(src.firelevel)
					//Foreach goto(1153)
			else
				if (src.icon_state == "burning")
					src.firelevel = 0
					unburn()
			src.oldoxy = src.oxygen
			src.oldpoison = src.poison
			src.oldco2 = src.co2
			src.osl_gas = src.sl_gas
			src.on2 = src.n2
			src.oheat = src.heat
	else
		if (cellcontrol.var_swap)
			var/divideby = 1
			var/total = src.oxygen
			var/tpoison = src.poison
			var/tco2 = src.co2
			var/tosl_gas = src.sl_gas
			var/ton2 = src.n2
			var/toheat = src.heat
			var/space = 0
			src.airdir = null
			src.airforce = 0
			var/adiff = null
			for(var/turf/S in src.FindTurfs())
				var/turf/T = S
				if (istype(T, /turf/space))
					space = 1
					src.airforce = src.oxygen + src.n2 + src.poison + src.co2 + 25000
					src.airdir = get_dir(src, T)
				else
					divideby++
					total += T.oldoxy
					tpoison += T.oldpoison
					tco2 += T.oldco2
					tosl_gas += T.osl_gas
					ton2 += T.on2
					toheat += T.oheat
					adiff = src.oldoxy + src.oldco2 + src.on2 - (T.oldoxy + T.oldco2 + T.on2)
					if (adiff > src.airforce)
						src.airforce = adiff
						src.airdir = get_dir(src, T)
					//Foreach continue //goto(1356)
			if (src.airforce > 25000)
				for(var/atom/movable/AM as mob|obj in src.loc)
					if ((!( AM.anchored ) && AM.weight <= src.airforce))
						spawn( 0 )
							step(AM, src.airdir)
							return
					//Foreach goto(1559)
			if (space)
				src.oxygen = 0
				src.poison = 0
				src.co2 = 0
				src.sl_gas = 0
				src.n2 = 0
				src.heat = 0
			else
				src.oxygen = total / divideby
				src.poison = tpoison / divideby
				src.co2 = tco2 / divideby
				src.sl_gas = tosl_gas / divideby
				src.n2 = ton2 / divideby
				src.heat = toheat / divideby
			if (src.sl_gas > 0)
				src.sl_gas--
			if (src.co2 >= src.poison)
				src.co2 -= src.poison
				src.oxygen += src.poison
				src.poison = 0
			else
				src.poison -= src.co2
				src.oxygen += src.co2
				src.co2 = 0
			src.tmpoxy = src.oxygen
			src.tmppoison = src.poison
			src.tmpco2 = src.co2
			src.tsl_gas = src.sl_gas
			src.tn2 = src.n2
			src.theat = src.heat
		else
			var/divideby = 1
			var/total = src.oxygen
			var/tpoison = src.poison
			var/tco2 = src.co2
			var/tosl_gas = src.sl_gas
			var/ton2 = src.n2
			var/toheat = src.heat
			var/space = 0
			src.airdir = null
			src.airforce = 0
			var/adiff = null
			for(var/turf/S in src.FindTurfs())
				var/turf/T = S
				if (istype(T, /turf/space))
					space = 1
					src.airforce = src.oxygen + src.poison + src.n2 + src.co2 + 25000
					src.airdir = get_dir(src, T)
				else
					divideby++
					total += T.tmpoxy
					tpoison += T.tmppoison
					tco2 += T.tmpco2
					tosl_gas += T.tsl_gas
					ton2 += T.tn2
					toheat += T.theat
					adiff = src.tmpoxy + src.tmpco2 + src.tn2 - (T.tmpoxy + T.tmpco2 + T.tn2)
					if (adiff > src.airforce)
						src.airforce = adiff
						src.airdir = get_dir(src, T)
					//Foreach continue //goto(1927)
			if (src.airforce > 25000)
				for(var/atom/movable/AM as mob|obj in src.loc)
					if ((!( AM.anchored ) && AM.weight <= src.airforce))
						spawn( 0 )
							step(AM, src.airdir)
							return
					//Foreach goto(2130)
			if (space)
				src.oxygen = 0
				src.poison = 0
				src.co2 = 0
				src.sl_gas = 0
				src.n2 = 0
				src.heat = 0
			else
				src.oxygen = total / divideby
				src.poison = tpoison / divideby
				src.co2 = tco2 / divideby
				src.sl_gas = tosl_gas / divideby
				src.n2 = ton2 / divideby
				src.heat = toheat / divideby
			if (src.sl_gas > 0)
				src.sl_gas--
			if (src.co2 >= src.poison)
				src.co2 -= src.poison
				src.oxygen += src.poison
				src.poison = 0
			else
				src.poison -= src.co2
				src.oxygen += src.co2
				src.co2 = 0
			src.oldoxy = src.oxygen
			src.oldpoison = src.poison
			src.oldco2 = src.co2
			src.osl_gas = src.sl_gas
			src.on2 = src.n2
			src.oheat = src.heat
	if ((locate(/obj/effects/water, src.loc) || src.firelevel < 900000.0))
		src.firelevel = 0
	return

/obj/move/wall/New()

	var/F = locate(/obj/move/floor, src.loc)
	if (F)
		//F = null
		del(F)
	return

/obj/move/wall/process()

	src.updatecell = 0

	return

/obj/move/New()

	if ( (src.x & 1) == (src.y & 1) )
		src.checkfire = 0
	src.tmpoxy = src.oxygen
	src.oldoxy = src.oxygen
	src.tmppoison = src.poison
	src.oldpoison = src.poison
	src.tmpco2 = src.co2
	src.oldco2 = src.co2
	src.oheat = 9.8892006E8
	src.theat = 9.8892006E8
	..()
	return

/turf/proc/res_vars()

	src.oldoxy = src.oxygen
	src.tmpoxy = src.oxygen
	src.oldpoison = src.poison
	src.tmppoison = src.poison
	src.oldco2 = src.co2
	src.tmpco2 = src.co2
	src.osl_gas = src.sl_gas
	src.tsl_gas = src.sl_gas
	src.on2 = src.n2
	src.tn2 = src.n2
	src.oheat = src.heat
	src.theat = src.heat
	return

/turf/proc/unburn()

	src.icon_state = initial(src.icon_state)
	return


//*****


/turf/proc/Neighbors()

	var/list/L = list( NORTH, SOUTH, EAST, WEST )
	for(var/obj/machinery/door/window/D in src)
		if(!( D.density ))
			goto Label_96 //continue
		//+++++
		//L -= D.dir

		if (D.dir & 12)
			L -= SOUTH
		else
			L -= EAST

		Label_96
		//Foreach goto(34)
	for(var/obj/window/D in src)
		if(!( D.density ))
			goto Label_178 //continue
		L -= D.dir
		if (D.dir == SOUTHWEST)
			L.len = null
			return L
		Label_178
		//Foreach goto(111)
	return L


/proc/flipdir(dir)

	switch(dir)
		if(1)
			return 2
		if(2)
			return 1
		if(4)
			return 8
		if(8)
			return 4
		if(5)
			return 10
		if(6)
			return 9
		if(9)
			return 10
		if(10)
			return 9
		else
			return 0


/turf/proc/FindTurfs()

	var/list/L = list(  )
	if (locate(/obj/move, src))
		return list(  )
	for(var/dir in src.Neighbors())
		var/turf/T = get_step(src, dir)
		//*****RM

		//
		if((!( T ) || !( T.updatecell )))
			goto Label_317

		L += T
		var/direct = flipdir(dir)
		//*****RM as 4.1beta

		for(var/obj/machinery/door/window/D in T)
			if(!( D.density ))
				goto Label_201
			//var/direct = get_dir(src, T)
			if (D.dir & 12)
				if((dir & 1))		// was (direct & 1)
					L -= T
					goto Label_201
			else
				if(dir & 8)			//was (direct&8)
					L -= T

			Label_201:
			//Foreach goto(101)

		for(var/obj/window/D in T)
			if(!( D.density ))
				goto Label_312
			//var/direct = get_dir(T, src)
			if (D.dir == SOUTHWEST)
				L -= T
				goto Label_312
			else
				if(direct == D.dir)
					L -= T

			Label_312:

			//Foreach goto(219)

		//*****

		Label_317:
		//Foreach goto(40)

	for(var/turf/T in L)
		if (locate(/obj/move, T))
			L -= T
			var/obj/move/O = locate(/obj/move, T)
			if (O.updatecell)
				L += O
		//Foreach goto(333)
	return L

/turf/New()

	if ((src.x & 1) == (src.y & 1))
		src.checkfire = 0
	src.tmpoxy = src.oxygen
	src.oldoxy = src.oxygen
	src.tmppoison = src.poison
	src.oldpoison = src.poison
	src.tmpco2 = src.co2
	src.oldco2 = src.co2
	src.osl_gas = src.sl_gas
	src.tsl_gas = src.sl_gas
	src.on2 = src.n2
	src.tn2 = src.n2
	src.oheat = src.heat
	src.theat = src.heat
	..()
	return

/turf/updatecell()


	src.checkfire = !( src.checkfire )
	if (src.checkfire)
		if (cellcontrol.var_swap)
			var/divideby = 1
			var/total = src.oxygen
			var/tpoison = src.poison
			var/tco2 = src.co2
			var/tosl_gas = src.sl_gas
			var/ton2 = src.n2
			var/toheat = src.heat
			var/space = 0
			var/burn = src.firelevel >= 10
			for(var/turf/S in src.FindTurfs())
				var/turf/T = S
				if (istype(T, /turf/space))
					space = 1
					break //*****RM
				else
					divideby++
					total += T.oldoxy
					tpoison += T.oldpoison
					tco2 += T.oldco2
					tosl_gas += T.osl_gas
					ton2 += T.on2
					toheat += T.oheat
					if (T.firelevel >= 900000.0)
						burn = 1
					//Foreach continue //goto(113)
			if (space)
				src.oxygen = 0
				src.poison = 0
				src.co2 = 0
				src.sl_gas = 0
				src.n2 = 0
				src.heat = 0
			else
				src.oxygen = total / divideby
				src.poison = tpoison / divideby
				src.co2 = tco2 / divideby
				src.sl_gas = tosl_gas / divideby
				src.n2 = ton2 / divideby
				src.heat = toheat / divideby
			if (src.sl_gas > 0)
				src.sl_gas--
			if (src.poison > 100000.0)
				src.overlays = list( plmaster )
			else
				if (src.sl_gas > 101000.0)
					src.overlays = list( slmaster )
				else
					src.overlays = null
			if (burn)
				src.firelevel = src.oxygen + src.poison
			if (src.firelevel >= 900000.0)
				src.icon_state = "burning"
				if (src.oxygen > 5000)
					src.co2 += 2500
					src.oxygen -= 5000
				else
					src.oxygen = 0
				src.poison = max(0, src.poison - 1000)
				src.co2 += 2500
				if (locate(/obj/effects/water, src))
					src.firelevel = 0
				for(var/atom/movable/A as mob|obj in src)
					A.burn(src.firelevel)
					//Foreach goto(522)
			else
				src.firelevel = 0
				if (src.icon_state == "burning")
					unburn()
			src.tmpoxy = src.oxygen
			src.tmppoison = src.poison
			src.tmpco2 = src.co2
			src.tsl_gas = src.sl_gas
			src.tn2 = src.n2
			src.theat = src.heat
		else
			var/divideby = 1
			var/total = src.oxygen
			var/tpoison = src.poison
			var/tco2 = src.co2
			var/tosl_gas = src.sl_gas
			var/ton2 = src.n2
			var/toheat = src.heat
			var/space = 0
			var/burn = src.firelevel >= 10
			for(var/turf/S in src.FindTurfs())
				var/turf/T = S
				if (istype(T, /turf/space))
					space = 1
					break //*****RM
				else
					divideby++
					total += T.tmpoxy
					tpoison += T.tmppoison
					tco2 += T.tmpco2
					tosl_gas += T.tsl_gas
					ton2 += T.tn2
					toheat += T.theat
					if (T.firelevel >= 900000.0)
						burn = 1
					//Foreach continue //goto(705)
			if (space)
				src.oxygen = 0
				src.poison = 0
				src.co2 = 0
				src.sl_gas = 0
				src.n2 = 0
				src.heat = 0
			else
				src.oxygen = total / divideby
				src.poison = tpoison / divideby
				src.co2 = tco2 / divideby
				src.sl_gas = tosl_gas / divideby
				src.n2 = ton2 / divideby
				src.heat = toheat / divideby
			if (src.sl_gas > 0)
				src.sl_gas--
			if (src.poison > 100000.0)
				src.overlays = list( plmaster )
			else
				if (src.sl_gas > 101000.0)
					src.overlays = list( slmaster )
				else
					src.overlays = null
			if (burn)
				src.firelevel = src.oxygen + src.poison
			if (src.firelevel >= 900000.0)
				src.icon_state = "burning"
				if (src.oxygen > 5000)
					src.co2 += 2500
					src.oxygen -= 5000
				else
					src.oxygen = 0
				src.poison = max(0, src.poison - 1000)
				src.co2 += 2500
				if (locate(/obj/effects/water, src))
					src.firelevel = 0
				for(var/atom/movable/A as mob|obj in src)
					A.burn(src.firelevel)
					//Foreach goto(1114)
			else
				if (src.icon_state == "burning")
					src.firelevel = 0
					unburn()
			src.oldoxy = src.oxygen
			src.oldpoison = src.poison
			src.oldco2 = src.co2
			src.osl_gas = src.sl_gas
			src.on2 = src.n2
			src.oheat = src.heat
	else
		if (cellcontrol.var_swap)
			var/divideby = 1
			var/total = src.oxygen
			var/tpoison = src.poison
			var/tco2 = src.co2
			var/tosl_gas = src.sl_gas
			var/ton2 = src.n2
			var/toheat = src.heat
			var/space = 0
			src.airdir = null
			src.airforce = 0
			var/adiff = null
			for(var/S in src.FindTurfs())
				var/turf/T = S
				if (istype(T, /turf/space))
					space = 1
					src.airforce = src.oxygen + src.poison + src.n2 + src.co2 + 25000
					src.airdir = get_dir(src, T)
					break //*****RM
				else
					divideby++
					total += T.oldoxy
					tpoison += T.oldpoison
					tco2 += T.oldco2
					tosl_gas += T.osl_gas
					ton2 += T.on2
					toheat += T.oheat
					adiff = src.oldoxy + src.oldco2 + src.on2 - (T.oldoxy + T.oldco2 + T.on2)
					if (adiff > src.airforce)
						src.airforce = adiff
						src.airdir = get_dir(src, T)
					//Foreach continue //goto(1317)
			if (src.airforce > 25000)
				for(var/atom/movable/AM as mob|obj in src)
					if ((!( AM.anchored ) && AM.weight <= src.airforce))
						spawn( 0 )
							step(AM, src.airdir)
							return
					//Foreach goto(1518)
			if (space)
				src.oxygen = 0
				src.poison = 0
				src.co2 = 0
				src.sl_gas = 0
				src.n2 = 0
				src.heat = 0
			else
				src.oxygen = total / divideby
				src.poison = tpoison / divideby
				src.co2 = tco2 / divideby
				src.sl_gas = tosl_gas / divideby
				src.n2 = ton2 / divideby
				src.heat = toheat / divideby
			if (src.co2 >= src.poison)
				src.co2 -= src.poison
				src.oxygen += src.poison
				src.poison = 0
			else
				src.poison -= src.co2
				src.oxygen += src.co2
				src.co2 = 0
			src.tmpoxy = src.oxygen
			src.tmppoison = src.poison
			src.tmpco2 = src.co2
			src.tsl_gas = src.sl_gas
			src.tn2 = src.n2
			src.theat = src.heat
		else
			var/divideby = 1
			var/total = src.oxygen
			var/tpoison = src.poison
			var/tco2 = src.co2
			var/tosl_gas = src.sl_gas
			var/ton2 = src.n2
			var/toheat = src.heat
			var/space = 0
			src.airdir = null
			src.airforce = 0
			var/adiff = null
			for(var/S in src.FindTurfs())
				var/turf/T = S
				if (istype(T, /turf/space))
					space = 1
					src.airforce = src.oxygen + src.poison + src.n2 + src.co2 + 25000
					src.airdir = get_dir(src, T)
					break //*****RM
				else
					divideby++
					total += T.tmpoxy
					tpoison += T.tmppoison
					tco2 += T.tmpco2
					tosl_gas += T.tsl_gas
					ton2 += T.tn2
					toheat += T.theat
					adiff = src.tmpoxy + src.tmpco2 + src.tn2 - (T.tmpoxy + T.tmpco2 + T.tn2)
					if (adiff > src.airforce)
						src.airforce = adiff
						src.airdir = get_dir(src, T)
					//Foreach continue //goto(1872)
			if (src.airforce > 25000)
				for(var/atom/movable/AM as mob|obj in src)
					if ((!( AM.anchored ) && AM.weight <= src.airforce))
						spawn( 0 )
							step(AM, src.airdir)
							return
					//Foreach goto(2073)
			if (space)
				src.oxygen = 0
				src.poison = 0
				src.co2 = 0
				src.sl_gas = 0
				src.n2 = 0
				src.heat = 0
			else
				src.oxygen = total / divideby
				src.poison = tpoison / divideby
				src.co2 = tco2 / divideby
				src.sl_gas = tosl_gas / divideby
				src.n2 = ton2 / divideby
				src.heat = toheat / divideby
			if (src.sl_gas > 0)
				src.sl_gas--
			if (src.co2 >= src.poison)
				src.co2 -= src.poison
				src.oxygen += src.poison
				src.poison = 0
			else
				src.poison -= src.co2
				src.oxygen += src.co2
				src.co2 = 0
			src.oldoxy = src.oxygen
			src.oldpoison = src.poison
			src.oldco2 = src.co2
			src.osl_gas = src.sl_gas
			src.on2 = src.n2
			src.oheat = src.heat
	if ((locate(/obj/effects/water, src) || src.firelevel < 900000.0))
		src.firelevel = 0
	return
