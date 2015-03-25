
/proc/text2dir(direction)

	switch(uppertext(direction))
		if("NORTH")
			return 1
		if("SOUTH")
			return 2
		if("EAST")
			return 4
		if("WEST")
			return 8
		if("NORTHEAST")
			return 5
		if("NORTHWEST")
			return 9
		if("SOUTHEAST")
			return 6
		if("SOUTHWEST")
			return 10
		else
	return

/proc/get_turf(T as turf)

	while((!( istype(T, /turf) ) && T))
		T = T.loc
	return T
	return

/proc/dir2text(direction)

	switch(direction)
		if(1.0)
			return "north"
		if(2.0)
			return "south"
		if(4.0)
			return "east"
		if(8.0)
			return "west"
		if(5.0)
			return "northeast"
		if(6.0)
			return "southeast"
		if(9.0)
			return "northwest"
		if(10.0)
			return "southwest"
		else
	return

/obj/proc/hear_talk(M as mob, text)

	return

/obj/machinery/recharger/process()

	if (src.charging)
		if (src.charging.charges < 10)
			src.charges++
			src.icon_state = "recharger1"
		else
			src.icon_state = "recharger2"
	else
		src.icon_state = "recharger0"
	return

/obj/machinery/recharger/attack_paw(user as mob)

	if ((ticker && ticker.mode == "monkey"))
		return src.attack_hand(user)
	return

/obj/machinery/recharger/attack_hand(user as mob)

	src.add_fingerprint(user)
	if (src.charging)
		src.charging.update_icon()
		src.charging.loc = src.loc
		src.charging = null
	return

/obj/machinery/recharger/attackby(G as obj, user as mob)

	if (src.charging)
		return
	if (istype(G, /obj/item/weapon/gun/energy))
		user.drop_item()
		G.loc = src
		src.charging = G
		return
	return

/obj/item/weapon/table_parts/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/weapon/sheet/metal( src.loc )
		src = null
		del(src)
		return
		return
	return

/obj/item/weapon/table_parts/attack_self(user as mob)

	var/state = input(user, "What type of table?", "Assembling Table", null) in list( "sides", "corners", "alone" )
	var/direct = SOUTH
	if (state == "corners")
		direct = input(user, "Direction?", "Assembling Table", null) in list( "northwest", "northeast", "southwest", "southeast" )
	else
		if (state == "sides")
			direct = input(user, "Direction?", "Assembling Table", null) in list( "north", "east", "south", "west" )
	var/obj/table/T = new /obj/table( user.loc )
	T.icon_state = state
	T.dir = text2dir(direct)
	T.add_fingerprint(user)
	src = null
	del(src)
	return
	return

/obj/item/weapon/rack_parts/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/weapon/sheet/metal( src.loc )
		src = null
		del(src)
		return
		return
	return

/obj/item/weapon/rack_parts/attack_self(user as mob)

	var/obj/rack/R = new /obj/rack( user.loc )
	R.add_fingerprint(user)
	src = null
	del(src)
	return
	return

/obj/item/weapon/paper_bin/proc/update()

	src.icon_state = text("paper_bin[]", ((src.amount || locate(/obj/item/weapon/paper, src)) ? "1" : null))
	return

/obj/item/weapon/paper_bin/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/paper))
		user.drop_item()
		W.loc = src
	else
		if (istype(W, /obj/item/weapon/weldingtool))
			var/T = W
			if ((T.welding && T.weldfuel > 0))
				viewers(user, null) << text("[] burns the paper with the welding tool!", user)
				spawn( 0 )
					src.burn(1800000.0)
					return
		else
			if (istype(W, /obj/item/weapon/igniter))
				viewers(user, null) << text("[] burns the paper with the igniter!", user)
				spawn( 0 )
					src.burn(1800000.0)
					return
	src.update()
	return

/obj/item/weapon/paper_bin/burn(fi_amount)

	flick("paper_binb", src)
	for(var/atom/movable/A as mob|obj in src)
		A.burn(fi_amount)
		//Foreach goto(23)
	if (fi_amount >= 900000.0)
		src.amount = 0
	src.update()
	return

/obj/item/weapon/paper_bin/MouseDrop(user as mob)

	if ((user == usr && (!( usr.restrained() ) && (!( usr.stat ) && (usr.contents.Find(src) || get_dist(src, usr) <= 1)))))
		if (usr.hand)
			if (!( usr.l_hand ))
				spawn( 0 )
					src.attack_hand(usr, 1, 1)
					return
		else
			if (!( src.r_hand ))
				spawn( 0 )
					src.attack_hand(usr, 0, 1)
					return
	return

/obj/item/weapon/paper_bin/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/paper_bin/attack_hand(user as mob, unused, flag)

	if (flag)
		return ..()
	src.add_fingerprint(user)
	if (locate(/obj/item/weapon/paper, src))
		for(var/obj/item/weapon/paper/P as obj in src)
			if ((usr.hand && !( usr.l_hand )))
				usr.l_hand = P
				P.loc = usr
				P.layer = 20
				P = null
				usr.UpdateClothing()
			else
				if (!( usr.r_hand ))
					usr.r_hand = P
					P.loc = usr
					P.layer = 20
					P = null
					usr.UpdateClothing()
			else
			//Foreach goto(48)
	else
		if (usr.amount >= 1)
			usr.amount--
			new /obj/item/weapon/paper( usr.loc )
	src.update()
	return

/obj/item/weapon/paper_bin/examine()
	set src in oview(1)

	src.amount = round(src.amount)
	var/n = src.amount
	for(var/obj/item/weapon/paper/P as obj in src)
		n++
		//Foreach goto(33)
	if (n <= 0)
		n = 0
		usr << "There are no papers in the bin."
	else
		if (n == 1)
			usr << "There is one paper in the bin."
		else
			usr << text("There are [] papers in the bin.", n)
	return

/obj/item/weapon/dummy/ex_act()

	return

/obj/item/weapon/game_kit/New()

	src.board_stat = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
	src.selected = "CR"
	return

/obj/item/weapon/game_kit/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/game_kit/MouseDrop(user as mob)

	if ((user == usr && (!( usr.restrained() ) && (!( usr.stat ) && (usr.contents.Find(src) || get_dist(src, usr) <= 1)))))
		if (usr.hand)
			if (!( usr.l_hand ))
				spawn( 0 )
					src.attack_hand(usr, 1, 1)
					return
		else
			if (!( src.r_hand ))
				spawn( 0 )
					src.attack_hand(usr, 0, 1)
					return
	return

/obj/item/weapon/game_kit/proc/update()

	if (!( src.internet ))
		var/dat = text("<CENTER><B>Game Board</B></CENTER><BR><a href='?src=\ref[];mode=hia'>[]</a> <a href='?src=\ref[];mode=remove'>remove</a><HR><table width= 256  border= 0  height= 256  cellspacing= 0  cellpadding= 0 >", src, (src.selected ? text("Selected: []", src.selected) : "Nothing Selected"), src)
		var/counter = null
		counter = 1
		while(counter <= 8)
			dat += text("<tr>\n\t<td><a href='?src=\ref[];s_board=1 []'><img src='board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=2 []'><img src='board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=3 []'><img src='board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=4 []'><img src='board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=5 []'><img src='board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=6 []'><img src='board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=7 []'><img src='board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=8 []'><img src='board_[][].png' width= 32 height= 32 ></td>\n\t</tr>", src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 1) * 2) - 1, ((((counter - 1) * 8) + 1) * 2) + 1), ((counter + 1) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 2) * 2) - 1, ((((counter - 1) * 8) + 2) * 2) + 1), ((counter + 2) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 3) * 2) - 1, ((((counter - 1) * 8) + 3) * 2) + 1), ((counter + 3) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 4) * 2) - 1, ((((counter - 1) * 8) + 4) * 2) + 1), ((counter + 4) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 5) * 2) - 1, ((((counter - 1) * 8) + 5) * 2) + 1), ((counter + 5) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 6) * 2) - 1, ((((counter - 1) * 8) + 6) * 2) + 1), ((counter + 6) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 7) * 2) - 1, ((((counter - 1) * 8) + 7) * 2) + 1), ((counter + 7) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 8) * 2) - 1, ((((counter - 1) * 8) + 8) * 2) + 1), ((counter + 8) % 2 ? "W" : "B"))
			counter++
		dat += "</table><HR><B>Chips:</B> "
		dat += text("<a href='?src=\ref[];s_piece=CB'><img src='board_CB.png' width= 32 height= 32 ></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=CR'><img src='board_CR.png' width= 32 height= 32 ></A>", src)
		dat += "<HR><B>Chess pieces:</B><BR>"
		dat += text("<a href='?src=\ref[];s_piece=WP'><img src='board_WP.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WK'><img src='board_WK.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WQ'><img src='board_WQ.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WI'><img src='board_WI.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WN'><img src='board_WN.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WR'><img src='board_WR.png'></A><BR>", src)
		dat += text("<a href='?src=\ref[];s_piece=BP'><img src='board_BP.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BK'><img src='board_BK.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BQ'><img src='board_BQ.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BI'><img src='board_BI.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BN'><img src='board_BN.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BR'><img src='board_BR.png'></A><HR>", src)
		dat += text("<a href='?src=\ref[];sw_pic=1'>Using cache for pictures</A>", src)
		src.data = dat
	else
		var/dat = text("<CENTER><B>Game Board</B></CENTER><BR><a href='?src=\ref[];mode=hia'>[]</a> <a href='?src=\ref[];mode=remove'>remove</a><HR><table width= 256  border= 0  height= 256  cellspacing= 0  cellpadding= 0 >", src, (src.selected ? text("Selected: []", src.selected) : "Nothing Selected"), src)
		var/counter = null
		counter = 1
		while(counter <= 8)
			dat += text("<tr>\n\t<td><a href='?src=\ref[];s_board=1 []'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=2 []'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=3 []'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=4 []'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=5 []'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=6 []'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=7 []'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_[][].png' width= 32 height= 32 ></td>\n\t<td><a href='?src=\ref[];s_board=8 []'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_[][].png' width= 32 height= 32 ></td>\n\t</tr>", src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 1) * 2) - 1, ((((counter - 1) * 8) + 1) * 2) + 1), ((counter + 1) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 2) * 2) - 1, ((((counter - 1) * 8) + 2) * 2) + 1), ((counter + 2) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 3) * 2) - 1, ((((counter - 1) * 8) + 3) * 2) + 1), ((counter + 3) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 4) * 2) - 1, ((((counter - 1) * 8) + 4) * 2) + 1), ((counter + 4) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 5) * 2) - 1, ((((counter - 1) * 8) + 5) * 2) + 1), ((counter + 5) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 6) * 2) - 1, ((((counter - 1) * 8) + 6) * 2) + 1), ((counter + 6) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 7) * 2) - 1, ((((counter - 1) * 8) + 7) * 2) + 1), ((counter + 7) % 2 ? "W" : "B"), src, counter, copytext(src.board_stat, ((((counter - 1) * 8) + 8) * 2) - 1, ((((counter - 1) * 8) + 8) * 2) + 1), ((counter + 8) % 2 ? "W" : "B"))
			counter++
		dat += "</table><HR><B>Chips:</B> "
		dat += text("<a href='?src=\ref[];s_piece=CB'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_CB.png' width= 32 height= 32 ></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=CR'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_CR.png' width= 32 height= 32 ></A>", src)
		dat += "<HR><B>Chess pieces:</B><BR>"
		dat += text("<a href='?src=\ref[];s_piece=WP'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_WP.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WK'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_WK.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WQ'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_WQ.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WI'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_WI.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WN'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_WN.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=WR'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_WR.png'></A><BR>", src)
		dat += text("<a href='?src=\ref[];s_piece=BP'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_BP.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BK'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_BK.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BQ'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_BQ.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BI'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_BI.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BN'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_BN.png'></A>", src)
		dat += text("<a href='?src=\ref[];s_piece=BR'><img src='http://exadv1.aretesoft.com/Game_Board_Files/board_BR.png'></A><HR>", src)
		dat += text("<a href='?src=\ref[];sw_pic=1'>Using Internet for pictures</A>", src)
		src.data = dat
	return

/obj/item/weapon/game_kit/attack_hand(user as mob, unused, flag)

	if (flag)
		return ..()
	else
		user.machine = src
		if (!( src.data ))
			update()
		user << browse(src.data, "window=game_kit")
		return
	return

/obj/item/weapon/game_kit/Topic(href, href_list)

	if ((usr.stat || usr.restrained()))
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		if (href_list["s_piece"])
			src.selected = href_list["s_piece"]
		else
			if (href_list["mode"])
				if (href_list["mode"] == "remove")
					src.selected = "remove"
				else
					src.selected = null
			else
				if (href_list["sw_pic"])
					src.internet = !( src.internet )
				else
					if (href_list["s_board"])
						if (!( src.selected ))
							src.selected = href_list["s_board"]
						else
							var/tx = text2num(copytext(href_list["s_board"], 1, 2))
							var/ty = text2num(copytext(href_list["s_board"], 3, 4))
							if ((copytext(src.selected, 2, 3) == " " && length(src.selected) == 3))
								var/sx = text2num(copytext(src.selected, 1, 2))
								var/sy = text2num(copytext(src.selected, 3, 4))
								var/place = ((((sy - 1) * 8) + sx) * 2) - 1
								src.selected = copytext(src.board_stat, place, place + 2)
								if (place == 1)
									src.board_stat = text("BB[]", copytext(src.board_stat, 3, 129))
								else
									if (place == 127)
										src.board_stat = text("[]BB", copytext(src.board_stat, 1, 127))
									else
										if (place)
											src.board_stat = text("[]BB[]", copytext(src.board_stat, 1, place), copytext(src.board_stat, place + 2, 129))
								place = ((((ty - 1) * 8) + tx) * 2) - 1
								if (place == 1)
									src.board_stat = text("[][]", src.selected, copytext(src.board_stat, 3, 129))
								else
									if (place == 127)
										src.board_stat = text("[][]", copytext(src.board_stat, 1, 127), src.selected)
									else
										if (place)
											src.board_stat = text("[][][]", copytext(src.board_stat, 1, place), src.selected, copytext(src.board_stat, place + 2, 129))
								src.selected = null
							else
								if (src.selected == "remove")
									var/place = ((((ty - 1) * 8) + tx) * 2) - 1
									if (place == 1)
										src.board_stat = text("BB[]", copytext(src.board_stat, 3, 129))
									else
										if (place == 127)
											src.board_stat = text("[]BB", copytext(src.board_stat, 1, 127))
										else
											if (place)
												src.board_stat = text("[]BB[]", copytext(src.board_stat, 1, place), copytext(src.board_stat, place + 2, 129))
								else
									if (length(src.selected) == 2)
										var/place = ((((ty - 1) * 8) + tx) * 2) - 1
										if (place == 1)
											src.board_stat = text("[][]", src.selected, copytext(src.board_stat, 3, 129))
										else
											if (place == 127)
												src.board_stat = text("[][]", copytext(src.board_stat, 1, 127), src.selected)
											else
												if (place)
													src.board_stat = text("[][][]", copytext(src.board_stat, 1, place), src.selected, copytext(src.board_stat, place + 2, 129))
		src.add_fingerprint(usr)
		update()
		for(var/M as mob in viewers(1, src))
			if ((M.client && M.machine == src))
				src.attack_hand(M)
			//Foreach goto(835)
	return

/obj/item/weapon/ex_act(severity)

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

/obj/item/weapon/proc/attack_self()

	return

/obj/item/weapon/proc/talk_into(M as mob, text)

	return

/obj/item/weapon/proc/moved(user as mob, old_loc as turf)

	return

/obj/item/weapon/proc/dropped(user as mob)

	return

/obj/item/weapon/proc/afterattack()

	return
	return

/obj/item/weapon/proc/attack(M as mob, user as mob, def_zone)

	for(var/O as mob in viewers(M, null))
		O.show_message(text("\red <B>[] has been attacked with [][] </B>", M, src, (user ? text(" by [].", user) : ".")), 1)
		//Foreach goto(20)
	var/power = src.force
	if (M.health >= -10.0)
		if (istype(M, /mob/human))
			var/H = M
			var/affecting = H.organs["chest"]
			if (istype(user, /mob/human))
				if (!( def_zone ))
					var/user2 = user
					var/t = user2.zone_sel.selecting
					if ((t in list( "hair", "eyes", "mouth", "neck" )))
						t = "head"
					def_zone = ran_zone(t)
				if (H.organs[text("[]", def_zone)])
					affecting = H.organs[text("[]", def_zone)]
			if (istype(affecting, /obj/item/weapon/organ/external))
				var/b_dam = (src.damtype == "brute" ? src.force : 0)
				var/f_dam = (src.damtype == "fire" ? src.force : 0)
				if (def_zone == "head")
					if ((b_dam && (((H.head && H.head.brute_protect & 1) || (H.wear_mask && H.wear_mask.brute_protect & 1)) && prob(75))))
						if (prob(20))
							affecting.take_damage(power, 0)
						else
							H.show_message("\red You have been protected from a hit to the head.")
						return
					if ((b_dam && prob((src.force + affecting.brute_dam) + affecting.burn_dam)))
						var/time = rand(10, 120)
						if (prob(90))
							if (H.paralysis < time)
								H.paralysis = time
						else
							if (H.weakened < time)
								H.weakened = time
						H.stat = 1
						for(var/O as mob in viewers(M, null))
							O.show_message(text("\red <B>[] has been knocked unconscious!</B>", H), 1, "\red You hear someone fall.", 2)
							//Foreach goto(514)
						H.show_message(text("\red <B>This was a []% hit. Roleplay it! (personality/memory change if the hit was severe enough)</B>", (time * 100) / 120))
					affecting.take_damage(b_dam, f_dam)
				else
					if (def_zone == "chest")
						if ((b_dam && (((H.wear_suit && H.wear_suit.brute_protect & 2) || (H.w_uniform && H.w_uniform.brute_protect & 2)) && prob(90 - src.force))))
							H.show_message("\red You have been protected from a hit to the chest.")
							return
						if ((b_dam && prob((src.force + affecting.brute_dam) + affecting.burn_dam)))
							if (prob(50))
								if (H.weakened < 5)
									H.weakened = 5
								for(var/O as mob in viewers(H, null))
									O.show_message(text("\red <B>[] has been knocked down!</B>", H), 1, "\red You hear someone fall.", 2)
									//Foreach goto(738)
							else
								if (H.stunned < 2)
									H.stunned = 2
								for(var/O as mob in viewers(H, null))
									O.show_message(text("\red <B>[] has been stunned!</B>", H), 1)
									//Foreach goto(808)
							H.stat = 1
						affecting.take_damage(b_dam, f_dam)
					else
						if (def_zone == "diaper")
							if ((b_dam && (((H.wear_suit && H.wear_suit.brute_protect & 4) || (H.w_uniform && H.w_uniform.brute_protect & 4)) && prob(90 - src.force))))
								H.show_message("\red You have been protected from a hit to the lower chest/diaper.")
								return
							if ((b_dam && prob((src.force + affecting.brute_dam) + affecting.burn_dam)))
								if (prob(50))
									if (H.weakened < 5)
										H.weakened = 5
									for(var/O as mob in viewers(H, null))
										O.show_message(text("\red <B>[] has been knocked down!</B>", H), 1, "\red You hear someone fall.", 2)
										//Foreach goto(1014)
								else
									if (H.stunned < 2)
										H.stunned = 2
									for(var/O as mob in viewers(H, null))
										O.show_message(text("\red <B>[] has been stunned!</B>", H), 1)
										//Foreach goto(1084)
								H.stat = 1
							affecting.take_damage(b_dam, f_dam)
						else
							affecting.take_damage(b_dam, f_dam)
			H.UpdateDamageIcon()
		else
			switch(src.damtype)
				if("brute")
					M.bruteloss += power
				if("fire")
					M.fireloss += power
				else
		M.health = (((100 - M.oxyloss) - M.toxloss) - M.fireloss) - M.bruteloss
	src.add_fingerprint(user)
	return

