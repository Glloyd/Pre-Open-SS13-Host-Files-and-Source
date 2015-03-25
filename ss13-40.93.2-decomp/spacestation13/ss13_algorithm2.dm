
/proc/SetupOccupationsList()

	var/list/new_occupations = list(  )
	for(var/occupation in occupations)
		if (!( new_occupations.Find(occupation) ))
			new_occupations[occupation] = 1
		else
			new_occupations[occupation] += 1
		//Foreach goto(23)
	occupations = new_occupations
	return

/proc/DivideOccupations()

	var/list/occupations1 = list(  )
	var/list/occupations2 = list(  )
	var/list/occupations3 = list(  )
	var/list/final_occupations = list(  )
	var/list/unassigned_mobs = list(  )
	var/occupation_choices = occupations.Copy()
	occupation_choices = shuffle(occupation_choices)
	for(var/occupation in occupations + assistant_occupations)
		occupations1[occupation] = list(  )
		occupations2[occupation] = list(  )
		occupations3[occupation] = list(  )
		final_occupations[occupation] = list(  )
		//Foreach goto(78)
	occupations1["Captain"] = list(  )
	occupations2["Captain"] = list(  )
	occupations3["Captain"] = list(  )
	final_occupations["Captain"] = list(  )
	for(var/mob/human/M as mob in world)
		if ((!( M.client ) || (!( M.start ) || M.already_placed)))
		else
			unassigned_mobs += M
			if (M.occupation1 != "No Preference")
				occupations1[M.occupation1] += M
				if (M.occupation2 != "No Preference")
					occupations2[M.occupation2] += M
					if (M.occupation3 != "No Preference")
						occupations3[M.occupation3] += M
		//Foreach goto(187)
	for(var/occupation in occupations)
		occupations1[occupation] = shuffle(occupations1[occupation])
		occupations2[occupation] = shuffle(occupations2[occupation])
		occupations3[occupation] = shuffle(occupations3[occupation])
		//Foreach goto(339)
	occupations1["Captain"] = shuffle(occupations1["Captain"])
	occupations2["Captain"] = shuffle(occupations2["Captain"])
	occupations3["Captain"] = shuffle(occupations3["Captain"])
	var/captain_choice = occupations1["Captain"]
	if (captain_choice.len)
		final_occupations["Captain"] = captain_choice[1]
		occupation_choices -= "Captain"
		unassigned_mobs -= final_occupations["Captain"]
	if (!( final_occupations["Captain"] ))
		captain_choice = occupations2["Captain"]
		if (captain_choice.len)
			final_occupations["Captain"] = captain_choice[1]
			occupation_choices -= "Captain"
			unassigned_mobs -= final_occupations["Captain"]
	if (!( final_occupations["Captain"] ))
		captain_choice = occupations3["Captain"]
		if (captain_choice.len)
			final_occupations["Captain"] = captain_choice[1]
			occupation_choices -= "Captain"
			unassigned_mobs -= final_occupations["Captain"]
	if (!( final_occupations["Captain"] ))
		var/list/contenders = list(  )
		for(var/mob/human/M as mob in world)
			if (M.client)
				contenders += M
			//Foreach goto(691)
		var/M = pick(contenders)
		final_occupations["Captain"] = M
		occupation_choices -= "Captain"
		unassigned_mobs -= final_occupations["Captain"]
		occupations1[text("[]", M.occupation1)] -= M
		occupations2[text("[]", M.occupation2)] -= M
		occupations3[text("[]", M.occupation3)] -= M
	for(var/mob/human/M as mob in unassigned_mobs)
		if (assistant_occupations.Find(M.occupation1))
			M.Assign_Rank(M.occupation1)
			unassigned_mobs -= M
		//Foreach goto(844)
	for(var/occupation in occupation_choices)
		var/L = occupations1[occupation]
		if (L.len)
			var/eligible = occupations[occupation]
			var/multiple = eligible > 1
			while(eligible--)
				var/M = null
				var/i = null
				i = 1
				while((i <= L.len && !( M )))
					if (unassigned_mobs.Find(L[i]))
						M = L[i]
					i++
				if (M)
					if (multiple)
						final_occupations[occupation] += M
					else
						final_occupations[occupation] = M
					unassigned_mobs -= M
					if (eligible < 1)
						occupation_choices -= occupation
		if ((!( occupation_choices.len ) || !( unassigned_mobs.len )))
		else
			//Foreach continue //goto(913)
	for(var/mob/human/M as mob in unassigned_mobs)
		if (assistant_occupations.Find(M.occupation2))
			M.Assign_Rank(M.occupation2)
			unassigned_mobs -= M
		//Foreach goto(1158)
	for(var/occupation in occupation_choices)
		var/L = occupations2[occupation]
		if (L.len)
			var/eligible = occupations[occupation]
			var/multiple = eligible > 1
			if (multiple)
				var/X = final_occupations[occupation]
				eligible -= X.len
			while(eligible--)
				var/M = null
				var/i = null
				i = 1
				while((i <= L.len && !( M )))
					if (unassigned_mobs.Find(L[i]))
						M = L[i]
					i++
				if (M)
					if (multiple)
						final_occupations[occupation] += M
					else
						final_occupations[occupation] = M
					unassigned_mobs -= M
					if (eligible < 1)
						occupation_choices -= occupation
		if ((!( occupation_choices.len ) || !( unassigned_mobs.len )))
		else
			//Foreach continue //goto(1227)
	for(var/mob/human/M as mob in unassigned_mobs)
		if (assistant_occupations.Find(M.occupation3))
			M.Assign_Rank(M.occupation3)
			unassigned_mobs -= M
		//Foreach goto(1502)
	for(var/occupation in occupation_choices)
		var/L = occupations3[occupation]
		if (L.len)
			var/eligible = occupations[occupation]
			var/multiple = eligible > 1
			if (multiple)
				var/X = final_occupations[occupation]
				eligible -= X.len
			while(eligible--)
				var/M = null
				var/i = null
				i = 1
				while((i <= L.len && !( M )))
					if (unassigned_mobs.Find(L[i]))
						M = L[i]
					i++
				if (M)
					if (multiple)
						final_occupations[occupation] += M
					else
						final_occupations[occupation] = M
					unassigned_mobs -= M
					if (eligible < 1)
						occupation_choices -= occupation
		//Foreach goto(1571)
	if (unassigned_mobs.len)
		unassigned_mobs = shuffle(unassigned_mobs)
	for(var/mob/human/M as mob in unassigned_mobs)
		if (occupation_choices.len)
			var/occupation = pick(occupation_choices)
			final_occupations[occupation] = M
			occupation_choices -= occupation
			unassigned_mobs -= M
		else
			else
		//Foreach goto(1846)
	for(var/occupation in final_occupations)
		var/M = final_occupations[occupation]
		if (ismob(M))
			M.Assign_Rank(occupation)
		else
			if (istype(M, (List:0)))
				for(var/mob/human/E as mob in final_occupations[occupation])
					E.Assign_Rank(occupation)
					//Foreach goto(2003)
		//Foreach goto(1931)
	for(var/mob/human/M as mob in unassigned_mobs)
		M.Assign_Rank(pick("Research Assistant", "Technical Assistant", "Medical Assistant", "Staff Assistant"))
		//Foreach goto(2051)
	return

