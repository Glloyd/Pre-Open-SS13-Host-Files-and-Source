
/sound/New(file, repeat, wait, channel)

	src.file = fcopy_rsc(file)
	src.repeat = repeat
	src.wait = wait
	src.channel = channel
	return ..()
	return

/sound/proc/RscFile()

	return src.file
	return

/icon/New(icon, icon_state, dir, frame, moving)

	src.icon = _dm_new_icon(icon, icon_state, dir, frame, moving)
	return

/icon/proc/Icon()

	return src.icon
	return

/icon/proc/RscFile()

	return fcopy_rsc(src.icon)
	return

/icon/proc/IconStates()

	return icon_states(src.icon)
	return

/icon/proc/Turn(angle)

	_dm_turn_icon(src.icon, angle)
	return

/icon/proc/Flip(dir)

	_dm_flip_icon(src.icon, dir)
	return

/icon/proc/Shift(dir, offset, wrap)

	_dm_shift_icon(src.icon, dir, offset, wrap)
	return

/icon/proc/SetIntensity(r, g, b)

	if (g == null)
		g = -1.0
	if (b == null)
		b = -1.0
	_dm_icon_intensity(src.icon, r, g, b)
	return

/icon/proc/Blend(icon, f)

	_dm_icon_blend(src.icon, icon, f)
	return

/icon/proc/SwapColor(o, n)

	_dm_icon_swap_color(src.icon, o, n)
	return

/icon/proc/DrawBox(c, x1, y1, x2, y2)

	_dm_draw_box(src.icon, c, x1, y1, x2, y2)
	return

/icon/proc/Insert(new_icon, icon_state, dir, frame, moving, delay)

	_dm_icon_insert(src.icon, new_icon, icon_state, dir, frame, moving, delay)
	return