/obj/item/weapon/bedsheet/ex_act(severity)

	if (severity <= 2)
		src = null
		del(src)
		return
	return

/obj/item/weapon/bedsheet/attack_self(user as mob)

	user.drop_item()
	src.layer = 5
	src.add_fingerprint(user)
	return

/obj/item/weapon/bedsheet/burn(fi_amount)

	if (fi_amount > 3.0E7)
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
	return

/obj/item/weapon/wrapping_paper/examine()
	set src in oview(1)

	..()
	usr << text("There is about [] square units of paper left!", src.amount)
	return

/obj/item/weapon/wrapping_paper/attackby(W as obj, user as mob)

	if (!( locate(/obj/table, src.loc) ))
		user << "\blue You MUST put the paper on a table!"
	if (W.w_class < 4)
		if ((istype(user.l_hand, /obj/item/weapon/wirecutters) || istype(user.r_hand, /obj/item/weapon/wirecutters)))
			var/a_used = 2 ** (src.w_class - 1)
			if (src.amount < a_used)
				user << "\blue You need more paper!"
				return
			else
				src.amount -= a_used
				user.drop_item()
				var/obj/item/weapon/gift/G = new /obj/item/weapon/gift( src.loc )
				G.size = W.w_class
				G.w_class = G.size + 1
				G.icon_state = text("gift[]", G.size)
				G.gift = W
				W.loc = G
				G.add_fingerprint(user)
				W.add_fingerprint(user)
				src.add_fingerprint(user)
			if (src.amount <= 0)
				new /obj/item/weapon/c_tube( src.loc )
				src = null
				del(src)
				return
		else
			user << "\blue You need scissors!"
	else
		user << "\blue The object is FAR too large!"
	return

/obj/item/weapon/gift/attack_self(user as mob)

	src.gift.loc = user
	if (user.hand)
		user.l_hand = src.gift
	else
		user.r_hand = src.gift
	src.gift.layer = 20
	src.gift.add_fingerprint(user)
	src = null
	del(src)
	return
	return

/obj/item/weapon/a_gift/ex_act()

	src = null
	del(src)
	return
	return

/obj/item/weapon/a_gift/burn(fi_amount)

	if (fi_amount > 900000.0)
		src = null
		del(src)
		return
	return

/obj/item/weapon/a_gift/attack_self(M as mob)

	switch(pick("pill", "flash", "t_gun", "l_gun", "shield", "sword"))
		if("pill")
			var/obj/item/weapon/m_pill/superpill/W = new /obj/item/weapon/m_pill/superpill( M )
			if (M.hand)
				M.l_hand = W
			else
				M.r_hand = W
			W.layer = 20
			W.add_fingerprint(M)
			src = null
			del(src)
			return
		if("flash")
			var/obj/item/weapon/flash/W = new /obj/item/weapon/flash( M )
			if (M.hand)
				M.l_hand = W
			else
				M.r_hand = W
			W.layer = 20
			W.add_fingerprint(M)
			src = null
			del(src)
			return
		if("l_gun")
			var/obj/item/weapon/gun/energy/laser_gun/W = new /obj/item/weapon/gun/energy/laser_gun( M )
			if (M.hand)
				M.l_hand = W
			else
				M.r_hand = W
			W.layer = 20
			W.add_fingerprint(M)
			src = null
			del(src)
			return
		if("t_gun")
			var/obj/item/weapon/gun/energy/taser_gun/W = new /obj/item/weapon/gun/energy/taser_gun( M )
			if (M.hand)
				M.l_hand = W
			else
				M.r_hand = W
			W.layer = 20
			W.add_fingerprint(M)
			src = null
			del(src)
			return
		if("shield")
			var/obj/item/weapon/shield/W = new /obj/item/weapon/shield( M )
			if (M.hand)
				M.l_hand = W
			else
				M.r_hand = W
			W.layer = 20
			W.add_fingerprint(M)
			src = null
			del(src)
			return
		if("sword")
			var/obj/item/weapon/sword/W = new /obj/item/weapon/sword( M )
			if (M.hand)
				M.l_hand = W
			else
				M.r_hand = W
			W.layer = 20
			W.add_fingerprint(M)
			src = null
			del(src)
			return
		else
	return

/obj/item/weapon/flashbang/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/screwdriver))
		if (src.det_time == 30)
			src.det_time = 30
			user.show_message("\blue You set the flashbang for 3 second detonation time.")
			src.desc = "It is set to detonate in 3 seconds."
		else
			src.det_time = 100
			user.show_message("\blue You set the flashbang for 10 second detonation time.")
			src.desc = "It is set to detonate in 10 seconds."
		src.add_fingerprint(user)
	return

/obj/item/weapon/flashbang/afterattack(target as mob|obj|turf|area, user as mob)

	if (user.equipped() == src)
		if (!( src.state ))
			user << "\red You prime the flashbang! 10 seconds!"
			src.state = 1
			src.icon_state = "flashbang1"
			spawn( src.det_time )
				src.prime()
				return
		user.dir = get_dir(user, target)
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
		src.add_fingerprint(user)
	return

/obj/item/weapon/flashbang/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/flashbang/attack_hand()

	walk(src, null, null)
	src.throwspeed = 20
	..()
	return

/obj/item/weapon/flashbang/proc/prime()

	var/T = get_turf(src)
	T.firelevel = T.poison
	for(var/M as mob in viewers(T, null))
		if (locate(/obj/item/weapon/cloaking_device, M))
			for(var/obj/item/weapon/cloaking_device/S as obj in M)
				S.active = 0
				S.icon_state = "shield0"
				//Foreach goto(72)
		if ((get_dist(M, T) <= 2 || (src.loc == M.loc || src.loc == M)))
			flick("e_flash", M.flash)
			M.stunned = 10
			M.weakened = 3
			M << "\red <B>BANG</B>"
			if ((prob(14) || (M == src.loc && prob(70))))
				M.ear_damage += rand(10, 20)
			else
				if (prob(30))
					M.ear_damage += rand(7, 14)
			if (!( M.paralysis ))
				M.eye_stat += rand(10, 15)
			if (prob(10))
				M.eye_stat += 7
			M.ear_deaf += 30
			if (M == src.loc)
				M.eye_stat += 10
				if (prob(60))
					if (istype(M, /mob/human))
						var/H = M
						if (!( istype(H.ears, /obj/item/weapon/clothing/ears/earmuffs) ))
							M.ear_damage += 15
							M.ear_deaf += 60
					else
						M.ear_damage += 15
						M.ear_deaf += 60
		else
			if (get_dist(M, T) <= 5)
				flick("e_flash", M.flash)
				if (!( istype(M, /mob/human) ))
					M.stunned = 7
					M.weakened = 2
				else
					var/H = M
					M.ear_deaf += 10
					if (prob(20))
						M.ear_damage += 10
					if ((!( istype(H.glasses, /obj/item/weapon/clothing/glasses/sunglasses) ) || M.paralysis))
						M.stunned = 7
						M.weakened = 2
					else
						if (!( M.paralysis ))
							M.eye_stat += rand(1, 3)
				M << "\red <B>BANG</B>"
			else
				if (!( istype(M, /mob/human) ))
					flick("flash", M.flash)
				else
					var/H = M
					if (!( istype(H.glasses, /obj/item/weapon/clothing/glasses/sunglasses) ))
						flick("flash", M.flash)
				M.eye_stat += rand(1, 2)
				M.ear_deaf += 5
				M << "\red <B>BANG</B>"
		if (M.eye_stat >= 20)
			M << "\red Your eyes start to burn badly!"
			M.disabilities |= 1
			if (prob((M.eye_stat - 20) + 1))
				M << "\red You go blind!"
				M.sdisabilities |= 1
		if (M.ear_damage >= 15)
			M << "\red Your ears start to ring badly!"
			if (prob((M.ear_damage - 10) + 5))
				M << "\red You go deaf!"
				M.sdisabilities |= 4
		else
			if (M.ear_damage >= 5)
				M << "\red Your ears start to ring!"
		//Foreach goto(39)
	src = null
	del(src)
	return
	return

/obj/item/weapon/flashbang/attack_self(user as mob)

	if (!( src.state ))
		user << "\red You prime the flashbang! 10 seconds!"
		src.state = 1
		src.icon_state = "flashbang1"
		src.add_fingerprint(user)
		spawn( src.det_time )
			prime()
			return
	return

/obj/item/weapon/flash/attack(M as mob, user as mob)

	if (src.shots > 0)
		var/safety = null
		if (istype(M, /mob/human))
			var/H = M
			if (istype(H.glasses, /obj/item/weapon/clothing/glasses/sunglasses))
				safety = 1
		if (!( safety ))
			M.weakened = 10
			if (M.client)
				if (!( safety ))
					if ((M.eye_stat > 15 && prob(M.eye_stat + 50)))
						flick("e_flash", M.flash)
						M.eye_stat += rand(1, 2)
					else
						flick("flash", M.flash)
						M.eye_stat += rand(0, 2)
					if (M.eye_stat >= 20)
						M << "\red You eyes start to burn badly!"
						M.disabilities |= 1
						if (prob((M.eye_stat - 20) + 1))
							M << "\red You go blind!"
							M.sdisabilities |= 1
		for(var/O as mob in viewers(user, null))
			O.show_message(text("\red [] blinds [] with the flash!", user, M))
			//Foreach goto(229)
	src.attack_self(user, 1)
	return

/obj/item/weapon/flash/attack_self(user as mob, flag)

	if ((world.time + 600) > src.l_time)
		src.shots = 5
	if (src.shots < 1)
		user.show_message("\red *click* *click*", 2)
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	src.l_time = world.time
	src.add_fingerprint(user)
	src.shots--
	flick("flash2", src)
	if (!( flag ))
		for(var/M as mob in oviewers(3, null))
			if (prob(50))
				if (locate(/obj/item/weapon/cloaking_device, M))
					for(var/obj/item/weapon/cloaking_device/S as obj in M)
						S.active = 0
						S.icon_state = "shield0"
						//Foreach goto(201)
			if (M.client)
				var/safety = null
				if (istype(M, /mob/human))
					var/H = M
					if (istype(H.glasses, /obj/item/weapon/clothing/glasses/sunglasses))
						safety = 1
				if (!( safety ))
					flick("flash", M.flash)
			//Foreach goto(160)
	return

/obj/item/weapon/locator/attack_self(user as mob)

	user.machine = src
	if (src.temp)
		var/dat = text("[]<BR><BR><A href='?src=\ref[];temp=1'>Clear</A>", src.temp, src)
	else
		dat = text("<B>Persistent Signal Locator</B><HR>\nFrequency: <A href='?src=\ref[];freq=-1'>-</A><A href='?src=\ref[];freq=-0.2'>-</A> [] <A href='?src=\ref[];freq=0.2'>+</A><A href='?src=\ref[];freq=1'>+</A><BR>\n<A href='?src=\ref[];refresh=1'>Refresh</A>", src, src, src.freq, src, src, src)
	user << browse(dat, "window=radio")
	return

/obj/item/weapon/locator/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["refresh"])
			src.temp = "<B>Persistent Signal Locator</B><HR>"
			var/sr = get_turf(src)
			if (sr)
				src.temp += "<B>Located Beacons:</B><BR>"
				for(var/obj/item/weapon/radio/beacon/W as obj in world)
					if (W.freq == src.freq)
						var/tr = get_turf(W)
						if ((tr.z == sr.z && tr))
							var/direct = max(abs(tr.x - sr.x), abs(tr.y - sr.y))
							if (direct < 5)
								direct = "very strong"
							else
								if (direct < 10)
									direct = "strong"
								else
									if (direct < 20)
										direct = "weak"
									else
										direct = "very weak"
							src.temp += text("[]-[]-[]<BR>", W.code, dir2text(get_dir(sr, tr)), direct)
					//Foreach goto(114)
				src.temp += "<B>Extranneous Signals:</B><BR>"
				for(var/obj/item/weapon/implant/tracking/W as obj in world)
				Label_332:
					if (W.freq == src.freq)
						if ((!( W.implanted ) || !( ismob(W.loc) )))
							goto Label_332
						else
							var/M = W.loc
							if (M.stat == 2)
								if ((M.timeofdeath + 6000) < world.time)
									continue //goto(332)
						var/tr = get_turf(W)
						if ((tr.z == sr.z && tr))
							var/direct = max(abs(tr.x - sr.x), abs(tr.y - sr.y))
							if (direct < 20)
								if (direct < 5)
									direct = "very strong"
								else
									if (direct < 10)
										direct = "strong"
									else
										direct = "weak"
								src.temp += text("[]-[]-[]<BR>", W.id, dir2text(get_dir(sr, tr)), direct)
					//Foreach goto(332)
				src.temp += text("<B>You are at \[[],[],[]\]</B> in orbital coordinates.<BR><BR><A href='?src=\ref[];refresh=1'>Refresh</A><BR>", sr.x, sr.y, sr.z, src)
			else
				src.temp += "<B><FONT color='red'>Processing Error:</FONT></B> Unable to locate orbital position.<BR>"
		else
			if (href_list["freq"])
				src.freq += text2num(href_list["freq"])
				if (((src.freq * 10) % 2) == 0)
					src.freq += 0.1
				src.freq = min(148.9, src.freq)
				src.freq = max(144.1, src.freq)
			else
				if (href_list["temp"])
					src.temp = null
		if (istype(src.loc, /mob))
			attack_self(src.loc)
		else
			for(var/M as mob in viewers(1, src))
				if (M.client)
					src.attack_self(M)
				//Foreach goto(749)
	return

/obj/item/weapon/syndicate_uplink/proc/explode()

	var/T = get_turf(src.loc)
	T.firelevel = T.poison
	T.res_vars()
	var/sw = locate(max(T.x - 4, 1), max(T.y - 4, 1), T.z)
	var/ne = locate(min(T.x + 4, world.maxx), min(T.y + 4, world.maxy), T.z)
	for(var/U as turf in block(sw, ne))
		var/zone = 4
		if ((U.y <= (T.y + 2) && (U.y >= (T.y - 2) && (U.x <= (T.x + 2) && U.x >= (T.x - 2)))))
			zone = 3
		for(var/atom/A as mob|obj|turf|area in U)
			A.ex_act(zone)
			//Foreach goto(209)
		U.ex_act(zone)
		//Foreach goto(109)
	src.master = null
	del(src.master)
	src = null
	del(src)
	return
	return

/obj/item/weapon/syndicate_uplink/attack_self(user as mob)

	user.machine = src
	if (src.selfdestruct)
		var/dat = "Self Destructing..."
	else
		if (src.temp)
			dat = text("[]<BR><BR><A href='?src=\ref[];temp=1'>Clear</A>", src.temp, src)
		else
			dat = text("<B>Syndicate Uplink Console:</B><HR>\nTele-Crystals left: []<BR>\n<B>Request item:</B> (uses 1 tele-crystal)<BR>\n<A href='?src=\ref[];item_emag=1'>Electromagnet Card</A><BR>\n<A href='?src=\ref[];item_sleepypen=1'>Sleepy Pen</A><BR>\n<A href='?src=\ref[];item_cyanide=1'>Cyanide Pill</A><BR>\n<A href='?src=\ref[];item_cloak=1'>Cloaking Device</A><BR>\n<A href='?src=\ref[];item_revolver=1'>Revolver</A><BR>\n<A href='?src=\ref[];item_imp_freedom=1'>Implant- Freedom (with injector)</A><BR>\n<HR>\n<A href='?src=\ref[];selfdestruct=1'>Self-Destruct</A>", src.uses, src, src, src, src, src, src, src)
	user << browse(dat, "window=radio")
	return

/obj/item/weapon/syndicate_uplink/Topic(href, href_list)

	if (usr.stat)
		return
	var/H = usr
	if (!( istype(H, /mob/human) ))
		return 1
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["item_emag"])
			if (src.uses > 0)
				src.uses--
				new /obj/item/weapon/card/emag( H.loc )
		else
			if (href_list["item_sleepypen"])
				if (src.uses > 0)
					src.uses--
					new /obj/item/weapon/pen/sleepypen( H.loc )
			else
				if (href_list["item_cyanide"])
					if (src.uses > 0)
						src.uses--
						new /obj/item/weapon/m_pill/cyanide( H.loc )
				else
					if (href_list["item_cloak"])
						if (src.uses > 0)
							src.uses--
							new /obj/item/weapon/cloaking_device( H.loc )
					else
						if (href_list["item_revolver"])
							if (src.uses > 0)
								src.uses--
								var/obj/item/weapon/gun/revolver/O = new /obj/item/weapon/gun/revolver( H.loc )
								O.bullets = 7
						else
							if (href_list["item_imp_freedom"])
								if (src.uses > 0)
									src.uses--
									var/obj/item/weapon/implanter/O = new /obj/item/weapon/implanter( H.loc )
									O.imp = new /obj/item/weapon/implant/freedom( O )
								src.temp = "The implant is triggered by chuckling and has a random amount of uses."
		if (href_list["selfdestruct"])
			src.temp = text("<A href='?src=\ref[];selfdestruct2=1'>Self-Destruct</A>", src)
		if (href_list["selfdestruct2"])
			src.selfdestruct = 1
			spawn( 30 )
				explode()
				return
		else
			if (href_list["temp"])
				src.temp = null
		if (istype(src.loc, /mob))
			attack_self(src.loc)
		else
			for(var/M as mob in viewers(1, src))
				if (M.client)
					src.attack_self(M)
				//Foreach goto(488)
	return

/obj/item/weapon/sword/attack(target as mob, user as mob)

	..()
	if (user.key == "Exadv1")
		user.next_move = 1
	return

/obj/item/weapon/sword/attack_self(user as mob)

	src.active = !( src.active )
	if (src.active)
		user << "\blue The sword is now active."
		src.force = 40
		src.icon_state = "sword1"
		src.w_class = 4
	else
		user << "\blue The sword can now be concealed."
		src.force = 3
		src.icon_state = "sword0"
		src.w_class = 2
	src.add_fingerprint(user)
	return

/obj/item/weapon/shield/attack_self(user as mob)

	src.active = !( src.active )
	if (src.active)
		user << "\blue The shield is now active."
		src.force = 40
		src.icon_state = "shield1"
	else
		user << "\blue The shield is now inactive."
		src.force = 3
		src.icon_state = "shield0"
	src.add_fingerprint(user)
	return

/obj/item/weapon/cloaking_device/attack_self(user as mob)

	src.active = !( src.active )
	if (src.active)
		user << "\blue The cloaking device is now active."
		src.force = 40
		src.icon_state = "shield1"
	else
		user << "\blue The cloaking device is now inactive."
		src.force = 3
		src.icon_state = "shield0"
	src.add_fingerprint(user)
	return

/obj/item/weapon/ammo/proc/update_icon()

	return

/obj/item/weapon/ammo/a357/update_icon()

	src.icon_state = text("357-[]", src.amount_left)
	src.desc = text("There are [] bullet\s left!", src.amount_left)
	return

/obj/item/weapon/gun/revolver/examine()
	set src in usr

	src.desc = text("There are [] bullet\s left! Uses 357.", src.bullets)
	..()
	return

/obj/item/weapon/gun/revolver/attackby(A as obj, user as mob)

	if (istype(A, /obj/item/weapon/ammo/a357))
		if (src.bullets >= 7)
			user << "\blue It's already fully loaded!"
			return 1
		if (A.amount_left <= 0)
			user << "\red There is no more bullets!"
			return 1
		if (A.amount_left < (7 - src.bullets))
			src.bullets += A.amount_left
			user << text("\red You reload [] bullet\s!", A.amount_left)
			A.amount_left = 0
		else
			user << text("\red You reload [] bullet\s!", 7 - A.bullets)
			A.amount_left -= 7 - A.bullets
			src.bullets = 7
		A.update_icon()
		return 1
	return

