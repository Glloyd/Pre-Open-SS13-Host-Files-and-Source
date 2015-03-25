
/obj/item/weapon/organ/proc/process()

	return

/obj/item/weapon/organ/proc/receive_chem(chemical as obj)

	return

/obj/item/weapon/organ/external/proc/take_damage(brute, burn)

	if ((brute <= 0 && burn <= 0))
		return 0
	if ((src.brute_dam + src.burn_dam + brute + burn) < src.max_damage)
		src.brute_dam += brute
		src.burn_dam += burn
	else
		var/can_inflict = src.max_damage - (src.brute_dam + src.burn_dam)
		if (can_inflict)
			if ((brute > 0 && burn > 0))
				var/ratio = brute / (brute + burn)
				src.brute_dam += ratio * can_inflict
				src.burn_dam += (1 - ratio) * can_inflict
			else
				if (brute > 0)
					src.brute_dam += brute
				else
					src.burn_dam += burn
		else
			return 0
	return src.update_icon()
	return

/obj/item/weapon/organ/external/proc/heal_damage(brute, burn)

	src.brute_dam = max(0, src.brute_dam - brute)
	src.burn_dam = max(0, src.brute_dam - burn)
	return update_icon()
	return

/obj/item/weapon/organ/external/proc/update_icon()

	var/n_is = text("[]0", src.r_name)
	if (src.burn_dam == 0)
		n_is = text("0[]", n_is)
	else
		if (src.burn_dam < (src.max_damage * 0.25 / 2))
			n_is = text("1[]", n_is)
		else
			if (src.burn_dam < (src.max_damage * 0.75 / 2))
				n_is = text("2[]", n_is)
			else
				n_is = text("3[]", n_is)
	if (src.brute_dam == 0)
		n_is = text("0[]", n_is)
	else
		if (src.brute_dam < (src.max_damage * 0.25 / 2))
			n_is = text("1[]", n_is)
		else
			if (src.brute_dam < (src.max_damage * 0.75 / 2))
				n_is = text("2[]", n_is)
			else
				n_is = text("3[]", n_is)
	if (n_is != src.d_i_state)
		src.d_i_state = n_is
		return 1
	else
		return 0
	return

/obj/substance/proc/leak(turf)

	return

/obj/substance/chemical/proc/volume()

	var/amount = 0
	for(var/item in src.chemicals)
		var/datum/chemical/C = src.chemicals[item]
		if (istype(C, /datum/chemical))
			amount += C.return_property("volume")
		//Foreach goto(24)
	return amount
	return

/obj/substance/chemical/proc/split(amount)

	var/obj/substance/chemical/S = new /obj/substance/chemical( null )
	var/tot_volume = src.volume()
	if (amount > tot_volume)
		amount = tot_volume
		for(var/item in src.chemicals)
			var/C = src.chemicals[item]
			if (istype(C, /datum/chemical))
				S.chemicals[item] = C
				src.chemicals[item] = null
			//Foreach goto(60)
		return S
	else
		if (tot_volume <= 0)
			return S
		else
			for(var/item in src.chemicals)
				var/datum/chemical/C = src.chemicals[item]
				if (istype(C, /datum/chemical))
					var/datum/chemical/N = new C.type( null )
					C.copy_data(N)
					var/amt = C.return_property("volume") * amount / tot_volume
					C.moles -= amt * C.density / C.molarmass
					if (C.moles == 0)
						//C = null
						del(C)
					N.moles += amt * N.density / N.molarmass
					S.chemicals[text("[]", N.name)] = N
				//Foreach goto(161)
			return S
	return

/obj/substance/chemical/proc/transfer_from(var/obj/substance/chemical/S as obj, amount)

	var/volume = src.volume()
	var/s_volume = S.volume()
	if (amount > s_volume)
		amount = s_volume
	if (src.maximum)
		if (amount > (src.maximum - volume))
			amount = src.maximum - volume
	if (amount >= s_volume)
		for(var/item in S.chemicals)
			var/datum/chemical/C = S.chemicals[item]
			if (istype(C, /datum/chemical))
				var/datum/chemical/N = null
				N = src.chemicals[item]
				if (!( N ))
					N = new C.type( null )
					C.copy_data(N)
				N.moles += C.moles
				//C = null
				del(C)
			//Foreach goto(106)
	else
		var/obj/substance/chemical/U = S.split(amount)
		for(var/item in U.chemicals)
			var/datum/chemical/C = U.chemicals[item]
			if (istype(C, /datum/chemical))
				var/datum/chemical/N = src.chemicals[item]
				if (!( N ))
					N = new C.type( null )
					C.copy_data(N)
					src.chemicals[item] = N
				N.moles += C.moles
				//C = null
				del(C)
			//Foreach goto(251)
		//U = null
		del(U)
	var/datum/chemical/C = null
	for(var/t in src.chemicals)
		C = src.chemicals[text("[]", t)]
		if (istype(C, /datum/chemical))
			C.react(src)
		//Foreach goto(403)
	return amount
	return

