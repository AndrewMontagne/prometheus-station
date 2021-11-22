
/** 
Base class for player mobs intended for normal gameplay.

All playable mobs should inherit from this class. Mobs not inheriting from this class are for technical internal use only.
**/
/mob/player
	icon = 'assets/cc-by-sa-nc/icons/mob/human.dmi'
	icon_state = "body_m_s"
	maximum_hitpoints = 100
	hitpoints = 100
	var/obj/screen/toolbar/hand_toolbar
	var/obj/screen/toolbar/slot_toolbar
	var/list/obj/screen/hands

/mob/player/New(var/loc)
	. = ..(loc)
	src.init_chat()

	var/obj/screen/inventoryslot/jacket/jacket = new(src)
	var/obj/screen/inventoryslot/gloves/gloves = new(src)
	var/obj/screen/inventoryslot/shoes/shoes = new(src)
	var/obj/screen/inventoryslot/belt/belt = new(src)
	var/obj/screen/inventoryslot/hat/hat = new(src)
	var/obj/screen/inventoryslot/ears/ears = new(src)
	var/obj/screen/inventoryslot/glasses/glasses = new(src)

	var/obj/screen/inventoryslot/hand/left/hand_l = new(src)
	var/obj/screen/inventoryslot/hand/right/hand_r = new(src)
	
	src.hands = list(hand_r, hand_l)

	src.tryequip(new /obj/item/clothing/jumpsuit())
	src.tryequip(new /obj/item/clothing/shoes())

/mob/player/on_gain_client()
	. = ..()

	var/list/toolbar_slots = list()
	for (var/slotname in src.invslots)
		var/obj/screen/inventoryslot/S = src.invslots[slotname]
		if (istype(S, /obj/screen/inventoryslot/hand))
			continue
		toolbar_slots.Add(S)

	src.hand_toolbar = new /obj/screen/toolbar(src, "mapwindow.map", src.hands, TRUE, ANCHOR_CENTER, ANCHOR_CENTER, ANCHOR_BOTTOM)
	src.slot_toolbar = new /obj/screen/toolbar(src, "mapwindow.map", toolbar_slots, FALSE, ANCHOR_CENTER, ANCHOR_LEFT, ANCHOR_CENTER)


/mob/player/on_lose_client()
	. = ..()
	del(src.hand_toolbar)
	src.hand_toolbar = null
	del(src.slot_toolbar)
	src.slot_toolbar = null