/obj/item/weapon/gun/revolver/afterattack(target as mob|obj|turf|area, user as mob, flag)

	if (flag)
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	src.add_fingerprint(user)
	if (src.bullets < 1)
		user.show_message("\red *click* *click*", 2)
		return
	src.bullets--
	for(var/O as mob in viewers(user, null))
		O.show_message(text("\red <B>[] fires a revolver at []!</B>", user, target), 1, "\red You hear a gunshot", 2)
		//Foreach goto(122)
	var/T = user.loc
	var/U = (istype(target, /atom/movable) ? target.loc : target)
	if ((!( U ) || !( T )))
		return
	while(!( istype(U, /turf) ))
		U = U.loc
	if (!( istype(T, /turf) ))
		return
	if (U == T)
		user.las_act()
		return
	var/obj/bullet/A = new /obj/bullet( user.loc )
	if (!( istype(U, /turf) ))
		A = null
		del(A)
		return
	A.current = U
	A.yo = U.y - T.y
	A.xo = U.x - T.x
	user.next_move = world.time + 4
	spawn( 0 )
		A.process()
		return
	return

/obj/item/weapon/gun/revolver/attack(M as mob, user as mob)

	src.add_fingerprint(user)
	var/H = M
	if ((istype(H, /mob/human) && (istype(H, /obj/item/weapon/clothing/head) && (H.flags & 8 && prob(80)))))
		M << "\red The helmet protects you from being hit hard in the head!"
		return
	if ((user.a_intent == "hurt" && src.bullets > 0))
		if (prob(20))
			if (M.paralysis < 10)
				M.paralysis = 10
		else
			if (M.weakened < 10)
				M.weakened = 10
		src.bullets--
		src.force = 75
		..()
		src.force = 60
		M.stat = 1
		for(var/O as mob in viewers(M, null))
			O.show_message(text("\red <B>[] has been shot point-blank by []!</B>", M, user), 1, "\red You hear someone fall", 2)
			//Foreach goto(192)
	else
		if (prob(50))
			if (M.paralysis < 60)
				M.paralysis = 60
		else
			if (M.weakened < 60)
				M.weakened = 60
		src.force = 60
		..()
		M.stat = 1
		for(var/O as mob in viewers(M, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[] has been pistol whipped []!</B>", M, user), 1, "\red You hear someone fall", 2)
			//Foreach goto(315)
	return

/obj/item/weapon/gun/energy/proc/update_icon()

	var/ratio = src.charges / 10
	ratio = round(ratio, 0.25) * 100
	src.icon_state = text("gun[]", ratio)
	return

/obj/item/weapon/gun/energy/laser_gun/afterattack(target as mob|obj|turf|area, user as mob, flag)

	if (flag)
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	src.add_fingerprint(user)
	if (src.charges < 1)
		user.show_message("\red *click* *click*", 2)
		return
	src.charges--
	update_icon()
	var/T = user.loc
	var/U = (istype(target, /atom/movable) ? target.loc : target)
	if ((!( U ) || !( T )))
		return
	while(!( istype(U, /turf) ))
		U = U.loc
	if (!( istype(T, /turf) ))
		return
	if (U == T)
		user.las_act()
		return
	var/obj/beam/a_laser/A = new /obj/beam/a_laser( user.loc )
	if (!( istype(U, /turf) ))
		A = null
		del(A)
		return
	A.current = U
	A.yo = U.y - T.y
	A.xo = U.x - T.x
	user.next_move = world.time + 4
	spawn( 0 )
		A.process()
		return
	return

/obj/item/weapon/gun/energy/laser_gun/attack(M as mob, user as mob)

	..()
	src.add_fingerprint(user)
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
			if (M.weakened < time)
				M.weakened = time
		M.stat = 1
		for(var/O as mob in viewers(M, null))
			O.show_message(text("\red <B>[] has been knocked unconscious!</B>", M), 1, "\red You hear someone fall", 2)
			//Foreach goto(181)
		M.show_message(text("\red <B>This was a []% hit. Roleplay it! (personality/memory change if the hit was severe enough)</B>", (time * 100) / 120))
	return

/obj/item/weapon/gun/energy/taser_gun/update_icon()

	var/ratio = src.charges / 10
	ratio = round(ratio, 0.25) * 100
	src.icon_state = text("t_gun[]", ratio)
	return

/obj/item/weapon/gun/energy/taser_gun/afterattack(target as mob|obj|turf|area, user as mob, flag)

	if (flag)
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	src.add_fingerprint(user)
	if (src.charges < 1)
		user.show_message("\red *click* *click*", 2)
		return
	src.charges--
	update_icon()
	var/T = user.loc
	var/U = (istype(target, /atom/movable) ? target.loc : target)
	if ((!( U ) || !( T )))
		return
	while((!( istype(U, /turf) ) && U))
		U = U.loc
	if (!( istype(T, /turf) ))
		return
	if (U == T)
		user.las_act(1)
		return
	var/obj/beam/a_laser/s_laser/A = new /obj/beam/a_laser/s_laser( user.loc )
	if (!( istype(U, /turf) ))
		A = null
		del(A)
		return
	A.current = U
	A.yo = U.y - T.y
	A.xo = U.x - T.x
	spawn( 0 )
		A.process()
		return
	return

/obj/item/weapon/gun/energy/taser_gun/attack(M as mob, user as mob)

	src.add_fingerprint(user)
	var/H = M
	if ((istype(H, /mob/human) && (istype(H, /obj/item/weapon/clothing/head) && (H.flags & 8 && prob(80)))))
		M << "\red The helmet protects you from being hit hard in the head!"
		return
	if (user.a_intent == "hurt")
		if (prob(20))
			if (M.paralysis < 10)
				M.paralysis = 10
		else
			if (M.weakened < 10)
				M.weakened = 10
		if (M.stuttering < 10)
			M.stuttering = 10
		..()
		M.stat = 1
		for(var/O as mob in viewers(M, null))
			O.show_message(text("\red <B>[] has been knocked unconscious!</B>", M), 1, "\red You hear someone fall", 2)
			//Foreach goto(182)
	else
		if (prob(50))
			if (M.paralysis < 60)
				M.paralysis = 60
		else
			if (M.weakened < 60)
				M.weakened = 60
		if (M.stuttering < 60)
			M.stuttering = 60
		M.stat = 1
		for(var/O as mob in viewers(M, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red <B>[] has been stunned with the taser gun by []!</B>", M, user), 1, "\red You hear someone fall", 2)
			//Foreach goto(309)
	return

/obj/item/weapon/pill_canister/New()

	..()
	src.pixel_x = rand(-10.0, 10)
	src.pixel_y = rand(-10.0, 10)
	return

/obj/item/weapon/pill_canister/placebo/New()

	..()
	spawn( 2 )
		var/obj/item/weapon/m_pill/P = new /obj/item/weapon/m_pill( src )
		P.amount = 30
		return
	return

/obj/item/weapon/pill_canister/antitoxin/New()

	..()
	spawn( 2 )
		var/obj/item/weapon/m_pill/antitoxin/P = new /obj/item/weapon/m_pill/antitoxin( src )
		P.amount = 30
		return
	return

/obj/item/weapon/pill_canister/Tourette/New()

	..()
	spawn( 2 )
		var/obj/item/weapon/m_pill/Tourette/P = new /obj/item/weapon/m_pill/Tourette( src )
		P.amount = 30
		return
	return

/obj/item/weapon/pill_canister/sleep/New()

	..()
	spawn( 2 )
		var/obj/item/weapon/m_pill/sleep/P = new /obj/item/weapon/m_pill/sleep( src )
		P.amount = 30
		return
	return

/obj/item/weapon/pill_canister/epilepsy/New()

	..()
	spawn( 2 )
		var/obj/item/weapon/m_pill/epilepsy/P = new /obj/item/weapon/m_pill/epilepsy( src )
		P.amount = 30
		return
	return

/obj/item/weapon/pill_canister/cough/New()

	..()
	spawn( 2 )
		var/obj/item/weapon/m_pill/cough/P = new /obj/item/weapon/m_pill/cough( src )
		P.amount = 30
		return
	return

/obj/item/weapon/pill_canister/examine()
	set src in view(1)

	..()
	if (src.contents.len)
		var/pills = 0
		for(var/obj/item/weapon/m_pill/M as obj in src)
			pills += M.amount
			//Foreach goto(39)
		usr << text("\blue There are [] pills inside!", pills)
	else
		usr << "\blue It looks empty!"
	return

/obj/item/weapon/pill_canister/attack_paw(user as mob)

	if ((ticker && ticker.mode == "monkey"))
		return src.attack_hand(user)
	return

/obj/item/weapon/pill_canister/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		var/P = pick(src.contents)
		if (P)
			P.amount--
			var/W = new P.type( user )
			if (user.hand)
				user.l_hand = W
			else
				user.r_hand = W
			W.layer = 20
			if (P.amount <= 0)
				P = null
				del(P)
			W.add_fingerprint(user)
			src.add_fingerprint(user)
	else
		return ..()
	return

/obj/item/weapon/pill_canister/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/m_pill))
		var/pills = 0
		for(var/obj/item/weapon/m_pill/M as obj in src)
			pills += M.amount
			//Foreach goto(34)
		if (pills > 30)
			usr << "\blue There are too many pills inside!"
			return
		for(var/obj/item/weapon/m_pill/M as obj in src)
			if (M.type == W.type)
				M.amount += W.amount
				W = null
				del(W)
				return
			//Foreach goto(97)
		if (W)
			user.drop_item()
			W.loc = src
			src.add_fingerprint(user)
			W.add_fingerprint(user)
	if (istype(W, /obj/item/weapon/pen))
		var/t = input(user, "What would you like the label to be?", text("[]", src.name), null)  as text
		if (user.equipped() != W)
			return
		if (src.loc != user)
			return
		t = html_encode(t)
		if (t)
			src.name = text("Pill Canister- '[]'", t)
		else
			src.name = "Pill Canister"
	return

/obj/item/weapon/m_pill/proc/ingest(M as mob)

	src.amount--
	if (src.amount <= 0)
		src = null
		del(src)
		return
	return

/obj/item/weapon/m_pill/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		src.add_fingerprint(user)
		var/F = new src.type( user )
		F.amount = 1
		src.amount--
		if (user.hand)
			user.l_hand = F
		else
			user.r_hand = F
		F.layer = 20
		F.add_fingerprint(user)
		if (src.amount < 1)
			src = null
			del(src)
			return
	else
		..()
	return

/obj/item/weapon/m_pill/attack(M as mob, user as mob)

	if ((user != M && istype(M, /mob/human)))
		for(var/O as mob in viewers(M, null))
			O.show_message(text("\red [] is forcing [] to swallow the []", user, M, src), 1)
			//Foreach goto(41)
		var/obj/equip_e/human/O = new /obj/equip_e/human(  )
		O.source = user
		O.target = M
		O.item = src
		O.s_loc = user.loc
		O.t_loc = M.loc
		O.place = "pill"
		M.requests += O
		spawn( 0 )
			O.process()
			return
	else
		src.add_fingerprint(user)
		ingest(M)
	return

/obj/item/weapon/m_pill/superpill/ingest(M as mob)

	M.fireloss = 0
	M.toxloss = 0
	M.bruteloss = 0
	M.oxyloss = 0
	M.paralysis = 5
	M.stunned = 15
	M.weakened = 10
	M.health = (((100 - M.oxyloss) - M.toxloss) - M.fireloss) - M.bruteloss
	..()
	return

/obj/item/weapon/m_pill/sleep/ingest(M as mob)

	if (M.drowsyness < 600)
		M.drowsyness += 600
		M.drowsyness = min(M.drowsyness, 1800)
	if (prob(25))
		M.paralysis += 60
	else
		if (prob(50))
			M.paralysis += 30
	..()
	return

/obj/item/weapon/m_pill/cyanide/ingest(M as mob)

	if (M.health > -50.0)
		M.toxloss += M.health + 50
	M.health = (((100 - M.oxyloss) - M.toxloss) - M.fireloss) - M.bruteloss
	..()
	return

/obj/item/weapon/m_pill/antitoxin/ingest(M as mob)

	if ((prob(50) && M.drowsyness < 600))
		M.drowsyness += 60
		M.drowsyness = min(M.drowsyness, 600)
	if (M.health >= 0)
		if (M.toxloss <= 20)
			M.toxloss = 0
		else
			M.toxloss -= 20
	M.antitoxs += 600
	M.health = (((100 - M.oxyloss) - M.toxloss) - M.fireloss) - M.bruteloss
	..()
	return

/obj/item/weapon/m_pill/cough/ingest(M as mob)

	if ((prob(75) && M.drowsyness < 600))
		M.drowsyness += 60
		M.drowsyness = min(M.drowsyness, 600)
	M.r_ch_cou += 1200
	..()
	return

/obj/item/weapon/m_pill/epilepsy/ingest(M as mob)

	if (M.drowsyness < 600)
		M.drowsyness += rand(2, 3) * 60
		M.drowsyness = min(M.drowsyness, 600)
	M.r_epil += 1200
	..()
	return

/obj/item/weapon/m_pill/Tourette/ingest(M as mob)

	if (M.drowsyness < 600)
		M.drowsyness += rand(3, 5) * 60
		M.drowsyness = min(M.drowsyness, 600)
	M.r_Tourette += 1200
	..()
	return

/obj/item/weapon/m_pill/examine()
	set src in view(1)

	..()
	usr << text("\blue There are [] pills left on the stack!", src.amount)
	return

/obj/item/weapon/m_pill/attackby(W as obj, user as mob)

	if (!( istype(W, src.type) ))
		return
	if (W.amount == 5)
		return
	if ((W.amount + src.amount) > 5)
		src.amount = (W.amount + src.amount) - 5
		W.amount = 5
	else
		W.amount += W.amount
		src = null
		del(src)
		return
	return

/obj/item/weapon/handcuffs/attack(M as mob, user as mob)

	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	if (istype(M, /mob/human))
		var/obj/equip_e/human/O = new /obj/equip_e/human(  )
		O.source = user
		O.target = M
		O.item = user.equipped()
		O.s_loc = user.loc
		O.t_loc = M.loc
		O.place = "handcuff"
		M.requests += O
		spawn( 0 )
			O.process()
			return
	else
		var/obj/equip_e/monkey/O = new /obj/equip_e/monkey(  )
		O.source = user
		O.target = M
		O.item = user.equipped()
		O.s_loc = user.loc
		O.t_loc = M.loc
		O.place = "handcuff"
		M.requests += O
		spawn( 0 )
			O.process()
			return
	return

/obj/item/weapon/throwing(t_dir, rs)

	if (!( rs ))
		rs = src.r_speed
	..(t_dir, rs)
	return

/obj/item/weapon/examine()
	set src in view()

	switch(src.w_class)
		if(1.0)
			var/t = "tiny"
		if(2.0)
			t = "small"
		if(3.0)
			t = "normal-sized"
		if(4.0)
			t = "bulky"
		if(5.0)
			t = "huge"
		else
	usr << text("This is a \icon[][]. It is a [] item.", src, src.name, t)
	..()
	return

/obj/item/weapon/attack_hand(user as mob)

	if (istype(src.loc, /obj/item/weapon/storage))
		for(var/M as mob in range(1, src.loc))
			if (M.s_active == src.loc)
				if (M.client)
					M.client.screen -= src
			//Foreach goto(34)
	src.throwing = 0
	if (src.loc == user)
		user.u_equip(src)
	if (user.hand)
		user.l_hand = src
	else
		user.r_hand = src
	src.loc = user
	src.layer = 20
	src.add_fingerprint(user)
	user.UpdateClothing()
	return

/obj/item/weapon/attack_paw(user as mob)

	if (istype(src.loc, /obj/item/weapon/storage))
		for(var/M as mob in range(1, src.loc))
			if (M.s_active == src.loc)
				if (M.client)
					M.client.screen -= src
			//Foreach goto(34)
	src.throwing = 0
	if (src.loc == user)
		user.u_equip(src)
	if (user.hand)
		user.l_hand = src
	else
		user.r_hand = src
	src.loc = user
	src.layer = 20
	user.UpdateClothing()
	return

/obj/item/weapon/wire/proc/update()

	if (src.amount > 1)
		src.icon_state = "spool_wire"
		src.desc = text("This is just spool of regular insulated wire. It consists of about [] unit\s of wire.", src.amount)
	else
		src.icon_state = "item_wire"
		src.desc = "This is just a simple piece of regular insulated wire."
	return

/obj/item/weapon/wire/attack_self(user as mob)

	if (src.laying)
		src.laying = 0
		user << "\blue Your done laying wire!"
	else
		user << "\blue You are not using this to lay wire..."
	return

/obj/item/weapon/card/data/verb/label(t as text)
	set src in usr

	if (t)
		src.name = text("Data Disk- '[]'", t)
	else
		src.name = "Data Disk"
	src.add_fingerprint(usr)
	return

/obj/item/weapon/card/id/attack_self(user as mob)

	for(var/O as mob in viewers(user, null))
		O.show_message(text("[] shows you: \icon[] []: assignment: []", user, src, src.name, src.assignment), 1)
		//Foreach goto(20)
	src.add_fingerprint(user)
	return

/obj/item/weapon/card/id/verb/read()
	set src in usr

	usr << text("\icon[] []: The current assignment on the card is [].", src, src.name, src.assignment)
	usr << "\blue The rubric for the 4 access numbers is: general>lab-engine-air"
	return

/obj/item/weapon/rods/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		src.add_fingerprint(user)
		var/obj/item/weapon/rods/F = new /obj/item/weapon/rods( user )
		F.amount = 1
		src.amount--
		if (user.hand)
			user.l_hand = F
		else
			user.r_hand = F
		F.layer = 20
		F.add_fingerprint(user)
		if (src.amount < 1)
			src = null
			del(src)
			return
	else
		..()
	return

/obj/item/weapon/rods/attackby(W as obj, user as mob)

	if (!( istype(W, /obj/item/weapon/rods) ))
		return
	if (W.amount == 6)
		return
	if ((W.amount + src.amount) > 6)
		src.amount = (W.amount + src.amount) - 6
		W.amount = 6
	else
		W.amount += W.amount
		src = null
		del(src)
		return
	return

/obj/item/weapon/rods/examine()
	set src in view(1)

	..()
	usr << text("There are [] rod\s left on the stack.", src.amount)
	return

/obj/item/weapon/rods/attack_self(user as mob)

	if (locate(/obj/grille, usr.loc))
		for(var/obj/grille/G as obj in usr.loc)
			if (G.destroyed)
				G.health = 10
				G.density = 1
				G.destroyed = 0
				G.icon_state = "grille"
				src.amount--
			else
				//Foreach continue //goto(30)
	else
		if (src.amount < 2)
			return
		src.amount -= 2
		new /obj/grille( usr.loc )
	if (src.amount < 1)
		src = null
		del(src)
		return
	src.add_fingerprint(user)
	return

/obj/item/weapon/sheet/metal/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		src.add_fingerprint(user)
		var/obj/item/weapon/sheet/metal/F = new /obj/item/weapon/sheet/metal( user )
		F.amount = 1
		src.amount--
		if (user.hand)
			user.l_hand = F
		else
			user.r_hand = F
		F.layer = 20
		F.add_fingerprint(user)
		if (src.amount < 1)
			src = null
			del(src)
			return
	else
		..()
	src.force = 5
	return

/obj/item/weapon/sheet/metal/attackby(W as obj, user as mob)

	if (!( istype(W, /obj/item/weapon/sheet/metal) ))
		return
	if (W.amount == 5)
		return
	if ((W.amount + src.amount) > 5)
		src.amount = (W.amount + src.amount) - 5
		W.amount = 5
	else
		W.amount += W.amount
		src = null
		del(src)
		return
	return

/obj/item/weapon/sheet/metal/examine()
	set src in view(1)

	..()
	usr << text("There are [] metal sheet\s on the stack.", src.amount)
	return

/obj/item/weapon/sheet/metal/attack_self(user as mob)

	var/t1 = text("<HTML><HEAD></HEAD><TT>Amount Left: [] <BR>", src.amount)
	var/counter = 1
	var/list/L = list(  )
	L["rods"] = "metal rods (makes 2)"
	L["stool"] = "stool"
	L["chair"] = "chair"
	L["table"] = "table parts (2)"
	L["rack"] = "rack parts"
	L["o2can"] = "o2 canister (2)"
	L["plcan"] = "pl canister (2)"
	L["closet"] = "closet (2)"
	L["fl_tiles"] = "floor tiles (makes 4)"
	L["reinforced"] = "reinforced sheet (2) (Doesn't stack)"
	L["repair"] = "repair wall"
	L["construct"] = "construct wall"
	for(var/t in L)
		counter++
		t1 += text("<A href='?src=\ref[];make=[]'>[]</A>  ", src, t, L[t])
		if (counter > 2)
			counter = 1
			t1 += "<BR>"
		//Foreach goto(186)
	t1 += "</TT></HTML>"
	user << browse(t1, "window=met_sheet")
	return

/obj/item/weapon/sheet/metal/Topic(href, href_list)

	if ((usr.restrained() || (usr.stat || usr.equipped() != src)))
		return
	if (href_list["make"])
		if (src.amount < 1)
			src = null
			del(src)
			return
		switch(href_list["make"])
			if("rods")
				src.amount--
				var/obj/item/weapon/rods/R = new /obj/item/weapon/rods( usr.loc )
				R.amount = 2
			if("table")
				if (src.amount < 2)
					return
				src.amount -= 2
				new /obj/item/weapon/table_parts( usr.loc )
			if("stool")
				src.amount--
				new /obj/stool( usr.loc )
			if("chair")
				src.amount--
				var/obj/stool/chair/C = new /obj/stool/chair( usr.loc )
				C.dir = usr.dir
				if (C.dir == NORTH)
					C.layer = 5
			if("rack")
				src.amount--
				new /obj/item/weapon/rack_parts( usr.loc )
			if("o2can")
				if (src.amount < 2)
					return
				src.amount -= 2
				var/obj/machinery/atmoalter/canister/oxygencanister/C = new /obj/machinery/atmoalter/canister/oxygencanister( usr.loc )
				C.gas.oxygen = 0
			if("plcan")
				if (src.amount < 2)
					return
				src.amount -= 2
				var/obj/machinery/atmoalter/canister/poisoncanister/C = new /obj/machinery/atmoalter/canister/poisoncanister( usr.loc )
				C.gas.plasma = 0
			if("reinforced")
				if (src.amount < 2)
					return
				src.amount -= 2
				var/obj/item/weapon/sheet/r_metal/C = new /obj/item/weapon/sheet/r_metal( usr.loc )
				C.amount = 1
			if("closet")
				if (src.amount < 2)
					return
				src.amount -= 2
				new /obj/closet( usr.loc )
			if("fl_tiles")
				src.amount--
				var/obj/item/weapon/tile/R = new /obj/item/weapon/tile( usr.loc )
				R.amount = 4
			if("construct")
				if (src.amount < 2)
					return
				src.amount -= 2
				var/F = get_step(usr, usr.dir)
				if (!( istype(F, /turf/station/floor) ))
					return
				var/turf/station/wall/W = new /turf/station/wall( locate(F.x, F.y, F.z) )
				W.icon_state = "girder"
				W.updatecell = 1
				W.opacity = 0
				W.state = 1
				W.density = 1
			else
				if (src.amount < 2)
					return
				var/W = get_step(usr, usr.dir)
				if (!( istype(W, /turf/station/wall) ))
					return
				src.amount -= 2
				W.icon_state = ""
				W.state = 2
				W.density = 1
				W.opacity = 1
				W.updatecell = 0
		if (src.amount <= 0)
			src = null
			del(src)
			return
	spawn( 0 )
		src.attack_self(usr)
		return
	return

/obj/item/weapon/sheet/glass/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		src.add_fingerprint(user)
		var/obj/item/weapon/sheet/glass/F = new /obj/item/weapon/sheet/glass( user )
		F.amount = 1
		src.amount--
		if (user.hand)
			user.l_hand = F
		else
			user.r_hand = F
		F.layer = 20
		F.add_fingerprint(user)
		if (src.amount < 1)
			src = null
			del(src)
			return
	else
		..()
	src.force = 5
	return

/obj/item/weapon/sheet/glass/attackby(W as obj, user as mob)

	if (!( istype(W, /obj/item/weapon/sheet/glass) ))
		return
	if (W.amount == 5)
		return
	if ((W.amount + src.amount) > 5)
		src.amount = (W.amount + src.amount) - 5
		W.amount = 5
	else
		W.amount += W.amount
		src = null
		del(src)
		return
	return

/obj/item/weapon/sheet/glass/examine()
	set src in view(1)

	..()
	usr << text("There are [] glass sheet\s on the stack.", src.amount)
	return

/obj/item/weapon/sheet/glass/attack_self(user as mob)

	if (!( istype(usr.loc, /turf/station) ))
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	switch(alert("Sheet-Glass", "Would you like full tile glass or one direction?", "one direct", "full (2 sheets)", null, null))
		if("one direct")
			var/obj/window/W = new /obj/window( usr.loc )
			W.anchored = 0
			if (src.amount < 1)
				return
			src.amount--
		if("full (2 sheets)")
			if (src.amount < 2)
				return
			src.amount -= 2
			var/obj/window/W = new /obj/window( usr.loc )
			W.dir = SOUTHWEST
			W.ini_dir = SOUTHWEST
			W.anchored = 0
		else
	if (src.amount <= 0)
		user.u_equip(src)
		src = null
		del(src)
		return
	return

/obj/item/weapon/clipboard/attack_self(user as mob)

	var/dat = "<B>Clipboard</B><BR>"
	if (src.pen)
		dat += text("<A href='?src=\ref[];pen=1'>Remove Pen</A><BR><HR>", src)
	for(var/obj/item/weapon/paper/P as obj in src)
		dat += text("<A href='?src=\ref[];read=\ref[]'>[]</A> <A href='?src=\ref[];write=\ref[]'>Write</A> <A href='?src=\ref[];remove=\ref[]'>Remove</A><BR>", src, P, P.name, src, P, src, P)
		//Foreach goto(42)
	user << browse(dat, "window=clipboard")
	return

/obj/item/weapon/clipboard/Topic(href, href_list)

	if ((usr.stat || usr.restrained()))
		return
	if (usr.contents.Find(src))
		usr.machine = src
		if (href_list["pen"])
			if (src.pen)
				if ((usr.hand && !( usr.l_hand )))
					usr.l_hand = src.pen
					src.pen.loc = usr
					src.pen.layer = 20
					src.pen = null
					usr.UpdateClothing()
				else
					if (!( usr.r_hand ))
						usr.r_hand = src.pen
						src.pen.loc = usr
						src.pen.layer = 20
						src.pen = null
						usr.UpdateClothing()
				if (src.pen)
					src.pen.add_fingerprint(usr)
				src.add_fingerprint(usr)
		if (href_list["remove"])
			var/P = locate(href_list["remove"])
			if ((P && P.loc == src))
				if ((usr.hand && !( usr.l_hand )))
					usr.l_hand = P
					P.loc = usr
					P.layer = 20
					usr.UpdateClothing()
				else
					if (!( usr.r_hand ))
						usr.r_hand = P
						P.loc = usr
						P.layer = 20
						usr.UpdateClothing()
				P.add_fingerprint(usr)
				src.add_fingerprint(usr)
		if (href_list["write"])
			var/P = locate(href_list["write"])
			if ((P && P.loc == src))
				if (istype(usr.r_hand, /obj/item/weapon/pen))
					P.attackby(usr.r_hand, usr)
				else
					if (istype(P.l_hand, /obj/item/weapon/pen))
						P.attackby(P.l_hand, usr)
					else
						if (istype(src.pen, /obj/item/weapon/pen))
							P.attackby(src.pen, usr)
			src.add_fingerprint(usr)
		if (href_list["read"])
			var/P = locate(href_list["read"])
			if ((P && P.loc == src))
				if (!( istype(usr, /mob/human) ))
					usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", P.name, stars(P.info)), text("window=[]", P.name))
				else
					usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", P.name, P.info), text("window=[]", P.name))
		if (ismob(src.loc))
			var/M = src.loc
			if (M.machine == src)
				spawn( 0 )
					src.attack_self(M)
					return
	return

/obj/item/weapon/clipboard/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/clipboard/attack_hand(user as mob)

	if ((locate(/obj/item/weapon/paper, src) && (!( user.equipped() ) && (user.l_hand == src || user.r_hand == src))))
		for(/obj/item/weapon/paper/var/P as obj in src)
			else
			//Foreach goto(50)
		if (P)
			if (user.hand)
				user.l_hand = P
			else
				user.r_hand = P
			P.loc = user
			P.layer = 20
			P.add_fingerprint(user)
			user.UpdateClothing()
		src.add_fingerprint(user)
	else
		if (user.contents.Find(src))
			spawn( 0 )
				src.attack_self(user)
				return
		else
			return ..()
	return

/obj/item/weapon/clipboard/attackby(P as obj, user as mob)

	if (istype(P, /obj/item/weapon/paper))
		if (src.contents.len < 15)
			user.drop_item()
			P.loc = src
			if (istype(P, /obj/item/weapon/paper/flag))
				if (ctf)
					ctf.check_win(src)
		else
			user << "\blue Not enough space!!!"
	else
		if (istype(P, /obj/item/weapon/pen))
			if (!( src.pen ))
				user.drop_item()
				P.loc = src
				src.pen = P
		else
			return
	src.update()
	spawn( 0 )
		attack_self(user)
		return
	return

/obj/item/weapon/clipboard/proc/update()

	src.icon_state = text("clipboard[][]", (locate(/obj/item/weapon/paper, src) ? "1" : "0"), (locate(/obj/item/weapon/pen, src) ? "1" : "0"))
	return

/obj/item/weapon/fcardholder/attack_self(user as mob)

	var/dat = "<B>Clipboard</B><BR>"
	for(var/obj/item/weapon/f_card/P as obj in src)
		dat += text("<A href='?src=\ref[];read=\ref[]'>[]</A> <A href='?src=\ref[];remove=\ref[]'>Remove</A><BR>", src, P, P.name, src, P)
		//Foreach goto(23)
	user << browse(dat, "window=fcardholder")
	return

/obj/item/weapon/fcardholder/Topic(href, href_list)

	if ((usr.stat || usr.restrained()))
		return
	if (usr.contents.Find(src))
		usr.machine = src
		if (href_list["remove"])
			var/P = locate(href_list["remove"])
			if ((P && P.loc == src))
				if ((usr.hand && !( usr.l_hand )))
					usr.l_hand = P
					P.loc = usr
					P.layer = 20
					usr.UpdateClothing()
				else
					if (!( usr.r_hand ))
						usr.r_hand = P
						P.loc = usr
						P.layer = 20
						usr.UpdateClothing()
				src.add_fingerprint(usr)
				P.add_fingerprint(usr)
			src.update()
		if (href_list["read"])
			var/P = locate(href_list["read"])
			if ((P && P.loc == src))
				if (!( istype(usr, /mob/human) ))
					usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", P.name, P.display()), text("window=[]", P.name))
				else
					usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", P.name, P.display()), text("window=[]", P.name))
			src.add_fingerprint(usr)
		if (ismob(src.loc))
			var/M = src.loc
			if (M.machine == src)
				spawn( 0 )
					src.attack_self(M)
					return
	return

/obj/item/weapon/fcardholder/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/fcardholder/attack_hand(user as mob)

	if (user.contents.Find(src))
		spawn( 0 )
			src.attack_self(user)
			return
		src.add_fingerprint(user)
	else
		return ..()
	return

/obj/item/weapon/fcardholder/attackby(P as obj, user as mob)

	if (istype(P, /obj/item/weapon/f_card))
		if (src.contents.len < 30)
			user.drop_item()
			P.loc = src
			add_fingerprint(user)
			src.add_fingerprint(user)
		else
			user << "\blue Not enough space!!!"
	else
		if (istype(P, /obj/item/weapon/pen))
			var/t = input(user, "Holder Label:", text("[]", src.name), null)  as text
			if (user.equipped() != P)
				return
			if ((get_dist(src, usr) > 1 && src.loc != user))
				return
			t = html_encode(t)
			if (t)
				src.name = text("FPCase- '[]'", t)
			else
				src.name = "Finger Print Case"
		else
			return
	src.update()
	spawn( 0 )
		attack_self(user)
		return
	return

/obj/item/weapon/fcardholder/proc/update()

	var/i = 0
	for(var/obj/item/weapon/f_card/F as obj in src)
		i = 1
		else
		//Foreach goto(22)
	src.icon_state = text("fcardholder[]", (i ? "1" : "0"))
	return

/obj/item/weapon/extinguisher/examine()
	set src in usr

	usr << text("\icon[] [] contains [] units of water left!", src, src.name, src.waterleft)
	..()
	return

/obj/item/weapon/extinguisher/afterattack(target as mob|obj|turf|area, user as mob, flag)

	if (src.icon_state == "fire_extinguisher1")
		if (src.waterleft < 1)
			return
		if (world.time < (src.last_use + 20))
			return
		src.last_use = world.time
		if (istype(target, /area))
			return
		var/cur_loc = get_turf(user)
		var/tar_loc = (isturf(target) ? target : get_turf(target))
		if (get_dist(tar_loc, cur_loc) > 1)
			var/list/close = list(  )
			var/list/far = list(  )
			for(var/T as turf in oview(2, tar_loc))
				if (get_dist(T, tar_loc) <= 1)
					close += T
				else
					far += T
				//Foreach goto(147)
			close += tar_loc
			var/t = null
			t = 1
			while(t <= 14)
				var/obj/effects/water/W = new /obj/effects/water( cur_loc )
				if (rand(1, 3) != 1)
					walk_towards(W, pick(close), null)
				else
					walk_towards(W, pick(far), null)
				sleep(1)
				t++
			src.waterleft--
			src.last_use = world.time
		else
			if (cur_loc == tar_loc)
				new /obj/effects/water( cur_loc )
				src.waterleft -= 0.25
				src.last_use = 1
			else
				var/list/possible = list(  )
				for(var/T as turf in oview(1, tar_loc))
					possible += T
					//Foreach goto(366)
				possible += tar_loc
				var/t = null
				t = 1
				while(t <= 7)
					var/obj/effects/water/W = new /obj/effects/water( cur_loc )
					walk_towards(W, pick(possible), null)
					sleep(1)
					t++
				src.waterleft -= 0.5
				src.last_use = world.time
	else
		return ..()
	return

/obj/item/weapon/extinguisher/attack_self(user as mob)

	if (src.icon_state == "fire_extinguisher0")
		src.icon_state = "fire_extinguisher1"
		src.desc = "The safety is off."
	else
		src.icon_state = "fire_extinguisher0"
		src.desc = "The safety is on."
	return

/obj/item/weapon/pen/sleepypen/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/pen/sleepypen/New()

	src.chem = new /obj/substance/chemical(  )
	src.chem.maximum = 5
	var/datum/chemical/s_tox/C = new /datum/chemical/s_tox( null )
	C.moles = (C.density * 5) / C.molarmass
	src.chem.chemicals[text("[]", C.name)] = C
	..()
	return

/obj/item/weapon/pen/sleepypen/attack(M as mob, user as mob)

	if (!( istype(M, /mob) ))
		return
	if (src.desc == "It's a normal black ink pen.")
		return ..()
	if (user)
		for(var/O as mob in viewers(M, null))
			O.show_message(text("\red [] has been stabbed with [] by [].", M, src, user), 1)
			//Foreach goto(57)
		var/amount = src.transfer_mob(M, src.chem.maximum)
		user.show_message(text("\red You inject [] units into the [].", amount, M))
		src.desc = "It's a normal black ink pen."
	return

/obj/item/weapon/paint/attack_self(user as mob)

	var/t1 = input(user, "Please select a color:", "Locking Computer", null) in list( "red", "blue", "green", "yellow", "black", "white", "neutral" )
	if ((user.equipped() != src || (user.stat || user.restrained())))
		return
	src.color = t1
	src.icon_state = text("paint_[]", t1)
	src.add_fingerprint(user)
	return

/obj/item/weapon/paper/burn(fi_amount)

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
	return

/obj/item/weapon/paper/photograph/New()

	..()
	src.pixel_y = 0
	src.pixel_x = 0
	return

/obj/item/weapon/paper/photograph/attack_self(user as mob)

	var/n_name = input(user, "What would you like to label the photo?", "Paper Labelling", null)  as text
	n_name = copytext(n_name, 1, 32)
	if ((src.loc == user && user.stat == 0))
		src.name = text("photo[]", (n_name ? text("- '[]'", n_name) : null))
	src.add_fingerprint(user)
	return

/obj/item/weapon/paper/photograph/examine()
	set src in view()

	..()
	return

/obj/item/weapon/paper/flag/burn()

	return
	return

/obj/item/weapon/paper/flag/New()

	..()
	src.pixel_y = 0
	src.pixel_x = 0
	src.name = "flag- 'FLAG'"
	return

/obj/item/weapon/paper/flag/attack_hand()

	if ((ctf && ctf.immobile))
		return 0
	else
		. = ..()
	return

/obj/item/weapon/paper/flag/attack_self(user as mob)

	var/n_name = input(user, "What would you like to label the paper?", "Paper Labelling", null)  as text
	n_name = copytext(n_name, 1, 32)
	if ((src.loc == user && user.stat == 0))
		src.name = text("flag[]", (n_name ? text("- '[]'", n_name) : null))
	src.add_fingerprint(user)
	return

/obj/item/weapon/paper/flag/attackby(P as obj, user as mob)

	if (istype(P, /obj/item/weapon/pen))
		..()
	else
		if (istype(P, /obj/item/weapon/paint))
			var/C = P
			src.icon_state = text("flag_[]", C.color)
			if (ctf)
				ctf.check_win()
		else
			return
	return

/obj/item/weapon/paper/New()

	..()
	src.pixel_y = rand(1, 16)
	src.pixel_x = rand(1, 16)
	return

/obj/item/weapon/paper/attack_self(user as mob)

	var/n_name = input(user, "What would you like to label the paper?", "Paper Labelling", null)  as text
	n_name = copytext(n_name, 1, 32)
	if ((src.loc == user && user.stat == 0))
		src.name = text("paper[]", (n_name ? text("- '[]'", n_name) : null))
	src.add_fingerprint(user)
	return

/obj/item/weapon/paper/attackby(P as obj, user as mob)

	if (istype(P, /obj/item/weapon/pen))
		var/t = input(user, "What text do you wish to add?", text("[]", src.name), null)  as message
		if ((get_dist(src, usr) > 1 && (src.loc != user && (!( istype(src.loc, /obj/item/weapon/clipboard) ) && (src.loc.loc != user && user.equipped() != P)))))
			return
		t = html_encode(t)
		t = dd_replacetext(t, "\n", "<BR>")
		t = dd_replacetext(t, "\[b\]", "<B>")
		t = dd_replacetext(t, "\[/b\]", "</B>")
		t = dd_replacetext(t, "\[i\]", "<I>")
		t = dd_replacetext(t, "\[/i\]", "</I>")
		t = dd_replacetext(t, "\[u\]", "<U>")
		t = dd_replacetext(t, "\[/u\]", "</U>")
		t = dd_replacetext(t, "\[sign\]", text("<font face=vivaldi>[]</font>", user.rname))
		t = text("<font face=calligrapher>[]</font>", t)
		src.info += t
	else
		if (istype(P, /obj/item/weapon/weldingtool))
			var/W = P
			if ((W.welding && W.weldfuel > 0))
				for(var/O as mob in viewers(user, null))
					O.show_message(text("\red [] burns [] with the welding tool!", user, src), 1, "\red You hear a small burning noise", 2)
					//Foreach goto(323)
				spawn( 0 )
					src.burn(1800000.0)
					return
		else
			if (istype(P, /obj/item/weapon/igniter))
				for(var/O as mob in viewers(user, null))
					O.show_message(text("\red [] burns [] with the igniter!", user, src), 1, "\red You hear a small burning noise", 2)
					//Foreach goto(406)
				spawn( 0 )
					src.burn(1800000.0)
					return
			else
				if (istype(P, /obj/item/weapon/wirecutters))
					for(var/O as mob in viewers(user, null))
						O.show_message(text("\red [] starts cutting []!", user, src), 1)
						//Foreach goto(489)
					sleep(50)
					if (((src.loc == src || get_dist(src, user) <= 1) && (!( user.stat ) && !( restrained() ))))
						for(var/O as mob in viewers(user, null))
							O.show_message(text("\red [] cuts [] to pieces!", user, src), 1)
							//Foreach goto(580)
						src = null
						del(src)
						return
	src.add_fingerprint(user)
	return

/obj/item/weapon/paper/examine()
	set src in view()

	..()
	if (!( istype(usr, /mob/human) ))
		usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", src.name, stars(src.info)), text("window=[]", src.name))
	else
		usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", src.name, src.info), text("window=[]", src.name))
	return

/obj/item/weapon/f_card/examine()
	set src in view(2)

	..()
	usr << text("\blue There are [] on the stack!", src.amount)
	usr << browse(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", src.name, src.display()), text("window=[]", src.name))
	return

/obj/item/weapon/f_card/proc/display()

	if (src.fingerprints)
		var/dat = "<B>Fingerprints on Card</B><HR>"
		var/L = params2list(src.fingerprints)
		for(var/i in L)
			dat += text("[]<BR>", i)
			//Foreach goto(41)
		return dat
	else
		return "<B>There are no fingerprints on this card.</B>"
	return

/obj/item/weapon/f_card/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		src.add_fingerprint(user)
		var/obj/item/weapon/f_card/F = new /obj/item/weapon/f_card( user )
		F.amount = 1
		src.amount--
		if (user.hand)
			user.l_hand = F
		else
			user.r_hand = F
		F.layer = 20
		F.add_fingerprint(user)
		if (src.amount < 1)
			src = null
			del(src)
			return
	else
		..()
	return

/obj/item/weapon/f_card/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/f_card))
		if ((src.fingerprints || W.fingerprints))
			return
		if (src.amount == 10)
			return
		if ((W.amount + src.amount) > 10)
			src.amount = 10
			W.amount = (W.amount + src.amount) - 10
		else
			src.amount += W.amount
			W = null
			del(W)
		src.add_fingerprint(user)
		if (W)
			W.add_fingerprint(user)
	else
		if (istype(W, /obj/item/weapon/pen))
			var/t = input(user, "Card Label:", text("[]", src.name), null)  as text
			if (user.equipped() != W)
				return
			if ((get_dist(src, usr) > 1 && src.loc != user))
				return
			t = html_encode(t)
			if (t)
				src.name = text("FPrintC- '[]'", t)
			else
				src.name = "Finger Print Card"
			W.add_fingerprint(user)
			src.add_fingerprint(user)
	return

/obj/item/weapon/f_card/add_fingerprint()

	..()
	if (src.fingerprints)
		if (src.amount > 1)
			var/obj/item/weapon/f_card/F = new /obj/item/weapon/f_card( (ismob(src.loc) ? src.loc.loc : src.loc) )
			F.amount = --src.amount
			src.amount = 1
		src.icon_state = "f_print_card1"
	return

/obj/item/weapon/f_print_scanner/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/f_card))
		if (W.fingerprints)
			return
		if (src.amount == 20)
			return
		if ((W.amount + src.amount) > 20)
			src.amount = 20
			W.amount = (W.amount + src.amount) - 20
		else
			src.amount += W.amount
			W = null
			del(W)
		src.add_fingerprint(user)
		if (W)
			W.add_fingerprint(user)
	return

