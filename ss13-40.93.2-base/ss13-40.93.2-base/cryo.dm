
/obj/machinery/computer/med_data/attack_paw(user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/computer/med_data/attack_hand(mob/user as mob)

	var/dat
	if (src.temp)
		dat = text("<TT>[]</TT><BR><BR><A href='?src=\ref[];temp=1'>Clear Screen</A>", src.temp, src)
	else
		dat = text("Confirm Identity: <A href='?src=\ref[];scan=1'>[]</A><HR>", src, (src.scan ? text("[]", src.scan.name) : "----------"))
		if (src.authenticated)
			switch(src.screen)
				if(1.0)
					dat += text("<A href='?src=\ref[];search=1'>Search Records</A><BR>\n<A href='?src=\ref[];list=1'>List Records</A><BR>\n<BR>\n<A href='?src=\ref[];rec_m=1'>Record Maintenance</A><BR>\n<A href='?src=\ref[];logout=1'>{Log Out}</A><BR>\n", src, src, src, src)
				if(2.0)
					dat += "<B>Record List</B>:<HR>"
					for(var/datum/data/record/R in data_core.general)
						dat += text("<A href='?src=\ref[];d_rec=\ref[]'>[]: []<BR>", src, R, R.fields["id"], R.fields["name"])
						//Foreach goto(132)
					dat += text("<HR><A href='?src=\ref[];main=1'>Back</A>", src)
				if(3.0)
					dat += text("<B>Records Maintenance</B><HR>\n<A href='?src=\ref[];back=1'>Backup To Disk</A><BR>\n<A href='?src=\ref[];u_load=1'>Upload From disk</A><BR>\n<A href='?src=\ref[];del_all=1'>Delete All Records</A><BR>\n<BR>\n<A href='?src=\ref[];main=1'>Back</A>", src, src, src, src)
				if(4.0)
					dat += "<CENTER><B>Medical Record</B></CENTER><BR>"
					if ((istype(src.active1, /datum/data/record) && data_core.general.Find(src.active1)))
						dat += text("Name: [] ID: []<BR>\nSex: <A href='?src=\ref[];field=sex'>[]</A><BR>\nAge: <A href='?src=\ref[];field=age'>[]</A><BR>\nFingerprint: <A href='?src=\ref[];field=fingerprint'>[]</A><BR>\nPhysical Status: <A href='?src=\ref[];field=p_stat'>[]</A><BR>\nMental Status: <A href='?src=\ref[];field=m_stat'>[]</A><BR>", src.active1.fields["name"], src.active1.fields["id"], src, src.active1.fields["sex"], src, src.active1.fields["age"], src, src.active1.fields["fingerprint"], src, src.active1.fields["p_stat"], src, src.active1.fields["m_stat"])
					else
						dat += "<B>General Record Lost!</B><BR>"
					if ((istype(src.active2, /datum/data/record) && data_core.medical.Find(src.active2)))
						dat += text("<BR>\n<CENTER><B>Medical Data</B></CENTER><BR>\nBlood Type: <A href='?src=\ref[];field=b_type'>[]</A><BR>\n<BR>\nMinor Disabilities: <A href='?src=\ref[];field=mi_dis'>[]</A><BR>\nDetails: <A href='?src=\ref[];field=mi_dis_d'>[]</A><BR>\n<BR>\nMajor Disabilities: <A href='?src=\ref[];field=ma_dis'>[]</A><BR>\nDetails: <A href='?src=\ref[];field=ma_dis_d'>[]</A><BR>\n<BR>\nAllergies: <A href='?src=\ref[];field=alg'>[]</A><BR>\nDetails: <A href='?src=\ref[];field=alg_d'>[]</A><BR>\n<BR>\nCurrent Diseases: <A href='?src=\ref[];field=cdi'>[]</A> (per disease info placed in log/comment section)<BR>\nDetails: <A href='?src=\ref[];field=cdi_d'>[]</A><BR>\n<BR>\nImportant Notes:<BR>\n\t<A href='?src=\ref[];field=notes'>[]</A><BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>", src, src.active2.fields["b_type"], src, src.active2.fields["mi_dis"], src, src.active2.fields["mi_dis_d"], src, src.active2.fields["ma_dis"], src, src.active2.fields["ma_dis_d"], src, src.active2.fields["alg"], src, src.active2.fields["alg_d"], src, src.active2.fields["cdi"], src, src.active2.fields["cdi_d"], src, src.active2.fields["notes"])
						var/counter = 1
						while(src.active2.fields[text("com_[]", counter)])
							dat += text("[]<BR><A href='?src=\ref[];del_c=[]'>Delete Entry</A><BR><BR>", src.active2.fields[text("com_[]", counter)], src, counter)
							counter++
						dat += text("<A href='?src=\ref[];add_c=1'>Add Entry</A><BR><BR>", src)
						dat += text("<A href='?src=\ref[];del_r=1'>Delete Record (Medical Only)</A><BR><BR>", src)
					else
						dat += "<B>Medical Record Lost!</B><BR>"
						dat += text("<A href='?src=\ref[];new=1'>New Record</A><BR><BR>", src)
					dat += text("\n<A href='?src=\ref[];print_p=1'>Print Record</A><BR>\n<A href='?src=\ref[];list=1'>Back</A><BR>", src, src)
				else
		else
			dat += text("<A href='?src=\ref[];login=1'>{Log In}</A>", src)
	user << browse(text("<HEAD><TITLE>Medical Records</TITLE></HEAD><TT>[]</TT>", dat), "window=med_rec")
	return

/obj/machinery/computer/med_data/Topic(href, href_list)

	if (!( data_core.general.Find(src.active1) ))
		src.active1 = null
	if (!( data_core.medical.Find(src.active2) ))
		src.active2 = null
	if ((usr.stat || usr.restrained()))
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["temp"])
			src.temp = null
		if (href_list["scan"])
			if (src.scan)
				src.scan.loc = src.loc
				src.scan = null
			else
				var/obj/item/I = usr.equipped()
				if (istype(I, /obj/item/weapon/card/id))
					usr.drop_item()
					I.loc = src
					src.scan = I
		else
			if (href_list["logout"])
				src.authenticated = null
				src.screen = null
				src.active1 = null
				src.active2 = null
			else
				if (href_list["login"])
					if (istype(src.scan, /obj/item/weapon/card/id))
						src.active1 = null
						src.active2 = null
						var/list/L = list( "Medical Researcher", "Medical Doctor", "Head of Personnel", "Captain" )
						if (L.Find(src.scan.assignment))
							src.authenticated = src.scan.registered
							src.rank = src.scan.assignment
							src.screen = 1
		if (src.authenticated)
			if (href_list["list"])
				src.screen = 2
				src.active1 = null
				src.active2 = null
			else
				if (href_list["rec_m"])
					src.screen = 3
					src.active1 = null
					src.active2 = null
				else
					if (href_list["del_all"])
						src.temp = text("Are you sure you wish to delete all records?<br>\n\t<A href='?src=\ref[];temp=1;del_all2=1'>Yes</A><br>\n\t<A href='?src=\ref[];temp=1'>No</A><br>", src, src)
					else
						if (href_list["del_all2"])
							for(var/datum/data/record/R in data_core.medical)
								//R = null
								del(R)
								//Foreach goto(494)
							src.temp = "All records deleted."
						else
							if (href_list["main"])
								src.screen = 1
								src.active1 = null
								src.active2 = null
							else
								if (href_list["field"])
									var/a1 = src.active1
									var/a2 = src.active2
									switch(href_list["field"])
										if("fingerprint")
											if (istype(src.active1, /datum/data/record))
												var/t1 = input("Please input fingerprint hash:", "Med. records", src.active1.fields["id"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active1 != a1))
													return
												src.active1.fields["fingerprint"] = t1
										if("sex")
											if (istype(src.active1, /datum/data/record))
												if (src.active1.fields["sex"] == "Male")
													src.active1.fields["sex"] = "Female"
												else
													src.active1.fields["sex"] = "Male"
										if("age")
											if (istype(src.active1, /datum/data/record))
												var/t1 = input("Please input age:", "Med. records", src.active1.fields["age"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active1 != a1))
													return
												src.active1.fields["age"] = t1
										if("mi_dis")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please input minor disabilities list:", "Med. records", src.active2.fields["mi_dis"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["mi_dis"] = t1
										if("mi_dis_d")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize minor dis.:", "Med. records", src.active2.fields["mi_dis_d"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["mi_dis_d"] = t1
										if("ma_dis")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please input major diabilities list:", "Med. records", src.active2.fields["ma_dis"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["ma_dis"] = t1
										if("ma_dis_d")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize major dis.:", "Med. records", src.active2.fields["ma_dis_d"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["ma_dis_d"] = t1
										if("alg")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please state allergies:", "Med. records", src.active2.fields["alg"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["alg"] = t1
										if("alg_d")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize allergies:", "Med. records", src.active2.fields["alg_d"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["alg_d"] = t1
										if("cdi")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please state diseases:", "Med. records", src.active2.fields["cdi"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["cdi"] = t1
										if("cdi_d")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize diseases:", "Med. records", src.active2.fields["cdi_d"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["cdi_d"] = t1
										if("notes")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize notes:", "Med. records", src.active2.fields["notes"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["notes"] = t1
										if("p_stat")
											if (istype(src.active1, /datum/data/record))
												src.temp = text("<B>Physical Condition:</B><BR>\n\t<A href='?src=\ref[];temp=1;p_stat=deceased'>*Deceased*</A><BR>\n\t<A href='?src=\ref[];temp=1;p_stat=unconscious'>*Unconscious*</A><BR>\n\t<A href='?src=\ref[];temp=1;p_stat=active'>Active</A><BR>\n\t<A href='?src=\ref[];temp=1;p_stat=unfit'>Physically Unfit</A><BR>", src, src, src, src)
										if("m_stat")
											if (istype(src.active1, /datum/data/record))
												src.temp = text("<B>Mental Condition:</B><BR>\n\t<A href='?src=\ref[];temp=1;m_stat=insane'>*Insane*</A><BR>\n\t<A href='?src=\ref[];temp=1;m_stat=unstable'>*Unstable*</A><BR>\n\t<A href='?src=\ref[];temp=1;m_stat=watch'>*Watch*</A><BR>\n\t<A href='?src=\ref[];temp=1;m_stat=stable'>Stable</A><BR>", src, src, src, src)
										if("b_type")
											if (istype(src.active2, /datum/data/record))
												src.temp = text("<B>Blood Type:</B><BR>\n\t<A href='?src=\ref[];temp=1;b_type=an'>A-</A> <A href='?src=\ref[];temp=1;b_type=ap'>A+</A><BR>\n\t<A href='?src=\ref[];temp=1;b_type=bn'>B-</A> <A href='?src=\ref[];temp=1;b_type=bp'>B+</A><BR>\n\t<A href='?src=\ref[];temp=1;b_type=abn'>AB-</A> <A href='?src=\ref[];temp=1;b_type=abp'>AB+</A><BR>\n\t<A href='?src=\ref[];temp=1;b_type=on'>O-</A> <A href='?src=\ref[];temp=1;b_type=op'>O+</A><BR>", src, src, src, src, src, src, src, src)
										else
								else
									if (href_list["p_stat"])
										if (src.active1)
											switch(href_list["p_stat"])
												if("deceased")
													src.active1.fields["p_stat"] = "*Deceased*"
												if("unconscious")
													src.active1.fields["p_stat"] = "*Unconscious*"
												if("active")
													src.active1.fields["p_stat"] = "Active"
												if("unfit")
													src.active1.fields["p_stat"] = "Physically Unfit"
									else
										if (href_list["m_stat"])
											if (src.active1)
												switch(href_list["m_stat"])
													if("insane")
														src.active1.fields["m_stat"] = "*Insane*"
													if("unstable")
														src.active1.fields["m_stat"] = "*Unstable*"
													if("watch")
														src.active1.fields["m_stat"] = "*Watch*"
													if("stable")
														src.active2.fields["m_stat"] = "Stable"

										else
											if (href_list["b_type"])
												if (src.active2)
													switch(href_list["b_type"])
														if("an")
															src.active2.fields["b_type"] = "A-"
														if("bn")
															src.active2.fields["b_type"] = "B-"
														if("abn")
															src.active2.fields["b_type"] = "AB-"
														if("on")
															src.active2.fields["b_type"] = "O-"
														if("ap")
															src.active2.fields["b_type"] = "A+"
														if("bp")
															src.active2.fields["b_type"] = "B+"
														if("abp")
															src.active2.fields["b_type"] = "AB+"
														if("op")
															src.active2.fields["b_type"] = "O+"

											else
												if (href_list["del_r"])
													if (src.active2)
														src.temp = text("Are you sure you wish to delete the record (Medical Portion Only)?<br>\n\t<A href='?src=\ref[];temp=1;del_r2=1'>Yes</A><br>\n\t<A href='?src=\ref[];temp=1'>No</A><br>", src, src)
												else
													if (href_list["del_r2"])
														if (src.active2)
															//src.active2 = null
															del(src.active2)
													else
														if (href_list["d_rec"])
															var/datum/data/record/R = locate(href_list["d_rec"])
															var/datum/data/record/M = locate(href_list["d_rec"])
															if (!( data_core.general.Find(R) ))
																src.temp = "Record Not Found!"
																return
															for(var/datum/data/record/E in data_core.medical)
																if ((E.fields["name"] == R.fields["name"] || E.fields["id"] == R.fields["id"]))
																	M = E
																else
																	//Foreach continue //goto(2540)
															src.active1 = R
															src.active2 = M
															src.screen = 4
														else
															if (href_list["new"])
																if ((istype(src.active1, /datum/data/record) && !( istype(src.active2, /datum/data/record) )))
																	var/datum/data/record/R = new /datum/data/record(  )
																	R.fields["name"] = src.active1.fields["name"]
																	R.fields["id"] = src.active1.fields["id"]
																	R.name = text("Medical Record #[]", R.fields["id"])
																	R.fields["b_type"] = "Unknown"
																	R.fields["mi_dis"] = "None"
																	R.fields["mi_dis_d"] = "No minor disabilities have been declared."
																	R.fields["ma_dis"] = "None"
																	R.fields["ma_dis_d"] = "No major disabilities have been diagnosed."
																	R.fields["alg"] = "None"
																	R.fields["alg_d"] = "No allergies have been detected in this patient."
																	R.fields["cdi"] = "None"
																	R.fields["cdi_d"] = "No diseases have been diagnosed at the moment."
																	R.fields["notes"] = "No notes."
																	data_core.medical += R
																	src.active2 = R
																	src.screen = 4
															else
																if (href_list["add_c"])
																	if (!( istype(src.active2, /datum/data/record) ))
																		return
																	var/a2 = src.active2
																	var/t1 = input("Add Comment:", "Med. records", null, null)  as message
																	if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
																		return
																	var/counter = 1
																	while(src.active2.fields[text("com_[]", counter)])
																		counter++
																	src.active2.fields[text("com_[]", counter)] = text("Made by [] ([]) on [], 2053<BR>[]", src.authenticated, src.rank, time2text(world.realtime, "DDD MMM DD hh:mm:ss"), t1)
																else
																	if (href_list["del_c"])
																		if ((istype(src.active2, /datum/data/record) && src.active2.fields[text("com_[]", href_list["del_c"])]))
																			src.active2.fields[text("com_[]", href_list["del_c"])] = "<B>Deleted</B>"
																	else
																		if (href_list["search"])
																			var/t1 = input("Search String: (Name or ID)", "Med. records", null, null)  as text
																			if ((!( t1 ) || usr.stat || !( src.authenticated ) || usr.restrained() || get_dist(src, usr) > 1))
																				return
																			src.active1 = null
																			src.active2 = null
																			t1 = lowertext(t1)
																			for(var/datum/data/record/R in data_core.general)
																				if ((lowertext(R.fields["name"]) == t1 || t1 == lowertext(R.fields["id"])))
																					src.active1 = R
																				else
																					//Foreach continue //goto(3229)
																			if (!( src.active1 ))
																				src.temp = text("Could not locate record [].", t1)
																			else
																				for(var/datum/data/record/E in data_core.medical)
																					if ((E.fields["name"] == src.active1.fields["name"] || E.fields["id"] == src.active1.fields["id"]))
																						src.active2 = E
																					else
																						//Foreach continue //goto(3334)
																				src.screen = 4
																		else
																			if (href_list["print_p"])
																				if (!( src.printing ))
																					src.printing = 1
																					sleep(50)
																					var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( src.loc )
																					P.info = "<CENTER><B>Medical Record</B></CENTER><BR>"
																					if ((istype(src.active1, /datum/data/record) && data_core.general.Find(src.active1)))
																						P.info += text("Name: [] ID: []<BR>\nSex: []<BR>\nAge: []<BR>\nFingerprint: []<BR>\nPhysical Status: []<BR>\nMental Status: []<BR>", src.active1.fields["name"], src.active1.fields["id"], src.active1.fields["sex"], src.active1.fields["age"], src.active1.fields["fingerprint"], src.active1.fields["p_stat"], src.active1.fields["m_stat"])
																					else
																						P.info += "<B>General Record Lost!</B><BR>"
																					if ((istype(src.active2, /datum/data/record) && data_core.medical.Find(src.active2)))
																						P.info += text("<BR>\n<CENTER><B>Medical Data</B></CENTER><BR>\nBlood Type: []<BR>\n<BR>\nMinor Disabilities: []<BR>\nDetails: []<BR>\n<BR>\nMajor Disabilities: []<BR>\nDetails: []<BR>\n<BR>\nAllergies: []<BR>\nDetails: []<BR>\n<BR>\nCurrent Diseases: [] (per disease info placed in log/comment section)<BR>\nDetails: []<BR>\n<BR>\nImportant Notes:<BR>\n\t[]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>", src.active2.fields["b_type"], src.active2.fields["mi_dis"], src.active2.fields["mi_dis_d"], src.active2.fields["ma_dis"], src.active2.fields["ma_dis_d"], src.active2.fields["alg"], src.active2.fields["alg_d"], src.active2.fields["cdi"], src.active2.fields["cdi_d"], src.active2.fields["notes"])
																						var/counter = 1
																						while(src.active2.fields[text("com_[]", counter)])
																							P.info += text("[]<BR>", src.active2.fields[text("com_[]", counter)])
																							counter++
																					else
																						P.info += "<B>Medical Record Lost!</B><BR>"
																					P.info += "</TT>"
																					P.name = "paper- 'Medical Record'"
																					src.printing = null
	src.add_fingerprint(usr)
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(3792)
	return

