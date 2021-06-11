
/** 
Base class for player mobs intended for normal gameplay.

All playable mobs should inherit from this class. Mobs not inheriting from this class are for technical internal use only.
**/
/mob/player
	icon = 'cc-by-sa-nc/icons/mob/human.dmi'
	icon_state = "body_m_s"

/mob/player/New(var/loc)
	. = ..(loc)

	var/obj/screen/inventoryslot/jacket/jacket = new(src)
	jacket.screen_loc = "CENTER,2"
	src.screen += jacket