/obj/item/weapon/f_print_scanner/attack_self(user as mob)

	src.printing = !( src.printing )
	src.icon_state = text("f_print_scanner[]", src.printing)
	src.add_fingerprint(user)
	return

/obj/item/weapon/f_print_scanner/attack(M as mob, user as mob)

	if ((!( ismob(M) ) || (!( istype(M.primary, /obj/dna) ) || (!( istype(M, /mob/human) ) || M.gloves))))
		user << text("\blue Unable to locate any fingerprints on []!", M)
		return 0
	else
		if ((src.amount < 1 && src.printing))
			user << text("\blue Fingerprints scanned on []. Need more cards to print.", M)
			src.printing = 0
	src.icon_state = text("f_print_scanner[]", src.printing)
	if (src.printing)
		src.amount--
		var/obj/item/weapon/f_card/F = new /obj/item/weapon/f_card( user.loc )
		F.amount = 1
		F.fingerprints = md5(M.primary.uni_identity)
		F.icon_state = "f_print_card1"
		F.name = text("FPrintC- '[]'", M.name)
		user << "\blue Done printing."
	user << text("\blue []'s Fingerprints: []", M, md5(M.primary.uni_identity))
	return

/obj/item/weapon/f_print_scanner/afterattack(A as mob|obj|turf|area, user as mob)

	src.add_fingerprint(user)
	if (!( A.fingerprints ))
		user << "\blue Unable to locate any fingerprints!"
		return 0
	else
		if ((src.amount < 1 && src.printing))
			user << "\blue Fingerprints found. Need more cards to print."
			src.printing = 0
	src.icon_state = text("f_print_scanner[]", src.printing)
	if (src.printing)
		src.amount--
		var/obj/item/weapon/f_card/F = new /obj/item/weapon/f_card( user.loc )
		F.amount = 1
		F.fingerprints = A.fingerprints
		F.icon_state = "f_print_card1"
		user << "\blue Done printing."
	var/L = params2list(A.fingerprints)
	user << text("\blue Isolated [] fingerprints.", L.len)
	for(var/i in L)
		user << text("\blue \t []", i)
		//Foreach goto(186)
	return