/obj/substance/chemical/proc/transfer_mob(var/mob/M as mob, amount)

	if (!( ismob(M) ))
		return
	var/obj/substance/chemical/S = src.split(amount)
	for(var/item in S.chemicals)
		var/datum/chemical/C = S.chemicals[item]
		if (istype(C, /datum/chemical))
			C.injected(M)
		//Foreach goto(44)
	//S = null
	del(S)
	return

/obj/substance/chemical/proc/dropper_mob(M as mob, amount)

	if (!( ismob(M) ))
		return
	var/obj/substance/chemical/S = src.split(amount)
	for(var/item in S.chemicals)
		var/datum/chemical/C = S.chemicals[item]
		if (istype(C, /datum/chemical))
			C.injected(M, "eye")
		//Foreach goto(44)
	//S = null
	del(S)
	return

/obj/substance/chemical/Del()

	for(var/item in src.chemicals)
		//src.chemicals[item] = null
		del(src.chemicals[item])
		//Foreach goto(17)
	..()
	return

/obj/substance/gas/leak(T as turf)

	turf_add(T, src.co2 + src.oxygen + src.plasma)
	return

/obj/substance/gas/proc/tot_gas()

	return src.co2 + src.oxygen + src.plasma + src.sl_gas + src.n2
	return

/obj/substance/gas/proc/transfer_from(var/obj/substance/gas/target as obj, amount)

	if ((!( istype(target, /obj/substance/gas) ) || !( amount )))
		return
	var/t1 = target.co2 + target.oxygen + target.plasma + target.sl_gas + target.n2
	if (!( t1 ))
		return
	if (amount > t1)
		amount = t1
	var/t2 = src.co2 + src.oxygen + src.plasma + src.sl_gas + src.n2
	if (amount < 0)
		amount = t1
	if ((src.maximum > 0 && (src.maximum - t2) < amount))
		amount = src.maximum - t2
	var/t_oxy = amount * target.oxygen / t1
	var/t_pla = amount * target.plasma / t1
	var/t_co2 = amount * target.co2 / t1
	var/t_sl_gas = amount * target.sl_gas / t1
	var/t_n2 = amount * target.n2 / t1
	var/t3 = t1 + t2
	var/t4 = t2 * src.temperature
	var/t5 = t1 * target.temperature
	if (t3 > 0)
		src.temperature = (t4 + t5) / t3
	src.co2 += t_co2
	src.oxygen += t_oxy
	src.plasma += t_pla
	src.sl_gas += t_sl_gas
	src.n2 += t_n2
	target.oxygen -= t_oxy
	target.co2 -= t_co2
	target.plasma -= t_pla
	target.sl_gas -= t_sl_gas
	target.n2 -= t_n2
	return

/obj/substance/gas/proc/clear()

	src.oxygen = 0
	src.plasma = 0
	src.co2 = 0
	src.sl_gas = 0
	src.n2 = 0
	return

/obj/substance/gas/proc/has_gas()

	return (src.co2 + src.oxygen + src.plasma + src.sl_gas + src.n2) > 0
	return

/obj/substance/gas/proc/turf_add(var/turf/target as turf, amount)

	if (((!( istype(target, /turf) ) && !( istype(target, /obj/move) )) || !( amount )))
		return
	if (locate(/obj/move, target))
		target = locate(/obj/move, target)
	var/t2 = src.co2 + src.oxygen + src.plasma + src.sl_gas + src.n2
	if (amount < 0)
		amount = src.plasma + src.oxygen + src.co2 + src.sl_gas + src.n2
	if (!( t2 ))
		return
	var/t_oxy = amount * src.oxygen / t2
	var/t_pla = amount * src.plasma / t2
	var/t_co2 = amount * src.co2 / t2
	var/t_sl_gas = amount * src.sl_gas / t2
	var/t_n2 = amount * src.n2 / t2
	src.co2 -= t_co2
	src.oxygen -= t_oxy
	src.plasma -= t_pla
	src.sl_gas -= t_sl_gas
	src.n2 -= t_n2
	target.oxygen += t_oxy
	target.co2 += t_co2
	target.poison += t_pla
	target.sl_gas += t_sl_gas
	target.n2 += t_n2
	target.heat += amount * (src.temperature - -254.7)
	target.res_vars()
	return

