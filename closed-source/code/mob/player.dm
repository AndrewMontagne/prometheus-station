
/** 
Base class for player mobs intended for normal gameplay.

All playable mobs should inherit from this class. Mobs not inheriting from this class are for technical internal use only.
**/
/mob/player
	icon = 'cc-by-sa-nc/icons/mob/human.dmi'
	icon_state = "body_m_s"
	maximum_hitpoints = 100
	hitpoints = 100

/mob/player/New(var/loc)
	. = ..(loc)

	var/obj/screen/inventoryslot/jacket/jacket = new(src)
	jacket.screen_loc = "CENTER,3"
	src.screen += jacket
	var/obj/screen/inventoryslot/gloves/gloves = new(src)
	gloves.screen_loc = "CENTER:-32,3"
	src.screen += gloves
	var/obj/screen/inventoryslot/shoes/shoes = new(src)
	shoes.screen_loc = "CENTER:32,3"
	src.screen += shoes

	var/obj/screen/inventoryslot/hand/left/hand_l = new(src)
	src.screen += hand_l
	var/obj/screen/inventoryslot/hand/right/hand_r = new(src)
	src.screen += hand_r