/obj/item/weapon/healthanalyzer/attack(M as mob, user as mob)

	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	for(var/O as mob in viewers(M, null))
		O.show_message(text("\red [] has analyzed []'s vitals!", user, M), 1)
		//Foreach goto(67)
	user.show_message(text("\blue Analyzing Results for []:\n\t Overall Status: []", M, (M.stat > 1 ? "dead" : text("[]% healthy", M.health))), 1)
	user.show_message(text("\blue \t Damage Specifics: []-[]-[]-[]", M.oxyloss, M.toxloss, M.fireloss, M.bruteloss), 1)
	user.show_message("\blue Key: Suffocation/Toxin/Burns/Brute", 1)
	if (M.rejuv)
		user.show_message(text("\blue Bloodstream Analysis located [] units of rejuvenation chemicals.", M.rejuv), 1)
	src.add_fingerprint(user)
	return
	return

/obj/item/weapon/analyzer/attack_self(user as mob)

	if (user.stat)
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	var/T = user.loc
	if (!( istype(T, /turf) ))
		return
	if (locate(/obj/move, T))
		T = locate(/obj/move, T)
	var/turf_total = (((T.co2 + T.oxygen) + T.poison) + T.sl_gas) + T.n2
	turf_total = max(turf_total, 1)
	user.show_message("\blue <B>Results:</B>", 1)
	var/t = ""
	var/t1 = (turf_total / 3600000.0) * 100
	if ((90 < t1 && t1 < 110))
		user.show_message(text("\blue Air Pressure: []%", t1), 1)
	else
		user.show_message(text("\blue Air Pressure:\red []%", t1), 1)
	t1 = (T.n2 / turf_total) * 100
	t1 = round(t1, 0.0010)
	if ((60 < t1 && t1 < 80))
		t += text("<font color=blue>Nitrogen: []</font> ", t1)
	else
		t += text("<font color=red>Nitrogen: []</font> ", t1)
	t1 = (T.oxygen / turf_total) * 100
	t1 = round(t1, 0.0010)
	if ((20 < t1 && t1 < 24))
		t += text("<font color=blue>Oxygen: []</font> ", t1)
	else
		t += text("<font color=red>Oxygen: []</font> ", t1)
	t1 = (T.poison / turf_total) * 100
	t1 = round(t1, 0.0010)
	if (t1 < 0.5)
		t += text("<font color=blue>Plasma: []</font> ", t1)
	else
		t += text("<font color=red>Plasma: []</font> ", t1)
	t1 = (T.co2 / turf_total) * 100
	t1 = round(t1, 0.0010)
	if (t1 < 1)
		t += text("<font color=blue>CO2: []</font> ", t1)
	else
		t += text("<font color=red>CO2: []</font> ", t1)
	t1 = (T.sl_gas / turf_total) * 100
	t1 = round(t1, 0.0010)
	if (t1 < 5)
		t += text("<font color=blue>NO2: []</font>", t1)
	else
		t += text("<font color=red>NO2: []</font>", t1)
	user.show_message(t, 1)
	user.show_message(text("\blue \t Temperature: [] C", (T.heat / turf_total) + -254.7), 1)
	src.add_fingerprint(user)
	return

/obj/item/weapon/storage/proc/return_inv()

	var/list/L = list(  )
	for(var/obj/item/weapon/storage/S as obj in src)
		L += S.return_inv()
		//Foreach goto(22)
	return L
	return

/obj/item/weapon/storage/proc/show_to(user as mob)

	user.client.screen -= src.boxes
	user.client.screen -= src.closer
	user.client.screen -= src.contents
	user.client.screen += src.boxes
	user.client.screen += src.closer
	user.client.screen += src.contents
	user.s_active = src
	return

/obj/item/weapon/storage/proc/hide_from(user as mob)

	user.client.screen -= src.boxes
	user.client.screen -= src.closer
	user.client.screen -= src.contents
	return

/obj/item/weapon/storage/proc/close(user as mob)

	src.hide_from(user)
	user.s_active = null
	return

/obj/item/weapon/storage/proc/orient_objs(tx, ty, mx, my)

	var/cx = tx
	var/cy = ty
	src.boxes.screen_loc = text("[],[] to [],[]", tx, ty, mx, my)
	for(var/obj/O as obj in src.contents)
		O.screen_loc = text("[],[]", cx, cy)
		O.layer = 20
		cx++
		if (cx > mx)
			cx = tx
			cy--
		//Foreach goto(56)
	src.closer.screen_loc = text("[],[]", mx, my)
	return

/obj/item/weapon/storage/proc/orient2hud(user as mob)

	if (src == user.l_hand)
		src.orient_objs(3, 11, 3, 4)
	else
		if (src == src.r_hand)
			src.orient_objs(1, 11, 1, 4)
		else
			if (src == src.back)
				src.orient_objs(4, 10, 4, 3)
			else
				src.orient_objs(7, 8, 10, 7)
	return

/obj/item/weapon/storage/lglo_kit/New()

	new /obj/item/weapon/clothing/gloves/latex( src )
	new /obj/item/weapon/clothing/gloves/latex( src )
	new /obj/item/weapon/clothing/gloves/latex( src )
	new /obj/item/weapon/clothing/gloves/latex( src )
	new /obj/item/weapon/clothing/gloves/latex( src )
	new /obj/item/weapon/clothing/gloves/latex( src )
	new /obj/item/weapon/clothing/gloves/latex( src )
	..()
	return

/obj/item/weapon/storage/flashbang_kit/New()

	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	new /obj/item/weapon/flashbang( src )
	..()
	return

/obj/item/weapon/storage/stma_kit/New()

	new /obj/item/weapon/clothing/mask/surgical( src )
	new /obj/item/weapon/clothing/mask/surgical( src )
	new /obj/item/weapon/clothing/mask/surgical( src )
	new /obj/item/weapon/clothing/mask/surgical( src )
	new /obj/item/weapon/clothing/mask/surgical( src )
	new /obj/item/weapon/clothing/mask/surgical( src )
	new /obj/item/weapon/clothing/mask/surgical( src )
	..()
	return

/obj/item/weapon/storage/gl_kit/New()

	new /obj/item/weapon/clothing/glasses/regular( src )
	new /obj/item/weapon/clothing/glasses/regular( src )
	new /obj/item/weapon/clothing/glasses/regular( src )
	new /obj/item/weapon/clothing/glasses/regular( src )
	new /obj/item/weapon/clothing/glasses/regular( src )
	new /obj/item/weapon/clothing/glasses/regular( src )
	new /obj/item/weapon/clothing/glasses/regular( src )
	..()
	return

/obj/item/weapon/storage/trackimp_kit/New()

	new /obj/item/weapon/implantcase/tracking( src )
	new /obj/item/weapon/implantcase/tracking( src )
	new /obj/item/weapon/implantcase/tracking( src )
	new /obj/item/weapon/implantcase/tracking( src )
	new /obj/item/weapon/implanter( src )
	new /obj/item/weapon/implantpad( src )
	new /obj/item/weapon/locator( src )
	..()
	return

/obj/item/weapon/storage/fcard_kit/New()

	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	new /obj/item/weapon/f_card( src )
	..()
	return

/obj/item/weapon/storage/id_kit/New()

	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	new /obj/item/weapon/card/id( src )
	..()
	return

/obj/item/weapon/storage/handcuff_kit/New()

	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	new /obj/item/weapon/handcuffs( src )
	..()
	return

/obj/item/weapon/storage/disk_kit/disks/New()

	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	new /obj/item/weapon/card/data( src )
	..()
	return

/obj/item/weapon/storage/disk_kit/disks2/New()

	spawn( 2 )
		for(var/obj/item/weapon/card/data/D as obj in src.loc)
			D.loc = src
			//Foreach goto(23)
		return
	..()
	return

/obj/item/weapon/storage/backpack/New()

	new /obj/item/weapon/storage/box( src )
	..()
	return

/obj/item/weapon/storage/backpack/MouseDrop(over_object as obj)

	if (src.loc != usr)
		return
	if ((istype(usr, /mob/human) || (ticker && ticker.mode == "monkey")))
		var/M = usr
		if (!( istype(over_object, /obj/screen) ))
			return ..()
		if ((!( M.restrained() ) && (!( M.stat ) && M.back == src)))
			if (over_object.name == "r_hand")
				if (!( M.r_hand ))
					M.u_equip(src)
					M.r_hand = src
			else
				if (M.name == "l_hand")
					if (!( M.l_hand ))
						M.u_equip(src)
						M.l_hand = src
			M.UpdateClothing()
			src.add_fingerprint(usr)
	return

/obj/item/weapon/storage/backpack/attackby(W as obj, user as mob)

	if (src.contents.len >= 7)
		return
	if (W.w_class > 3)
		return
	for(var/obj/item/weapon/O as obj in src)
		var/t += O.w_class
		//Foreach goto(46)
	t += W.w_class
	if (t > 20)
		user << "You cannot fit the item inside. (Remove larger classed items)"
		return
	user.u_equip(W)
	W.loc = src
	if ((user.client && user.s_active != src))
		user.client.screen -= W
	src.orient2hud(user)
	W.dropped()
	add_fingerprint(user)
	for(var/O as mob in viewers(user, null))
		O.show_message(text("\blue [] has added [] to []!", user, W, src), 1)
		//Foreach goto(206)
	return

/obj/item/weapon/storage/attackby(W as obj, user as mob)

	if (src.contents.len >= 7)
		return
	if ((W.w_class >= 3 || istype(W, /obj/item/weapon/storage)))
		return
	user.u_equip(W)
	W.loc = src
	if ((user.client && user.s_active != src))
		user.client.screen -= W
	src.orient2hud(user)
	W.dropped()
	add_fingerprint(user)
	for(var/O as mob in viewers(user, null))
		O.show_message(text("\blue [] has added [] to []!", user, W, src), 1)
		//Foreach goto(139)
	return

/obj/item/weapon/storage/dropped(user as mob)

	src.orient_objs(7, 8, 10, 7)
	return

/obj/item/weapon/storage/MouseDrop(over_object, src_location, over_location)

	..()
	if ((over_object == usr && (get_dist(src, usr) <= 1 || usr.contents.Find(src))))
		if (usr.s_active)
			usr.s_active.close(usr)
		src.show_to(usr)
	return

/obj/item/weapon/storage/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/storage/attack_hand(user as mob)

	if (src.loc == user)
		if (user.s_active)
			user.s_active.close(user)
		src.show_to(user)
	else
		..()
		for(var/M as mob in range(1, null))
			if (M.s_active == src)
				src.close(M)
			//Foreach goto(76)
		src.orient2hud(user)
	src.add_fingerprint(user)
	return

/obj/item/weapon/storage/New()

	src.boxes = new /obj/screen/storage(  )
	src.boxes.name = "storage"
	src.boxes.master = src
	src.boxes.icon_state = "block"
	src.boxes.screen_loc = "7,7 to 10,8"
	src.boxes.layer = 19
	src.closer = new /obj/screen/close(  )
	src.closer.master = src
	src.closer.icon_state = "x"
	src.closer.layer = 20
	spawn( 5 )
		src.orient_objs(7, 8, 10, 7)
		return
	return

/obj/item/weapon/storage/toolbox/New()

	new /obj/item/weapon/screwdriver( src )
	new /obj/item/weapon/wrench( src )
	new /obj/item/weapon/weldingtool( src )
	new /obj/item/weapon/radio( src )
	new /obj/item/weapon/analyzer( src )
	new /obj/item/weapon/extinguisher( src )
	new /obj/item/weapon/wirecutters( src )
	..()
	return

/obj/item/weapon/storage/toolbox/attack(M as mob, user as mob)

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
			O.show_message(text("\red <B>[] has been knocked unconscious!</B>", M), 1, "\red You hear someone fall.", 2)
			//Foreach goto(169)
		M.show_message(text("\red <B>This was a []% hit. Roleplay it! (personality/memory change if the hit was severe enough)</B>", (time * 100) / 120))
	return

/obj/item/weapon/storage/firstaid/fire/New()

	..()
	new /obj/item/weapon/ointment( src )
	new /obj/item/weapon/ointment( src )
	new /obj/item/weapon/ointment( src )
	new /obj/item/weapon/ointment( src )
	new /obj/item/weapon/healthanalyzer( src )
	var/obj/item/weapon/syringe/S = new /obj/item/weapon/syringe( src )
	var/datum/chemical/rejuv/C = new /datum/chemical/rejuv( null )
	C.moles = (C.density * 15) / C.molarmass
	S.chem.chemicals[text("[]", C.name)] = C
	S.icon_state = "syringe_15"
	return

/obj/item/weapon/storage/firstaid/syringes/New()

	..()
	new /obj/item/weapon/syringe( src )
	new /obj/item/weapon/syringe( src )
	new /obj/item/weapon/syringe( src )
	new /obj/item/weapon/syringe( src )
	new /obj/item/weapon/syringe( src )
	new /obj/item/weapon/syringe( src )
	new /obj/item/weapon/syringe( src )
	return

/obj/item/weapon/storage/firstaid/regular/New()

	..()
	new /obj/item/weapon/brutepack( src )
	new /obj/item/weapon/brutepack( src )
	new /obj/item/weapon/brutepack( src )
	new /obj/item/weapon/ointment( src )
	new /obj/item/weapon/ointment( src )
	new /obj/item/weapon/healthanalyzer( src )
	var/obj/item/weapon/syringe/S = new /obj/item/weapon/syringe( src )
	var/datum/chemical/rejuv/C = new /datum/chemical/rejuv( null )
	C.moles = (C.density * 15) / C.molarmass
	S.chem.chemicals[text("[]", C.name)] = C
	S.icon_state = "syringe_15"
	return

