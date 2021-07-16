
/** 
Base class for player mobs intended for normal gameplay.

All playable mobs should inherit from this class. Mobs not inheriting from this class are for technical internal use only.
**/
/mob/player
	icon = 'assets/cc-by-sa-nc/icons/mob/human.dmi'
	icon_state = "body_m_s"
	maximum_hitpoints = 100
	hitpoints = 100

/mob/player/New(var/loc)
	. = ..(loc)
	src.init_chat()

	var/obj/screen/inventoryslot/jacket/jacket = new(src)
	jacket.screen_loc = "inventorymap:1,1"
	src.screen += jacket
	var/obj/screen/inventoryslot/gloves/gloves = new(src)
	gloves.screen_loc = "inventorymap:2,1"
	src.screen += gloves
	var/obj/screen/inventoryslot/shoes/shoes = new(src)
	shoes.screen_loc = "inventorymap:3,1"
	src.screen += shoes

	var/obj/screen/inventoryslot/hand/left/hand_l = new(src)
	src.screen += hand_l
	var/obj/screen/inventoryslot/hand/right/hand_r = new(src)
	src.screen += hand_r

	src.tryequip(new /obj/item/clothing/jumpsuit())
	src.tryequip(new /obj/item/clothing/shoes())
