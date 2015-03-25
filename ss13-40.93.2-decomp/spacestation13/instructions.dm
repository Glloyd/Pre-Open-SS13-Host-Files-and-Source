
/obj/machinery/computer/hologram_comp/New()

	..()
	spawn( 10 )
		src.projector = locate(/obj/machinery/hologram_proj, get_step(src.loc, NORTH))
		return
	return

/obj/machinery/computer/hologram_comp/DblClick()

	if (get_dist(src, usr) > 1)
		return 0
	src.show_console(usr)
	return

/obj/machinery/computer/hologram_comp/proc/render()

	var/icon/I = new /icon( 'human.dmi', "male" )
	if (src.lumens >= 0)
		I.Blend(rgb(src.lumens, src.lumens, src.lumens), 0)
	else
		I.Blend(rgb( -I.lumens,  -I.lumens,  -I.lumens), 1)
	I.Blend(new /icon( 'human.dmi', "mouth" ), 3)
	var/icon/U = new /icon( 'human.dmi', "diaper" )
	Blend(U, 3)
	U = new /icon( 'mob.dmi', "hair_a" )
	U.Blend(rgb(src.h_r, src.h_g, src.h_b), 0)
	I.Blend(U, 3)
	src.projector.projection.icon = I
	return

/obj/machinery/computer/hologram_comp/proc/show_console(user as mob)

	user.machine = src
	if (src.temp)
		var/dat = text("[]<BR><BR><A href='?src=\ref[];temp=1'>Clear</A>", src.temp, src)
	else
		dat = text("<B>Hologram Status:</B><HR>\nPower: <A href='?src=\ref[];power=1'>[]</A><HR>\n<B>Hologram Control:</B><BR>\nColor Luminosity: []/220 <A href='?src=\ref[];reset=1'>\[Reset\]</A><BR>\nLighten: <A href='?src=\ref[];light=1'>1</A> <A href='?src=\ref[];light=10'>10</A><BR>\nDarken: <A href='?src=\ref[];light=-1'>1</A> <A href='?src=\ref[];light=-10'>10</A><BR>\n<BR>\nHair Color: ([],[],[]) <A href='?src=\ref[];h_reset=1'>\[Reset\]</A><BR>\nRed (0-255): <A href='?src=\ref[];h_r=-300'>\[0\]</A> <A href='?src=\ref[];h_r=-10'>-10</A> <A href='?src=\ref[];h_r=-1'>-1</A> [] <A href='?src=\ref[];h_r=1'>1</A> <A href='?src=\ref[];h_r=10'>10</A> <A href='?src=\ref[];h_r=300'>\[255\]</A><BR>\nGreen (0-255): <A href='?src=\ref[];h_g=-300'>\[0\]</A> <A href='?src=\ref[];h_g=-10'>-10</A> <A href='?src=\ref[];h_g=-1'>-1</A> [] <A href='?src=\ref[];h_g=1'>1</A> <A href='?src=\ref[];h_g=10'>10</A> <A href='?src=\ref[];h_g=300'>\[255\]</A><BR>\nBlue (0-255): <A href='?src=\ref[];h_b=-300'>\[0\]</A> <A href='?src=\ref[];h_b=-10'>-10</A> <A href='?src=\ref[];h_b=-1'>-1</A> [] <A href='?src=\ref[];h_b=1'>1</A> <A href='?src=\ref[];h_b=10'>10</A> <A href='?src=\ref[];h_b=300'>\[255\]</A><BR>", src, (src.projector.projection ? "On" : "Off"),  -src.lumens + 35, src, src, src, src, src, src.h_r, src.h_g, src.h_b, src, src, src, src, src.h_r, src, src, src, src, src, src, src.h_g, src, src, src, src, src, src, src.h_b, src, src, src)
	user << browse(dat, "window=hologram_console")
	return

/obj/machinery/computer/hologram_comp/Topic(href, href_list)

	if (get_dist(src, usr) <= 1)
		flick("holo_console1", src)
		if (href_list["power"])
			if (src.projector.projection)
				src.icon_state = "hologram0"
				src.projection = null
				del(src.projector.projection)
			else
				src.projection = new /obj/projection( src.loc )
				src.projector.projection.icon = 'human.dmi'
				src.projector.projection.icon_state = "male"
				src.projector.icon_state = "hologram1"
				src.render()
		else
			if (href_list["h_r"])
				if (src.projector.projection)
					src.h_r += text2num(href_list["h_r"])
					src.h_r = min(max(src.h_r, 0), 255)
					render()
			else
				if (href_list["h_g"])
					if (src.projector.projection)
						src.h_g += text2num(href_list["h_g"])
						src.h_g = min(max(src.h_g, 0), 255)
						render()
				else
					if (href_list["h_b"])
						if (src.projector.projection)
							src.h_b += text2num(href_list["h_b"])
							src.h_b = min(max(src.h_b, 0), 255)
							render()
					else
						if (href_list["light"])
							if (src.projector.projection)
								src.lumens += text2num(href_list["light"])
								src.lumens = min(max(src.lumens, -185.0), 35)
								render()
						else
							if (href_list["reset"])
								if (src.projector.projection)
									src.lumens = 0
									render()
							else
								if (href_list["temp"])
									src.temp = null
		for(var/M as mob in viewers(1, src))
			if ((M.client && M.machine == src))
				src.show_console(M)
			//Foreach goto(446)
	return

