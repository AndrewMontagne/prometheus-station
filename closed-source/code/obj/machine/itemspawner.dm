/obj/machine/itemspawner
	icon = 'assets/cc-by-sa-nc/icons/obj/vending.dmi'
	icon_state = "robotics"
	name = "vending machine"

/obj/machine/itemspawner/HelpClick(mob/holder, atom/item, list/params)
	. = ..()
	
	var/list/item_paths = typesof(/obj/item)
	var/list/item_paths_str = list()

	for (var/P in item_paths)
		var/obj/item/I = P // Lets us introspect the initial values
		if (initial(I.name) != "unnamed")
			item_paths_str[initial(I.name)] = "[P]"

	play_sound('assets/cc-by-sa-nc/sound/machines/vending_coin.ogg', src, range=5)

	var/to_spawn = input(holder, "What do you want?", src.name, null) in item_paths_str

	if (isnull(to_spawn))
		return

	var/path = text2path(item_paths_str[to_spawn])
	var/obj/item/spawned = new path(src.find_turf())
	spawned.HelpClick(holder, item, params)

	play_sound('assets/cc-by-sa-nc/sound/machines/vending_dispense.ogg', src, range=5)