/obj/item/weapon/storage/firstaid/toxin/New()

	..()
	new /obj/item/weapon/pill_canister/antitoxin( src )
	new /obj/item/weapon/pill_canister/antitoxin( src )
	var/t = null
	t = 1
	while(t <= 4)
		var/obj/item/weapon/syringe/S = new /obj/item/weapon/syringe( src )
		var/datum/chemical/pl_coag/C = new /datum/chemical/pl_coag( null )
		C.moles = (C.density * 15) / C.molarmass
		S.chem.chemicals[text("[]", C.name)] = C
		S.icon_state = "syringe_15"
		t++
	new /obj/item/weapon/healthanalyzer( src )
	return

/obj/item/weapon/storage/firstaid/attackby(W as obj, user as mob)

	if (src.contents.len >= 7)
		return
	if ((W.w_class >= 2 || istype(W, /obj/item/weapon/storage)))
		return
	..()
	return

/obj/item/weapon/tile/New()

	src.pixel_x = rand(1, 14)
	src.pixel_y = rand(1, 14)
	return

/obj/item/weapon/tile/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		src.add_fingerprint(user)
		var/obj/item/weapon/tile/F = new /obj/item/weapon/tile( user )
		F.amount = 1
		src.amount--
		if (user.hand)
			user.l_hand = F
		else
			user.r_hand = F
		F.layer = 20
		F.add_fingerprint(user)
		if (src.amount < 1)
			src = null
			del(src)
			return
	else
		..()
	return

/obj/item/weapon/tile/proc/build(S as turf)

	var/A = S.loc
	var/turf/station/floor/W = new /turf/station/floor( locate(S.x, S.y, S.z) )
	if (istype(A, /area))
		A.contents -= W
		A.contents += W
	W.oxygen = 0
	return

/obj/item/weapon/tile/attack_self(user as mob)

	if (usr.stat)
		return
	var/T = user.loc
	if (!( istype(T, /turf) ))
		user << "\blue You must be on the ground!"
		return
	else
		var/S = T
		if (!( istype(S, /turf/space) ))
			user << "You cannot build on or repair this turf!"
			return
		else
			src.build(S)
			src.amount--
	if (src.amount < 1)
		user.u_equip(src)
		src = null
		del(src)
		return
	src.add_fingerprint(user)
	return

/obj/item/weapon/tile/attackby(W as obj, user as mob)

	if (!( istype(W, /obj/item/weapon/tile) ))
		return
	if (W.amount == 10)
		return
	W.add_fingerprint(user)
	if ((W.amount + src.amount) > 10)
		src.amount = (W.amount + src.amount) - 10
		W.amount = 10
	else
		W.amount += W.amount
		src = null
		del(src)
		return
	return

/obj/item/weapon/tile/examine()
	set src in view(1)

	..()
	usr << text("There are [] tile\s left on the stack.", src.amount)
	return

/obj/item/weapon/igniter/attackby(W as obj, user as mob)

	if ((istype(W, /obj/item/weapon/radio/signaler) && !( src.status )))
		var/S = W
		if (!( S.b_stat ))
			return
		var/obj/item/weapon/assembly/rad_ignite/R = new /obj/item/weapon/assembly/rad_ignite( user )
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
		src.add_fingerprint(user)
	else
		if ((istype(W, /obj/item/weapon/prox_sensor) && !( src.status )))
			var/obj/item/weapon/assembly/prox_ignite/R = new /obj/item/weapon/assembly/prox_ignite( user )
			W.loc = R
			R.part1 = W
			W.layer = W.initial(W.layer)
			if (user.client)
				user.client.screen -= W
			if (user.r_hand == W)
				u_equip(W)
				user.r_hand = R
			else
				u_equip(W)
				user.l_hand = R
			W.master = R
			src.master = R
			src.layer = initial(src.layer)
			user.u_equip(src)
			if (user.client)
				user.client.screen -= src
			src.loc = R
			R.part2 = src
			R.layer = 20
			R.loc = user
			src.add_fingerprint(user)
	if (!( istype(W, /obj/item/weapon/screwdriver) ))
		return
	src.status = !( src.status )
	if (src.status)
		user.show_message("\blue The igniter is ready!")
	else
		user.show_message("\blue The igniter can now be attached!")
	src.add_fingerprint(user)
	return

/obj/item/weapon/igniter/attack_self(user as mob)

	src.add_fingerprint(user)
	spawn( 5 )
		src.ignite()
		return
	return

/obj/item/weapon/igniter/proc/ignite()

	if (src.status)
		var/T = src.loc
		if (src.master)
			T = src.master.loc
		if (!( istype(T, /turf) ))
			T = T.loc
		if (!( istype(T, /turf) ))
			T = T.loc
		if (locate(/obj/move, T))
			T = locate(/obj/move, T)
		else
			if (!( istype(T, /turf) ))
				return
		if (T.firelevel < 900000.0)
			T.firelevel = T.poison
	return

/obj/item/weapon/igniter/examine()
	set src in view()

	..()
	if ((get_dist(src, usr) <= 1 || src.loc == usr))
		if (src.status)
			usr.show_message("The igniter is ready!")
		else
			usr.show_message("The igniter can be attached!")
	return

/obj/item/weapon/radio/electropack/examine()
	set src in view()

	..()
	if ((get_dist(src, usr) <= 1 || src.loc == usr))
		if (src.e_pads)
			usr << "\blue The electric pads are exposed!"
	return

/obj/item/weapon/radio/electropack/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/radio/electropack/attack_hand(user as mob)

	if (src == user.back)
		user << "\blue You need help taking this off!"
		return
	else
		..()
	return

/obj/item/weapon/radio/electropack/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/screwdriver))
		src.e_pads = !( src.e_pads )
		if (src.e_pads)
			user.show_message("\blue The electric pads have been exposed!")
		else
			user.show_message("\blue The electric pads have been reinserted!")
		src.add_fingerprint(user)
	else
		if (istype(W, /obj/item/weapon/clothing/head/helmet))
			var/obj/item/weapon/assembly/shock_kit/A = new /obj/item/weapon/assembly/shock_kit( user )
			W.loc = A
			A.part1 = W
			W.layer = W.initial(W.layer)
			if (user.client)
				user.client.screen -= W
			if (user.r_hand == W)
				u_equip(W)
				user.r_hand = A
			else
				u_equip(W)
				user.l_hand = A
			W.master = A
			src.master = A
			src.layer = initial(src.layer)
			user.u_equip(src)
			if (user.client)
				user.client.screen -= src
			src.loc = A
			A.part2 = src
			A.layer = 20
			src.add_fingerprint(user)
			A.add_fingerprint(user)
	return

/obj/item/weapon/radio/electropack/Topic(href, href_list)

	if (usr.stat)
		return
	if (((istype(usr, /mob/human) && ((!( ticker ) || (ticker && ticker.mode != "monkey")) && usr.contents.Find(src))) || (usr.contents.Find(src.master) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf)))))
		usr.machine = src
		if (href_list["freq"])
			src.freq += text2num(href_list["freq"])
			if (((src.freq * 10) % 2) == 0)
				src.freq += 0.1
			src.freq = min(148.9, src.freq)
			src.freq = max(144.1, src.freq)
		else
			if (href_list["code"])
				src.code += text2num(href_list["code"])
				src.code = round(src.code)
				src.code = min(100, src.code)
				src.code = max(1, src.code)
			else
				if (href_list["power"])
					src.on = !( src.on )
					src.icon_state = text("electropack[]", src.on)
		if (!( src.master ))
			if (istype(src.loc, /mob))
				attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(308)
		else
			if (istype(src.master.loc, /mob))
				src.attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src.master))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(384)
	else
		usr << browse(null, "window=radio")
		return
	return

/obj/item/weapon/radio/electropack/accept_rad(R as obj, message)

	if ((istype(R, /obj/item/weapon/radio/signaler) && (R.freq == src.freq && R.code == src.code)))
		return 1
	else
		return null
	return

/obj/item/weapon/radio/electropack/r_signal()

	if ((ismob(src.loc) && src.on))
		var/M = src.loc
		var/T = M.loc
		if ((istype(T, /turf) || istype(T, /obj/move)))
			if (M.last_move)
				step(M, M.last_move)
		M.show_message("\red <B>You feel a sharp shock!</B>")
		if (M.weakened < 10)
			M.weakened = 10
	if ((src.master && src.wires & 1))
		src.master.r_signal(1)
	return

/obj/item/weapon/radio/electropack/attack_self(user as mob, flag1)

	if (!( istype(user, /mob/human) ))
		return
	user.machine = src
	var/dat = text("<TT><A href='?src=\ref[];power=1'>[]</A><BR>\n<B>Frequency/Code</B> for electropack:<BR>\nFrequency: <A href='?src=\ref[];freq=-1'>-</A><A href='?src=\ref[];freq=-0.2'>-</A> [] <A href='?src=\ref[];freq=0.2'>+</A><A href='?src=\ref[];freq=1'>+</A><BR>\nCode: <A href='?src=\ref[];code=-5'>-</A><A href='?src=\ref[];code=-1'>-</A> [] <A href='?src=\ref[];code=1'>+</A><A href='?src=\ref[];code=5'>+</A><BR>\n</TT>", src, (src.on ? "Turn Off" : "Turn On"), src, src, src.freq, src, src, src, src, src.code, src, src)
	user << browse(dat, "window=radio")
	return

/obj/item/weapon/radio/proc/accept_rad(R as obj, message)

	if ((R.freq == src.freq && message))
		return 1
	else
		return null
	return

/obj/item/weapon/radio/proc/r_signal()

	return

/obj/item/weapon/radio/proc/send_crackle()

	if ((src.listening && src.wires & 2))
		return hearers(3, src.loc)
	return

/obj/item/weapon/radio/proc/sendm(msg)

	if ((src.listening && src.wires & 2))
		return hearers(1, src.loc)
	return

/obj/item/weapon/radio/examine()
	set src in view()

	..()
	if ((get_dist(src, usr) <= 1 || src.loc == usr))
		if (src.b_stat)
			usr.show_message("\blue The radio can be attached and modified!")
		else
			usr.show_message("\blue The radio can not be modified or attached!")
	return

/obj/item/weapon/radio/attackby(W as obj, user as mob)

	user.machine = src
	if (!( istype(W, /obj/item/weapon/screwdriver) ))
		return
	src.b_stat = !( src.b_stat )
	if (src.b_stat)
		user.show_message("\blue The radio can now be attached and modified!")
	else
		user.show_message("\blue The radio can no longer be modified or attached!")
	for(var/M as mob in viewers(1, src))
		if (M.client)
			src.attack_self(M)
		//Foreach goto(83)
	src.add_fingerprint(user)
	return

/obj/item/weapon/radio/beacon/hear_talk()

	return
	return

/obj/item/weapon/radio/beacon/sendm()

	return null
	return

/obj/item/weapon/radio/beacon/send_crackle()

	return null
	return

/obj/item/weapon/radio/beacon/verb/alter_signal(t as text)
	set src in usr

	if ((usr.canmove && !( usr.restrained() )))
		src.code = t
	if (!( src.code ))
		src.code = "beacon"
	src.add_fingerprint(usr)
	return

/obj/item/weapon/radio/signaler/accept_rad(R as obj, message)

	if ((istype(R, /obj/item/weapon/radio/signaler) && (R.freq == src.freq && R.code == src.code)))
		return 1
	else
		return null
	return

/obj/item/weapon/radio/signaler/examine()
	set src in view()

	..()
	if ((get_dist(src, usr) <= 1 || src.loc == usr))
		if (src.b_stat)
			usr.show_message("\blue The signaler can be attached and modified!")
		else
			usr.show_message("\blue The signaler can not be modified or attached!")
	return

/obj/item/weapon/radio/signaler/attack_self(user as mob, flag1)

	user.machine = src
	if ((src.b_stat && !( flag1 )))
		var/t1 = text("-------<BR>\nGreen Wire: []<BR>\nRed Wire:   []<BR>\nBlue Wire:  []<BR>\n", (src.wires & 4 ? text("<A href='?src=\ref[];wires=4'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=4'>Mend Wire</A>", src)), (src.wires & 2 ? text("<A href='?src=\ref[];wires=2'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=2'>Mend Wire</A>", src)), (src.wires & 1 ? text("<A href='?src=\ref[];wires=1'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=1'>Mend Wire</A>", src)))
	else
		t1 = "-------"
	var/dat = text("<TT>Speaker: []<BR>\n<A href='?src=\ref[];send=1'>Send Signal</A><BR>\n<B>Frequency/Code</B> for signaler:<BR>\nFrequency: <A href='?src=\ref[];freq=-1'>-</A><A href='?src=\ref[];freq=-0.2'>-</A> [] <A href='?src=\ref[];freq=0.2'>+</A><A href='?src=\ref[];freq=1'>+</A><BR>\nCode: <A href='?src=\ref[];code=-5'>-</A><A href='?src=\ref[];code=-1'>-</A> [] <A href='?src=\ref[];code=1'>+</A><A href='?src=\ref[];code=5'>+</A><BR>\n[]</TT>", (src.listening ? text("<A href='?src=\ref[];listen=0'>Engaged</A>", src) : text("<A href='?src=\ref[];listen=1'>Disengaged</A>", src)), src, src, src, src.freq, src, src, src, src, src.code, src, src, t1)
	user << browse(dat, "window=radio")
	return

/obj/item/weapon/radio/signaler/hear_talk()

	return
	return

/obj/item/weapon/radio/signaler/sendm()

	return
	return

/obj/item/weapon/radio/signaler/send_crackle()

	return
	return

/obj/item/weapon/radio/signaler/r_signal(signal)

	if (!( src.wires & 2 ))
		return
	if ((src.master && src.wires & 1))
		src.master.r_signal(signal)
	for(var/O as mob in hearers(1, src.loc))
		O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)
		//Foreach goto(64)
	return

/obj/item/weapon/radio/signaler/proc/s_signal(signal)

	if (signal == null)
		signal = 1
	if (!( src.wires & 4 ))
		return
	for(var/obj/item/weapon/radio/R as obj in world)
		if (R.accept_rad(src))
			spawn( 0 )
				if (R)
					r_signal(signal)
				return
		//Foreach goto(48)
	return

/obj/item/weapon/radio/signaler/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (usr.contents.Find(src.master) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf)))))
		usr.machine = src
		if (href_list["freq"])
			src.freq += text2num(href_list["freq"])
			if (((src.freq * 10) % 2) == 0)
				src.freq += 0.1
			src.freq = min(148.9, src.freq)
			src.freq = max(144.1, src.freq)
		else
			if (href_list["code"])
				src.code += text2num(href_list["code"])
				src.code = round(src.code)
				src.code = min(100, src.code)
				src.code = max(1, src.code)
			else
				if (href_list["send"])
					var/t1 = round(text2num(href_list["send"]))
					spawn( 0 )
						src.s_signal(t1)
						return
				else
					if (href_list["listen"])
						src.listening = text2num(href_list["listen"])
					else
						if (href_list["wires"])
							var/t1 = text2num(href_list["wires"])
							if (!( istype(src.equipped(), /obj/item/weapon/wirecutters) ))
								return
							if ((!( src.b_stat ) && !( src.master )))
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
		src.add_fingerprint(usr)
		if (!( src.master ))
			if (istype(src.loc, /mob))
				attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(501)
		else
			if (istype(src.master.loc, /mob))
				src.attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src.master))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(577)
	else
		usr << browse(null, "window=radio")
		return
	return

/obj/item/weapon/radio/intercom/attack_paw(user as mob)

	if ((ticker && ticker.mode == "monkey"))
		return src.attack_hand(user)
	return

/obj/item/weapon/radio/intercom/attack_hand(user as mob)

	src.add_fingerprint(user)
	spawn( 0 )
		attack_self(user)
		return
	return

/obj/item/weapon/radio/intercom/send_crackle()

	if (src.listening)
		return list(  )
	return

/obj/item/weapon/radio/intercom/sendm(msg)

	if (src.listening)
		return hearers(7, src.loc)
	return

/obj/item/weapon/radio/attack_self(user as mob)

	user.machine = src
	if (src.b_stat)
		var/t1 = text("-------<BR>\nGreen Wire: []<BR>\nRed Wire:   []<BR>\nBlue Wire:  []<BR>\n", (src.wires & 4 ? text("<A href='?src=\ref[];wires=4'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=4'>Mend Wire</A>", src)), (src.wires & 2 ? text("<A href='?src=\ref[];wires=2'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=2'>Mend Wire</A>", src)), (src.wires & 1 ? text("<A href='?src=\ref[];wires=1'>Cut Wire</A>", src) : text("<A href='?src=\ref[];wires=1'>Mend Wire</A>", src)))
	else
		t1 = "-------"
	var/dat = text("<TT>Microphone: []<BR>\nSpeaker: []<BR>\nFrequency: <A href='?src=\ref[];freq=-1'>-</A><A href='?src=\ref[];freq=-0.2'>-</A> [] <A href='?src=\ref[];freq=0.2'>+</A><A href='?src=\ref[];freq=1'>+</A><BR>\n[]</TT>", (src.broadcasting ? text("<A href='?src=\ref[];talk=0'>Engaged</A>", src) : text("<A href='?src=\ref[];talk=1'>Disengaged</A>", src)), (src.listening ? text("<A href='?src=\ref[];listen=0'>Engaged</A>", src) : text("<A href='?src=\ref[];listen=1'>Disengaged</A>", src)), src, src, src.freq, src, src, t1)
	user << browse(dat, "window=radio")
	return

/obj/item/weapon/radio/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["freq"])
			src.freq += text2num(href_list["freq"])
			if (((src.freq * 10) % 2) == 0)
				src.freq += 0.1
			src.freq = min(148.9, src.freq)
			src.freq = max(144.1, src.freq)
		else
			if (href_list["talk"])
				src.broadcasting = text2num(href_list["talk"])
			else
				if (href_list["listen"])
					src.listening = text2num(href_list["listen"])
				else
					if (href_list["wires"])
						var/t1 = text2num(href_list["wires"])
						if (!( istype(src.equipped(), /obj/item/weapon/wirecutters) ))
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
		if (!( src.master ))
			if (istype(src.loc, /mob))
				attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(390)
		else
			if (istype(src.master.loc, /mob))
				src.attack_self(src.loc)
			else
				for(var/M as mob in viewers(1, src.master))
					if (M.client)
						src.attack_self(M)
					//Foreach goto(466)
		src.add_fingerprint(usr)
	else
		usr << browse(null, "window=radio")
		return
	return

