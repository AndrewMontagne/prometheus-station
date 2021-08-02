/client
	var/map_panes

/client/proc/init_map_panes()
	map_panes = list()
	new /datum/map_pane(src, "mapwindow.map")

/mob/verb/interface_resize(var/pane_name as null|text, var/new_size as null|text)
	set name = "OnInterfaceResize"
	set hidden = 1

	var/datum/map_pane/pane = client.map_panes[pane_name]
	pane.update(new_size)

/datum/map_pane
	var/client/player
	var/skin_id
	var/width = 0
	var/height = 0

	var/left_offset = 0
	var/right_offset = 0
	var/top_offset = 0
	var/bottom_offset = 0

	var/obj/screen/background
	var/list/listeners = list()

/datum/map_pane/New(var/_player, var/_skin_id)
	skin_id = _skin_id
	player = _player

	add_background()

	update()
	winset(player, skin_id, "on-size=\"OnInterfaceResize \\\"[skin_id]\\\" \\\"\[\[*\]\]\\\"\"")
	player.map_panes[skin_id] = src


/datum/map_pane/proc/update(size = winget(player, skin_id, "size"))
	var/raw = list()
	if (findtext(size, "x"))
		raw = splittext(size , "x")
	else
		raw = splittext(size , ",")
	
	src.width = round(text2num(raw[1]) / 2)
	src.height = round(text2num(raw[2]) / 2)

	var/tiles_x = round(width / 32)
	var/tiles_y = round(height / 32)

	src.bottom_offset = round((((tiles_y + 1) * 32) - height) / 2) + 1
	src.left_offset = round((((tiles_x + 1) * 32) - width) / 2) + 1
	src.top_offset = bottom_offset + (height - 32) - 2
	src.right_offset = left_offset + (width - 32) - 2

	var/view_width = player.view
	var/view_height = player.view
	if (findtext(player.view, "x"))
		raw = splittext(player.view , "x")
		view_width = raw[1]
		view_height = raw[2]

	LOG_TRACE("W: [view_width] H: [view_height]")
	LOG_TRACE("T: [top_offset] R: [right_offset] B: [bottom_offset] L: [left_offset] X: [tiles_x] Y: [tiles_y]")

	if (background)
		background.screen_loc = "[src.skin_id]:0,0 to [tiles_x],[tiles_y]"

	for (var/listener in src.listeners)
		var/datum/toolbar/T = listener
		T.update()

/datum/map_pane/proc/add_background()
	background = new /obj/screen(null)
	background.icon_state = "blank"
	background.layer--
	background.name = "pane background"
	player.screen += background