/proc/shuffle(shufflelist)

	if (!( shufflelist ))
		return
	var/old_list = shufflelist.Copy()
	var/list/new_list = list(  )
	while(old_list.len)
		var/item = old_list[rand(1, old_list.len)]
		new_list += item
		old_list -= item
	return new_list
	return

/world/New()

	..()
	spawn( 0 )
		SetupOccupationsList()
		return
	return

/mob/human/verb/char_setup()

	if (src.start)
		return
	src.ShowChoices()
	return

/mob/human/proc/ShowChoices()

	var/destructive = assistant_occupations.Copy()
	var/dat = "<html><body>"
	dat += text("<b>Name:</b> <a href=\"byond://?src=\ref[];rname=input\"><b>[]</b></a><br>", src, src.rname)
	dat += text("<b>Gender:</b> <a href=\"byond://?src=\ref[];gender=input\"><b>[]</b></a><br>", src, (src.gender == "male" ? "Male" : "Female"))
	dat += text("<b>Age</b> - <a href='byond://?src=\ref[];age=input'>[]</a><hr>", src, src.age)
	dat += "<hr><b>Occupation Choices</b>:<br>"
	if (destructive.Find(src.occupation1))
		dat += text("\t<a href=\"byond://?src=\ref[];occ=1\"><b>[]</b></a><br>", src, src.occupation1)
	else
		if (src.occupation1 != "No Preference")
			dat += text("\tFirst Choice: <a href=\"byond://?src=\ref[];occ=1\"><b>[]</b></a><br>", src, src.occupation1)
			if (destructive.Find(src.occupation2))
				dat += text("\tSecond Choice: <a href=\"byond://?src=\ref[];occ=2\"><b>[]</b></a><BR>", src, src.occupation2)
			else
				if (src.occupation2 != "No Preference")
					dat += text("\tSecond Choice: <a href=\"byond://?src=\ref[];occ=2\"><b>[]</b></a><BR>", src, src.occupation2)
					if (destructive.Find(src.occupation3))
						dat += text("\tLast Choice: <a href=\"byond://?src=\ref[];occ=3\"><b>[]</b></a><BR>", src, src.occupation3)
					else
						if (src.occupation3 != "No Preference")
							dat += text("\tLast Choice: <a href=\"byond://?src=\ref[];occ=3\"><b>[]</b></a><BR>", src, src.occupation3)
						else
							dat += text("\tLast Choice: <a href=\"byond://?src=\ref[];occ=3\">No Preference</a><br>", src)
				else
					dat += text("\tSecond Choice: <a href=\"byond://?src=\ref[];occ=2\">No Preference</a><br>", src)
		else
			dat += text("\t<a href=\"byond://?src=\ref[];occ=1\">No Preference</a><br>", src)
	dat += "<hr><b>Body Data</b><br>"
	dat += text("<b>Blood Type:</b> <a href='byond://?src=\ref[];b_type=input'>[]</a><br>", src, src.b_type)
	dat += text("<b>Skin Tone:</b> <a href='byond://?src=\ref[];ns_tone=input'>[]/220</a><br>", src,  -src.ns_tone + 35)
	dat += text("<b>Hair Color:</b> <font color=\"#[][][]\">test</font><br>", num2hex(src.nr_hair, 2), num2hex(src.ng_hair, 2), num2hex(src.nb_hair))
	dat += text(" <b><font color=\"#[]0000\">Red</font></b> - <a href='byond://?src=\ref[];nr_hair=input'>[]</a>", num2hex(src.nr_hair, 2), src, src.nr_hair)
	dat += text(" <b><font color=\"#00[]00\">Green</font></b> - <a href='byond://?src=\ref[];ng_hair=input'>[]</a>", num2hex(src.ng_hair, 2), src, src.ng_hair)
	dat += text(" <b><font color=\"#0000[]\">Blue</font></b> - <a href='byond://?src=\ref[];nb_hair=input'>[]</a>", num2hex(src.nb_hair, 2), src, src.nb_hair)
	dat += text("<br> <b>Style</b> - <a href='byond://?src=\ref[];h_style=input'>[]</a>", src, src.h_style)
	dat += text("<br><b>Eye Color:</b> <font color=\"#[][][]\">test</font><br>", num2hex(src.r_eyes, 2), num2hex(src.g_eyes, 2), num2hex(src.b_eyes, 2))
	dat += text(" <b><font color=\"#[]0000\">Red</font></b> - <a href='byond://?src=\ref[];r_eyes=input'>[]</a>", num2hex(src.r_eyes, 2), src, src.r_eyes)
	dat += text(" <b><font color=\"#00[]00\">Green</font></b> - <a href='byond://?src=\ref[];g_eyes=input'>[]</a>", num2hex(src.g_eyes, 2), src, src.g_eyes)
	dat += text(" <b><font color=\"#0000[]\">Blue</font></b> - <a href='byond://?src=\ref[];b_eyes=input'>[]</a>", num2hex(src.b_eyes, 2), src, src.b_eyes)
	dat += "<hr><b>Disabilities</b><br>"
	dat += text("Need Glasses: <a href=\"byond://?src=\ref[];n_gl=1\"><b>[]</b></a><br>", src, (src.need_gl ? "Yes" : "No"))
	dat += text("Epileptic: <a href=\"byond://?src=\ref[];b_ep=1\"><b>[]</b></a><br>", src, (src.be_epil ? "Yes" : "No"))
	dat += text("Tourette Syndrome: <a href=\"byond://?src=\ref[];b_tur=1\"><b>[]</b></a><br>", src, (src.be_tur ? "Yes" : "No"))
	dat += text("Chronic Cough: <a href=\"byond://?src=\ref[];b_co=1\"><b>[]</b></a><br>", src, (src.be_cough ? "Yes" : "No"))
	dat += text("Stutter: <a href=\"byond://?src=\ref[];b_stut=1\"><b>[]</b></a><br>", src, (src.be_stut ? "Yes" : "No"))
	dat += "<hr>"
	dat += text("<a href='byond://?src=\ref[];load=1'>Load Setup</a><br>", src)
	dat += text("<a href='byond://?src=\ref[];save=1'>Save Setup</a><br>", src)
	dat += "</body></html>"
	src << browse(dat, "window=mob_occupations;size=300x600")
	return