/obj/item/weapon/radio/talk_into(M as mob, msg)

	if (!( src.wires & 4 ))
		return
	var/list/receive = list(  )
	var/list/crackle = list(  )
	for(var/obj/item/weapon/radio/R as obj in world)
		if (((src.freq == 0 || R.accept_rad(src, msg)) && src.freq != 5))
			for(var/i as mob in R.sendm(msg))
				receive -= i
				receive += i
				//Foreach goto(118)
			for(var/i as mob in R.send_crackle())
				crackle -= i
				crackle += i
				//Foreach goto(162)
		//Foreach goto(43)
	for(var/i as mob in receive)
		crackle -= i
		//Foreach goto(203)
	for(var/O as mob in crackle)
		O.show_message(text("\icon[] <I>Crackle,Crackle</I>", src), 2)
		//Foreach goto(233)
	if (istype(M, /mob/human))
		for(var/O as mob in receive)
			if (istype(O, /mob/human))
				O.show_message(text("<B>[]-\icon[]\[[]\]-broadcasts</B>: <I>[]</I>", M.rname, src, src.freq, msg), 2)
			else
				O.show_message(text("<B>[]-\icon[]\[[]\]-broadcasts</B>: <I>[]</I>", M.rname, src, src.freq, stars(msg)), 2)
			//Foreach goto(284)
		if (src.freq == 5)
			for(var/O as mob in receive)
				if (istype(O, /mob/human))
					O.show_message(text("<B>[]-\icon[]\[[]\]-broadcasts (over PA)</B>: <I>[]</I>", M.rname, src, src.freq, msg), 2)
				else
					O.show_message(text("<B>[]-\icon[]\[[]\]-broadcasts (over PA)</B>: <I>[]</I>", M.rname, src, src.freq, stars(msg)), 2)
				//Foreach goto(393)
	else
		for(var/O as mob in receive)
			if (istype(O, M))
				O.show_message(text("<B>The monkey-\icon[]\[[]\]-broadcasts</B>: <I>[]</I>", src, src.freq, msg), 2)
			else
				O.show_message(text("<B>The monkey-\icon[]\[[]\]-broadcasts</B>: chimpering", src, src.freq), 2)
			//Foreach goto(492)
		if (src.freq == 5)
			for(var/O as mob in receive)
				if (istype(O, M))
					O.show_message(text("<B>The monkey-\icon[]\[[]\]-broadcasts (over PA)</B>: <I>[]</I>", src, src.freq, msg), 2)
				else
					O.show_message(text("<B>The monkey-\icon[]\[[]\]-broadcasts (over PA)</B>: chimpering", src, src.freq), 2)
				//Foreach goto(585)
	return

/obj/item/weapon/radio/hear_talk(M as mob, msg)

	if (src.broadcasting)
		talk_into(M, msg)
	return

/obj/item/weapon/shard/Bump()

	spawn( 0 )
		if (prob(20))
			src.force = 15
		else
			src.force = 4
		..()
		return
	return

/obj/item/weapon/shard/New()

	src.icon_state = pick("large", "medium", "small")
	switch(src.icon_state)
		if("small")
			src.pixel_x = rand(1, 18)
			src.pixel_y = rand(1, 18)
		if("medium")
			src.pixel_x = rand(1, 16)
			src.pixel_y = rand(1, 16)
		if("large")
			src.pixel_x = rand(1, 10)
			src.pixel_y = rand(1, 5)
		else
	return

/obj/item/weapon/shard/attackby(W as obj, user as mob)

	..()
	if (!( istype(W, /obj/item/weapon/weldingtool) ))
		return
	new /obj/item/weapon/sheet/glass( user.loc )
	src = null
	del(src)
	return
	return

/obj/item/weapon/Bump(M as mob)

	spawn( 0 )
		..()
		if (src.throwing)
			src.throwing = 0
			src.density = 0
			if (istype(M, /obj))
				var/O = M
				for(var/B as mob in viewers(M, null))
					B.show_message(text("\red [] has been hit by [].", M, src), 1)
					//Foreach goto(71)
				O.hitby(src)
			if (!( istype(M, /mob) ))
				return
			for(var/O as mob in viewers(M, null))
				O.show_message(text("\red [] has been hit by [].", M, src), 1)
				//Foreach goto(143)
			if (M.health > -100.0)
				if (istype(M, /mob/human))
					var/H = M
					var/dam_zone = pick("chest", "diaper", "head")
					if (H.organs[text("[]", dam_zone)])
						var/affecting = H.organs[text("[]", dam_zone)]
						if (affecting.take_damage(src.throwforce, 0))
							H.UpdateDamageIcon()
						else
							H.UpdateDamage()
				else
					M.bruteloss += src.throwforce
				M.health = (((100 - M.oxyloss) - M.toxloss) - M.fireloss) - M.bruteloss
		return
	return

/obj/item/weapon/wrench/New()

	if (prob(75))
		src.pixel_x = rand(0, 16)
	return

/obj/item/weapon/screwdriver/New()

	if (prob(75))
		src.pixel_y = rand(0, 16)
	return

/obj/item/weapon/dropper/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/dropper/attack_hand()

	..()
	src.update_is()
	return

/obj/item/weapon/dropper/proc/update_is()

	var/t1 = round(src.chem.volume())
	if (istype(src.loc, /mob))
		if (src.mode == "inject")
			src.icon_state = text("dropper_[]_I", t1)
		else
			src.icon_state = text("dropper_[]_d", t1)
	else
		src.icon_state = text("dropper_[]", t1)
	src.s_istate = "dropper"
	return

/obj/item/weapon/dropper/dropped()

	..()
	src.update_is()
	return

/obj/item/weapon/dropper/attack_self()

	if (src.mode == "inject")
		src.mode = "draw"
	else
		src.mode = "inject"
	src.update_is()
	return

/obj/item/weapon/dropper/New()

	src.chem = new /obj/substance/chemical(  )
	src.chem.maximum = 5
	..()
	return

/obj/item/weapon/dropper/attack(M as mob, user as mob)

	if (!( istype(M, /mob) ))
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	if (user)
		for(var/O as mob in viewers(M, null))
			O.show_message(text("\red [] has been eyedropped with [] by [].", M, src, user), 1)
			//Foreach goto(89)
		var/amount = src.chem.dropper_mob(M, 1)
		src.update_is()
		user.show_message(text("\red You drop [] units into []'s eyes. The dropper contains [] millimeters.", amount, M, src.chem.volume()))
		src.add_fingerprint(user)
	return

/obj/item/weapon/implantcase/proc/update()

	if (src.imp)
		src.icon_state = text("implantcase-[]", src.imp.color)
	else
		src.icon_state = "implantcase-0"
	return

/obj/item/weapon/implantcase/attackby(I as obj, user as mob)

	if (istype(I, /obj/item/weapon/pen))
		var/t = input(user, "What would you like the label to be?", text("[]", src.name), null)  as text
		if (user.equipped() != I)
			return
		if ((get_dist(src, usr) > 1 && src.loc != user))
			return
		t = html_encode(t)
		if (t)
			src.name = text("Glass Case- '[]'", t)
		else
			src.name = "Glass Case"
	else
		if (!( istype(I, /obj/item/weapon/implanter) ))
			return
	if (I.imp)
		if ((src.imp || I.imp.implanted))
			return
		I.imp.loc = src
		src.imp = I.imp
		I.imp = null
		src.update()
		I.update()
	else
		if (src.imp)
			if (I.imp)
				return
			src.imp.loc = I
			I.imp = src.imp
			src.imp = null
			update()
			I.update()
	return

/obj/item/weapon/implantcase/tracking/New()

	src.imp = new /obj/item/weapon/implant/tracking( src )
	..()
	return

/obj/item/weapon/implantpad/proc/update()

	if (src.case)
		src.icon_state = "implantpad-1"
	else
		src.icon_state = "implantpad-0"
	return

/obj/item/weapon/implantpad/attack_hand(user as mob)

	if ((src.case && (user.l_hand == src || user.r_hand == src)))
		if (user.hand)
			user.l_hand = src.case
		else
			user.r_hand = src.case
		src.case.loc = user
		src.case.layer = 20
		src.case.add_fingerprint(user)
		src.case = null
		user.UpdateClothing()
		src.add_fingerprint(user)
		update()
	else
		if (user.contents.Find(src))
			spawn( 0 )
				src.attack_self(user)
				return
		else
			return ..()
	return

/obj/item/weapon/implantpad/attackby(C as obj, user as mob)

	if (istype(C, /obj/item/weapon/implantcase))
		if (!( src.case ))
			user.drop_item()
			C.loc = src
			src.case = C
	else
		return
	src.update()
	return

/obj/item/weapon/implantpad/attack_self(user as mob)

	user.machine = src
	var/dat = "<B>Implant Mini-Computer:</B><HR>"
	if (src.case)
		if (src.case.imp)
			if (istype(src.imp, /obj/item/weapon/implant/tracking))
				var/T = src.imp
				dat += text("<b>Implant Specifications:</b><BR>\n<b>Name:</b> Tracking Beacon<BR>\n<b>Zone:</b> Spinal Column> 2-5 vertebrae<BR>\n<b>Power Source:</b> Nervous System Ion Withdrawl Gradient<BR>\n<b>Life:</b> 10 minutes after death of host<BR>\n<b>Important Notes:</b> None<BR>\n<HR>\n<b>Implant Details:</b> <BR>\n<b>Function:</b> Continuously transmits low power signal on frequency- Useful for tracking.<BR>\nRange: 35-40 meters<BR>\n<b>Special Features:</b><BR>\n<i>Neuro-Safe</i>- Specialized shell absorbs excess voltages self-destructing the chip if\na malfunction occurs thereby securing safety of subject. The implant will melt and\ndisintegrate into bio-safe elements.<BR>\n<b>Integrity:</b> Gradient creates slight risk of being overcharged and frying the\ncircuitry. As a result neurotoxins can cause massive damage.<HR>\nImplant Specifics:\nFrequency (144.1-148.9): <A href='?src=\ref[];freq=-1'>-</A><A href='?src=\ref[];freq=-0.2'>-</A> [] <A href='?src=\ref[];freq=0.2'>+</A><A href='?src=\ref[];freq=1'>+</A><BR>\nID (1-100): <A href='?src=\ref[];id=-10'>-</A><A href='?src=\ref[];id=-1'>-</A> [] <A href='?src=\ref[];id=1'>+</A><A href='?src=\ref[];id=10'>+</A><BR>", src, src, T.freq, src, src, src, src, T.id, src, src)
			else
				if (istype(T.imp, /obj/item/weapon/implant/freedom))
					dat += "<b>Implant Specifications:</b><BR>\n<b>Name:</b> Freedom Beacon<BR>\n<b>Zone:</b> Right Hand> Near wrist<BR>\n<b>Power Source:</b> Lithium Ion Battery<BR>\n<b>Life:</b> optimum 5 uses<BR>\n<b>Important Notes: <font color='red'>Illegal</font></b><BR>\n<HR>\n<b>Implant Details:</b> <BR>\n<b>Function:</b> Transmits a specialized cluster of signals to override handcuff locking\nmechanisms<BR>\n<b>Special Features:</b><BR>\n<i>Neuro-Scan</i>- Analyzes certain shadow signals in the nervous system along the dark\njoy sectors which respond mainly to chuckling<BR>\n<b>Integrity:</b> The battery is extremely weak and commonly after injection its\nlife can drive down to only 1 use.<HR>\nNo Implant Specifics"
				else
					dat += "Implant ID not in database"
		else
			dat += "The implant casing is empty."
	else
		dat += "Please insert an implant casing!"
	user << browse(dat, "window=implantpad")
	return

/obj/item/weapon/implantpad/Topic(href, href_list)

	if (usr.stat)
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["freq"])
			if ((istype(src.case, /obj/item/weapon/implantcase) && istype(src.case.imp, /obj/item/weapon/implant/tracking)))
				var/T = src.case.imp
				T.freq += text2num(href_list["freq"])
				if (((T.freq * 10) % 2) == 0)
					T.freq += 0.1
				T.freq = min(148.9, T.freq)
				T.freq = max(144.1, T.freq)
		if (href_list["id"])
			if ((istype(src.case, /obj/item/weapon/implantcase) && istype(src.case.imp, /obj/item/weapon/implant/tracking)))
				var/T = src.case.imp
				T.id += text2num(href_list["id"])
				T.id = min(100, T.id)
				T.id = max(1, T.id)
		if (istype(src.loc, /mob))
			attack_self(src.loc)
		else
			for(var/M as mob in viewers(1, src))
				if (M.client)
					src.attack_self(M)
				//Foreach goto(290)
		src.add_fingerprint(usr)
	else
		usr << browse(null, "window=implantpad")
		return
	return

/obj/item/weapon/implant/proc/trigger(emote, source as mob)

	return

/obj/item/weapon/implant/freedom/New()

	src.uses = rand(1, 5)
	..()
	return

/obj/item/weapon/implant/freedom/trigger(emote, source as mob)

	if (src.uses < 1)
		return 0
	if (emote == "chuckle")
		src.uses--
		if (source.handcuffed)
			var/W = source.handcuffed
			source.handcuffed = null
			if (source.client)
				source.client.screen -= W
			if (W)
				W.loc = source.loc
				dropped(source)
				if (W)
					W.layer = initial(W.layer)
	return

/obj/item/weapon/implanter/proc/update()

	if (src.imp)
		src.icon_state = "implanter1"
	else
		src.icon_state = "implanter0"
	return

/obj/item/weapon/implanter/attack(M as mob, user as mob)

	if (!( istype(M, /mob) ))
		return
	if ((user && src.imp))
		for(var/O as mob in viewers(M, null))
			O.show_message(text("\red [] has been implanted by [].", M, user), 1)
			//Foreach goto(48)
		src.imp.loc = M
		src.imp.implanted = 1
		src.imp = null
		user.show_message(text("\red You implanted the implant into the [].", M))
		src.icon_state = "implanter0"
	return

/obj/item/weapon/syringe/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/item/weapon/syringe/attack_hand()

	..()
	src.update_is()
	return

/obj/item/weapon/syringe/proc/update_is()

	var/t1 = round(src.chem.volume(), 5)
	if (istype(src.loc, /mob))
		if (src.mode == "inject")
			src.icon_state = text("syringe_[]_I", t1)
		else
			src.icon_state = text("syringe_[]_d", t1)
	else
		src.icon_state = text("syringe_[]", t1)
	src.s_istate = text("syringe_[]", t1)
	return

/obj/item/weapon/syringe/proc/inject(M as mob)

	var/amount = 5
	var/volume = src.chem.volume()
	if (volume < 0.01)
		return
	else
		if (volume < 5.01)
			amount = volume - 0.01
	amount = src.chem.transfer_mob(M, amount)
	src.update_is()
	return amount
	return

/obj/item/weapon/syringe/dropped()

	..()
	src.update_is()
	return

/obj/item/weapon/syringe/attack_self()

	if (src.mode == "inject")
		src.mode = "draw"
	else
		src.mode = "inject"
	src.update_is()
	return

/obj/item/weapon/syringe/New()

	src.chem = new /obj/substance/chemical(  )
	src.chem.maximum = 15
	..()
	return

/obj/item/weapon/syringe/attack(M as mob, user as mob)

	if (!( istype(M, /mob) ))
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	if (user)
		if (istype(M, /mob/human))
			var/obj/equip_e/human/O = new /obj/equip_e/human(  )
			O.source = user
			O.target = M
			O.item = src
			O.s_loc = user.loc
			O.t_loc = M.loc
			O.place = "syringe"
			M.requests += O
			spawn( 0 )
				O.process()
				return
		else
			for(var/O as mob in viewers(M, null))
				O.show_message(text("\red [] has been injected with [] by [].", M, src, user), 1)
				//Foreach goto(192)
			var/amount = src.chem.transfer_mob(M, 5)
			src.update_is()
			user.show_message(text("\red You inject [] units into the []. The syringe contains [] millimeters.", amount, M, src.chem.volume()))
	return

/obj/item/weapon/brutepack/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		src.add_fingerprint(user)
		var/obj/item/weapon/brutepack/F = new /obj/item/weapon/brutepack( user )
		F.amount = 1
		src.amount--
		if (user.hand)
			user.l_hand = F
		else
			user.r_hand = F
		F.layer = 20
		F.add_fingerprint(user)
		if (src.amount < 1)
			src = null
			del(src)
			return
	else
		..()
	return

/obj/item/weapon/brutepack/attack(M as mob, user as mob)

	if (M.health < 0)
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	if (user)
		for(var/O as mob in viewers(M, null))
			O.show_message(text("\red [] has been applied with [] by []", M, src, user), 1)
			//Foreach goto(89)
	if (istype(M, /mob/human))
		var/H = M
		var/affecting = H.organs["chest"]
		if (istype(user, /mob/human))
			var/user2 = user
			var/t = user2.zone_sel.selecting
			if ((t in list( "hair", "eyes", "mouth", "neck" )))
				t = "head"
			if (H.organs[text("[]", t)])
				affecting = H.organs[text("[]", t)]
		else
			if ((!( istype(affecting, /obj/item/weapon/organ/external) ) || affecting.burn_dam <= 0))
				affecting = H.organs["head"]
				if ((!( istype(affecting, /obj/item/weapon/organ/external) ) || affecting.burn_dam <= 0))
					affecting = H.organs["diaper"]
		if (affecting.heal_damage(60, 0))
			H.UpdateDamageIcon()
		else
			H.UpdateDamage()
	M.health = (((100 - M.oxyloss) - M.toxloss) - M.fireloss) - M.bruteloss
	src.amount--
	return

/obj/item/weapon/brutepack/examine()
	set src in view(1)

	..()
	usr << text("\blue there are [] bruise pack\s left on the stack!", src.amount)
	if (src.amount <= 0)
		src = null
		del(src)
		return
	return

/obj/item/weapon/brutepack/attackby(W as obj, user as mob)

	if (!( istype(W, /obj/item/weapon/brutepack) ))
		return
	if (src.amount == 5)
		return
	if ((W.amount + src.amount) > 5)
		src.amount = 5
		W.amount = (W.amount + src.amount) - 5
	else
		src.amount += W.amount
		W = null
		del(W)
	return

/obj/item/weapon/hand_tele/attack_self(user as mob)

	var/list/L = list(  )
	for(var/obj/machinery/teleport/hub/R as obj in world)
		var/com = locate(/obj/machinery/computer/teleporter, locate(R.x - 2, R.y, R.z))
		if (istype(com, /obj/machinery/computer/teleporter))
			L[text("[][]", com.id, (src.icon_state == "tele1" ? " (Active)" : " (Inactive)"))] = com.locked
		//Foreach goto(22)
	var/t1 = input(user, "Please select a location to lock in.", "Locking Computer", null) in L
	if ((user.equipped() != src || (user.stat || user.restrained())))
		return
	var/T = L[t1]
	for(var/O as mob in hearers(user, null))
		O.show_message("\blue Locked In", 2)
		//Foreach goto(192)
	var/obj/portal/P = new /obj/portal( get_turf(src) )
	P.target = T
	src.add_fingerprint(user)
	return

/obj/item/weapon/ointment/attack_hand(user as mob)

	if ((user.r_hand == src || user.l_hand == src))
		src.add_fingerprint(user)
		var/obj/item/weapon/ointment/F = new /obj/item/weapon/ointment( user )
		F.amount = 1
		src.amount--
		if (user.hand)
			user.l_hand = F
		else
			user.r_hand = F
		F.layer = 20
		F.add_fingerprint(user)
		if (src.amount < 1)
			src = null
			del(src)
			return
	else
		..()
	return