/obj/machinery/computer/secure_data/attack_paw(mob/user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/computer/secure_data/attack_hand(mob/user as mob)

	var/dat
	if (src.temp)
		dat = text("<TT>[]</TT><BR><BR><A href='?src=\ref[];temp=1'>Clear Screen</A>", src.temp, src)
	else
		dat = text("Confirm Identity: <A href='?src=\ref[];scan=1'>[]</A><HR>", src, (src.scan ? text("[]", src.scan.name) : "----------"))
		if (src.authenticated)
			switch(src.screen)
				if(1.0)
					dat += text("<A href='?src=\ref[];search=1'>Search Records</A><BR>\n<A href='?src=\ref[];list=1'>List Records</A><BR>\n<A href='?src=\ref[];search_f=1'>Search Fingerprints</A><BR>\n<A href='?src=\ref[];new_r=1'>New Record</A><BR>\n<BR>\n<A href='?src=\ref[];rec_m=1'>Record Maintenance</A><BR>\n<A href='?src=\ref[];logout=1'>{Log Out}</A><BR>\n", src, src, src, src, src, src)
				if(2.0)
					dat += "<B>Record List</B>:<HR>"
					for(var/datum/data/record/R in data_core.general)
						dat += text("<A href='?src=\ref[];d_rec=\ref[]'>[]: []<BR>", src, R, R.fields["id"], R.fields["name"])
						//Foreach goto(136)
					dat += text("<HR><A href='?src=\ref[];main=1'>Back</A>", src)
				if(3.0)
					dat += text("<B>Records Maintenance</B><HR>\n<A href='?src=\ref[];back=1'>Backup To Disk</A><BR>\n<A href='?src=\ref[];u_load=1'>Upload From disk</A><BR>\n<A href='?src=\ref[];del_all=1'>Delete All Records</A><BR>\n<BR>\n<A href='?src=\ref[];main=1'>Back</A>", src, src, src, src)
				if(4.0)
					dat += "<CENTER><B>Security Record</B></CENTER><BR>"
					if ((istype(src.active1, /datum/data/record) && data_core.general.Find(src.active1)))
						dat += text("Name: <A href='?src=\ref[];field=name'>[]</A> ID: <A href='?src=\ref[];field=id'>[]</A><BR>\nSex: <A href='?src=\ref[];field=sex'>[]</A><BR>\nAge: <A href='?src=\ref[];field=age'>[]</A><BR>\nRank: <A href='?src=\ref[];field=rank'>[]</A><BR>\nFingerprint: <A href='?src=\ref[];field=fingerprint'>[]</A><BR>\nPhysical Status: []<BR>\nMental Status: []<BR>", src, src.active1.fields["name"], src, src.active1.fields["id"], src, src.active1.fields["sex"], src, src.active1.fields["age"], src, src.active1.fields["rank"], src, src.active1.fields["fingerprint"], src.active1.fields["p_stat"], src.active1.fields["m_stat"])
					else
						dat += "<B>General Record Lost!</B><BR>"
					if ((istype(src.active2, /datum/data/record) && data_core.security.Find(src.active2)))
						dat += text("<BR>\n<CENTER><B>Security Data</B></CENTER><BR>\nCriminal Status: <A href='?src=\ref[];field=criminal'>[]</A><BR>\n<BR>\nMinor Crimes: <A href='?src=\ref[];field=mi_crim'>[]</A><BR>\nDetails: <A href='?src=\ref[];field=mi_crim_d'>[]</A><BR>\n<BR>\nMajor Crimes: <A href='?src=\ref[];field=ma_crim'>[]</A><BR>\nDetails: <A href='?src=\ref[];field=ma_crim_d'>[]</A><BR>\n<BR>\nImportant Notes:<BR>\n\t<A href='?src=\ref[];field=notes'>[]</A><BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>", src, src.active2.fields["criminal"], src, src.active2.fields["mi_crim"], src, src.active2.fields["mi_crim_d"], src, src.active2.fields["ma_crim"], src, src.active2.fields["ma_crim_d"], src, src.active2.fields["notes"])
						var/counter = 1
						while(src.active2.fields[text("com_[]", counter)])
							dat += text("[]<BR><A href='?src=\ref[];del_c=[]'>Delete Entry</A><BR><BR>", src.active2.fields[text("com_[]", counter)], src, counter)
							counter++
						dat += text("<A href='?src=\ref[];add_c=1'>Add Entry</A><BR><BR>", src)
						dat += text("<A href='?src=\ref[];del_r=1'>Delete Record (Security Only)</A><BR><BR>", src)
					else
						dat += "<B>Security Record Lost!</B><BR>"
						dat += text("<A href='?src=\ref[];new=1'>New Record</A><BR><BR>", src)
					dat += text("\n<A href='?src=\ref[];dela_r=1'>Delete Record (ALL)</A><BR><BR>\n<A href='?src=\ref[];print_p=1'>Print Record</A><BR>\n<A href='?src=\ref[];list=1'>Back</A><BR>", src, src, src)
				else
		else
			dat += text("<A href='?src=\ref[];login=1'>{Log In}</A>", src)
	user << browse(text("<HEAD><TITLE>Security Records</TITLE></HEAD><TT>[]</TT>", dat), "window=secure_rec")
	return

/obj/machinery/computer/secure_data/Topic(href, href_list)

	if (!( data_core.general.Find(src.active1) ))
		src.active1 = null
	if (!( data_core.security.Find(src.active2) ))
		src.active2 = null
	if ((usr.stat || usr.restrained()))
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["temp"])
			src.temp = null
		if (href_list["scan"])
			if (src.scan)
				src.scan.loc = src.loc
				src.scan = null
			else
				var/obj/item/I = usr.equipped()
				if (istype(I, /obj/item/weapon/card/id))
					usr.drop_item()
					I.loc = src
					src.scan = I
		else
			if (href_list["logout"])
				src.authenticated = null
				src.screen = null
				src.active1 = null
				src.active2 = null
			else
				if (href_list["login"])
					if (istype(src.scan, /obj/item/weapon/card/id))
						src.active1 = null
						src.active2 = null
						var/list/L = list( "Security Officer", "Forensic Technician", "Prison Warden", "Head of Personnel", "Captain" )
						if (L.Find(src.scan.assignment))
							src.authenticated = src.scan.registered
							src.rank = src.scan.assignment
							src.screen = 1
		if (src.authenticated)
			if (href_list["list"])
				src.screen = 2
				src.active1 = null
				src.active2 = null
			else
				if (href_list["rec_m"])
					src.screen = 3
					src.active1 = null
					src.active2 = null
				else
					if (href_list["del_all"])
						src.temp = text("Are you sure you wish to delete all records?<br>\n\t<A href='?src=\ref[];temp=1;del_all2=1'>Yes</A><br>\n\t<A href='?src=\ref[];temp=1'>No</A><br>", src, src)
					else
						if (href_list["del_all2"])
							for(var/datum/data/record/R in data_core.security)
								//R = null
								del(R)
								//Foreach goto(497)
							src.temp = "All records deleted."
						else
							if (href_list["main"])
								src.screen = 1
								src.active1 = null
								src.active2 = null
							else
								if (href_list["field"])
									var/a1 = src.active1
									var/a2 = src.active2
									switch(href_list["field"])
										if("name")
											if (istype(src.active1, /datum/data/record))
												var/t1 = input("Please input name:", "Secure. records", src.active1.fields["name"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active1 != a1))
													return
												src.active1.fields["name"] = t1
										if("id")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please input id:", "Secure. records", src.active1.fields["id"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active1 != a1))
													return
												src.active1.fields["id"] = t1
										if("fingerprint")
											if (istype(src.active1, /datum/data/record))
												var/t1 = input("Please input fingerprint hash:", "Secure. records", src.active1.fields["fingerprint"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active1 != a1))
													return
												src.active1.fields["fingerprint"] = t1
										if("sex")
											if (istype(src.active1, /datum/data/record))
												if (src.active1.fields["sex"] == "Male")
													src.active1.fields["sex"] = "Female"
												else
													src.active1.fields["sex"] = "Male"
										if("age")
											if (istype(src.active1, /datum/data/record))
												var/t1 = input("Please input age:", "Secure. records", src.active1.fields["age"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active1 != a1))
													return
												src.active1.fields["age"] = t1
										if("mi_crim")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please input minor disabilities list:", "Secure. records", src.active2.fields["mi_crim"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["mi_crim"] = t1
										if("mi_crim_d")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize minor dis.:", "Secure. records", src.active2.fields["mi_crim_d"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["mi_crim_d"] = t1
										if("ma_crim")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please input major diabilities list:", "Secure. records", src.active2.fields["ma_crim"], null)  as text
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["ma_crim"] = t1
										if("ma_crim_d")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize major dis.:", "Secure. records", src.active2.fields["ma_crim_d"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["ma_crim_d"] = t1
										if("notes")
											if (istype(src.active2, /datum/data/record))
												var/t1 = input("Please summarize notes:", "Secure. records", src.active2.fields["notes"], null)  as message
												if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
													return
												src.active2.fields["notes"] = t1
										if("criminal")
											if (istype(src.active2, /datum/data/record))
												src.temp = text("<B>Criminal Status:</B><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=none'>None</A><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=arrest'>*Arrest*</A><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=incarcerated'>Incarcerated</A><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=parolled'>Parolled</A><BR>\n\t<A href='?src=\ref[];temp=1;criminal2=released'>Released</A><BR>", src, src, src, src, src)
										if("rank")
											var/list/L = list( "Head of Personnel", "Captain" )
											if ((istype(src.active1, /datum/data/record) && L.Find(src.rank)))
												src.temp = text("<B>Rank:</B><BR>\n<B>Assistants:</B><BR>\n<A href='?src=\ref[];temp=1;rank=res_assist'>Research Assistant</A><BR>\n<A href='?src=\ref[];temp=1;rank=staff_assist'>Staff Assistant</A><BR>\n<A href='?src=\ref[];temp=1;rank=med_assist'>Medical Assistant</A><BR>\n<A href='?src=\ref[];temp=1;rank=tech_assist'>Technical Assistant</A><BR>\n<B>Technicians:</B><BR>\n<A href='?src=\ref[];temp=1;rank=foren_tech'>Forensic Technician</A><BR>\n<A href='?src=\ref[];temp=1;rank=res_tech'>Research Technician</A><BR>\n<A href='?src=\ref[];temp=1;rank=stat_tech'>Station Technician</A><BR>\n<A href='?src=\ref[];temp=1;rank=atmo_tech'>Atmospheric Technician</A><BR>\n<A href='?src=\ref[];temp=1;rank=engineer'>Engineer (Engine Technician)\n<B>Researchers:</B><BR>\n<A href='?src=\ref[];temp=1;rank=med_res'>Medical Researcher</A><BR>\n<A href='?src=\ref[];temp=1;rank=tox_res'>Toxin Researcher</A><BR>\n<B>Officers:</B><BR>\n<A href='?src=\ref[];temp=1;rank=med_doc'>Medical Doctor</A><BR>\n<A href='?src=\ref[];temp=1;rank=secure_off'>Security Officer</A><BR>\n<B>Higher Officers:</B><BR>\n<A href='?src=\ref[];temp=1;rank=hoperson'>Head of Research</A><BR>\n<A href='?src=\ref[];temp=1;rank=horesearch'>Head of Personnel</A><BR>\n<A href='?src=\ref[];temp=1;rank=captain'>Captain</A><BR>", src, src, src, src, src, src, src, src, src, src, src, src, src, src, src, src)
										else
								else
									if (href_list["rank"])
										var/list/L = list( "Head of Personnel", "Captain" )
										if ((src.active1 && L.Find(src.rank)))
											switch(href_list["rank"])
												if("res_assist")
													src.active1.fields["rank"] = "Research Assistant"
												if("staff_assist")
													src.active1.fields["rank"] = "Staff Assistant"
												if("med_assist")
													src.active1.fields["rank"] = "Medical Assistant"
												if("tech_assist")
													src.active1.fields["rank"] = "Technical Assistant"
												if("foren_tech")
													src.active1.fields["rank"] = "Forensic Technician"
												if("res_tech")
													src.active1.fields["rank"] = "Research Technician"
												if("stat_tech")
													src.active1.fields["rank"] = "Station Technician"
												if("atmo_tech")
													src.active1.fields["rank"] = "Atmospheric Technician"
												if("engineer")
													src.active1.fields["rank"] = "Engineer"
												if("med_res")
													src.active1.fields["rank"] = "Medical Researcher"
												if("tox_res")
													src.active1.fields["rank"] = "Toxin Researcher"
												if("med_doc")
													src.active1.fields["rank"] = "Medical Doctor"
												if("secure_off")
													src.active1.fields["rank"] = "Security Officer"
												if("hoperson")
													src.active1.fields["rank"] = "Head of Research"
												if("horesearch")
													src.active1.fields["rank"] = "Head of Personnel"
												if("captain")
													src.active1.fields["rank"] = "Captain"

									else
										if (href_list["criminal2"])
											if (src.active2)
												switch(href_list["criminal2"])
													if("none")
														src.active2.fields["criminal"] = "None"
													if("arrest")
														src.active2.fields["criminal"] = "*Arrest*"
													if("incarcerated")
														src.active2.fields["criminal"] = "Incarcerated"
													if("parolled")
														src.active2.fields["criminal"] = "Parolled"
													if("released")
														src.active2.fields["criminal"] = "Released"

										else
											if (href_list["del_r"])
												if (src.active2)
													src.temp = text("Are you sure you wish to delete the record (Security Portion Only)?<br>\n\t<A href='?src=\ref[];temp=1;del_r2=1'>Yes</A><br>\n\t<A href='?src=\ref[];temp=1'>No</A><br>", src, src)
											else
												if (href_list["del_r2"])
													if (src.active2)
														//src.active2 = null
														del(src.active2)
												else
													if (href_list["dela_r"])
														if (src.active1)
															src.temp = text("Are you sure you wish to delete the record (ALL)?<br>\n\t<A href='?src=\ref[];temp=1;dela_r2=1'>Yes</A><br>\n\t<A href='?src=\ref[];temp=1'>No</A><br>", src, src)
													else
														if (href_list["dela_r2"])
															for(var/datum/data/record/R in data_core.medical)
																if ((R.fields["name"] == src.active1.fields["name"] || R.fields["id"] == src.active1.fields["id"]))
																	//R = null
																	del(R)
																else
																	//Foreach continue //goto(2405)
															if (src.active2)
																//src.active2 = null
																del(src.active2)
															if (src.active1)
																//src.active1 = null
																del(src.active1)
														else
															if (href_list["d_rec"])
																var/datum/data/record/R = locate(href_list["d_rec"])
																var/S = locate(href_list["d_rec"])
																if (!( data_core.general.Find(R) ))
																	src.temp = "Record Not Found!"
																	return
																for(var/datum/data/record/E in data_core.security)
																	if ((E.fields["name"] == R.fields["name"] || E.fields["id"] == R.fields["id"]))
																		S = E
																	else
																		//Foreach continue //goto(2614)
																src.active1 = R
																src.active2 = S
																src.screen = 4
															else
																if (href_list["new_r"])
																	var/datum/data/record/G = new /datum/data/record(  )
																	G.fields["name"] = "New Record"
																	G.fields["id"] = text("[]", add_zero(num2hex(rand(1, 1.6777215E7)), 6))
																	G.fields["rank"] = "Unassigned"
																	G.fields["sex"] = "Male"
																	G.fields["age"] = "Unknown"
																	G.fields["fingerprint"] = "Unknown"
																	G.fields["p_stat"] = "Active"
																	G.fields["m_stat"] = "Stable"
																	data_core.general += G
																	src.active1 = G
																	src.active2 = null
																else
																	if (href_list["new"])
																		if ((istype(src.active1, /datum/data/record) && !( istype(src.active2, /datum/data/record) )))
																			var/datum/data/record/R = new /datum/data/record(  )
																			R.fields["name"] = src.active1.fields["name"]
																			R.fields["id"] = src.active1.fields["id"]
																			R.name = text("Security Record #[]", R.fields["id"])
																			R.fields["criminal"] = "None"
																			R.fields["mi_crim"] = "None"
																			R.fields["mi_crim_d"] = "No minor crime convictions."
																			R.fields["ma_crim"] = "None"
																			R.fields["ma_crim_d"] = "No minor crime convictions."
																			R.fields["notes"] = "No notes."
																			data_core.security += R
																			src.active2 = R
																			src.screen = 4
																	else
																		if (href_list["add_c"])
																			if (!( istype(src.active2, /datum/data/record) ))
																				return
																			var/a2 = src.active2
																			var/t1 = input("Add Comment:", "Secure. records", null, null)  as message
																			if ((!( t1 ) || !( src.authenticated ) || usr.stat || usr.restrained() || get_dist(src, usr) > 1 || src.active2 != a2))
																				return
																			var/counter = 1
																			while(src.active2.fields[text("com_[]", counter)])
																				counter++
																			src.active2.fields[text("com_[]", counter)] = text("Made by [] ([]) on [], 2053<BR>[]", src.authenticated, src.rank, time2text(world.realtime, "DDD MMM DD hh:mm:ss"), t1)
																		else
																			if (href_list["del_c"])
																				if ((istype(src.active2, /datum/data/record) && src.active2.fields[text("com_[]", href_list["del_c"])]))
																					src.active2.fields[text("com_[]", href_list["del_c"])] = "<B>Deleted</B>"
																			else
																				if (href_list["search_f"])
																					var/t1 = input("Search String: (Fingerprint)", "Secure. records", null, null)  as text
																					if ((!( t1 ) || usr.stat || !( src.authenticated ) || usr.restrained() || get_dist(src, usr) > 1))
																						return
																					src.active1 = null
																					src.active2 = null
																					t1 = lowertext(t1)
																					for(var/datum/data/record/R in data_core.general)
																						if (lowertext(R.fields["fingerprint"]) == t1)
																							src.active1 = R
																						else
																							//Foreach continue //goto(3414)
																					if (!( src.active1 ))
																						src.temp = text("Could not locate record [].", t1)
																					else
																						for(var/datum/data/record/E in data_core.security)
																							if ((E.fields["name"] == src.active1.fields["name"] || E.fields["id"] == src.active1.fields["id"]))
																								src.active2 = E
																							else
																								//Foreach continue //goto(3502)
																						src.screen = 4
																				else
																					if (href_list["search"])
																						var/t1 = input("Search String: (Name or ID)", "Secure. records", null, null)  as text
																						if ((!( t1 ) || usr.stat || !( src.authenticated ) || usr.restrained() || get_dist(src, usr) > 1))
																							return
																						src.active1 = null
																						src.active2 = null
																						t1 = lowertext(t1)
																						for(var/datum/data/record/R in data_core.general)
																							if ((lowertext(R.fields["name"]) == t1 || t1 == lowertext(R.fields["id"])))
																								src.active1 = R
																							else
																								//Foreach continue //goto(3708)
																						if (!( src.active1 ))
																							src.temp = text("Could not locate record [].", t1)
																						else
																							for(var/datum/data/record/E in data_core.security)
																								if ((E.fields["name"] == src.active1.fields["name"] || E.fields["id"] == src.active1.fields["id"]))
																									src.active2 = E
																								else
																									//Foreach continue //goto(3813)
																							src.screen = 4
																					else
																						if (href_list["print_p"])
																							if (!( src.printing ))
																								src.printing = 1
																								sleep(50)
																								var/obj/item/weapon/paper/P = new /obj/item/weapon/paper( src.loc )
																								P.info = "<CENTER><B>Security Record</B></CENTER><BR>"
																								if ((istype(src.active1, /datum/data/record) && data_core.general.Find(src.active1)))
																									P.info += text("Name: [] ID: []<BR>\nSex: []<BR>\nAge: []<BR>\nFingerprint: []<BR>\nPhysical Status: []<BR>\nMental Status: []<BR>", src.active1.fields["name"], src.active1.fields["id"], src.active1.fields["sex"], src.active1.fields["age"], src.active1.fields["fingerprint"], src.active1.fields["p_stat"], src.active1.fields["m_stat"])
																								else
																									P.info += "<B>General Record Lost!</B><BR>"
																								if ((istype(src.active2, /datum/data/record) && data_core.security.Find(src.active2)))
																									P.info += text("<BR>\n<CENTER><B>Security Data</B></CENTER><BR>\nCriminal Status: []<BR>\n<BR>\nMinor Crimes: []<BR>\nDetails: []<BR>\n<BR>\nMajor Crimes: []<BR>\nDetails: []<BR>\n<BR>\nImportant Notes:<BR>\n\t[]<BR>\n<BR>\n<CENTER><B>Comments/Log</B></CENTER><BR>", src.active2.fields["criminal"], src.active2.fields["mi_crim"], src.active2.fields["mi_crim_d"], src.active2.fields["ma_crim"], src.active2.fields["ma_crim_d"], src.active2.fields["notes"])
																									var/counter = 1
																									while(src.active2.fields[text("com_[]", counter)])
																										P.info += text("[]<BR>", src.active2.fields[text("com_[]", counter)])
																										counter++
																								else
																									P.info += "<B>Security Record Lost!</B><BR>"
																								P.info += "</TT>"
																								P.name = "paper- 'Security Record'"
																								src.printing = null
	src.add_fingerprint(usr)
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(4247)
	return