/obj/substance/gas/proc/turf_take(var/turf/target as turf, amount)

	if (((!( istype(target, /turf) ) && !( istype(target, /obj/move) )) || !( amount )))
		return
	if (locate(/obj/move, target))
		target = locate(/obj/move, target)
	var/t1 = target.co2 + target.oxygen + target.poison + target.sl_gas + target.n2
	if (!( t1 ))
		return
	var/t2 = src.co2 + src.oxygen + src.plasma + src.sl_gas + src.n2
	if (amount > 0)
		if ((src.maximum > 0 && (src.maximum - t2) < amount))
			amount = src.maximum - t2
	else
		amount = src.plasma + src.oxygen + src.co2 + src.sl_gas + src.n2
	if (amount > t1)
		amount = t1
	var/turf_total = target.poison + target.oxygen + target.co2 + target.sl_gas + target.n2
	var/heat_gain = (turf_total ? amount / turf_total * target.heat : 0)
	var/temp_gain = (turf_total ? target.heat / turf_total + -254.7 : 0)
	var/t_oxy = amount * target.oxygen / t1
	var/t_pla = amount * target.poison / t1
	var/t_co2 = amount * target.co2 / t1
	var/t_sl_gas = amount * target.sl_gas / t1
	var/t_n2 = amount * target.n2 / t1
	var/t3 = t1 + t2
	var/t4 = t2 * src.temperature
	var/t5 = t1 * temp_gain
	if (t3 > 0)
		src.temperature = (t4 + t5) / t3
	else
		src.temperature = 0
	src.co2 += t_co2
	src.oxygen += t_oxy
	src.plasma += t_pla
	src.sl_gas += t_sl_gas
	src.n2 += t_n2
	target.oxygen -= t_oxy
	target.co2 -= t_co2
	target.poison -= t_pla
	target.sl_gas -= t_sl_gas
	target.n2 -= t_n2
	target.heat -= heat_gain
	target.res_vars()
	return

/obj/substance/gas/proc/extract_toxs(var/turf/target as turf)

	if ((!( istype(target, /turf) ) && !( istype(target, /obj/move) )))
		return
	if (locate(/obj/move, target))
		target = locate(/obj/move, target)
	var/co2_diff = target.co2 - 0
	var/oxy_diff = target.oxygen - 756000.0
	var/no2_diff = target.sl_gas - 0
	var/n2_diff = target.n2 - 2844000.0
	var/plas_diff = target.poison - 0
	if (co2_diff < 0)
		co2_diff = 0
	if (oxy_diff < 0)
		oxy_diff = 0
	if (no2_diff < 0)
		no2_diff = 0
	if (n2_diff < 0)
		n2_diff = 0
	if (plas_diff < 0)
		plas_diff = 0
	var/turf_total = target.poison + target.oxygen + target.co2 + target.sl_gas + target.n2
	var/air_total = co2_diff + oxy_diff + no2_diff + n2_diff + plas_diff
	var/heat_gain = (turf_total ? air_total / turf_total * target.heat : null)
	var/temp_gain = (turf_total ? target.heat / turf_total + -254.7 : 0)
	src.co2 += co2_diff
	src.oxygen += oxy_diff
	src.sl_gas += no2_diff
	src.n2 += n2_diff
	src.plasma += plas_diff
	target.co2 -= co2_diff
	target.oxygen -= oxy_diff
	target.sl_gas -= no2_diff
	target.n2 -= n2_diff
	target.poison -= plas_diff
	var/t3 = turf_total + air_total
	var/t4 = turf_total * src.temperature
	var/t5 = air_total * temp_gain
	if (t3 > 0)
		src.temperature = (t4 + t5) / t3
	else
		src.temperature = 0
	target.heat -= heat_gain
	target.res_vars()
	return

/obj/substance/gas/proc/merge_into(var/obj/substance/gas/target as obj)

	if (!( istype(target, /obj/substance/gas) ))
		return
	var/amount = src.co2 + src.oxygen + src.plasma + src.sl_gas + src.n2 + target.co2 + target.oxygen + target.plasma + target.sl_gas + target.n2
	var/t1 = (src.co2 + src.oxygen + src.plasma + src.sl_gas) * src.temperature
	var/t2 = (target.co2 + target.oxygen + target.plasma + target.sl_gas) * target.temperature
	if (amount > 0)
		src.temperature = (t1 + t2) / amount
	src.co2 += target.co2
	src.oxygen += target.oxygen
	src.plasma += target.plasma
	src.sl_gas += target.sl_gas
	src.n2 += target.n2
	target.oxygen = 0
	target.plasma = 0
	target.co2 = 0
	target.sl_gas = 0
	target.n2 = 0
	return

/datum/chemical/pathogen/proc/process(source as obj)

	return

/datum/chemical/proc/react(S as obj)

	return

