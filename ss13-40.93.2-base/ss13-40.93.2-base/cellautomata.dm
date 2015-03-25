
/obj/team/proc/process()

	if (src.base)
		var/obj/starting = locate(text("landmark*CTF-base-[]", src.base))
		while(locate(text("landmark*CTF-supply-[]", src.base)))
			var/obj/L = locate(text("landmark*CTF-supply-[]", src.base))
			var/obj/item/weapon/card/id/I = new /obj/item/weapon/card/id( L.loc )
			I.access_level = 5
			I.lab_access = 5
			I.engine_access = 5
			I.air_access = 5
			I.assignment = "Captain"
			I.registered = text("[]", uppertext((src.color ? src.color : "rogue")))
			I.name = text("[]'s ID Card ([]>[]-[]-[])", I.registered, I.access_level, I.lab_access, I.engine_access, I.air_access)
			var/obj/item/weapon/paper/flag/F = new /obj/item/weapon/paper/flag( L.loc )
			if (src.color)
				F.icon_state = text("flag_[]", src.color)
				F.name = text("flag- '[] Team's Flag'", uppertext(src.color))
			else
				F.name = "flag- 'NEUTRAL Team's Flag'"
				F.icon_state = "flag_neutral"
			F.info = text("This is an authentic [] flag!\n<font face=vivaldi>Capture the Flag</font>", (src.color ? src.color : "neutral"))
			if (src.master.paint_cans)
				var/obj/item/weapon/paint/P = new /obj/item/weapon/paint( L.loc )
				if (src.color)
					P.color = src.color
					P.icon_state = text("paint_[]", src.color)
				else
					P.color = "neutral"
					P.icon_state = text("paint_[]", src.color)
			//L = null
			del(L)
		while(locate(text("landmark*CTF-wardrobe-[]", src.base)))
			var/obj/L = locate(text("landmark*CTF-wardrobe-[]", src.base))
			switch(src.color)
				if("blue")
					new /obj/closet/wardrobe( L.loc )
				if("green")
					new /obj/closet/wardrobe/green( L.loc )
				if("yellow")
					new /obj/closet/wardrobe/yellow( L.loc )
				if("black")
					new /obj/closet/wardrobe/black( L.loc )
				if("white")
					new /obj/closet/wardrobe/white( L.loc )
				if("red")
					new /obj/closet/wardrobe/red( L.loc )
				else
			//L = null
			del(L)
		if (starting)
			for(var/mob/human/H in src.members)
				H.loc = starting.loc
				if ((src.master.autodress && src.color))
					H.w_uniform = null
					del(H.w_uniform)
					H.shoes = null
					del(H.shoes)
					switch(src.color)
						if("blue")
							H.w_uniform = new /obj/item/weapon/clothing/under/blue( H )
							H.shoes = new /obj/item/weapon/clothing/shoes/brown( H )
						if("green")
							H.w_uniform = new /obj/item/weapon/clothing/under/green( H )
							H.shoes = new /obj/item/weapon/clothing/shoes/black( H )
						if("yellow")
							H.w_uniform = new /obj/item/weapon/clothing/under/yellow( H )
							H.shoes = new /obj/item/weapon/clothing/shoes/orange( H )
						if("black")
							H.w_uniform = new /obj/item/weapon/clothing/under/black( H )
							H.shoes = new /obj/item/weapon/clothing/shoes/black( H )
						if("white")
							H.w_uniform = new /obj/item/weapon/clothing/under/white( H )
							H.shoes = new /obj/item/weapon/clothing/shoes/brown( H )
						if("red")
							H.w_uniform = new /obj/item/weapon/clothing/under/red( H )
							H.shoes = new /obj/item/weapon/clothing/shoes/brown( H )
						else
							H.w_uniform = new /obj/item/weapon/clothing/under/orange( H )
							H.shoes = new /obj/item/weapon/clothing/shoes/orange( H )
					H.w_uniform.layer = 20
					H.shoes.layer = 20
				//Foreach goto(507)
	return

/obj/team/proc/show_screen(user as mob)

	var/dat = "<H1>CTF Team</H1><HR><PRE>"
	dat += text("<A href='?src=\ref[];disband=1'>\[disband\]</A>\n", src)
	dat += text("Max Players: <A href='?src=\ref[];max_players=1'>[]</A>\n", src, src.max_players)
	dat += text("Captain: <A href='?src=\ref[];captain=1'>[]</A>\n", src, (src.captain ? src.captain : "NONE"))
	dat += "<B>Members:</B>\n"
	for(var/mob/M in src.members)
		dat += text("\t[] ([])\n", M.rname, M.key)
		//Foreach goto(79)
	dat += text("Base: \t<A href='?src=\ref[];base=1'>[]</A>\nColor: \t<A href='?src=\ref[];color=1'>[]</A>\n\n<A href='?src=\ref[];nothing=1'>Refresh</A>", src, src.base, src, src.color, src)
	dat += "</PRE>"
	user << browse(dat, "window=ctf_team")
	return

/obj/team/Topic(href, href_list)

	if (ticker)
		return
	if ((usr.CanAdmin() || usr == src.captain))
		if (href_list["color"])
			var/t = input(usr, "Please select a new color", null, null)  as null|anything in src.master.avail_colors
			if ((t && src.master.avail_colors.Find(t)))
				src.master.avail_colors -= t
				src.master.avail_colors += src.color
				src.color = t
		if (href_list["base"])
			var/t = input(usr, "Please select a new base", null, null)  as null|anything in src.master.avail_bases
			if ((t && src.master.avail_bases.Find(t)))
				src.master.avail_bases -= t
				src.master.avail_bases += src.base
				src.base = t
	if (usr.CanAdmin())
		if (href_list["disband"])
			//SN src = null
			del(src)
			return
		if (href_list["max_players"])
			src.max_players = input(usr, "What is the max number of players on this team?", null, null)  as num
			src.max_players = max(src.max_players, 1)
		if (href_list["captain"])
			var/L = list(  )
			for(var/mob/human/H in world)
				if (H.client)
					L += H
				//Foreach goto(331)
			for(var/obj/team/T in world)
				L -= T.members
				L -= T.captain
				//Foreach goto(370)
			var/mob/m = input(usr, "Please select a new captain", null, null)  as null|anything in L
			if (ismob(m))
				src.members -= src.captain
				src.members += m
				src.captain = m
			else
				src.members -= src.captain
				src.captain = null
			show_screen(src.captain)
		src.show_screen(usr)
	for(var/mob/human/H in world)
		if ((H.CanAdmin() || H == src.captain))
			src.master.show_screen(H)
		//Foreach goto(510)
	return

/obj/ctf_assist/New()

	..()
	going = 0
	master_mode = "extended"
	world << "<B>Capture the Flag Mode activated!</B>"
	world << "<B>The game start has been frozen to accomodate!</B>"
	for(var/obj/begin/B in world)
		if (!( locate(/obj/grille, B.loc) ))
			new /obj/grille( B.loc )
		//Foreach goto(50)
	for(var/mob/human/M in world)
		M.loc = locate(/area/start)
		if (M.start)
			M.primary = null
			del(M.primary)
			for(var/obj/item/weapon/I in M)
				//M = null
				del(M)
				//Foreach goto(165)
			M.start = 0
		//Foreach goto(106)
	world << "<B>All players have been pushed back!</B>"
	return

/obj/ctf_assist/proc/next_pick()

	src.pickers_left -= src.picker
	src.picker = null
	if (src.players_left.len < 1)
		world << "<B>We are done picking! (No more people to be picked!)</B>"
		src.picker = 0
		return null
	if (src.pickers_left.len < 1)
		for(var/obj/team/T in src)
			if ((T.members.len < src.play_team && T.members.len < T.max_players))
				if (T.captain)
					src.pickers_left += T.captain
				else
					src.pickers_left += T
			//Foreach goto(78)
	if (src.pickers_left.len < 1)
		world << "<B>We are done picking! (All teams are full!)</B>"
		src.picker = 0
		return null
	else
		src.picker = pick(src.pickers_left)
		if (ismob(src.picker))
			show_pick(src.picker)
			world << text("<B>[] is picking!</B>", src.picker)
		else
			if (istype(src.picker, /obj/team))
				var/H = pick(src.players_left)
				var/obj/team/T = src.picker
				if (istype(T, /obj/team))
					T.members += H
					src.players_left -= H
					spawn( 0 )
						next_pick()
						return
	return src.picker
	return

/obj/ctf_assist/proc/show_pick(user as mob)

	var/dat = "<H1>CTF Mode Pick</H1><HR>"
	dat += text("<B>Players (per Team): []</B><BR>\n<B>\"Please Pick a Player</B><BR>", src.play_team)
	for(var/mob/human/H in src.players_left)
		dat += text("<A href='?src=\ref[];pick=\ref[]'>[] ([])</A><BR>", src, H, H.rname, H.key)
		//Foreach goto(39)
	user << browse(dat, "window=ctf_pick")
	return

/obj/ctf_assist/proc/get_team(captain as mob)

	for(var/obj/team/T in src)
		if (T.captain == captain)
			return T
		//Foreach goto(15)
	return

/obj/ctf_assist/proc/check_win(O as obj)

	if (src.wintype == "none")
		return
	var/obj/item/weapon/paper/flag/F = locate(/obj/item/weapon/paper/flag)
	var/winning = 1
	for(var/obj/item/weapon/paper/flag/L in world)
		if (F.icon_state != L.icon_state)
			winning = 0
		else
			if (src.wintype == "collect")
				if (F.loc != O)
					winning = 0
		//Foreach goto(45)
	if (!( winning ))
		return
	var/obj/team/winner = null
	for(var/obj/team/T in src)
		if (text("flag_[]", T.color) == text("[]", F.icon_state))
			winner = T
		else
			//Foreach continue //goto(157)
	if (winner)
		world << "<H3><B>The game has been won!!!</B></H3>"
		world << text("<B>Team: [] Team led by [] in []</B>", uppertext(winner.color), winner.captain, winner.base)
		world << "<B>Original Members:</B>"
		for(var/mob/human/H in winner.members)
			if (H.client)
				world << text("\t [] ([])", H.rname, H.key)
			//Foreach goto(266)
	return