/mob/human/proc/SetChoices(occ)

	if (occ == null)
		occ = 1
	var/HTML = "<body>"
	HTML += "<tt><center>"
	switch(occ)
		if(1.0)
			HTML += "<b>Which occupation would you like most?</b><br><br>"
		if(2.0)
			HTML += "<b>Which occupation would you like if you couldn't have your first?</b><br><br>"
		if(3.0)
			HTML += "<b>Which occupation would you like if you couldn't have the others?</b><br><br>"
		else
	for(var/job in occupations + assistant_occupations)
		HTML += text("<a href=\"byond://?src=\ref[];occ=[];job=[]\">[]</a><br>", src, occ, job, job)
		//Foreach goto(105)
	HTML += text("<a href=\"byond://?src=\ref[];occ=[];job=Captain\">Captain</a><br>", src, occ)
	HTML += "<br>"
	HTML += text("<a href=\"byond://?src=\ref[];occ=[];job=No Preference\">\[No Preference\]</a><br>", src, occ)
	HTML += text("<a href=\"byond://?src=\ref[];occ=[];cancel\">\[Cancel\]</a>", src, occ)
	HTML += "</center></tt>"
	usr << browse(HTML, "window=mob_occupation;size=300x500")
	return

/mob/human/proc/SetJob(occ, job)

	if (occ == null)
		occ = 1
	if (job == null)
		job = "Captain"
	if ((!( occupations.Find(job) ) && (!( assistant_occupations.Find(job) ) && job != "Captain")))
		return
	switch(occ)
		if(1.0)
			if (job == src.occupation1)
				usr << browse(null, "window=mob_occupation")
				return
			else
				if (job == "No Preference")
					src.occupation1 = "No Preference"
				else
					if (job == src.occupation2)
						job = src.occupation1
						src.occupation1 = src.occupation2
						src.occupation2 = job
					else
						if (job == src.occupation3)
							job = src.occupation1
							src.occupation1 = src.occupation3
							src.occupation3 = job
						else
							src.occupation1 = job
		if(2.0)
			if (job == src.occupation2)
				src << browse(null, "window=mob_occupation")
				return
			else
				if (job == "No Preference")
					if (src.occupation3 != "No Preference")
						src.occupation2 = src.occupation3
						src.occupation3 = "No Preference"
					else
						src.occupation2 = "No Preference"
				else
					if (job == src.occupation1)
						if (src.occupation2 == "No Preference")
							src << browse(null, "window=mob_occupation")
							return
						job = src.occupation2
						src.occupation2 = src.occupation1
						src.occupation1 = job
					else
						if (job == src.occupation3)
							job = src.occupation2
							src.occupation2 = src.occupation3
							src.occupation3 = job
						else
							src.occupation2 = job
		if(3.0)
			if (job == src.occupation3)
				usr << browse(null, "window=mob_occupation")
				return
			else
				if (job == "No Preference")
					src.occupation3 = "No Preference"
				else
					if (job == src.occupation1)
						if (src.occupation3 == "No Preference")
							src << browse(null, "window=mob_occupation")
							return
						job = src.occupation3
						src.occupation3 = src.occupation1
						src.occupation1 = job
					else
						if (job == src.occupation2)
							if (src.occupation3 == "No Preference")
								src << browse(null, "window=mob_occupation")
								return
							job = src.occupation3
							src.occupation3 = src.occupation2
							src.occupation2 = job
						else
							src.occupation3 = job
		else
	src.ShowChoices()
	src << browse(null, "window=mob_occupation")
	return