/datum/chemical/proc/react_organ(O as obj)

	return

/datum/chemical/proc/injected(M as mob, zone)

	if (zone == null)
		zone = "body"
	return

/datum/chemical/proc/copy_data(var/datum/chemical/C)

	C.molarmass = src.molarmass
	C.density = src.density
	C.chem_formula = src.chem_formula
	return

/datum/chemical/proc/return_property(property)

	switch(property)
		if("moles")
			return src.moles
		if("mass")
			return src.moles * src.molarmass
		if("density")
			return src.density
		if("volume")
			return src.moles * src.molarmass / src.density
		else
	return

/datum/chemical/pl_coag/react(obj/substance/chemical/S as obj)

	var/datum/chemical/l_plas/C = S.chemicals["plasma-l"]
	if (istype(C, /datum/chemical/l_plas))
		if (C.moles < src.moles)
			src.moles -= C.moles
			var/datum/chemical/waste/W = S.chemicals["waste-l"]
			if (istype(W, /datum/chemical/waste))
				W.moles += C.moles
			else
				W = new /datum/chemical/waste(  )
				S.chemicals["waste-l"] = W
				W.moles += C.moles
			//C = null
			del(C)
		else
			C.moles -= src.moles
			var/datum/chemical/waste/W = S.chemicals["waste-l"]
			if (istype(W, /datum/chemical/waste))
				W.moles += src.moles
			else
				W = new /datum/chemical/waste(  )
				S.chemicals["waste-l"] = W
				W.moles += src.moles
			src.moles = 0
		if (src.moles <= 0)
			//SN src = null
			del(src)
			return
	return

/datum/chemical/pl_coag/injected(var/mob/M as mob, zone)

	var/volume = src.return_property("volume")
	switch(zone)
		if("eye")
			M.eye_stat -= volume * 2
			M.eye_stat = max(0, M.eye_stat)
		else
			if (M.health >= 0)
				if ((volume * 4) >= M.toxloss)
					M.toxloss = 0
				else
					M.toxloss -= volume * 4
			M.antitoxs += volume * 180
			M.health = 100 - M.oxyloss - M.toxloss - M.fireloss - M.bruteloss
	return

/datum/chemical/l_plas/injected(var/mob/M as mob, zone)

	var/volume = src.return_property("volume")
	switch(zone)
		if("eye")
			M.eye_stat += volume * 5
			M.eye_blurry += volume * 3
			if (M.eye_stat >= 20)
				M << "\red Your eyes start to burn badly!"
				M.disabilities |= 1
				if (prob(M.eye_stat - 20 + 1))
					M << "\red You go blind!"
					M.sdisabilities |= 1
		else
			M.plasma += volume * 6
			for(var/obj/item/weapon/implant/tracking/T in M)
				M.plasma += 1
				//T = null
				del(T)
				//Foreach goto(133)
	return

/datum/chemical/s_tox/injected(var/mob/M as mob, zone)

	var/volume = src.return_property("volume")
	switch(zone)
		if("eye")
			M.eye_blind += volume * 10
			M.eye_blurry += volume * 15
		else
			M.paralysis += volume * 12
			M.stat = 1
	return

/datum/chemical/epil/injected(var/mob/M as mob, zone)

	var/volume = src.return_property("volume")
	switch(zone)
		if("eye")
			M.eye_blind += volume * 5
			M.eye_stat += volume * 2
			M.eye_blurry += volume * 20
			if (M.eye_stat >= 20)
				M << "\red Your eyes start to burn badly!"
				M.disabilities |= 1
				if (prob(M.eye_stat - 20 + 1))
					M << "\red You go blind!"
					M.sdisabilities |= 1
		else
			M.r_epil += volume * 60
	return

/datum/chemical/ch_cou/injected(var/mob/M as mob, zone)

	var/volume = src.return_property("volume")
	switch(zone)
		if("eye")
			M.eye_blind += volume * 2
			M.eye_stat += volume * 3
			M.eye_blurry += volume * 20
			M << "\red Your eyes start to burn badly!"
			M.disabilities |= 1
			if (prob(M.eye_stat - 20 + 1))
				M << "\red You go blind!"
				M.sdisabilities |= 1
		else
			M.r_ch_cou += volume * 60
	return

/datum/chemical/rejuv/injected(var/mob/M as mob, zone)

	var/volume = src.return_property("volume")
	switch(zone)
		if("eye")
			M.eye_stat -= volume * 5
			M.eye_blurry += volume * 5
			M.eye_stat = max(0, M.eye_stat)
		else
			M.rejuv += volume * 3
			if (M.paralysis)
				M.paralysis = 3
			if (M.weakened)
				M.weakened = 3
			if (M.stunned)
				M.stunned = 3
	return
