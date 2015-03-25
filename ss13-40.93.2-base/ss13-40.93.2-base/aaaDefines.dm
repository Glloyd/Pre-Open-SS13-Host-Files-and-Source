#define SHUTTLE_Z 10
#define PRISON_SHUTTLE_Z 12
#define ENGINE_EJECT_Z 8


/proc/add_zero(t, u)

	while(length(t) < u)
		t = text("0[]", t)
	return t

/obj/bomb/New()

	..()
	var/obj/item/weapon/assembly/r_i_ptank/R = new /obj/item/weapon/assembly/r_i_ptank( src.loc )
	var/obj/item/weapon/tank/plasmatank/p3 = new /obj/item/weapon/tank/plasmatank( R )
	var/obj/item/weapon/radio/signaler/p1 = new /obj/item/weapon/radio/signaler( R )
	var/obj/item/weapon/igniter/p2 = new /obj/item/weapon/igniter( R )
	R.part1 = p1
	R.part2 = p2
	R.part3 = p3
	p1.master = R
	p2.master = R
	p3.master = R
	R.status = 1
	p1.b_stat = 0
	p2.status = 1
	p3.gas.temperature = 500
	//SN src = null

	del(src)
	return

/obj/proc/throwing(t_dir, rs)

	if (src.throwspeed <= 1)
		src.throwing = 0
	src.throwspeed--
	if (rs == 0)
		rs = 1
	if (src.throwing)
		if (rs == 1)
			step(src, t_dir)
			sleep(1)
			spawn( 0 )
				throwing(t_dir, rs)
				return
		else
			if (rs > 1)
				var/t = null
				while(t < rs)
					step(src, t_dir)
					t++
				sleep(10)
				spawn( 0 )
					src.throwing(t_dir, rs)
					return
			else
				step(src, t_dir)
				sleep(10 / rs)
				spawn( 0 )
					throwing(t_dir, rs)
					return
	else
		src.density = 0
	return


/atom/proc/burn(fi_amount)

	return

/atom/movable/Move()

	var/atom/A = src.loc
	. = ..()
	src.move_speed = world.time - src.l_move_time
	src.l_move_time = world.time
	src.m_flag = 1
	if ((A != src.loc && A && A.z == src.z))
		src.last_move = get_dir(A, src.loc)
	return