/obj/begin/verb/ready()
	set src in usr.loc

	if ((!( istype(usr, /mob/human) ) || usr.start))
		usr << "You have already started!"
		return
	var/M = usr
	src.get_dna_ready(M)
	if ((!( M.w_uniform ) && !( ticker )))
		if (M.gender == "female")
			M.w_uniform = new /obj/item/weapon/clothing/under/pink( M )
		else
			M.w_uniform = new /obj/item/weapon/clothing/under/blue( M )
		M.w_uniform.layer = 20
		M.shoes = new /obj/item/weapon/clothing/shoes/brown( M )
		M.shoes.layer = 20
	else
		M << "You will have to find clothes from the station."
	if ((ticker && !( M.l_hand )))
		var/obj/item/weapon/card/id/I = new /obj/item/weapon/card/id( M )
		var/list/L = list( "Technical Assistant", "Research Assistant", "Staff Assistant", "Medical Assistant" )
		if (L.Find(M.occupation1))
			var/choose = M.occupation1
		else
			choose = pick(L)
		switch(choose)
			if("Research Assistant")
				I.assignment = "Research Assistant"
				I.registered = M.rname
				I.access_level = 0
				I.lab_access = 0
				I.engine_access = 0
				I.air_access = 0
			if("Technical Assistant")
				I.assignment = "Technical Assistant"
				I.registered = M.rname
				I.access_level = 0
				I.lab_access = 0
				I.engine_access = 0
				I.air_access = 0
			if("Medical Assistant")
				I.assignment = "Medical Assistant"
				I.registered = M.rname
				I.access_level = 0
				I.lab_access = 0
				I.engine_access = 0
				I.air_access = 0
			if("Staff Assistant")
				I.assignment = "Staff Assistant"
				I.registered = M.rname
				I.access_level = 0
				I.lab_access = 0
				I.engine_access = 0
				I.air_access = 0
			else
		I.name = text("[]'s ID Card ([]>[]-[]-[])", I.registered, I.access_level, I.lab_access, I.engine_access, I.air_access)
		I.layer = 20
		M.l_hand = I
	M.start = 1
	M.update_face()
	M.update_body()
	return

/obj/begin/verb/enter()
	set src in usr.loc

	if (!( enter_allowed ))
		usr << "\blue There is an administrative lock on entering the game!"
		return
	if ((!( usr.start ) || !( istype(usr, /mob/human) )))
		usr << "\blue <B>You aren't ready! Use the ready verb on this pad to set up your character!</B>"
		return
	if (ctf)
		var/rogue = locate("landmark*CTF-rogue")
		usr.loc = rogue.loc
		usr << "<B>It's CTF mode. You are a late joiner so you are a Rogue!</B>"
		usr << "\blue Now teleporting."
		if (ticker)
			var/H = usr
			if (istype(H, /mob/human))
				reg_dna[text("[]", H.primary.uni_identity)] = H.rname
		return
	var/M = usr
	var/list/start_loc = list(  )
	if ((M.key in list( "Thief jack", "Link43130", "Hutchy2k1", "Easty", "Exadv1" )))
		start_loc["Supply Station"] = locate(77, 40, 10)
	var/A = locate(/area/sleep_area)
	var/list/L = list(  )
	for(var/T as turf in A)
		L += T
		//Foreach goto(239)
	start_loc["SS13"] = pick(L)
	if (locate(text("spstart[]", M.ckey)))
		for(var/obj/sp_start/S as obj in world)
			if (S.tag == text("spstart[]", M.ckey))
				start_loc[text("[]", S.desc)] = S
			//Foreach goto(295)
	var/option = input(M, "Where should you start?", "Start Selector", null) in start_loc
	if ((!( usr.start ) || (!( istype(usr, /mob/human) ) || usr.loc != src.loc)))
		return
	if (ticker)
		reg_dna[text("[]", M.primary.uni_identity)] = M.rname
	var/S = start_loc[option]
	if (istype(S, /obj/sp_start))
		M << "\blue Now teleporting to special location."
		if (S.special == 2)
			for(var/obj/O as obj in M)
				O = null
				del(O)
				//Foreach goto(492)
			M.loc = S.loc
		else
			if (M.special == 3)
				for(var/obj/O as obj in M)
					O = null
					del(O)
					//Foreach goto(560)
				var/mob/monkey/O = new /mob/monkey( S.loc )
				M.client.mob = O
				O.loc = S.loc
				M = null
				del(M)
			else
				M.loc = O.loc
	else
		if (isturf(S))
			M << "\blue Now teleporting."
			M.loc = S
	return

