/client
	var/map_panes

/client/proc/init_map_panes()
	map_panes = list()
	new /datum/map_pane(src, "inventorywindow.inventory")

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

	var/obj/screen/background

/datum/map_pane/New(var/_player, var/_skin_id)
	skin_id = _skin_id
	player = _player

	background = new /obj/screen(null)
	background.icon_state = "blank"
	background.layer--
	background.name = "pane background"

	player.screen += background

	update()
	winset(player, skin_id, "on-size=\"OnInterfaceResize \\\"[skin_id]\\\" \\\"\[\[*\]\]\\\"\"")
	player.map_panes[skin_id] = src


/datum/map_pane/proc/update(size = winget(player, skin_id, "size"))
	var/raw =  splittext(size , "x")
	width = round(text2num(raw[1]) / 2)
	height = round(text2num(raw[2]) / 2)

	var/tiles_x = round(width / 32)
	var/tiles_y = round(height / 32)

	var/bottom_offset = round((((tiles_y + 1) * 32) - height) / 2) + 1
	var/left_offset = round((((tiles_x + 1) * 32) - width) / 2) + 1
	var/top_offset = bottom_offset + (height - 32) - 2
	var/right_offset = left_offset + (width - 32) - 2

	background.screen_loc = "inventory:0,0 to [tiles_x],[tiles_y]"
