/// Structures - Objects that do no periodic processing and consume no power
/obj/structure
	anchored = TRUE

/obj/structure/glass
	density = TRUE
	icon = 'assets/cc-by-sa-nc/icons_new/obj/structure/smooth/reinforced_window.dmi'
	icon_state = "placeholder"
	smoothing_type = SMOOTHING_STRUCTS

/obj/structure/lattice
	density = FALSE
	layer = LAYER_TURF + 0.1
	name = "lattice"
	icon = 'assets/cc-by-sa-nc/icons_new/obj/structure/smooth/lattice.dmi'
	icon_state = "placeholder"
	smoothing_type = SMOOTHING_STRUCTS

/obj/structure/lattice/can_smooth_with(atom/neighbor)
	return istype(neighbor, /turf/space) == FALSE

/obj/structure/signage
	density = FALSE
	layer = LAYER_FLOOR
	icon = 'assets/cc-by-sa/icons/structure/signage.dmi'