/obj/machinery/computer/sleep_console/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				//SN src = null
				del(src)
				return
		else
	return

/obj/machinery/computer/sleep_console/New()

	..()
	spawn( 5 )
		src.connected = locate(/obj/machinery/sleeper, get_step(src, WEST))
		return
	return

/obj/machinery/computer/sleep_console/attack_paw(mob/user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/computer/sleep_console/attack_hand(mob/user as mob)

	if (src.connected)
		var/mob/occupant = src.connected.occupant
		var/dat = "<font color='blue'><B>Occupant Statistics:</B></FONT><BR>"
		if (occupant)
			var/t1
			switch(occupant.stat)
				if(0.0)
					t1 = "Conscious"
				if(1.0)
					t1 = "Unconscious"
				if(2.0)
					t1 = "*dead*"
				else
			dat += text("[]\tHealth %: [] ([])</FONT><BR>", (occupant.health > 50 ? "<font color='blue'>" : "<font color='red'>"), occupant.health, t1)
			dat += text("[]\t-Respiratory Damage %: []</FONT><BR>", (occupant.oxyloss < 60 ? "<font color='blue'>" : "<font color='red'>"), occupant.oxyloss)
			dat += text("[]\t-Toxin Content %: []</FONT><BR>", (occupant.toxloss < 60 ? "<font color='blue'>" : "<font color='red'>"), occupant.toxloss)
			dat += text("[]\t-Burn Severity %: []</FONT><BR>", (occupant.fireloss < 60 ? "<font color='blue'>" : "<font color='red'>"), occupant.fireloss)
			dat += text("<BR>Paralysis Summary %: [] ([] seconds left!)</FONT><BR>", occupant.paralysis, round(occupant.paralysis / 4))
			dat += text("<HR><A href='?src=\ref[];refresh=1'>Refresh</A><BR><A href='?src=\ref[];rejuv=1'>Inject Rejuvenators</A>", src, src)
		else
			dat += "The sleeper is empty."
		dat += text("<BR><BR><A href='?src=\ref[];mach_close=sleeper'>Close</A>", user)
		user << browse(dat, "window=sleeper;size=400x500")
	return

/obj/machinery/computer/sleep_console/Topic(href, href_list)

	if ((usr.stat || usr.restrained()))
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["rejuv"])
			if (src.connected)
				src.connected.inject(usr)
		if (href_list["refresh"])
			for(var/mob/M in viewers(1, src))
				if ((M.client && M.machine == src))
					src.attack_hand(M)
				//Foreach goto(123)
		src.add_fingerprint(usr)
	return

