
/obj/screen/swap_hands
	name = "Swap Hands"
	icon = 'assets/cc-by-sa-nc/icons/ui/screen_midnight.dmi'
	icon_state = "swap_1_m"
	screen_loc = "CENTER:-16,BOTTOM+1"

/obj/screen/swap_hands/second
	icon_state = "swap_2"
	screen_loc = "CENTER:+16,BOTTOM+1"

/obj/screen/swap_hands/HelpClick(mob/holder, atom/item, list/params)
	. = ..()
	if (istype(holder, /mob/player))
		var/mob/player/P = holder
		P.change_active_hand()