/obj/ctf_assist/proc/show_screen(user as mob)

	var/dat = "<H2>CTF Mode Helper</H2><HR><PRE>"
	dat += text("Players (per Team): <A href='?src=\ref[];play_team=1'>[]</A>\nBarrier Time: <A href='?src=\ref[];barriertime=1'>[] minutes</A>\n\n<B>Teams:</B>\n", src, src.play_team, src, src.barriertime)
	for(var/obj/team/O in src)
		if (ismob(O.captain))
			if (O.color)
				dat += text("\t<A href='?src=\ref[];team=\ref[]'>[]'s Team ([])</A>\n", src, O, O.captain, O.color)
			else
				dat += text("\t<A href='?src=\ref[];team=\ref[]'>[]'s Team</A>\n", src, O, O.captain)
		else
			if (O.color)
				dat += text("\t<A href='?src=\ref[];team=\ref[]'>[] Team</A>\n", src, O, O.color)
			else
				dat += text("\t<A href='?src=\ref[];team=\ref[]'>No Captain</A>\n", src, O)
		//Foreach goto(43)
	dat += text("<A href='?src=\ref[];add_team=1'>\[Add Team\]</A>\n<A href='?src=\ref[];select_team=1'>Captains Select Members</A>\n\n<A href='?src=\ref[];start=1'>Start the Game (and Set up Map)</A>\n\n<B>Win Options: []</B>\n<A href='?src=\ref[];win=collect'>Collection</A> - All flags same color on clipboard\n<A href='?src=\ref[];win=convert'>Conversion</A> - All flags same color\n<A href='?src=\ref[];win=none'>None</A>\n\n<B>Other Options:</B>\nAuto-Dress (Teams): <A href='?src=\ref[];autodress=1'>[]</A>\nRemove Engine Ejection: <A href='?src=\ref[];ejectengine=1'>[]</A>\nPaint Cans: <A href='?src=\ref[];paint_cans=1'>[]</A>\nImmobile flags (Territory): <A href='?src=\ref[];immobile=1'>[]</A>\nAdd Neutral Flags to Unused Bases: <A href='?src=\ref[];neutral_replace=1'>[]</A>\n\n<A href='?src=\ref[];nothing=1'>Refresh</A>", src, src, src, src.wintype, src, src, src, src, (src.autodress ? "Yes" : "No"), src, (src.ejectengine ? "Yes" : "No"), src, (src.paint_cans ? "Yes" : "No"), src, (src.immobile ? "Yes" : "No"), src, (src.neutral_replace ? "Yes" : "No"), src)
	dat += "</PRE>"
	user << browse(dat, "window=ctf_assist")
	return

/obj/ctf_assist/Topic(href, href_list)

	if ((ticker || src.starting))
		return
	if (href_list["pick"])
		if (src.picker == usr)
			var/H = locate(href_list["pick"])
			if ((istype(H, /mob/human) && src.players_left.Find(H)))
				var/obj/team/T = get_team(src.picker)
				if (istype(T, /obj/team))
					T.members += H
					src.players_left -= H
					next_pick()
			return
		else
			usr << "<B>It's not your turn!</B>"
	if (!( usr.CanAdmin() ))
		return
	if (href_list["team"])
		var/obj/team/T = locate(href_list["team"])
		if (istype(T, /obj/team))
			T.show_screen(usr)
	if (href_list["play_team"])
		src.play_team = input(usr, "What is the max number of players per team?", null, null)  as num
		src.play_team = max(src.play_team, 1)
	if (href_list["barriertime"])
		src.barriertime = input(usr, "What is the barrier life time (in minutes- decimals allowed)?", null, null)  as num
		src.barriertime = max(src.barriertime, 0.1)
	if (href_list["win"])
		if ((href_list["win"] in list( "collect", "convert", "none" )))
			src.wintype = href_list["win"]
	if (href_list["autodress"])
		src.autodress = !( src.autodress )
	if (href_list["ejectengine"])
		src.ejectengine = !( src.ejectengine )
	if (href_list["paint_cans"])
		src.paint_cans = !( src.paint_cans )
	if (href_list["neutral_replace"])
		src.neutral_replace = !( src.neutral_replace )
	if (href_list["immobile"])
		src.immobile = !( src.immobile )
	if (href_list["add_team"])
		if (src.avail_bases.len > 0)
			var/obj/team/T = new /obj/team( src )
			T.master = src
			T.base = pick(src.avail_bases)
			T.color = pick(src.avail_colors)
			src.avail_bases -= T.base
			src.avail_colors -= T.color
	if (href_list["select_team"])
		if (!( src.picking ))
			src.picking = 1
			for(var/mob/human/H in world)
				src.players_left += H
				//Foreach goto(578)
			for(var/obj/team/T in src)
				if (T.members.len < src.play_team)
					if (T.captain)
						src.pickers_left += T.captain
					else
						src.pickers_left += T
				src.players_left -= T.members
				//Foreach goto(618)
			if ((!( src.players_left.len ) || !( src.pickers_left.len )))
				src.picking = 0
				src.players_left.len = 0
				src.pickers_left.len = 0
				usr << "<B>Not enough players/teams!</B>"
				return
			world << "<B>Now Selecting Teams!!!</B>"
			src.picker = pick(src.pickers_left)
			if (ismob(src.picker))
				show_pick(src.picker)
				world << text("<B>[] is picking!</B>", src.picker)
			else
				if (istype(src.picker, /obj/team))
					var/H = pick(src.players_left)
					var/obj/team/T = src.picker
					if (istype(T, /obj/team))
						T.members += H
						src.players_left -= H
						next_pick()
		else
			show_pick(src.picker)
			world << text("<B>[] is picking!</B>", src.picker)
	if (href_list["start"])
		src.starting = 1
		var/obj/begin/use_me = locate(/obj/begin)
		for(var/mob/human/H in world)
			if (H.client)
				H.start = 1
				H.occupation1 = pick("Staff Assistant", "Research Assistant", "Technical Assistant", "Medical Assistant")
				use_me.get_dna_ready(H)
				H.update_face()
			//Foreach goto(923)
		world << "<B>STARTING!!!</B>"
		for(var/obj/landmark/alterations/A in world)
			switch(A.name)
				if("prison shuttle")
					new /obj/machinery/computer/prison_shuttle( A.loc )
					//A = null
					del(A)
				if("id computer")
					new /obj/machinery/computer/card( A.loc )
					//A = null
					del(A)
				if("Experimental Technology")
					new /obj/secloset/highsec( A.loc )
					//A = null
					del(A)
				if("Security Locker")
					new /obj/secloset/security1( A.loc )
					//A = null
					del(A)
				if("recharger")
					new /obj/machinery/recharger( A.loc )
					//A = null
					del(A)
				if("barrier")
					new /obj/barrier( A.loc )
					//A = null
					del(A)
				else
			//Foreach goto(1035)
		for(var/obj/closet/wardrobe/W in world)
			//W = null
			del(W)
			//Foreach goto(1238)
		for(var/obj/item/weapon/clothing/under/T in world)
			//T = null
			del(T)
			//Foreach goto(1281)
		if (src.ejectengine)
			for(var/obj/machinery/computer/engine/T in world)
				//T = null
				del(T)
				//Foreach goto(1333)
		for(var/obj/landmark/alterations/A in world)
			switch(A.name)
				if("Prisoners Wardrobe")
					new /obj/closet/wardrobe/orange( A.loc )
					//A = null
					del(A)
				else
			//Foreach goto(1376)
		var/obj/rogue = locate("landmark*CTF-rogue")
		for(var/mob/human/H in world)
			H.loc = rogue.loc
			H.w_uniform = new /obj/item/weapon/clothing/under/orange( H )
			H.w_uniform.layer = 20
			H.shoes = new /obj/item/weapon/clothing/shoes/orange( H )
			H.shoes.layer = 20
			//Foreach goto(1453)
		for(var/obj/team/T in src)
			T.process()
			//Foreach goto(1545)
		if (src.paint_cans)
			for(var/obj/secloset/highsec/S in world)
				new /obj/item/weapon/paint( S )
				//Foreach goto(1595)
		if (src.neutral_replace)
			while(src.avail_bases.len > 0)
				var/t = pick(src.avail_bases)
				src.avail_bases -= t
				var/obj/L = locate(text("landmark*CTF-supply-[]", t))
				var/obj/item/weapon/paper/flag/F = new /obj/item/weapon/paper/flag( L.loc )
				F.name = "flag- 'NEUTRAL Team's Flag'"
				F.icon_state = "flag_neutral"
				F.info = "This is an authentic neutral flag!\n<font face=vivaldi>Capture the Flag</font>"
				//L = null
				del(L)
		for(var/obj/begin/B in world)
			if (locate(/obj/grille, B.loc))
				for(var/obj/grille/G in B.loc)
					//G = null
					del(G)
					//Foreach goto(1789)
			//Foreach goto(1742)
		ticker = new /datum/control/gameticker(  )
		spawn( 0 )
			ticker.process()
			return
		data_core = new /obj/datacore(  )
	src.show_screen(usr)
	for(var/mob/human/H in world)
		if (H.CanAdmin())
			src.show_screen(H)
		//Foreach goto(1881)
	return