/mob/human/proc/Assign_Rank(rank)

	if (rank == "Captain")
		world << text("<b>[] is the captain!</b>", src)
	if (!( src.w_radio ))
		var/obj/item/weapon/radio/headset/H = new /obj/item/weapon/radio/headset( src )
		src.w_radio = H
		H.layer = 20
	if (!( src.back ))
		var/obj/item/weapon/storage/backpack/H = new /obj/item/weapon/storage/backpack( src )
		src.back = H
		H.layer = 20
	if (!( src.glasses ))
		if (src.disabilities & 1)
			var/obj/item/weapon/clothing/glasses/regular/G = new /obj/item/weapon/clothing/glasses/regular( src )
			src.glasses = G
			G.layer = 20
	if ((!( src.belt ) && src.w_uniform))
		var/obj/item/weapon/radio/signaler/S = new /obj/item/weapon/radio/signaler( src )
		src.belt = S
		S.layer = 20
	if ((!( src.r_store ) && src.w_uniform))
		var/obj/item/weapon/pen/S = new /obj/item/weapon/pen( src )
		src.r_store = S
		S.layer = 20
	if ((src.client && (!( src.wear_id ) && src.w_uniform)))
		var/obj/item/weapon/card/id/C = new /obj/item/weapon/card/id( src )
		src.wear_id = C
		C.assignment = rank
		C.layer = 20
		C.registered = src.rname
		switch(C.assignment)
			if("Research Assistant")
				C.access_level = 1
				C.lab_access = 1
				C.engine_access = 0
				C.air_access = 0
			if("Technical Assistant")
				C.access_level = 1
				C.lab_access = 0
				C.engine_access = 1
				C.air_access = 0
			if("Staff Assistant")
				C.access_level = 2
				C.lab_access = 0
				C.engine_access = 0
				C.air_access = 0
			if("Medical Assistant")
				if (!( src.l_hand ))
					var/obj/item/weapon/storage/firstaid/regular/W = new /obj/item/weapon/storage/firstaid/regular( src )
					src.l_hand = W
					W.layer = 20
					src.UpdateClothing()
				C.access_level = 1
				C.lab_access = 1
				C.engine_access = 0
				C.air_access = 0
			if("Engineer")
				if (!( src.l_hand ))
					var/obj/item/weapon/storage/toolbox/W = new /obj/item/weapon/storage/toolbox( src )
					src.l_hand = W
					W.layer = 20
					src.UpdateClothing()
				C.access_level = 2
				C.lab_access = 1
				C.engine_access = 3
				C.air_access = 0
			if("Research Technician")
				C.access_level = 2
				C.lab_access = 3
				C.engine_access = 0
				C.air_access = 0
			if("Forensic Technician")
				C.access_level = 3
				C.lab_access = 2
				C.engine_access = 0
				C.air_access = 0
			if("Medical Doctor")
				if (!( src.l_hand ))
					var/obj/item/weapon/storage/firstaid/regular/W = new /obj/item/weapon/storage/firstaid/regular( src )
					src.l_hand = W
					W.layer = 20
					src.UpdateClothing()
				C.access_level = 2
				C.lab_access = 0
				C.engine_access = 0
				C.air_access = 0
			if("Prison Doctor")
				if (!( src.l_hand ))
					var/obj/item/weapon/storage/firstaid/regular/W = new /obj/item/weapon/storage/firstaid/regular( src )
					src.l_hand = W
					W.layer = 20
					src.UpdateClothing()
				C.access_level = 2
				C.lab_access = 0
				C.engine_access = 0
				C.air_access = 0
			if("Captain")
				C.access_level = 5
				C.air_access = 5
				C.engine_access = 5
				C.lab_access = 5
			if("Security Officer")
				if (!( src.l_hand ))
					var/obj/item/weapon/handcuffs/W = new /obj/item/weapon/handcuffs( src )
					src.l_hand = W
					W.layer = 20
					src.UpdateClothing()
				C.access_level = 3
				C.lab_access = 0
				C.engine_access = 0
				C.air_access = 0
			if("Prison Security")
				if (!( src.l_hand ))
					var/obj/item/weapon/handcuffs/W = new /obj/item/weapon/handcuffs( src )
					src.l_hand = W
					W.layer = 20
					src.UpdateClothing()
				C.access_level = 3
				C.lab_access = 0
				C.engine_access = 0
				C.air_access = 0
			if("Medical Researcher")
				C.access_level = 2
				C.lab_access = 5
				C.engine_access = 0
				C.air_access = 0
			if("Toxin Researcher")
				C.access_level = 2
				C.lab_access = 5
				C.engine_access = 0
				C.air_access = 0
			if("Head of Research")
				C.access_level = 4
				C.air_access = 2
				C.engine_access = 2
				C.lab_access = 5
			if("Head of Personnel")
				C.access_level = 4
				C.air_access = 2
				C.engine_access = 2
				C.lab_access = 4
			if("Prison Warden")
				C.access_level = 4
				C.air_access = 2
				C.engine_access = 2
				C.lab_access = 4
			if("Station Technician")
				if (!( src.l_hand ))
					var/obj/item/weapon/storage/toolbox/W = new /obj/item/weapon/storage/toolbox( src )
					src.l_hand = W
					W.layer = 20
					src.UpdateClothing()
				C.access_level = 2
				C.lab_access = 0
				C.engine_access = 2
				C.air_access = 3
			if("Atmospheric Technician")
				C.access_level = 3
				C.lab_access = 0
				C.engine_access = 0
				C.air_access = 4
			else
		C.name = text("[]'s ID Card ([]>[]-[]-[])", C.registered, C.access_level, C.lab_access, C.engine_access, C.air_access)
		src << text("<B>You are the [].</B>", C.assignment)
		var/S = locate(text("start*[]", C.assignment))
		if ((istype(S, /obj/start) && (istype(S.loc, /turf) && !( ctf ))))
			src << "\blue <B>You have been teleported to your new starting location!</B>"
			src.loc = S.loc
	return
