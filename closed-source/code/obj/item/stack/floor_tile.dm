/obj/item/stack/floor_tile
	name = "floor tiles"
	icon = 'assets/cc-by-sa-nc/icons_new/item/tools.dmi'
	icon_state = "floor-tile"
	count = 10
	max_stack = 20

/obj/item/stack/floor_tile/UseOn(mob/holder, atom/target, list/params)
	if (istype(target, /turf/basic/open/plating))
		var/turf/basic/open/plating/T = target
		if (src.remove(1))
			for (var/obj/structure/network_node/N in T.contents)
				N.invisibility = VISIBLITY_UNDER_TILE
			T.change_turf(/turf/basic/open/floor)
			play_sound('assets/cc-by-sa-nc/sound/items/Deconstruct.ogg', target)