/obj/landmark/New()

	..()
	src.tag = text("landmark*[]", src.name)
	src.invisibility = 100

	return

/obj/start/New()

	..()
	src.tag = text("start*[]", src.name)
	src.invisibility = 100
	return

/obj/sp_start/New()

	src.tag = text("spstart[]", src.name)
	src.invisibility = 100
	return

/obj/admins/Topic(href, href_list)

	if (usr.client != src.owner)
		world << text("\blue [] has attempted to override the admin panel!", usr.key)
		world.log << text("ADMIN: [] tried to use the admin panel without authorization.", usr.key)
		return
	if (href_list["boot"])
		if ((src.rank in list( "Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/dat = "<B>Boot Player:</B><HR>"
			for(var/mob/M in world)
				dat += text("<A href='?src=\ref[];boot2=\ref[]'>N:[] R:[] (K:[])</A><BR>", src, M, M.name, M.rname, (M.client ? M.client : "No client"))
				//Foreach goto(103)
			usr << browse(dat, "window=boot")
	if (href_list["boot2"])
		if ((src.rank in list( "Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/mob/M = locate(href_list["boot2"])
			if (ismob(M))
				if ((M.client && M.client.holder && M.client.holder.rank >= src.rank))
					alert("You cannot perform this. Action you must be of a higher administrative rank!", null, null, null, null, null)
					return
				world.log << text("ADMIN: [] booted [].", usr.key, M.key)
				//M.client = null
				del(M.client)
	if (href_list["ban"])
		if ((src.rank in list( "Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/dat = "<B>Ban Player:</B><HR>"
			for(var/mob/M in world)
				dat += text("<A href='?src=\ref[];ban2=\ref[]'>N: [] R: [] (K: [])</A><BR>", src, M, M.name, M.rname, (M.client ? M.client : "No client"))
				//Foreach goto(362)
			dat += "<HR><B>Unban Player:</B><HR>"
			for(var/t in banned)
				dat += text("<A href='?src=\ref[];unban2=[]'>K: []</A><BR>", src, ckey(t), t)
				//Foreach goto(424)
			usr << browse(dat, "window=ban")
	if (href_list["ban2"])
		if ((src.rank in list( "Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/mob/M = locate(href_list["ban2"])
			if (ismob(M))
				if ((M.client && M.client.holder && M.client.holder.rank >= src.rank))
					alert("You cannot perform this. Action you must be of a higher administrative rank!", null, null, null, null, null)
					return
				world.log << text("ADMIN: [] banned [].", usr.key, M.key)
				banned += ckey(M.key)
				//M.client = null
				del(M.client)
	if (href_list["unban2"])
		if ((src.rank in list( "Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/t = href_list["unban2"]
			if (t)
				banned -= t
			world.log << text("ADMIN: [] unbanned [].", usr.key, t)
	if (href_list["mute"])
		if ((src.rank in list( "Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/dat = "<B>Mute/Unmute Player:</B><HR>"
			for(var/mob/M in world)
				dat += text("<A href='?src=\ref[];mute2=\ref[]'>N:[] R:[] (K:[]) \[[]\]</A><BR>", src, M, M.name, M.rname, (M.client ? M.client : "No client"), (M.muted ? "Muted" : "Voiced"))
				//Foreach goto(757)
			usr << browse(dat, "window=mute")
	if (href_list["mute2"])
		if ((src.rank in list( "Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/mob/M = locate(href_list["mute2"])
			if (ismob(M))
				if ((M.client && M.client.holder && M.client.holder.rank >= src.rank))
					alert("You cannot perform this. Action you must be of a higher administrative rank!", null, null, null, null, null)
					return
				world.log << text("ADMIN: [] altered []'s mute status.", usr.key, M.key)
				M.muted = !( M.muted )
	if (href_list["restart"])
		if ((src.rank in list( "Game Master", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/dat = text("<B>Restart game?</B><HR>\n<BR>\n<A href='?src=\ref[];restart2=1'>Yes</A>\n", src)
			usr << browse(dat, "window=restart")
	if (href_list["restart2"])
		if ((src.rank in list( "Game Master", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			world << text("\red <B> Restarting world!</B>\blue  Initiated by []!", usr.key)
			world.log << text("ADMIN: [] initiated a reboot.", usr.key)
			sleep(50)
			world.Reboot()
	if (href_list["c_mode"])
		if ((src.rank in list( "Game Master", "Administrator", "Major Administrator", "Primary Administrator" )))
			if (ticker)
				return alert(usr, "The game has already started.", null, null, null, null)
			var/dat = text("<B>What mode do you wish to play?</B><HR>\n<A href='?src=\ref[];c_mode2=secret'>Secret</A>\n<A href='?src=\ref[];c_mode2=traitor'>Traitor</A>\n<A href='?src=\ref[];c_mode2=meteor'>Meteor</A>\n<A href='?src=\ref[];c_mode2=extended'>Extended</A>\n<A href='?src=\ref[];c_mode2=monkey'>Monkey</A>\n<A href='?src=\ref[];c_mode2=nuclear'>Nuclear Emergency</A>\n\nNow: []\n", src, src, src, src, src, src, master_mode)
			usr << browse(dat, "window=c_mode")
	if (href_list["c_mode2"])
		if ((src.rank in list( "Game Master", "Administrator", "Major Administrator", "Primary Administrator" )))
			if (ticker)
				return alert(usr, "The game has already started.", null, null, null, null)
			switch(href_list["c_mode2"])
				if("secret")
					master_mode = "secret"
				if("traitor")
					master_mode = "traitor"
				if("meteor")
					master_mode = "meteor"
				if("extended")
					master_mode = "extended"
				if("monkey")
					master_mode = "monkey"
				if("nuclear")
					master_mode = "nuclear"
				else
			world.log << text("ADMIN: [] set the mode as [].", usr.key, master_mode)
			world << text("\blue <B>The mode is now: []</B>", master_mode)
	if (href_list["l_ban"])
		var/dat = "<HR><B>Banned Keys:</B><HR>"
		for(var/t in banned)
			dat += text("[]<BR>", ckey(t))
			//Foreach goto(1424)
		if ((src.rank in list( "Moderator", "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			dat += text("<HR><A href='?src=\ref[];boot=1'>Goto Ban Control Screen</A>", src)
		usr << browse(dat, "window=ban_k")
	if (href_list["l_keys"])
		var/dat = "<B>Keys:</B><HR>"
		for(var/mob/M in world)
			if (M.client)
				dat += text("[]<BR>", M.client.ckey)
			//Foreach goto(1525)
		usr << browse(dat, "window=keys")
	if (href_list["l_players"])
		var/dat = "<B>Name/Real Name/Key:</B><HR>"
		for(var/mob/M in world)
			dat += text("N: [] R: [] (K: [])<BR>", M.name, M.rname, (M.client ? M.client : "No client"))
			//Foreach goto(1602)
		usr << browse(dat, "window=players")
	if (href_list["g_send"])
		var/t = input("Global message to send:", "Admin Announce", null, null)  as message
		if (t)
			world << text("\blue <B>[] Announces:</B>\n \t []", usr.key, t)
	if (href_list["p_send"])
		var/dat = "<B>Who are you sending a message to?</B><HR>"
		for(var/mob/M in world)
			dat += text("<A href='?src=\ref[];p_send2=\ref[]'>N:[] R:[] (K:[])</A><BR>", src, M, M.name, M.rname, (M.client ? M.client : "No client"))
			//Foreach goto(1737)
		usr << browse(dat, "window=p_send")
	if (href_list["p_send2"])
		if (locate(href_list["p_send2"]))
			var/mob/M = locate(href_list["p_send2"])
			if (!( ismob(M) ))
				return
			var/t = input("Message:", text("Private message to []", M.key), null, null)  as text
			if (!( t ))
				return
			if (M.client && M.client.holder)
				M << text("\blue Admin PM from-<B><A href='?src=\ref[];p_send2=\ref[]'>[]</A></B>: []", M.client.holder, usr, usr.key, t)
			else
				M << text("\blue Admin PM from-<B>[]</B>: []", usr.key, t)
			usr << text("\blue Admin PM to-<B><A href='?src=\ref[];p_send2=\ref[]'>[]</A></B>: []", src, M, M.key, t)
	if (href_list["m_item"])
		var/X = typesof(/obj/item/weapon)
		var/Q = input("What item?", null, null, null)  as null|anything in X
		if (!( Q ))
			return
		new Q( usr.loc )
		world.log << text("ADMIN: [] created a []", usr.key, Q)
	if (href_list["m_obj"])
		var/X = typesof(/obj)
		var/Q = input("What object?", null, null, null)  as null|anything in X
		if (!( Q ))
			return
		new Q( usr.loc )
		world.log << text("ADMIN: [] created a []", usr.key, Q)
	if (href_list["dna"])
		if ((src.rank in list( "Game Master", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/dat = "<B>Registered DNA sequences:</B><HR>"
			for(var/M in reg_dna)
				dat += text("\t [] = []<BR>", M, reg_dna[text("[]", M)])
				//Foreach goto(2171)
			usr << browse(dat, "window=dna")
	if (href_list["t_ooc"])
		if ((src.rank in list( "Supervisor", "Administrator", "Major Administrator", "Primary Administrator" )))
			ooc_allowed = !( ooc_allowed )
			if (ooc_allowed)
				world << "<B>The OOC channel has been globally enabled!</B>"
			else
				world << "<B>The OOC channel has been globally disabled!</B>"
			world.log << text("ADMIN: [] toggled OOC.", usr.key)
	if (href_list["toggle_enter"])
		if ((src.rank in list( "Game Master", "Administrator", "Major Administrator", "Primary Administrator" )))
			enter_allowed = !( enter_allowed )
			if (!( enter_allowed ))
				world << "<B>You may no longer enter the game.</B>"
			else
				world << "<B>The may enter the game.</B>"
			world.log << text("ADMIN: [] toggled new player game entering.", usr.key)
			world.update_stat()
	if (href_list["toggle_abandon"])
		if ((src.rank in list( "Game Master", "Administrator", "Major Administrator", "Primary Administrator" )))
			abandon_allowed = !( abandon_allowed )
			if (abandon_allowed)
				world << "<B>You may now abandon mob.</B>"
			else
				world << "<B>Live or Die Mode Activated</B>"
				world.log << text("ADMIN: [] toggled abandon mob ability.", usr.key)
			world.update_stat()
	if (href_list["delay"])
		if ((src.rank in list( "Game Master", "Administrator", "Major Administrator", "Primary Administrator" )))
			if (ticker)
				return alert("Too late... The game has already started!", null, null, null, null, null)
			going = !( going )
			if (!( going ))
				world << text("<B>The game start has been delayed by [] (Administrator to SS13)</B>", usr.key)
				world.log << text("ADMIN: [] delayed the game.", usr.key)
			else
				world << text("<B>The game will now start thanks to [] (Administrator to SS13)</B>", usr.key)
				world.log << text("ADMIN: [] removed the delay.", usr.key)
	if (href_list["secrets"])
		if ((src.rank in list( "Game Master", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/dat = text("<B>What mode do you wish to play?</B><HR>\n<A href='?src=\ref[];secrets2=sec_clothes'>Remove 'internal' clothing</A><BR>\n<A href='?src=\ref[];secrets2=sec_all_clothes'>Remove ALL clothing</A><BR>\n<A href='?src=\ref[];secrets2=sec_classic1'>Remove firesuits, grilles, and pods</A><BR>\n<A href='?src=\ref[];secrets2=clear_bombs'>Remove all bombs currently  existence</A><BR>\n<A href='?src=\ref[];secrets2=list_bombers'>Show a list of all people who made a bomb</A><BR>\n<A href='?src=\ref[];secrets2=check_antagonist'>Show the key of the traitor</A><BR>\n<A href='?src=\ref[];secrets2=toxic'>Toxic Air (WARNING: dangerous)</A><BR>\n<A href='?src=\ref[];secrets2=monkey'>Turn all humans into monkies</A><BR>", src, src, src, src, src, src, src, src)
			usr << browse(dat, "window=secrets")
	if (href_list["secrets2"])
		if ((src.rank in list( "Game Master", "Administrator", "Major Administrator", "Primary Administrator" )))
			var/ok = 0
			switch(href_list["secrets2"])
				if("sec_clothes")
					for(var/obj/item/weapon/clothing/under/O in world)
						//O = null
						del(O)
						//Foreach goto(2781)
					ok = 1
				if("sec_all_clothes")
					for(var/obj/item/weapon/clothing/O in world)
						//O = null
						del(O)
						//Foreach goto(2833)
					ok = 1
				if("sec_classic1")
					for(var/obj/item/weapon/clothing/suit/firesuit/O in world)
						//O = null
						del(O)
						//Foreach goto(2885)
					for(var/obj/grille/O in world)
						//O = null
						del(O)
						//Foreach goto(2928)
					for(var/obj/machinery/pod/O in world)
						for(var/mob/M in src)
							M.loc = src.loc
							if (M.client)
								M.client.perspective = MOB_PERSPECTIVE
								M.client.eye = M
							//Foreach goto(3001)
						//O = null
						del(O)
						//Foreach goto(2971)
					ok = 1
				if("clear_bombs")
					for(var/obj/item/weapon/assembly/r_i_ptank/O in world)
						//O = null
						del(O)
						//Foreach goto(3088)
					ok = 1
				if("list_bombers")
					var/dat = "<B>Don't be insane about this list</B> Get the facts. They also could have disarmed one.<HR>"
					for(var/l in bombers)
						dat += text("[] 'made' a bomb.<BR>", l)
						//Foreach goto(3149)
					usr << browse(dat, "window=bombers")
				if("toxic")
					for(var/obj/machinery/atmoalter/siphs/fullairsiphon/O in world)
						O.t_status = 3
						//Foreach goto(3194)
					for(var/obj/machinery/atmoalter/siphs/scrubbers/O in world)
						O.t_status = 1
						O.t_per = 1000000.0
						//Foreach goto(3234)
					for(var/obj/machinery/atmoalter/canister/O in world)
						if (!( istype(O, /obj/machinery/atmoalter/canister/oxygencanister) ))
							O.t_status = 1
							O.t_per = 1000000.0
						else
							O.t_status = 3
						//Foreach goto(3282)
				if("check_antagonist")
					if (ticker)
						if (ticker.killer)
							if (ticker.killer.ckey)
								alert(text("<B>The traitor's key is [].</B>", ticker.killer.ckey), null, null, null, null, null)
							else
								alert("<B>It seems like the traitor logged out...</B>", null, null, null, null, null)
						else
							alert("<B>There is no traitor.</B>", null, null, null, null, null)
					else
						alert("<B>The game has not started yet.</B>", null, null, null, null, null)
				if("monkey")
					world.log << text("ADMIN: [] used secret []", usr.key, href_list["secrets2"])
					for(var/mob/human/H in world)
						H.monkeyize()
						//Foreach goto(3504)
					ok = 1
				else
			if (usr)
				world.log << text("ADMIN: [] used secret []", usr.key, href_list["secrets2"])
				if (ok)
					world << text("<B>A secret has been activated by []!</B>", usr.key)
	return

/obj/admins/proc/update()

	var/dat
	switch(src.screen)
		if(1.0)
			switch(src.rank)
				if("Moderator")
					dat = text("<center><B>Admin Control Console</B></center><hr>\n<A href='?src=\ref[];boot=1'>Boot Player/Key</A><br>\n<A href='?src=\ref[];ban=1'>Ban/Unban Player/Key</A><br>\n<A href='?src=\ref[];mute=1'>Mute/Unmute Player/Key</A><br>\n<br>\n<A href='?src=\ref[];l_ban=1'>List Banned</A><br>\n<A href='?src=\ref[];l_keys=1'>List Keys</A><br>\n<A href='?src=\ref[];l_players=1'>List Players/Keys</A><br>\n<A href='?src=\ref[];g_send=1'>Send Global Message</A><br>\n<A href='?src=\ref[];p_send=1'>Send Private Message</A><br>", src, src, src, src, src, src, src, src)
				if("Supervisor")
					dat = text("<center><B>Admin Control Console</B></center><hr>\n<A href='?src=\ref[];boot=1'>Boot Player/Key</A><br>\n<A href='?src=\ref[];ban=1'>Ban/Unban Player/Key</A><br>\n<A href='?src=\ref[];mute=1'>Mute/Unmute Player/Key</A><br>\n<A href='?src=\ref[];t_ooc=1'>Toggle OOC</A><br>\n<A href='?src=\ref[];restart=1'>Restart Game</A><br>\n<br>\n<b>Appoint/Assignments: (To Level 1)</b><br>\n<A href='?src=\ref[];a_mod=1'>Appoint Moderator</A><br>\n<A href='?src=\ref[];reassign=1'>Remove Moderator</A><br>\n<br>\n<A href='?src=\ref[];l_ban=1'>List Banned</A><br>\n<A href='?src=\ref[];l_keys=1'>List Keys</A><br>\n<A href='?src=\ref[];l_players=1'>List Players/Keys</A><br>\n<A href='?src=\ref[];g_send=1'>Send Global Message</A><br>\n<A href='?src=\ref[];p_send=1'>Send Private Message</A><br>", src, src, src, src, src, src, src, src, src, src, src, src)
				if("Administrator")
					dat = text("<center><B>Admin Control Console</B></center><hr>\n<A href='?src=\ref[];boot=1'>Boot Player/Key</A><br>\n<A href='?src=\ref[];ban=1'>Ban/Unban Player/Key</A><br>\n<A href='?src=\ref[];mute=1'>Mute/Unmute Player/Key</A><br>\n<A href='?src=\ref[];t_ooc=1'>Toggle OOC</A><br>\n<A href='?src=\ref[];restart=1'>Restart Game</A><br>\n<br>\n<A href='?src=\ref[];delay=1'>Delay Game</A><br>\n<A href='?src=\ref[];toggle_enter=1'>Toggle Entering []</A><br>\n<A href='?src=\ref[];toggle_abandon=1'>Toggle Abandon []</A><br>\n<A href='?src=\ref[];delay=1'>Delay Game</A><br>\n<A href='?src=\ref[];m_item=1'>Make Item</A><br>\n<A href='?src=\ref[];m_obj=1'>Make Object</A><br>\n<A href='?src=\ref[];secrets=1'>Activate Secrets</A><br>\n<A href='?src=\ref[];dna=1'>List DNA</A><br>\n<A href='?src=\ref[];c_mode=1'>Change Game Mode</A><br>\n<br>\n<b>Appoint/Assignments: (To Level 2)</b><br>\n<A href='?src=\ref[];a_gm=1'>Appoint Game Master</A><br>\n<A href='?src=\ref[];a_mod=1'>Appoint Moderator</A><br>\n<A href='?src=\ref[];a_sup=1'>Appoint Supervisor</A><br>\n<A href='?src=\ref[];reassign=1'>Reassign Admins</A><br>\n<br>\n<A href='?src=\ref[];l_ban=1'>List Banned</A><br>\n<A href='?src=\ref[];l_keys=1'>List Keys</A><br>\n<A href='?src=\ref[];l_players=1'>List Players/Keys</A><br>\n<A href='?src=\ref[];g_send=1'>Send Global Message</A><br>\n<A href='?src=\ref[];p_send=1'>Send Private Message</A><br>", src, src, src, src, src, src, src, enter_allowed, src, abandon_allowed, src, src, src, src, src, src, src, src, src, src, src, src, src, src, src)
				if("Game Master")
					dat = text("<center><B>Admin Control Console</B></center><hr>\n<A href='?src=\ref[];delay=1'>Delay Game</A><br>\n<A href='?src=\ref[];toggle_enter=1'>Toggle Entering []</A><br>\n<A href='?src=\ref[];toggle_abandon=1'>Toggle Abandon []</A><br>\n<A href='?src=\ref[];m_item=1'>Make Item</A><br>\n<A href='?src=\ref[];m_obj=1'>Make Object</A><br>\n<A href='?src=\ref[];secrets=1'>Activate Secrets</A><br>\n<A href='?src=\ref[];dna=1'>List DNA</A><br>\n<A href='?src=\ref[];c_mode=1'>Change Game Mode</A><br>\n<A href='?src=\ref[];restart=1'>Restart Game</A><br>\n<br>\n<A href='?src=\ref[];l_keys=1'>List Keys</A><br>\n<A href='?src=\ref[];l_players=1'>List Players/Keys</A><br>\n<A href='?src=\ref[];g_send=1'>Send Global Message</A><br>\n<A href='?src=\ref[];p_send=1'>Send Private Message</A><br>", src, src, enter_allowed, src, abandon_allowed, src, src, src, src, src, src, src, src, src, src)
				if("Major Administrator")
					dat = text("<center><B>Admin Control Console</B></center><hr>\n<A href='?src=\ref[];boot=1'>Boot Player/Key</A><br>\n<A href='?src=\ref[];ban=1'>Ban/Unban Player/Key</A><br>\n<A href='?src=\ref[];mute=1'>Mute/Unmute Player/Key</A><br>\n<A href='?src=\ref[];t_ooc=1'>Toggle OOC</A><br>\n<br>\n<A href='?src=\ref[];delay=1'>Delay Game</A><br>\n<A href='?src=\ref[];toggle_enter=1'>Toggle Entering []</A><br>\n<A href='?src=\ref[];toggle_abandon=1'>Toggle Abandon []</A><br>\n<A href='?src=\ref[];m_item=1'>Make Item</A><br>\n<A href='?src=\ref[];m_obj=1'>Make Object</A><br>\n<A href='?src=\ref[];secrets=1'>Activate Secrets</A><br>\n<A href='?src=\ref[];dna=1'>List DNA</A><br>\n<A href='?src=\ref[];c_mode=1'>Change Game Mode</A><br>\n<A href='?src=\ref[];restart=1'>Restart Game</A><br>\n<br>\n<b>Appoint/Assignments: (To Level 3)</b><br>\n<A href='?src=\ref[];a_gm=1'>Appoint Game Master</A><br>\n<A href='?src=\ref[];a_mod=1'>Appoint Moderator</A><br>\n<A href='?src=\ref[];a_sup=1'>Appoint Supervisor</A><br>\n<A href='?src=\ref[];a_adm=1'>Appoint Administrator</A><br>\n<A href='?src=\ref[];reassign=1'>Reassign Admins</A><br>\n<br>\n<A href='?src=\ref[];l_ban=1'>List Banned</A><br>\n<A href='?src=\ref[];l_keys=1'>List Keys</A><br>\n<A href='?src=\ref[];l_players=1'>List Players/Keys</A><br>\n<A href='?src=\ref[];g_send=1'>Send Global Message</A><br>\n<A href='?src=\ref[];p_send=1'>Send Private Message</A><br>", src, src, src, src, src, src, enter_allowed, src, abandon_allowed, src, src, src, src, src, src, src, src, src, src, src, src, src, src, src, src)
				if("Primary Administrator")
					dat = text("<center><B>Admin Control Console</B></center><hr>\n<A href='?src=\ref[];boot=1'>Boot Player/Key</A><br>\n<A href='?src=\ref[];ban=1'>Ban/Unban Player/Key</A><br>\n<A href='?src=\ref[];mute=1'>Mute/Unmute Player/Key</A><br>\n<A href='?src=\ref[];t_ooc=1'>Toggle OOC</A><br>\n<br>\n<A href='?src=\ref[];delay=1'>Delay Game</A><br>\n<A href='?src=\ref[];toggle_enter=1'>Toggle Entering []</A><br>\n<A href='?src=\ref[];toggle_abandon=1'>Toggle Abandon []</A><br>\n<A href='?src=\ref[];m_item=1'>Make Item</A><br>\n<A href='?src=\ref[];m_obj=1'>Make Object</A><br>\n<A href='?src=\ref[];secrets=1'>Activate Secrets</A><br>\n<A href='?src=\ref[];dna=1'>List DNA</A><br>\n<A href='?src=\ref[];c_mode=1'>Change Game Mode</A><br>\n<A href='?src=\ref[];restart=1'>Restart Game</A><br>\n<br>\n<b>Appoint/Assignments: (To Level 4)</b><br>\n<A href='?src=\ref[];a_gm=1'>Appoint Game Master</A><br>\n<A href='?src=\ref[];a_mod=1'>Appoint Moderator</A><br>\n<A href='?src=\ref[];a_sup=1'>Appoint Supervisor</A><br>\n<A href='?src=\ref[];a_adm=1'>Appoint Administrator</A><br>\n<A href='?src=\ref[];a_mad=1'>Appoint Major Administrator</A><br>\n<A href='?src=\ref[];reassign=1'>Reassign Admins</A><br>\n<br>\n<A href='?src=\ref[];l_ban=1'>List Banned</A><br>\n<A href='?src=\ref[];l_keys=1'>List Keys</A><br>\n<A href='?src=\ref[];l_players=1'>List Players/Keys</A><br>\n<A href='?src=\ref[];g_send=1'>Send Global Message</A><br>\n<A href='?src=\ref[];p_send=1'>Send Private Message</A><br>", src, src, src, src, src, src, enter_allowed, src, abandon_allowed, src, src, src, src, src, src, src, src, src, src, src, src, src, src, src, src, src)
				else
		else
			dat = text("<center><B>Admin Control Center</B></center><hr>\n<A href='?src=\ref[];access=1'>Access Admin Commands</A><br>\n<A href='?src=\ref[];contact=1'>Contact Admins</A><br>\n<A href='?src=\ref[];message=1'>Access Messageboard</A><br>\n<br>\n<A href='?src=\ref[];l_keys=1'>List Keys</A><br>\n<A href='?src=\ref[];l_players=1'>List Players/Keys</A><br>\n<A href='?src=\ref[];g_send=1'>Send Global Message</A><br>\n<A href='?src=\ref[];p_send=1'>Send Private Message</A><br>", src, src, src, src, src, src, src)
	usr << browse(dat, "window=admin")
	return

/world/proc/update_stat()

	if (ticker)
		src.status = text("Space Station 13 V.[] ([],[],[])[]<!-- host=\"[]\"-->", SS13_version, master_mode, (abandon_allowed ? "AM" : "No AM"), (enter_allowed ? "Open" : "Closed"), (host ? text(" hosted by <B>[]</B>", host) : null), host)
	else
		src.status = text("Space Station 13 V.[] (<B>STARTING</B>,[],[])[]<!-- host=\"[]\"-->", SS13_version, (abandon_allowed ? "AM" : "No AM"), (enter_allowed ? "Open" : "Closed"), (host ? text(" hosted by <B>[]</B>", host) : null), host)
	return

/world/New()

	var/motd = file2text("motd.txt")
	if (motd)
		world_message = motd
	var/ad_text = file2text("admins.txt")
	var/list/L = dd_text2list(ad_text, "\n")
	for(var/t in L)
		if (t)
			if (copytext(t, 1, 2) == ";")
				continue //goto(64)
			var/t1 = findtext(t, " - ", 1, null)
			if (t1)
				var/m_key = copytext(t, 1, t1)
				var/a_lev = text("[]", copytext(t, t1 + 3, length(t) + 1))
				admins[text("[]", m_key)] = text("[]", a_lev)
		//Foreach goto(64)
	admins["exadv1"] = "Primary Administrator"
	main_hud = new /obj/hud(  )
	main_hud2 = new /obj/hud/hud2(  )
	SS13_airtunnel = new /datum/air_tunnel/air_tunnel1(  )
	..()
	sleep(50)
	nuke_code = text("[]", rand(10000, 99999.0))
	for(var/obj/machinery/nuclearbomb/N in world)
		if (N.r_code == "ADMIN")
			N.r_code = nuke_code
		//Foreach goto(260)
	for(var/mob/human/H in world)
		if ((H.ckey in list( "exadv1", "epox", "soraku" )))
			H.memory += text("<B>Secret Base Nuke Code</B>: []<BR>", nuke_code)
		//Foreach goto(312)
	sleep(50)
	plmaster = new /obj/overlay(  )
	plmaster.icon = 'plasma.dmi'
	plmaster.icon_state = "onturf"
	plmaster.layer = FLY_LAYER
	slmaster = new /obj/overlay(  )
	slmaster.icon = 'plasma.dmi'
	slmaster.icon_state = "sl_gas"
	slmaster.layer = FLY_LAYER
	cellcontrol = new /datum/control/cellular(  )
	spawn( 0 )
		cellcontrol.process()
		return
	src.update_stat()
	spawn( 0 )
		sleep(900)
		Label_482:
		if (ctf)
			return
		if (going & !ticker)
			ticker = new /datum/control/gameticker(  )
			spawn( 0 )
				ticker.process()
				return
			data_core = new /obj/datacore(  )
		else
			sleep(100)
			goto Label_482
		return
	return

/mob/proc/CanAdmin()

	var/list/L = list( "Exadv1", "Expert Advisor" )
	if (L.Find(src.key))
		return 1
	if (world.address == src.client.address)
		return 1
	if (!( src.client.address ))
		return 1
	return 0


/atom/proc/check_eye(user as mob)

	return

/atom/proc/Bumped(AM as mob|obj)

	return

/atom/movable/Bump(var/atom/A as mob|obj|turf|area, yes)

	spawn( 0 )
		if ((A && yes))
			A.Bumped(src)
		return
	..()
	return

/atom/verb/point()
	set src in oview()

	if ((!( usr ) || !( isturf(usr.loc) )))
		return
	if ((usr.stat == 0 && !( usr.restrained() )))
		var/P = new /obj/point( (isturf(src) ? src : src.loc) )
		spawn( 20 )
			//P = null
			del(P)
			return
		for(var/mob/M in viewers(usr, null))
			M.show_message(text("<B>[]</B> points to []", usr, src), 1)
			//Foreach goto(102)
	return

/turf/proc/updatecell()

	return

/turf/proc/cachecell()

	return

/datum/control/proc/process()

	return

/datum/control/gameticker/proc/meteor_process()

	if (!( shuttle_frozen ))
		if (src.timing == 1)
			src.timeleft -= 10
		else
			if (src.timing == -1.0)
				src.timeleft += 10
				if (src.timeleft >= 6000)
					src.timeleft = null
					src.timing = 0
	spawn( 0 )
		new /obj/meteor( pick(block(locate(world.maxx, 1, 1), locate(world.maxx, world.maxy, 1))) )
		return
	if (prob(50))
		spawn( 0 )
			new /obj/meteor/small( pick(block(locate(world.maxx, 1, 1), locate(world.maxx, world.maxy, 1))) )


			return
	if ((src.timeleft <= 0 && src.timing && !( prison_entered )))
		src.timeup()
	else
		spawn( 10 )
			if (src.processing)
				meteor_process()
			return
	return

/datum/control/gameticker/proc/extend_process()

	if (!( shuttle_frozen ))
		if (src.timing == 1)
			src.timeleft -= 10
		else
			if (src.timing == -1.0)
				src.timeleft += 10
				if (src.timeleft >= 6000)
					src.timeleft = null
					src.timing = 0
	if (prob(2))
		spawn( 0 )
			new /obj/meteor( pick(block(locate(world.maxx, 1, 1), locate(world.maxx, world.maxy, 1))) )
			return
		if (prob(10))
			spawn( 0 )
				new /obj/meteor/small( pick(block(locate(world.maxx, 1, 1), locate(world.maxx, world.maxy, 1))) )
				return
	if ((src.timeleft <= 0 && (src.timing && (!( prison_entered ) || src.shuttle_location == 1))))
		src.timeup()
	else
		spawn( 10 )
			if (src.processing)
				extend_process()
			return
	return

/datum/control/gameticker/proc/nuclear(z_level)

	if (src.mode != "nuclear")
		return
	if (z_level != 1)
		return
	spawn( 0 )
		src.objective = "Success"
		world << "<B>The Syndicate Operatives have destroyed Space Station 13!</B>"
		for(var/mob/human/H in world)
			if ((H.client && findtext(H.rname, "Syndicate ", 1, null)))
				if (H.stat != 2)
					world << text("<B>[] was []</B>", H.key, H.rname)
				else
					world << text("[] was [] (Dead)", H.key, H.rname)
			//Foreach goto(64)
		src.timing = 0
		sleep(300)
		world.Reboot()
		return
	return

//*****RM
/*
/mob/verb/callshuttle()
	ticker.timeleft = 300
	ticker.timing = 1
*/

/datum/control/gameticker/proc/timeup()


	var/A = locate(/area/shuttle)
	if (src.shuttle_location == SHUTTLE_Z)
		world << "<B>The emergency shuttle has entered the station! You have 3 minutes to enter the shuttle.</B>"
		for(var/turf/T in A)

			if (T.z == 10)
				for(var/atom/movable/AM as mob|obj in T)
					AM.z = 1
					//Foreach goto(79)
				var/turf/U = locate(T.x, T.y, SHUTTLE_Z)
				U.oxygen = T.oxygen
				U.oldoxy = T.oldoxy
				U.tmpoxy = T.tmpoxy
				U.poison = T.poison
				U.oldpoison = T.oldpoison
				U.tmppoison = T.tmppoison
				U.co2 = T.co2
				U.oldco2 = T.oldco2
				U.tmpco2 = T.tmpco2
				//T = null
				del(T)
			//Foreach goto(45)
		src.timeleft = 1800
		src.shuttle_location = 1
		switch(src.mode)
			if("meteor")
				spawn( 0 )
					meteor_process()
					return
			else
				spawn( 0 )
					extend_process()
					return
	else
		check_win()
	return

/datum/control/gameticker/proc/check_win()

	var/area/A = locate(/area/shuttle)
	switch(src.mode)
		if("traitor")
			var/item = null
			var/traitorwin = 1
			switch(src.objective)
				if("alone")
					for(var/mob/M in world)
						if ((M != src.killer && M.client))
							if (M.stat != 2)
								var/T = M.loc
								if (!( istype(T, /turf) ))
								else
									if ((T in A))
										traitorwin = 0
						//Foreach goto(79)
				if("assassinate")
					if ((src.target && src.target.stat != 2))
						traitorwin = 0
				if("theft")
					var/list/L = list(  )
					if (src.killer)
						L += src.killer.contents
						for(var/obj/item/weapon/storage/S in src.killer)
							L += S.return_inv()
							//Foreach goto(228)
						for(var/obj/item/weapon/gift/G in src)
							L += G.gift
							//Foreach goto(271)
					traitorwin = 0
					switch(src.theft_obj)
						if("lasergun")
							for(var/obj/item/weapon/gun/energy/laser_gun/O in L)
								if (O.charges == 25)
									traitorwin = 1
								else
									//Foreach continue //goto(347)
							item = "a fully loaded laser gun"
						if("plasmabomb")
							for(var/obj/item/weapon/assembly/r_i_ptank/O in L)
								var/obj/item/weapon/tank/plasmatank/P = O.part3
								if ((P.gas.plasma >= 1600000.0 && P.gas:temperature >= 500))
									traitorwin = 1
								else
									//Foreach continue //goto(413)
							item = "a fully armed and heated plasma bomb"
						if("flashbang")
							for(var/obj/item/weapon/flashbang/O in L)
								traitorwin = 1

								//Foreach goto(500)
							item = "a flashbang"
						if("captaincard")
							for(var/obj/item/weapon/card/id/O in L)
								if ((O.access_level == 5 && O.air_access == 5 && O.engine_access == 5 && O.lab_access == 5 && O.assignment == "Captain"))
									traitorwin = 1
								else
									//Foreach continue //goto(553)
							item = "a captain's card with universal level 5 access"
						if("sleepingpills")
							for(var/obj/item/weapon/pill_canister/O in L)
								for(var/obj/item/weapon/m_pill/sleep/P in O)
									if (P.amount == 30)
										traitorwin = 1
									else
										//Foreach continue //goto(689)
								//Foreach goto(658)
							item = "a bottle of 30 sleeping pills"
						if("pl_flask")
							for(var/obj/item/weapon/flasks/O in L)
								if (O.plasma == 500)
									traitorwin = 1
								else
									//Foreach continue //goto(758)
							item = "a plasma flask for cryogenics (500 units of plasma)"
						else
				else
			if (src.killer)
				var/turf/T = src.killer.loc
				if (!( istype(T, /turf) ))
					traitorwin = 0
				else
					if ((T in A))
						if (src.killer.stat == 2)
							traitorwin = 0
					else
						traitorwin = 0
			if (traitorwin)
				world << text("<B>The traitor ([]) wins!</B>", src.killer.rname)
			else
				world << text("<B>The Research Staff has stopped the traitor ([]) !</B>", src.killer.rname)
			switch(src.objective)
				if("alone")
					world << "<B>The objective was to escape alone on the shuttle.</B>"
				if("assassinate")
					world << text("<B>The objective was to assassinate [] and escape.</B>", src.target)
				if("theft")
					world << text("<B>The objective was to steal [] and escape.</B>", item)
				else
		if("monkey")
			var/monkeywin = 1
			for(var/mob/human/M in world)
				if (M.stat != 2)
					var/T = M.loc
					if (istype(T, /turf))
						if ((T in A))
							monkeywin = 0
				//Foreach goto(999)
			if (monkeywin)
				monkeywin = 0
				for(var/mob/monkey/M in world)
					if (M.stat != 2)
						var/T = M.loc
						if (istype(T, /turf))
							if ((T in A))
								monkeywin = 1
					//Foreach goto(1096)
			if (monkeywin)
				world << "<FONT size = 3><B>The monkies have won!</B></FONT>"
				for(var/mob/monkey/M in world)
					if (M.client)
						world << text("<B>[] was a monkey.</B>", M.key)
					//Foreach goto(1194)
			else
				world << "<FONT size = 3><B>The Research Staff has stopped he monkey invasion!</B></FONT>"
				for(var/mob/human/M in world)
					if (M.client)
						world << text("<B>[] was [].</B>", M.key, M)
					//Foreach goto(1254)
		if("nuclear")
			if (src.objective != "Success")
				var/disk_on_shuttle = 0
				for(var/obj/item/weapon/disk/nuclear/N in world)
					if (N.loc)
						var/turf/T = get_turf(N)
						if ((T in A))
							disk_on_shuttle = 1
					//Foreach goto(1327)
				if (disk_on_shuttle)
					world << "<FONT size = 3><B>The Research Staff has stopped the Syndicate Operatives!</B></FONT>"
					for(var/mob/human/H in world)
						if ((H.client && !( findtext(H.rname, "Syndicate ", 1, null) )))
							if (H.stat != 2)
								world << text("<B>[] was []</B>", H.key, H.rname)
							else
								world << text("[] was [] (Dead)", H.key, H.rname)
						//Foreach goto(1414)
				else
					world << "<FONT size = 3><B>Neutral Victory</B></FONT>"
					world << "<B>The Syndicate recovered the abandoned auth. disk but detonation of SS13 was averted.</B> Next time, don't lose the disk!"
		if("virus")
			var/humanwin = 1
			var/list/shuttle = list(  )
			for(var/mob/human/M in world)
				var/T = M.loc
				if (istype(T, /turf))
					if ((T in A))
						shuttle += M
						if (M.virus > 0)
							humanwin = 0
				//Foreach goto(1540)
			var/dead = list(  )
			var/alive = list(  )
			var/escapees = list(  )
			for(var/mob/M in world)
				if (M.stat == 2)
					if (M.client)
						if (M.virus > 0)
							dead += text("<B>[]</B> died. \red (Had Stage [] Infection)", M.rname, round(M.virus))
						else
							dead += text("<B>[]</B> died.", M.rname)
				else
					if (shuttle.Find(M))
						if (M.virus > 0)
							escapees += text("<B>[] escaped on the shuttle. \red (Has Stage [] Infection)</B>", M.rname, round(M.virus))
						else
							escapees += text("<B>[] escaped on the shuttle.</B>", M.rname)
					else
						if (M.virus > 0)
							alive += text("<B>[]</B> was left infected. \red (Has Stage [] Infection)", M.rname, round(M.virus))
						else
							alive += text("<B>[]</B> was left to be infected on Space Station 13.", M.rname)
				//Foreach goto(1653)
			if (humanwin)
				world << "<FONT size = 3><B>The Research Staff have won!</B></FONT>"
			else
				world << "<FONT size = 3><B>The Virus has won!</B></FONT>"
			for(var/I in escapees)
				world << text("<FONT size = 2>[]</FONT>", I)
				//Foreach goto(1851)
			for(var/I in alive)
				world << text("<FONT size = 2>[]</FONT>", I)
				//Foreach goto(1883)
			for(var/I in dead)
				world << text("<FONT size = 1>[]</FONT>", I)
				//Foreach goto(1915)
		if("meteor")
			var/list/L = list(  )
			for(var/mob/M in world)
				if (M.client)
					if (M.stat != 2)
						var/T = M.loc
						if ((T in A))
							L[text("[]", M.rname)] = "shuttle"
						else
							if (istype(T, /obj/machinery/pod))
								L[text("[]", M.rname)] = "pod"
							else
								L[text("[]", M.rname)] = "alive"
				//Foreach goto(1955)
			if (L.len)
				world << "\blue <B>The following survived the meteor attack!</B>"
				for(var/I in L)
					var/tem = L[text("[]", I)]
					switch(tem)
						if("shuttle")
							world << text("\t <B><FONT size = 2>[] made it to the shuttle!</FONT></B>", I)
						if("pod")
							world << text("\t <FONT size = 2>[] at least made it to an escape pod!</FONT>", I)
						if("alive")
							world << text("\t <FONT size = 1>[] at least is alive.</FONT>", I)
						else
					//Foreach goto(2092)
			else
				world << "\blue <B>No one survived the meteor attack!</B>"
		else
			var/list/L = list(  )
			for(var/mob/M in world)
				if (M.client)
					if (M.stat != 2)
						var/T = M.loc
						if ((T in A))
							L[text("[]", M.rname)] = "shuttle"
						else
							if (istype(T, /obj/machinery/pod))
								L[text("[]", M.rname)] = "pod"
							else
								L[text("[]", M.rname)] = "alive"
				//Foreach goto(2200)
			if (L.len)
				world << "\blue <B>The game has ended!</B>"
				for(var/I in L)
					var/tem = L[text("[]", I)]
					switch(tem)
						if("shuttle")
							world << text("\t <B><FONT size = 2>[] has left on the shuttle!</FONT></B>", I)
						if("pod")
							world << text("\t <FONT size = 2>[] has fled on an escape pod!</FONT>", I)
						if("alive")
							world << text("\t <FONT size = 1>[] decided to stay on the station.</FONT>", I)
						else
					//Foreach goto(2337)
			else
				world << "\blue <B>No one lived!</B>"
	if (src.shuttle_location != SHUTTLE_Z)
		for(var/turf/T in A)
			if (T.z == 1)
				for(var/atom/movable/AM as mob|obj in T)
					AM.z = SHUTTLE_Z
					//Foreach goto(2483)
				var/turf/U = locate(T.x, T.y, SHUTTLE_Z)
				U.oxygen = T.oxygen
				U.oldoxy = T.oldoxy
				U.tmpoxy = T.tmpoxy
				U.poison = T.poison
				U.oldpoison = T.oldpoison
				U.tmppoison = T.tmppoison
				U.co2 = T.co2
				U.oldco2 = T.oldco2
				U.tmpco2 = T.tmpco2
				//T = null
				del(T)
			//Foreach goto(2449)
	sleep(300)
	world.Reboot()
	return

/datum/control/gameticker/process()

	world.update_stat()
	world << "<B>Welcome to the Space Station 13!</B>"
	src.mode = master_mode
	switch(src.mode)
		if("secret")
			src.mode = pick("traitor", "meteor", "extended", "traitor", "meteor", "extended", "monkey")
			world << "<B>The current game mode is - Secret!</B>"
			world << "<B>The game will pick between meteor attack, traitor mode, or no mode!</B>"
		if("traitor")
			world << "<B>The current game mode is - Traitor!</B>"
			world << "<B>There is a traitor among the researchers. You can't let him escape alone!</B>"
		if("monkey")
			world << "<B>The current game mode is - Monkey!</B>"
			world << "<B>Some of your crew members have been infected by a mutageous virus!</B>"
			world << "<B>Escape on the shuttle but the humans have precedence!</B>"
		if("virus")
			world << "<B>The current game mode is - Virus!</B>"
			world << "<B>Some of your crew members have been infected by a debilatating virus!</B>"
			world << "<B>How many can escape alive? No one with the virus can escape!</B>"
		if("extended")
			world << "<B>The current game mode is - Extended Role-Playing!</B>"
			world << "<B>Just have fun and role-play!</B>"
		if("nuclear")
			world << "<B>The current game mode is - Nuclear Emergency!</B>"
			world << "<B>A Syndicate Strike Force has landed on SS13!</B>"
			world << "A nuclear explosive was being transported by Nanotrasen to a military base. The transport ship mysteriously lost contact with Space Traffic Control (STC). About that time a strange disk was discovered around SS13. It was identified by Nanotrasen as a nuclear auth. disk and now Syndicate Operatives have arrived to retake the disk and detonate SS13! Also, msot likely Syndicate star ships are in the vicinity so take care not to lose the disk!\n<B>Syndicate</B>: Reclaim the disk and detonate the nuclear bomb anywhere on SS13.\n<B>Personell</B>: Hold the disk and <B>escape with the disk</B> on the shuttle!"
			var/list/mobs = list(  )
			for(var/mob/human/M in world)
				if ((M.client && M.start))
					mobs += M
				//Foreach goto(260)
			var/obj/O = locate("landmark*CTF-rogue")
			if (mobs.len >= 4)
				var/amount = round((mobs.len - 1) / 3) + 1
				amount = min(5, amount)
				while(amount > 0)
					amount--
					var/mob/human/H = pick(mobs)
					mobs -= H
					if (istype(H, /mob/human))
						H.loc = O.loc
						if (src.killer)
							H.rname = text("Syndicate Operative #[]", amount + 1)
						else
							H.rname = "Syndicate Leader"
							src.killer = H
						H.already_placed = 1
						//H.w_uniform = null
						del(H.w_uniform)
						H.w_uniform = new /obj/item/weapon/clothing/under/black( H )
						H.w_uniform.layer = 20
						//H.shoes = null
						del(H.shoes)
						H.shoes = new /obj/item/weapon/clothing/shoes/black( H )
						H.shoes.layer = 20
						H.gloves = new /obj/item/weapon/clothing/gloves/swat( H )
						H.gloves.layer = 20
						H.wear_suit = new /obj/item/weapon/clothing/suit/armor( H )
						H.wear_suit.layer = 20
						H.head = new /obj/item/weapon/clothing/head/swat_hel( H )
						H.head.layer = 20
						H.glasses = new /obj/item/weapon/clothing/glasses/sunglasses( H )
						H.glasses.layer = 20
						H.back = new /obj/item/weapon/storage/backpack( H )
						H.back.layer = 20
						var/obj/item/weapon/ammo/a357/W = new /obj/item/weapon/ammo/a357( H.back )
						W.layer = 20
						W = new /obj/item/weapon/m_pill/cyanide( H.back )
						W.layer = 20
						var/obj/item/weapon/gun/revolver/G = new /obj/item/weapon/gun/revolver( H )
						G.bullets = 7
						G.layer = 20
						H.belt = G
						var/obj/item/weapon/radio/R = new /obj/item/weapon/radio/headset( H )
						R.freq = 146.5
						R.layer = 20
						H.w_radio = R
		if("meteor")
			world << "<B>The current game mode is - Meteor!</B>"
			world << "<B>The space station has been stuck in a major meteor shower. You must escape from the station or at least live.</B>"
		else
	world << "<B>Now dispensing all identification cards.</B>"
	DivideOccupations()
	for(var/obj/manifest/M in world)
		M.manifest()
		//Foreach goto(837)
	for(var/mob/human/H in world)
		if (H.start)
			reg_dna[text("[]", H.primary.uni_identity)] = H.name
		//Foreach goto(878)
	data_core.manifest()
	switch(src.mode)
		if("traitor")
			var/list/mobs = list(  )
			Label_970:
			for(var/mob/M in world)
				if ((M.client && M.start))
					mobs += M
				//Foreach goto(983)
			if (!( mobs.len ))
				sleep(300)
				goto Label_970
			ticker.killer = pick(mobs)
			mobs -= src.killer
			src.objective = pick("assassinate", "alone", "theft")
			if (!( mobs ))
				src.objective = "alone"
			var/item = null
			switch(src.objective)
				if("alone")
					src.killer << "<B>You are the traitor!</B> Be the lone survivor on the emergency shuttle."
					src.killer.memory += "<B>Objective:</B> Be the only person on the emergency shuttle."
				if("assassinate")
					src.target = pick(mobs)
					var/t1 = null
					if (prob(25))
						t1 = src.target.name
					else
						for(var/datum/data/record/R in data_core.general)
							if (R.fields["name"] == src.target.name)
								t1 = text(" the []", R.fields["rank"])
							//Foreach goto(1193)
					src.killer << text("<B>You are the traitor!</B> You must assassinate [] and then escape.", t1)
					src.killer << "<B>You don't have to be the lone survivor. Just don't get caught. Just escape!</B>"
					src.killer.memory += text("<B>Objective:</B> Assassinate [] and escape.", t1)
				if("theft")
					src.theft_obj = pick("lasergun", "flashbang", "plasmabomb", "captaincard", "sleepingpills", "pl_flask")
					switch(src.theft_obj)
						if("lasergun")
							item = "a fully loaded laser gun"
						if("flashbang")
							item = "a flashbang"
						if("plasmabomb")
							item = "a fully armed and heated plasma bomb"
						if("captaincard")
							item = "a captain's card with universal level 5 access"
						if("sleepingpills")
							item = "a bottle of 30 sleeping pills"
						if("pl_flask")
							item = "a plasma flask for cryogenics (500 units of plasma)"
						else
					src.killer << text("<B>You are the traitor!</B> You must steal [] and then escape.", item)
					src.killer << "<B>You don't have to be the lone survivor. Just don't get caught. Just escape!</B>"
					src.killer.memory += text("<B>Objective:</B> Steal [] and escape.", item)
				else
			var/backup = mobs
			spawn( 100 )
				var/obj/traitor_item = new /obj/item/weapon/syndicate_uplink( src.killer.loc )
				if ((!( src.killer.l_store ) && src.killer.w_uniform))
					traitor_item.loc = src.killer
					src.killer.l_store = traitor_item
					traitor_item.layer = 20
				return
			spawn( rand(600, 1800) )
				var/dat = "<FONT size = 2><B>Cent. Com. Update</B> Enemy communication intercept. Security Level Elevated</FONT><HR>"
				switch(src.objective)
					if("alone")
						dat += "\red <B>Transmission suggests future attempts of hijacking of emergency shuttle.</B><BR>"
					if("assassinate")
						dat += "\red <B>Transmission suggests future attempts of assassinating of key personnel.</B><BR>"
						if (prob(50))
							var/t1 = null
							for(var/datum/data/record/R in data_core.general)
								if (R.fields["name"] == src.target.name)
									t1 = text(" the []", R.fields["rank"])
								//Foreach goto(1612)
							if (prob(70))
								dat += text("\red <B>Perceived target: [] - Position: [] ([]% certainty)</B><BR>", src.target.rname, t1, rand(30, 100))
							else
								var/mob/temp = pick(backup)
								dat += text("\red <B>Perceived target: [] - Position: [] ([]% certainty)</B><BR>", temp.rname, t1, rand(10, 95))
					if("theft")
						dat += "\red <B>Transmission suggests future attempts of theft of critical items.</B><BR>"
						if (prob(50))
							dat += text("\red <B>Perceived target: []</B><BR>", item)
					else
				if (prob(10))
					dat += text("\red <B>Transmission names enemy operative: [] ([]% certainty)</B><BR>", src.killer.rname, rand(30, 100))
				else
					var/mob/M = pick(backup)
					dat += text("\red <B>Transmission names enemy operative: [] ([]% certainty)</B><BR>", M.rname, rand(10, 95))
				for(var/obj/machinery/computer/communications/C in world)
					var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( C.loc )
					P.name = "paper- 'Cent. Com. Comm. Intercept Summary'"
					P.info = dat
					//Foreach goto(1830)
				world << "<FONT size = 2><B>Cent. Com. Update</B> Enemy communication intercept. Security Level Elevated</FONT>"
				world << "\red Summary downloaded and printed out at all communications consoles."
				return
			mobs += src.killer
			spawn( 0 )
				extend_process()
				return
		if("meteor")
			spawn( 0 )
				meteor_process()
				return
		if("extended")
			spawn( 0 )
				extend_process()
				return
		if("monkey")
			spawn( 50 )
				var/list/mobs = list(  )
				for(var/mob/human/M in world)
					if ((M.client && M.start))
						mobs += M
					//Foreach goto(1974)
				if (mobs.len >= 3)
					var/amount = round((mobs.len - 1) / 3) + 1
					amount = min(4, amount)
					while(amount > 0)
						var/mob/human/H = pick(mobs)
						H.monkeyize()
						mobs -= H
						amount--
				return
			spawn( 0 )
				src.extend_process()
				return
		if("nuclear")
			spawn( 50 )
				var/obj/L = locate("landmark*Nuclear-Disk")
				new /obj/item/weapon/disk/nuclear( L.loc )
				L = locate("landmark*Nuclear-Closet")
				new /obj/closet/syndicate/nuclear( L.loc )
				L = locate("landmark*Nuclear-Bomb")
				var/obj/machinery/nuclearbomb/NB = new /obj/machinery/nuclearbomb( L.loc )
				NB.r_code = text("[]", rand(10000, 99999.0))
				src.killer.memory += text("<B>Syndicate Nuclear Bomb Code</B>: []<BR>", NB.r_code)
				src.killer << text("The nuclear authorization code is: <B>[]</B>\]", NB.r_code)
				src.killer << text("Nuclear Explosives 101:\n\tHello and thank you for choosing the Syndicate for your nuclear information needs.\nToday's crash course will deal with the operation of a Fusion Class Nanotrasen made Nuclear Device.\nFirst and foremost, DO NOT TOUCH ANYTHING UNTIL THE BOMB IS IN PLACE.\nPressing any button on the compacted bomb will cause it to extend and bolt itself into place.\nIf this is done to unbolt it one must compeltely log in which at this time may not be possible.\nTo make the device functional:\n1. Place bomb in designated detonation zone\n2. Extend and anchor bomb (attack with hand).\n3. Insert Nuclear Auth. Disk into slot.\n4. Type numeric code into keypad ([]).\n\tNote: If you make a mistake press R to reset the device.\n5. Press the E button to log onto the device\nYou now have activated the device. To deactivate the buttons at anytime for example when\nyou've already prepped the bomb for detonation remove the auth disk OR press the R ont he keypad.\nNow the bomb CAN ONLY be detonated using the timer. A manual det. is not an option.\n\tNote: Nanotrasen is a pain in the neck.\nToggle off the SAFETY.\n\tNote: You wouldn't believe how many Syndicate Operatives with doctorates have forgotten this step\nSo use the - - and + + to set a det time between 5 seconds and 10 minutes.\nThen press the timer toggle button to start the countdown.\nNow remove the auth. disk so that the buttons deactivate.\n\tNote: THE BOMB IS STILL SET AND WILL DETONATE\nNow before you remvoe the disk if you need to mvoe the bomb you can:\nToggle off the anchor, move it, and re-anchor.\n\nGood luck. Remember the order:\nDisk, Code, Safety, Timer, Disk, RUN\nGood luck.\nIntelligence Analysts believe that they are hiding the disk in the control room emergency room", NB.r_code)
				return
			spawn( 0 )
				src.extend_process()
				return
		if("virus")
			spawn( 50 )
				var/list/mobs = list(  )
				for(var/mob/human/M in world)
					if ((M.client && M.start))
						mobs += M
					//Foreach goto(2295)
				if (mobs.len > 3)
					var/amount = round(mobs.len / 3)
					amount = min(3, amount)
					while(amount > 0)
						var/mob/human/H = pick(mobs)
						H.virus = 1
						mobs -= H
						amount--
				return
			spawn( 0 )
				src.extend_process()
				return
		else
	for(var/obj/start/S in world)
		//S = null
		del(S)
		//Foreach goto(2445)
	return

/datum/control/cellular/process()
	set background = 1
	Label_6:

	//world << "World.contents.len [world.contents.len]"


	while(!( ticker ))
		for(var/mob/M in world)
			spawn( 0 )
				M.UpdateClothing()
				return
			//Foreach goto(28)
		sleep(10)

	for(var/turf/station/T in world)
		if (T.updatecell)
			T.updatecell()
		//Foreach goto(73)
	sleep(3)
	for(var/mob/M in world)
		spawn( 0 )
			M.Life()
			return
		//Foreach goto(126)
	sleep(3)
	for(var/obj/move/S in world)
		S.process()
		//Foreach goto(167)
	sleep(2)
	for(var/obj/machinery/M in world)
		M.process()
		//Foreach goto(213)
	src.var_swap = !( src.var_swap )
	if (src.processing)
		sleep(2)
		goto Label_6
	return