/obj/machinery/computer/sleep_console/process()

	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(18)
	return

/obj/machinery/freezer/attack_paw(mob/user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/freezer/attack_hand(mob/user as mob)

	user.machine = src

	if (( !( istype(user, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		var/d1
		if (locate(/obj/item/weapon/flasks, src))
			var/counter = 1

			for(var/obj/item/weapon/flasks/F in src)
				d1 += text("<A href = '?src=\ref[];flask=[]'><B>Flask []</B></A>: [] / [] / []<BR>", src, counter, counter, F.oxygen, F.plasma, F.coolant)
				counter++
				//Foreach goto(78)
			d1 += "Key:    Oxygen / Plasma / Coolant<BR>"
		else
			d1 = "<B>No flasks!</B>"
		var/t1 = null
		switch(src.t_flags)
			if(0.0)
				t1 = text("<A href = '?src=\ref[];oxygen=1'>Oxygen-No</A> <A href = '?src=\ref[];plasma=1'>Plasma-No</A>", src, src)
			if(1.0)
				t1 = text("<A href = '?src=\ref[];oxygen=0'>Oxygen-Yes</A> <A href = '?src=\ref[];plasma=1'>Plasma-No</A>", src, src)
			if(2.0)
				t1 = text("<A href = '?src=\ref[];oxygen=1'>Oxygen-No</A> <A href = '?src=\ref[];plasma=0'>Plasma-Yes</A>", src, src)
			if(3.0)
				t1 = text("<A href = '?src=\ref[];oxygen=0'>Oxygen-Yes</A> <A href = '?src=\ref[];plasma=0'>Plasma-Yes</A>", src, src)
			else
		var/t2 = null
		if (src.status)
			t2 = text("Cooling-[] <A href = '?src=\ref[];cool=0'>Stop</A>", src.c_used, src)
		else
			t2 = text("<A href = '?src=\ref[];cool=1'>Cool</A> Stopped", src)
		var/dat = text("<HTML><HEAD></HEAD><BODY><TT><BR>\n\t\t<B>Temperature</B>: []<BR>\n\t\t<B>Transfer Status</B>: []<BR>\n\t\t   <B>Chemicals Used</B>: []<BR>\n\t\t<B>Freezer status</B>: []<BR>\n\t\t   <A href='?src=\ref[];cp=-5'>-</A> <A href='?src=\ref[];cp=-1'>-</A> [] <A href='?src=\ref[];cp=1'>+</A> <A href='?src=\ref[];cp=5'>+</A><BR>\n<BR>\n\t[]<BR>\n<BR>\n<BR>\n\t<A href='?src=\ref[];mach_close=freezer'>Close</A><BR>\n\t</TT></BODY></HTML>", src.temperature, (src.transfer ? text("Transfering <A href='?src=\ref[];transfer=0'>Stop</A>", src) : text("<A href='?src=\ref[];transfer=1'>Transfer</A> Stopped", src)), t1, t2, src, src, src.c_used, src, src, d1, user)
		user << browse(dat, "window=freezer;size=400x500")
	else
		var/d1 = null
		if (locate(/obj/item/weapon/flasks, src))
			var/counter = 1
			for(var/obj/item/weapon/flasks/F in src)
				d1 += text("<A href = '?src=\ref[];flask=[]'><B>[] []</B></A>: []<BR>", src, counter, stars("Flask"), counter, stars(text("[] / [] / []", F.oxygen, F.plasma, F.coolant)))
				counter++
				//Foreach goto(380)
			d1 += "Key:    Oxygen / Plasma / Coolant<BR>"
		else
			d1 = "<B>No flasks!</B>"
		var/t1 = null
		switch(src.t_flags)
			if(0.0)
				t1 = text("<A href = '?src=\ref[];oxygen=1'>[]</A> <A href = '?src=\ref[];plasma=1'>[]</A>", src, stars("Oxygen-No"), src, stars("Plasma-No"))
			if(1.0)
				t1 = text("<A href = '?src=\ref[];oxygen=0'>[]</A> <A href = '?src=\ref[];plasma=1'>[]</A>", src, stars("Oxygen-Yes"), src, stars("Plasma-No"))
			if(2.0)
				t1 = text("<A href = '?src=\ref[];oxygen=1'>[]</A> <A href = '?src=\ref[];plasma=0'>[]</A>", src, stars("Oxygen-No"), src, stars("Plasma-Yes"))
			if(3.0)
				t1 = text("<A href = '?src=\ref[];oxygen=0'>[]</A> <A href = '?src=\ref[];plasma=0'>[]</A>", src, stars("Oxygen-Yes"), src, stars("Plasma-Yes"))
			else
		var/t2 = null
		if (src.status)
			t2 = text("Cooling-[] <A href = '?src=\ref[];cool=0'>[]</A>", src.c_used, src, stars("Stop"))
		else
			t2 = text("<A href = '?src=\ref[];cool=1'>Cool</A> []", src, stars("Stopped"))
		var/dat = text("<HTML><HEAD></HEAD><BODY><TT><BR>\n\t\t<B>[]</B>: []<BR>\n\t\t<B>[]</B>: []<BR>\n\t\t   <B>[]</B>: []<BR>\n\t\t<B>[]</B>: []<BR>\n\t\t   <A href='?src=\ref[];cp=-5'>-</A> <A href='?src=\ref[];cp=-1'>-</A> [] <A href='?src=\ref[];cp=1'>+</A> <A href='?src=\ref[];cp=5'>+</A><BR>\n<BR>\n\t[]<BR>\n<BR>\n<BR>\n\t<A href='?src=\ref[];mach_close=freezer'>Close</A>\n\t</TT></BODY></HTML>", stars("Temperature"), src.temperature, stars("Transfer Status"), (src.transfer ? text("Transfering <A href='?src=\ref[];transfer=0'>Stop</A>", src) : text("<A href='?src=\ref[];transfer=1'>Transfer</A> Stopped", src)), stars("Chemicals Used"), t1, stars("Freezer status"), t2, src, src, src.c_used, src, src, d1, user)
		user << browse(dat, "window=freezer;size=400x500")
	return

/obj/machinery/freezer/Topic(href, href_list)

	if ((!( istype(usr, /mob/human) ) && (!( ticker ) || (ticker && ticker.mode != "monkey"))))
		usr << "\red You don't have the dexterity to do this!"
		return
	if ((usr.stat || usr.restrained()))
		return
	if ((usr.contents.Find(src) || (get_dist(src, usr) <= 1 && istype(src.loc, /turf))))
		usr.machine = src
		if (href_list["cp"])
			var/cp = text2num(href_list["cp"])
			src.c_used += cp
			src.c_used = min(max(round(src.c_used), 0), 10)
		if (href_list["oxygen"])
			var/t1 = text2num(href_list["oxygen"])
			if (t1)
				src.t_flags |= 1
			else
				src.t_flags &= 65534
		if (href_list["plasma"])
			var/t1 = text2num(href_list["plasma"])
			if (t1)
				src.t_flags |= 2
			else
				src.t_flags &= 65533
		if (href_list["cool"])
			src.status = text2num(href_list["cool"])
			src.icon_state = text("freezer_[]", src.status)
		if (href_list["transfer"])
			src.transfer = text2num(href_list["transfer"])
		if (href_list["flask"])
			var/t1 = text2num(href_list["flask"])
			if (t1 <= src.contents.len)
				var/obj/F = src.contents[t1]
				F.loc = src.loc
				src.rebuild_overlay()
		src.add_fingerprint(usr)
	return

/obj/machinery/freezer/process()

	var/obj/item/weapon/flasks/F1
	var/obj/item/weapon/flasks/F2
	var/obj/item/weapon/flasks/F3
	if (src.contents.len >= 3)
		F3 = src.contents[3]
	if (src.contents.len >= 2)
		F2 = src.contents[2]
	if (src.contents.len >= 1)
		F1 = src.contents[1]
	var/u_cool = 0
	if (src.status)
		u_cool = src.c_used
		if ((F2 && F2.coolant))
			if (F2.coolant >= u_cool)
				F2.coolant -= u_cool
			else
				u_cool = F2.coolant
				F2.coolant = 0
		else
			if ((F1 && F1.coolant))
				if (F1.coolant >= u_cool)
					F1.coolant -= u_cool
				else
					u_cool = F1.coolant
					F1.coolant = 0
			else
				if ((F3 && F3.coolant))
					if (F3.coolant >= u_cool)
						F3.coolant -= u_cool
					else
						u_cool = F3.coolant
						F3.coolant = 0
				else
					u_cool = 0
	if (u_cool)
		src.temperature = max(-100.0, src.temperature - (u_cool * 5) )
	src.temperature = min(src.temperature + 5, 20)
	if (src.transfer)
		var/u_oxy = 0
		var/u_pla = 0
		if (src.t_flags & 1)
			u_oxy = 1
			if ((F1 && F1.oxygen))
				if (F1.oxygen >= u_oxy)
					F1.oxygen -= u_oxy
				else
					u_oxy = F1.oxygen
					F1.oxygen = 0
			else
				if ((F2 && F2.oxygen))
					if (F2.oxygen >= u_oxy)
						F2.oxygen -= u_oxy
					else
						u_oxy = F2.oxygen
						F2.oxygen = 0
				else
					if ((F3 && F3.oxygen))
						if (F3.oxygen >= u_oxy)
							F3.oxygen -= u_oxy
						else
							u_oxy = F3.oxygen
							F3.oxygen = 0
					else
						u_oxy = 0
		if (src.t_flags & 2)
			u_pla = 1
			if ((F3 && F3.plasma))
				if (F3.plasma >= u_pla)
					F3.plasma -= u_pla
				else
					u_pla = F3.plasma
					F3.plasma = 0
			else
				if ((F2 && F2.plasma))
					if (F2.plasma >= u_pla)
						F2.plasma -= u_pla
					else
						u_pla = F2.plasma
						F2.plasma = 0
				else
					if ((F1 && F1.plasma))
						if (F1.plasma >= u_pla)
							F1.plasma -= u_pla
						else
							u_pla = F1.plasma
							F1.plasma = 0
					else
						u_pla = 0
		if ( (u_oxy + u_pla) > 0)
			var/obj/substance/gas/G = new /obj/substance/gas( null )
			G.oxygen = u_oxy
			G.plasma = u_pla
			G.temperature = src.temperature
			spawn( 3 )
				if (src.line_out)
					src.line_out.receive_gas(G, src)
				return
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(809)
	return

/obj/machinery/freezer/receive_gas(S as obj, source as obj)

	//S = null
	del(S)
	return

/obj/machinery/freezer/orient_pipe(P as obj)

	if (!( src.line_out ))
		src.line_out = P
	else
		return 0
	return 1
	return

/obj/machinery/freezer/New()

	..()
	var/obj/overlay/O1 = new /obj/overlay(  )
	O1.icon = 'Cryogenic2.dmi'
	O1.icon_state = "canister connector_0"
	O1.pixel_y = -16.0
	src.overlays += O1
	src.connector = O1
	new /obj/item/weapon/flasks/oxygen( src )
	new /obj/item/weapon/flasks/coolant( src )
	new /obj/item/weapon/flasks/plasma( src )
	rebuild_overlay()
	spawn( 50 )
		for(var/obj/machinery/M in orange(src, 1))
			if ((M.level == src.level && src.p_dir & get_dir(src, M) && M.p_dir & get_dir(M, src)))
				if (!( src.line_out ))
					src.line_out = M
			//Foreach goto(117)
		return
	return

/obj/machinery/freezer/attackby(obj/item/weapon/flasks/F as obj, mob/user as mob)

	if (!( istype(F, /obj/item/weapon/flasks) ))
		return
	if (src.contents.len >= 3)
		user << "\blue All slots are full!"
		return
	else
		user.drop_item()
		F.loc = src
		src.rebuild_overlay()
	return

/obj/machinery/freezer/proc/rebuild_overlay()

	for(var/x in src.overlays)
		src.overlays -= x
		//Foreach goto(17)
	src.overlays += src.connector
	var/counter = 0
	for(var/obj/item/weapon/flasks/F in src.contents)
		var/obj/overlay/O = new /obj/overlay(  )
		O.icon = F.icon
		O.icon_state = F.icon_state
		O.pixel_y = -17.0
		O.pixel_x = counter * 12
		src.overlays += O
		counter++
		if (counter >= 3)
			return
		//Foreach goto(64)
	return

/obj/machinery/sleeper/allow_drop()

	return 0
	return

/obj/machinery/sleeper/process()

	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(18)
	return

/obj/machinery/sleeper/ex_act(severity)

	switch(severity)
		if(1.0)
			for(var/atom/movable/A as mob|obj in src)
				A.loc = src.loc
				ex_act(severity)
				//Foreach goto(31)
			//SN src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(104)
				//SN src = null
				del(src)
				return
		else
	return

/obj/machinery/sleeper/verb/eject()
	set src in oview(1)

	if (usr.stat != 0)
		return
	src.go_out()
	add_fingerprint(usr)
	return

/obj/machinery/sleeper/verb/move_inside()
	set src in oview(1)

	if (usr.stat != 0)
		return
	if (src.occupant)
		usr << "\blue <B>The sleeper is already occupied!</B>"
		return
	if (usr.abiotic())
		usr << "Subject may not have abiotic items on."
		return
	usr.pulling = null
	usr.client.perspective = EYE_PERSPECTIVE
	usr.client.eye = src
	usr.loc = src
	src.occupant = usr
	src.icon_state = "sleeper_1"
	for(var/obj/O in src)
		//O = null
		del(O)
		//Foreach goto(124)
	src.add_fingerprint(usr)
	return

/obj/machinery/sleeper/attackby(obj/item/weapon/grab/G as obj, mob/user as mob)

	if ((!( istype(G, /obj/item/weapon/grab) ) || !( ismob(G.affecting) )))
		return
	if (src.occupant)
		user << "\blue <B>The sleeper is already occupied!</B>"
		return
	if (G.affecting.abiotic())
		user << "Subject may not have abiotic items on."
		return
	var/mob/M = G.affecting
	if (M.client)
		M.client.perspective = EYE_PERSPECTIVE
		M.client.eye = src
	M.loc = src
	src.occupant = M
	src.icon_state = "sleeper_1"
	for(var/obj/O in src)
		O.loc = src.loc
		//Foreach goto(154)
	src.add_fingerprint(user)
	//G = null
	del(G)
	return

/obj/machinery/sleeper/proc/go_out()

	if (!( src.occupant ))
		return
	for(var/obj/O in src)
		O.loc = src.loc
		//Foreach goto(26)
	if (src.occupant.client)
		src.occupant.client.eye = src.occupant.client.mob
		src.occupant.client.perspective = MOB_PERSPECTIVE
	src.occupant.loc = src.loc
	src.occupant = null
	src.icon_state = "sleeper_0"
	return

/obj/machinery/sleeper/proc/inject(mob/user as mob)

	if (src.occupant)
		if (src.occupant.rejuv < 60)
			src.occupant.rejuv = 60
		user << text("Occupant now has [] units of rejuvenation in his/her bloodstream.", src.occupant.rejuv)
	else
		user << "No occupant!"
	return

/obj/machinery/sleeper/proc/check(mob/user as mob)

	if (src.occupant)
		user << text("\blue <B>Occupant ([]) Statistics:</B>", src.occupant)
		var/t1
		switch(src.occupant.stat)
			if(0.0)
				t1 = "Conscious"
			if(1.0)
				t1 = "Unconscious"
			if(2.0)
				t1 = "*dead*"
			else
		user << text("[]\t Health %: [] ([])", (src.occupant.health > 50 ? "\blue " : "\red "), src.occupant.health, t1)
		user << text("[]\t -Respiratory Damage %: []", (src.occupant.oxyloss < 60 ? "\blue " : "\red "), src.occupant.oxyloss)
		user << text("[]\t -Toxin Content %: []", (src.occupant.toxloss < 60 ? "\blue " : "\red "), src.occupant.toxloss)
		user << text("[]\t -Burn Severity %: []", (src.occupant.fireloss < 60 ? "\blue " : "\red "), src.occupant.fireloss)
		user << "\blue Expected time till occupant can safely awake: (note: If health is below 20% these times are inaccurate)"
		user << text("\blue \t [] second\s (if around 1 or 2 the sleeper is keeping them asleep.)", src.occupant.paralysis / 5)
	else
		user << "\blue There is no one inside!"
	return

/obj/machinery/sleeper/ex_act(severity)

	switch(severity)
		if(1.0)
			for(var/atom/movable/A as mob|obj in src)
				A.loc = src.loc
				ex_act(severity)
				//Foreach goto(35)
			//SN src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(108)
				//SN src = null
				del(src)
				return
		if(3.0)
			if (prob(25))
				for(var/atom/movable/A as mob|obj in src)
					A.loc = src.loc
					ex_act(severity)
					//Foreach goto(181)
				//SN src = null
				del(src)
				return
		else
	return

/obj/machinery/sleeper/alter_health(mob/M as mob)

	if (M.health > 0)
		if (M.oxyloss >= 10)
			var/amount = max(0.15, 1)
			M.oxyloss -= amount
		else
			M.oxyloss = 0
		M.health = 100 - M.oxyloss - M.toxloss - M.fireloss - M.bruteloss
	M.paralysis -= 4
	M.weakened -= 4
	M.stunned -= 4
	if (M.paralysis <= 1)
		M.paralysis = 3
	if (M.weakened <= 1)
		M.weakened = 3
	if (M.stunned <= 1)
		M.stunned = 3
	if (M.rejuv < 3)
		M.rejuv = 4
	return

/obj/machinery/cryo_cell/ex_act(severity)

	switch(severity)
		if(1.0)
			//SN src = null
			del(src)
			return
		if(2.0)
			if (prob(50))
				for(var/x in src.verbs)
					src.verbs -= x
					//Foreach goto(54)
				src.icon_state = "broken"
		else
	return

/obj/machinery/cryo_cell/orient_pipe(P as obj)

	if (!( src.line_in ))
		src.line_in = P
	else
		return 0
	return 1
	return

/obj/machinery/cryo_cell/allow_drop()

	return 0
	return

/obj/machinery/cryo_cell/New()

	..()
	src.gas = new /obj/substance/gas( null )
	spawn( 50 )
		for(var/obj/machinery/M in orange(src, 1))
			if ((M.level == src.level && src.p_dir & get_dir(src, M) && M.p_dir & get_dir(M, src)))
				if (!( src.line_in ))
					src.line_in = M
			//Foreach goto(42)
		return
	return

/obj/machinery/cryo_cell/verb/move_eject()
	set src in oview(1)

	if (usr.stat != 0)
		return
	src.go_out()
	add_fingerprint(usr)
	return

/obj/machinery/cryo_cell/verb/move_inside()
	set src in oview(1)

	if (usr.stat != 0)
		return
	if (src.occupant)
		usr << "\blue <B>The cell is already occupied!</B>"
		return
	if (usr.abiotic())
		usr << "Subject may not have abiotic items on."
		return
	usr.pulling = null
	usr.client.perspective = EYE_PERSPECTIVE
	usr.client.eye = src
	usr.loc = src
	src.occupant = usr
	src.icon_state = "celltop_1"
	for(var/obj/O in src)
		O.loc = src.loc
		//Foreach goto(124)
	src.add_fingerprint(usr)
	return

/obj/machinery/cryo_cell/attackby(obj/item/weapon/grab/G as obj, mob/user as mob)

	if ((!( istype(G, /obj/item/weapon/grab) ) || !( ismob(G.affecting) )))
		return
	if (src.occupant)
		user << "\blue <B>The cell is already occupied!</B>"
		return
	if (G.affecting.abiotic())
		user << "Subject may not have abiotic items on."
		return
	var/mob/M = G.affecting
	if (M.client)
		M.client.perspective = EYE_PERSPECTIVE
		M.client.eye = src
	M.loc = src
	src.occupant = M
	src.icon_state = "celltop_1"
	for(var/obj/O in src)
		//O = null
		del(O)
		//Foreach goto(154)
	src.add_fingerprint(user)
	//G = null
	del(G)
	return

/obj/machinery/cryo_cell/attack_paw(mob/user as mob)

	return src.attack_hand(user)
	return

/obj/machinery/cryo_cell/attack_hand(mob/user as mob)

	user.machine = src
	if (istype(user, /mob/human))
		var/dat = "<font color='blue'> <B>System Statistics:</B></FONT><BR>"
		if (src.gas.temperature > 0)
			dat += text("<font color='red'>\tTemperature (Farenheight): [] (MUST be below 0, add coolant to mixture)</FONT><BR>", src.gas.temperature)
		else
			dat += text("<font color='blue'>\tTemperature(Farenheight): [] </FONT><BR>", src.gas.temperature)
		if (src.gas.plasma < 1)
			dat += text("<font color='red'>\tPlasma Units: [] (Add plasma to mixture!)</FONT><BR>", src.gas.plasma)
		else
			dat += text("<font color='blue'>\tPlasma Units: []</FONT><BR>", src.gas.plasma)
		if (src.gas.oxygen < 1)
			dat += text("<font color='red'>\tOxygen Units: [] (Add oxygen to mixture!)</FONT><BR>", src.gas.oxygen)
		else
			dat += text("<font color='blue'>\tOxygen Units: []</FONT><BR>", src.gas.oxygen)
		if (src.occupant)
			dat += "<font color='blue'><B>Occupant Statistics:</B></FONT><BR>"
			var/t1
			switch(src.occupant.stat)
				if(0.0)
					t1 = "Conscious"
				if(1.0)
					t1 = "Unconscious"
				if(2.0)
					t1 = "*dead*"
				else
			dat += text("[]\tHealth %: [] ([])</FONT><BR>", (src.occupant.health > 50 ? "<font color='blue'>" : "<font color='red'>"), src.occupant.health, t1)
			dat += text("[]\t-Respiratory Damage %: []</FONT><BR>", (src.occupant.oxyloss < 60 ? "<font color='blue'>" : "<font color='red'>"), src.occupant.oxyloss)
			dat += text("[]\t-Toxin Content %: []</FONT><BR>", (src.occupant.toxloss < 60 ? "<font color='blue'>" : "<font color='red'>"), src.occupant.toxloss)
			dat += text("[]\t-Burn Severity %: []</FONT>", (src.occupant.fireloss < 60 ? "<font color='blue'>" : "<font color='red'>"), src.occupant.fireloss)
		dat += text("<BR><BR><A href='?src=\ref[];mach_close=cryo'>Close</A>", user)
		user << browse(dat, "window=cryo;size=400x500")
	else
		var/dat = text("<font color='blue'> <B>[]</B></FONT><BR>", stars("System Statistics:"))
		if (src.gas.temperature > 0)
			dat += text("<font color='red'>\t[]</FONT><BR>", stars(text("Temperature (Farenheight): [] (MUST be below 0, add coolant to mixture)", src.gas.temperature)))
		else
			dat += text("<font color='blue'>\t[] </FONT><BR>", stars(text("Temperature(Farenheight): []", src.gas.temperature)))
		if (src.gas.plasma < 1)
			dat += text("<font color='red'>\t[]</FONT><BR>", stars(text("Plasma Units: [] (Add plasma to mixture!)", src.gas.plasma)))
		else
			dat += text("<font color='blue'>\t[]</FONT><BR>", stars(text("Plasma Units: []", src.gas.plasma)))
		if (src.gas.oxygen < 1)
			dat += text("<font color='red'>\t[]</FONT><BR>", stars(text("Oxygen Units: [] (Add oxygen to mixture!)", src.gas.oxygen)))
		else
			dat += text("<font color='blue'>\t[]</FONT><BR>", stars(text("Oxygen Units: []", src.gas.oxygen)))
		if (src.occupant)
			dat += "<font color='blue'><B>Occupant Statistics:</B></FONT><BR>"
			var/t1 = null
			switch(src.occupant.stat)
				if(0.0)
					t1 = "Conscious"
				if(1.0)
					t1 = "Unconscious"
				if(2.0)
					t1 = "*dead*"
				else
			dat += text("[]\t[]</FONT><BR>", (src.occupant.health > 50 ? "<font color='blue'>" : "<font color='red'>"), stars(text("Health %: [] ([])", src.occupant.health, t1)))
			dat += text("[]\t[]</FONT><BR>", (src.occupant.oxyloss < 60 ? "<font color='blue'>" : "<font color='red'>"), stars(text("-Respiratory Damage %: []", src.occupant.oxyloss)))
			dat += text("[]\t[]</FONT><BR>", (src.occupant.toxloss < 60 ? "<font color='blue'>" : "<font color='red'>"), stars(text("-Toxin Content %: []", src.occupant.toxloss)))
			dat += text("[]\t[]</FONT>", (src.occupant.fireloss < 60 ? "<font color='blue'>" : "<font color='red'>"), stars(text("-Burn Severity %: []", src.occupant.fireloss)))
		dat += text("<BR><BR><A href='?src=\ref[];mach_close=cryo'>Close</A>", user)
		user << browse(dat, "window=cryo;size=400x500")
	return

/obj/machinery/cryo_cell/proc/go_out()

	if (!( src.occupant ))
		return
	for(var/obj/O in src)
		O.loc = src.loc
		//Foreach goto(26)
	if (src.occupant.client)
		src.occupant.client.eye = src.occupant.client.mob
		src.occupant.client.perspective = MOB_PERSPECTIVE
	src.occupant.loc = src.loc
	src.occupant = null
	src.icon_state = "celltop"
	return

/obj/machinery/cryo_cell/relaymove(mob/user as mob)

	if (user.stat)
		return
	src.go_out()
	return

/obj/machinery/cryo_cell/alter_health(mob/M as mob)

	if (M.health < 0)
		if ((src.gas.temperature > 0 || src.gas.plasma < 1))
			return
	if (M.stat == 2)
		return
	if (src.gas.oxygen >= 1)
		src.gas.oxygen--
		if (M.oxyloss >= 10)
			var/amount = max(0.15, 2)
			M.oxyloss -= amount
		else
			M.oxyloss = 0
		M.health = 100 - M.oxyloss - M.toxloss - M.fireloss - M.bruteloss
	if ((src.gas.temperature < 0 && src.gas.plasma >= 1))
		src.gas.plasma--
		if (M.toxloss > 5)
			var/amount = max(0.1, 2)
			M.toxloss -= amount
		else
			M.toxloss = 0
		M.health = 100 - M.oxyloss - M.toxloss - M.fireloss - M.bruteloss
		if (istype(M, /mob/human))
			var/mob/human/H = M
			var/ok = 0
			for(var/organ in H.organs)
				var/obj/item/weapon/organ/external/affecting = H.organs[text("[]", organ)]
				ok += affecting.heal_damage(5, 5)
				//Foreach goto(267)
			if (ok)
				H.UpdateDamageIcon()
			else
				H.UpdateDamage()
		else
			if (M.fireloss > 15)
				var/amount = max(0.3, 2)
				M.fireloss -= amount
			else
				M.fireloss = 0
			if (M.bruteloss > 10)
				var/amount = max(0.3, 2)
				M.bruteloss -= amount
			else
				M.bruteloss = 0
		M.health = 100 - M.oxyloss - M.toxloss - M.fireloss - M.bruteloss
		M.paralysis += 5
	if (src.gas.temperature < 60)
		src.gas.temperature = min(src.gas.temperature + 1, 60)
	for(var/mob/E in viewers(1, src))
		if ((E.client && E.machine == src))
			src.attack_hand(E)
		//Foreach goto(489)
	return
	return

/obj/machinery/cryo_cell/receive_gas(S as obj, source as obj)

	if (!( istype(S, /obj/substance/gas) ))
		//S = null
		del(S)
		return
	else
		src.gas.merge_into(S)
		//S = null
		del(S)
	for(var/mob/M in viewers(1, src))
		if ((M.client && M.machine == src))
			src.attack_hand(M)
		//Foreach goto(74)
	return

/obj/machinery/cryo_cell/New()

	..()
	src.layer = 5
	var/obj/overlay/O1 = new /obj/overlay(  )
	O1.icon = 'Cryogenic2.dmi'
	O1.icon_state = "cellconsole"
	O1.pixel_y = -32.0
	O1.layer = 4
	var/obj/overlay/O2 = new /obj/overlay(  )
	O2.icon = 'Cryogenic2.dmi'
	O2.icon_state = "cellbottom"
	O2.pixel_y = -32.0
	src.pixel_y = 32
	src.overlays += O2
	src.overlays += O1
	return

/obj/item/weapon/flasks/examine()
	set src in oview(1)

	usr << text("The flask is []% full", (src.oxygen + src.plasma + src.coolant) * 100 / 500)
	usr << "The flask can ONLY store liquids."
	return

/mob/human/abiotic()

	if ((src.l_hand && !( src.l_hand.abstract )) || (src.r_hand && !( src.r_hand.abstract )) || (src.back || src.wear_mask || src.head || src.shoes || src.w_uniform || src.wear_suit || src.w_radio || src.glasses || src.ears || src.gloves))
		return 1
	else
		return 0
	return

/mob/proc/abiotic()

	if ((src.l_hand && !( src.l_hand.abstract )) || (src.r_hand && !( src.r_hand.abstract )) || src.back || src.wear_mask)
		return 1
	else
		return 0
	return

/datum/data/function/proc/reset()

	return

/datum/data/function/proc/r_input(href, href_list, mob/user as mob)

	return

/datum/data/function/proc/display()

	return