/obj/begin/proc/get_dna_ready(user as mob)

	var/M = user
	if (!( M.primary ))
		M.r_hair = M.nr_hair
		M.b_hair = M.nb_hair
		M.g_hair = M.ng_hair
		M.s_tone = M.ns_tone
		var/t1 = rand(1000, 1500)
		dna_ident += t1
		if (dna_ident > 65536.0)
			dna_ident = rand(1, 1500)
		M.primary = new /obj/dna( null )
		M.primary.uni_identity = text("[]", add_zero(num2hex(dna_ident), 4))
		var/t2 = add_zero(num2hex(M.nr_hair), 2)
		M.uni_identity = text("[][]", M.primary.uni_identity, t2)
		t2 = add_zero(num2hex(M.ng_hair), 2)
		M.uni_identity = text("[][]", M.primary.uni_identity, t2)
		t2 = add_zero(num2hex(M.nb_hair), 2)
		M.uni_identity = text("[][]", M.primary.uni_identity, t2)
		t2 = add_zero(num2hex(M.r_eyes), 2)
		M.uni_identity = text("[][]", M.primary.uni_identity, t2)
		t2 = add_zero(num2hex(M.g_eyes), 2)
		M.uni_identity = text("[][]", M.primary.uni_identity, t2)
		t2 = add_zero(num2hex(M.b_eyes), 2)
		M.uni_identity = text("[][]", M.primary.uni_identity, t2)
		t2 = add_zero(num2hex( -M.ns_tone + 35), 2)
		M.uni_identity = text("[][]", M.primary.uni_identity, t2)
		t2 = (M.gender == "male" ? text("[]", num2hex(rand(1, 124))) : text("[]", num2hex(rand(127, 250))))
		if (length(t2) < 2)
			M.uni_identity = text("[]0[]", M.primary.uni_identity, t2)
		else
			M.uni_identity = text("[][]", M.primary.uni_identity, t2)
		M.primary.spec_identity = "5BDFE293BA5500F9FFFD500AAFFE"
		M.primary.struc_enzyme = "CDE375C9A6C25A7DBDA50EC05AC6CEB63"
		if (rand(1, 3125) == 13)
			M.need_gl = 1
			M.be_epil = 1
			M.be_cough = 1
			M.be_tur = 1
			M.be_stut = 1
		if (M.need_gl)
			var/b_vis = add_zero(text("[]", num2hex(rand(10, 1400))), 3)
			M.disabilities = M.disabilities | 1
			M << "\blue You need glasses!"
		else
			b_vis = "5A7"
		if (M.be_epil)
			var/epil = add_zero(text("[]", num2hex(rand(10, 1400))), 3)
			M.disabilities = M.disabilities | 2
			M << "\blue You are epileptic!"
		else
			epil = "6CE"
		if (M.be_cough)
			var/cough = add_zero(text("[]", num2hex(rand(10, 1400))), 3)
			M.disabilities = M.disabilities | 4
			M << "\blue You have a chronic coughing syndrome!"
		else
			cough = "EC0"
		if (M.be_tur)
			epil = add_zero(text("[]", num2hex(rand(10, 1400))), 3)
			M.disabilities = M.disabilities | 8
			M << "\blue You have Tourette syndrome!"
		else
			var/Tourette = "5AC"
		if (M.be_stut)
			var/stutter = add_zero(text("[]", num2hex(rand(10, 1400))), 3)
			M.disabilities = M.disabilities | 16
			M << "\blue You have a stuttering problem!"
		else
			stutter = "A50"
		M.primary.struc_enzyme = text("CDE375C9A6C2[]DBD[][][][]B63", b_vis, stutter, cough, Tourette, epil)
		M.primary.use_enzyme = "493DB249EB6D13236100A37000800AB71"
		M.primary.n_chromo = 28
	return

/turf/station/command/floor/updatecell()

	src.oxygen = 756000.0
	src.firelevel = 0
	src.co2 = 0
	src.poison = 0
	src.sl_gas = 0
	src.n2 = 0
	return

/turf/station/command/floor/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/turf/station/command/floor/attack_hand(user as mob)

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