/obj/item/weapon/ointment/attack(M as mob, user as mob)

	if (M.health < 0)
		return
	if ((!( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		user << "\red You don't have the dexterity to do this!"
		return
	if (user)
		for(var/O as mob in viewers(M, null))
			if ((O.client && !( O.blinded )))
				O.show_message(text("\red [] has been applied with [] by []", M, src, user), 1)
			//Foreach goto(89)
	if (istype(M, /mob/human))
		var/H = M
		var/affecting = H.organs["chest"]
		if (istype(user, /mob/human))
			var/user2 = user
			var/t = user2.zone_sel.selecting
			if ((t in list( "hair", "eyes", "mouth", "neck" )))
				t = "head"
			if (H.organs[text("[]", t)])
				affecting = H.organs[text("[]", t)]
		else
			if ((!( istype(affecting, /obj/item/weapon/organ/external) ) || affecting.burn_dam <= 0))
				affecting = H.organs["head"]
				if ((!( istype(affecting, /obj/item/weapon/organ/external) ) || affecting.burn_dam <= 0))
					affecting = H.organs["diaper"]
		if (affecting.heal_damage(0, 40))
			H.UpdateDamageIcon()
		else
			H.UpdateDamage()
	src.amount--
	if (src.amount <= 0)
		src = null
		del(src)
		return
	return

/obj/item/weapon/ointment/examine()
	set src in view(1)

	usr << text("\blue there are [] ointment pack\s left on the stack!", src.amount)
	return

/obj/item/weapon/ointment/attackby(W as obj, user as mob)

	if (!( istype(W, /obj/item/weapon/ointment) ))
		return
	if (W.amount == 5)
		return
	if ((W.amount + src.amount) > 5)
		src.amount = (W.amount + src.amount) - 5
		W.amount = 5
	else
		W.amount += W.amount
		src = null
		del(src)
		return
	return

/obj/item/weapon/bottle/examine()
	set src in usr

	usr << text("\blue The bottle \icon[] contains [] millimeters of chemicals", src, round(src.chem.volume(), 0.1))
	return

/obj/item/weapon/bottle/New()

	src.chem = new /obj/substance/chemical(  )
	..()
	return

/obj/item/weapon/bottle/attackby(B as obj, user as mob)

	if (istype(B, /obj/item/weapon/bottle))
		var/t1 = src.chem.maximum
		var/volume = B.chem.volume()
		if (volume < 0.1)
			return
		else
			t1 = volume - 0.1
		t1 = src.chem.transfer_from(B.chem, t1)
		if (t1)
			user.show_message(text("\blue You pour [] unit\s into the bottle. The bottle now contains [] millimeters.", round(t1, 0.1), round(src.chem.volume(), 0.1)))
	if (istype(B, /obj/item/weapon/syringe))
		if (B.mode == "inject")
			var/t1 = 5
			var/volume = B.chem.volume()
			if (volume < 0.01)
				return
			else
				if (volume < 5.01)
					t1 = volume - 0.01
			t1 = src.chem.transfer_from(B.chem, t1)
			B.update_is()
			if (t1)
				user.show_message(text("\blue You inject [] unit\s into the bottle. The syringe contains [] units.", round(t1, 0.1), round(B.chem.volume(), 0.1)))
		else
			var/t1 = 5
			var/volume = src.chem.volume()
			if (volume < 0.05)
				return
			else
				if (volume < 5.05)
					t1 = volume - 0.05
			t1 = B.chem.transfer_from(src.chem, t1)
			B.update_is()
			if (t1)
				user.show_message(text("\blue You draw [] unit\s from the bottle. The syringe contains [] units.", round(t1, 0.1), round(B.chem.volume(), 0.1)))
		src.add_fingerprint(user)
	else
		if (istype(B, /obj/item/weapon/dropper))
			if (B.mode == "inject")
				var/t1 = 1
				var/volume = B.chem.volume()
				if (volume < 0.0050)
					return
				else
					if (volume < 1.005)
						t1 = volume - 0.0050
				t1 = src.chem.transfer_from(B.chem, t1)
				B.update_is()
				if (t1)
					user.show_message(text("\blue You deposit [] unit\s into the bottle. The dropper contains [] units.", round(t1, 0.1), round(B.chem.volume(), 0.1)))
			else
				var/t1 = 1
				var/volume = src.chem.volume()
				if (volume < 0.0050)
					return
				else
					if (volume < 1.005)
						t1 = volume - 0.0050
				t1 = B.chem.transfer_from(src.chem, t1)
				B.update_is()
				if (t1)
					user.show_message(text("\blue You extract [] unit\s from the bottle. The dropper contains [] units.", round(t1, 0.1), round(B.chem.volume(), 0.1)))
	return

/obj/item/weapon/bottle/toxins/New()

	..()
	src.chem.maximum = 60
	var/datum/chemical/l_plas/C = new /datum/chemical/l_plas( null )
	C.moles = (C.density * 50) / C.molarmass
	src.chem.chemicals[text("[]", C.name)] = C
	return

/obj/item/weapon/bottle/antitoxins/New()

	..()
	src.chem.maximum = 60
	var/datum/chemical/pl_coag/C = new /datum/chemical/pl_coag( null )
	C.moles = (C.density * 50) / C.molarmass
	src.chem.chemicals[text("[]", C.name)] = C
	return

/obj/item/weapon/bottle/r_epil/New()

	..()
	src.chem.maximum = 60
	var/datum/chemical/epil/C = new /datum/chemical/epil( null )
	C.moles = (C.density * 50) / C.molarmass
	src.chem.chemicals[text("[]", C.name)] = C
	return

/obj/item/weapon/bottle/r_ch_cough/New()

	..()
	src.chem.maximum = 60
	var/datum/chemical/ch_cou/C = new /datum/chemical/ch_cou( null )
	C.moles = (C.density * 50) / C.molarmass
	src.chem.chemicals[text("[]", C.name)] = C
	return

/obj/item/weapon/bottle/rejuvenators/New()

	..()
	src.chem.maximum = 60
	var/datum/chemical/rejuv/C = new /datum/chemical/rejuv( null )
	C.moles = (C.density * 50) / C.molarmass
	src.chem.chemicals[text("[]", C.name)] = C
	return

/obj/item/weapon/bottle/s_tox/New()

	..()
	src.chem.maximum = 60
	var/datum/chemical/s_tox/C = new /datum/chemical/s_tox( null )
	C.moles = (C.density * 50) / C.molarmass
	src.chem.chemicals[text("[]", C.name)] = C
	return

/obj/item/weapon/bottle/New()

	..()
	src.pixel_y = rand(-8.0, 8)
	src.pixel_x = rand(-8.0, 8)
	return

/obj/item/weapon/weldingtool/examine()
	set src in usr

	usr << text("\icon[] [] contains [] units of fuel left!", src, src.name, src.weldfuel)
	return

/obj/item/weapon/weldingtool/afterattack(O as obj, user as mob)

	if (src.welding)
		src.weldfuel--
		if (src.weldfuel <= 0)
			usr << "\blue Need more fuel!"
			src.welding = 0
			src.force = 3
			src.damtype = "brute"
			src.icon_state = "welder"
		var/location = user.loc
		if (!( istype(location, /turf) ))
			return
		location.firelevel = location.poison + 1
	return

/obj/item/weapon/weldingtool/attack_self(user as mob)

	src.welding = !( src.welding )
	if (src.welding)
		if (src.weldfuel <= 0)
			user << "\blue Need more fuel!"
			src.welding = 0
			return 0
		user << "\blue You will now weld when you attack."
		src.force = 15
		src.damtype = "fire"
		src.icon_state = "welder1"
	else
		user << "\blue Not welding anymore."
		src.force = 3
		src.damtype = "brute"
		src.icon_state = "welder"
	return

/obj/manifest/New()

	src.invisibility = 100
	return

/obj/manifest/proc/manifest()

	var/dat = "<B>Crew Manifest</B>:<BR>"
	for(var/mob/human/M as mob in world)
		if (M.start)
			dat += text("    <B>[]</B> -  []<BR>", M.name, (istype(M.wear_id, /obj/item/weapon/card/id) ? text("[]", M.wear_id.assignment) : "Unknown Position"))
		//Foreach goto(23)
	var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( src.loc )
	P.info = dat
	P.name = "paper- 'Crew Manifest'"
	src = null
	del(src)
	return
	return

/obj/screen/close/DblClick()

	if (src.master)
		src.master.close(usr)
	return

/obj/screen/storage/attackby(W, user as mob)

	src.master.attackby(W, user)
	return

/obj/bedsheetbin/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/bedsheet))
		W = null
		del(W)
		src.amount++
	return

/obj/bedsheetbin/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/bedsheetbin/attack_hand(user as mob)

	if (src.amount >= 1)
		src.amount--
		new /obj/item/weapon/bedsheet( src.loc )
		src.add_fingerprint(user)
	return

/obj/bedsheetbin/examine()
	set src in oview(1)

	src.amount = round(src.amount)
	if (src.amount <= 0)
		src.amount = 0
		usr << "There are no bed sheets in the bin."
	else
		if (src.amount == 1)
			usr << "There is one bed sheet in the bin."
		else
			usr << text("There are [] bed sheets in the bin.", src.amount)
	return

/obj/table/ex_act(severity)

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
				src.density = 0
		else
	return

/obj/table/hand_p(user as mob)

	return src.attack_paw(user)
	return

/obj/table/attack_paw(user as mob)

	if (!( locate(/obj/table, user.loc) ))
		step(user, get_dir(user, src))
		if (user.loc == src.loc)
			user.layer = TURF_LAYER
			for(var/M as mob in viewers(user, null))
				M.show_message("The monkey hides under the table!", 1)
				//Foreach goto(69)
	return

/obj/table/CheckPass(O as mob|obj, target as turf)

	if ((O.flags & 2 || istype(O, /obj/meteor)))
		return 1
	else
		return 0
	return

/obj/table/MouseDrop_T(O as obj, user as mob)

	if ((!( istype(O, /obj/item/weapon) ) || user.equipped() != O))
		return
	user.drop_item()
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/table/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/weapon/table_parts( src.loc )
		src = null
		del(src)
		return
		return
	user.drop_item()
	if (W.loc != src.loc)
		step(W, get_dir(W, src))
	return

/obj/rack/ex_act(severity)

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
				src.icon_state = "rackbroken"
				src.density = 0
		else
	return

/obj/rack/CheckPass(O as mob|obj, target as turf)

	if (O.flags & 2)
		return 1
	else
		return 0
	return

/obj/rack/MouseDrop_T(O as obj, user as mob)

	if ((!( istype(O, /obj/item/weapon) ) || user.equipped() != O))
		return
	user.drop_item()
	if (O.loc != src.loc)
		step(O, get_dir(O, src))
	return

/obj/rack/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/wrench))
		new /obj/item/weapon/rack_parts( src.loc )
		src = null
		del(src)
		return
		return
	user.drop_item()
	if (W.loc != src.loc)
		step(W, get_dir(W, src))
	return

/obj/rack/meteorhit(O as obj)

	if (O.icon_state == "flaming")
		src.icon_state = "rackbroken"
		src.density = 0
	return

/obj/weldfueltank/attackby(W as obj, user as mob)

	if (!( istype(W, /obj/item/weapon/weldingtool) ))
		return
	W.weldfuel = 20
	W.suffix = text("[][]", (W == src ? "equipped " : ""), W.weldfuel)
	user << "\blue Welder refueled"
	return

/obj/weldfueltank/ex_act(severity)

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

/obj/watertank/attackby(W as obj, user as mob)

	if (!( istype(W, /obj/item/weapon/extinguisher) ))
		return
	W.waterleft = 20
	W.suffix = text("[][]", (user.equipped() == src ? "equipped " : ""), W.waterleft)
	user << "\blue Extinguisher refueled"
	return

/obj/watertank/ex_act(severity)

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

/obj/d_girders/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/sheet/metal))
		if (W.amount < 1)
			W = null
			del(W)
			return
		new /obj/machinery/door/false_wall( src.loc )
		W.amount--
		if (W.amount < 1)
			W = null
			del(W)
		user << "\blue Keep in mind when you open it that it MAY be difficult to sldie at first so keep trying."
		src = null
		del(src)
		return
	else
		if (istype(W, /obj/item/weapon/screwdriver))
			new /obj/item/weapon/sheet/metal( src.loc )
			src = null
			del(src)
			return
	return

/obj/barrier/New()

	var/t = 1800
	if (ctf)
		t = round(ctf.barriertime * 600)
	spawn( t )
		src = null
		del(src)
		return
		return
	return

/obj/portal/Bumped(M as mob|obj)

	spawn( 0 )
		src.teleport(M)
		return
	return

/obj/portal/HasEntered(AM as mob|obj)

	spawn( 0 )
		src.teleport(AM)
		return
	return

/obj/portal/New()

	spawn( 300 )
		src = null
		del(src)
		return
		return
	return

/obj/portal/proc/teleport(M as mob|obj)

	if (M.anchored)
		return
	if (src.icon_state == "portal1")
		return
	if (!( src.target ))
		src = null
		del(src)
		return
	var/obj/effects/sparks/O = new /obj/effects/sparks( src.target )
	O.dir = pick(1, 2, 4, 8)
	spawn( 0 )
		O.Life()
		return
	if (istype(M, /atom/movable))
		var/tx = src.target.x + rand(-5.0, 5)
		var/ty = src.y + rand(-5.0, 5)
		if (prob(10))
			src.icon_state = "portal1"
			if (ismob(M))
				M.ex_act(2)
			else
				M.ex_act(1)
		if (rand(1, 1000) <= 10)
			M << "\red You see a fainting blue light."
			M.loc = null
		else
			M.loc = locate(tx, ty, src.target.z)
	return

/obj/effects/water/New()

	..()
	var/T = src.loc
	if (istype(T, /turf))
		T.firelevel = 0
	spawn( 70 )
		src = null
		del(src)
		return
		return
	return

/obj/effects/water/Del()

	var/T = src.loc
	if (istype(T, /turf))
		T.firelevel = 0
	..()
	return

/obj/effects/water/Move()

	..()
	var/T = src.loc
	if (istype(T, /turf))
		T.firelevel = 0
	if (--src.life < 1)
		src = null
		del(src)
		return
	return

/mob/attackby(W as obj, user as mob)

	var/shielded = 0
	for(var/obj/item/weapon/shield/S as obj in src)
		if (S.active)
			shielded = 1
		else
			//Foreach continue //goto(22)
	if (locate(/obj/item/weapon/grab, src))
		var/safe = null
		if (istype(src.l_hand, /obj/item/weapon/grab))
			var/G = src.l_hand
			if ((G.state == 3 && get_dir(src, user) == src.dir))
				safe = G.affecting
		if (istype(src.r_hand, /obj/item/weapon/grab))
			var/G = src.r_hand
			if ((G.state == 3 && get_dir(src, user) == src.dir))
				safe = G.affecting
		if (safe)
			return safe.attackby(W, user)
	if ((!( shielded ) || !( W.flags ) & 32))
		spawn( 0 )
			W.attack(src, user)
			return
	return

/atom/proc/MouseDrop_T()

	return

/atom/proc/attack_hand(user as mob)

	return

/atom/proc/attack_paw(user as mob)

	return

/atom/proc/hand_h(user as mob)

	return

/atom/proc/hand_p(user as mob)

	return

/atom/proc/hitby(W as obj)

	return

/atom/proc/attackby(W as obj, user as mob)

	if (istype(W, /obj/item/weapon/f_print_scanner))
		for(var/O as mob in viewers(src, null))
			if ((O.client && !( O.blinded )))
				O << text("\red [] has been scanned by [] with the []", src, user, W)
			//Foreach goto(31)
	else
		if (!( istype(W, /obj/item/weapon/grab) ))
			for(var/O as mob in viewers(src, null))
				if ((O.client && !( O.blinded )))
					O << text("\red <B>[] has been hit by [] with []</B>", src, user, W)
				//Foreach goto(102)
	return

/atom/proc/add_fingerprint(M as mob)

	if ((!( istype(M, /mob/human) ) || !( istype(M.primary, /obj/dna) )))
		return 0
	if (!( src.flags ) & 256)
		return
	if (M.gloves)
		return 0
	if (!( src.fingerprints ))
		src.fingerprints = text("[]", md5(M.primary.uni_identity))
	else
		var/L = params2list(src.fingerprints)
		L -= md5(M.primary.uni_identity)
		while(L.len >= 3)
			L -= L[1]
		L += md5(M.primary.uni_identity)
		src.fingerprints = list2params(L)
	return

/atom/MouseDrop(over_object as mob|obj|turf|area)

	spawn( 0 )
		if (istype(over_object, /atom))
			over_object.MouseDrop_T(src, usr)
		return
	..()
	return

/atom/DblClick()

	..()
	var/W = usr.equipped()
	if ((W == src && usr.stat == 0))
		spawn( 0 )
			W.attack_self(usr)
			return
		return
	if ((!( usr.canmove ) || usr.stat != 0))
		return
	if ((!( usr.contents.Find(src) ) && (((!( isturf(src) ) && (!( isturf(src.loc) ) && (src.loc && !( isturf(src.loc.loc) )))) || !( isturf(usr.loc) )) && (src.loc != usr.loc && (!( istype(src, /obj/screen) ) && !( usr.contents.Find(src.loc) ))))))
		return
	var/t5 = (get_dist(src, usr) <= 1 || src.loc == usr)
	if ((istype(src, /obj/item/weapon/organ) && usr.contents.Find(src)))
		var/H = usr
		usr << "Betchya think your really smart trying to remvoe your own body parts aren't ya!"
		if (istype(H, /mob/human))
			if (!( (src == H.l_store || src == H.r_store) ))
				return
		else
			return
	if (((t5 || (W && W.flags & 16)) && !( istype(src, /obj/screen) )))
		if (usr.next_move < world.time)
			usr.next_move = world.time + 10
		else
			return
		if ((src.loc && (get_dist(src, usr) < 2 || src.loc == usr.loc)))
			var/direct = get_dir(usr, src)
			var/obj/item/weapon/dummy/D = new /obj/item/weapon/dummy( usr.loc )
			var/ok = 0
			if ((direct - 1) & direct)
				switch(direct)
					if(5.0)
						var/T = get_step(usr, NORTH)
						if (T.Enter(D, src))
							D.loc = T
							T = src.loc
							if (T.Enter(D, src))
								ok = 1
						else
							T = get_step(usr, EAST)
							if (T.Enter(D, src))
								D.loc = T
								T = src.loc
								if (T.Enter(D, src))
									ok = 1
					if(6.0)
						T = get_step(usr, SOUTH)
						if (T.Enter(D, src))
							D.loc = T
							T = src.loc
							if (T.Enter(D, src))
								ok = 1
						else
							T = get_step(usr, EAST)
							if (T.Enter(D, src))
								D.loc = T
								T = src.loc
								if (T.Enter(D, src))
									ok = 1
					if(9.0)
						T = get_step(usr, NORTH)
						if (T.Enter(D, src))
							D.loc = T
							T = src.loc
							if (T.Enter(D, src))
								ok = 1
						else
							T = get_step(usr, WEST)
							if (T.Enter(D, src))
								D.loc = T
								T = src.loc
								if (T.Enter(D, src))
									ok = 1
					if(10.0)
						T = get_step(usr, SOUTH)
						if (T.Enter(D, src))
							D.loc = T
							T = src.loc
							if (T.Enter(D, src))
								ok = 1
						else
							T = get_step(usr, WEST)
							if (T.Enter(D, src))
								D.loc = T
								T = src.loc
								if (T.Enter(D, src))
									ok = 1
					else
			else
				if (src.loc.Enter(D, src))
					ok = 1
				else
					if ((src.flags & 512 && get_dir(src, usr) & src.dir))
						ok = 1
						if (usr.loc != src.loc)
							for(var/atom/A as mob|obj|turf|area in usr.loc)
								if ((!( A.CheckExit(usr, src.loc) ) && A != usr))
									ok = 0
								//Foreach goto(1111)
			D = null
			del(D)
			if (!( ok ))
				return 0
		if (!( usr.restrained() ))
			if (W)
				if (t5)
					src.attackby(W, usr)
				if (W)
					W.afterattack(src, usr, (t5 ? 1 : 0))
			else
				if (istype(usr, /mob/human))
					src.attack_hand(usr, W.hand)
				else
					if (istype(usr, /mob/monkey))
						src.attack_paw(usr, src.hand)
		else
			if (istype(usr, /mob/human))
				src.hand_h(usr, src.hand)
			else
				if (istype(usr, /mob/monkey))
					src.hand_p(usr, src.hand)
	else
		if (istype(src, /obj/screen))
			if (usr.next_move < world.time)
				usr.next_move = world.time + 10
			else
				return
			if (!( usr.restrained() ))
				if ((W && !( istype(src, /obj/screen) )))
					src.attackby(W, usr)
					if (W)
						W.afterattack(src, usr)
				else
					if (istype(usr, /mob/human))
						src.attack_hand(usr, usr.hand)
					else
						if (istype(usr, /mob/monkey))
							src.attack_paw(usr, usr.hand)
			else
				if (istype(usr, /mob/human))
					src.hand_h(usr, src.hand)
				else
					if (istype(usr, /mob/monkey))
						src.hand_p(usr, src.hand)
	return
