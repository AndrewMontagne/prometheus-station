
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

	new /obj/screen/inventoryslot/jacket(src)
	new /obj/screen/inventoryslot/gloves(src)
	new /obj/screen/inventoryslot/shoes(src)
	new /obj/screen/inventoryslot/hat(src)
	new /obj/screen/inventoryslot/ears(src)
	new /obj/screen/inventoryslot/glasses(src)

	var/obj/screen/inventoryslot/hand/left/hand_l = new(src)
	var/obj/screen/inventoryslot/hand/right/hand_r = new(src)
	
	src.hands = list(hand_r, hand_l)

	src.tryequip(new /obj/item/clothing/jumpsuit())
	src.tryequip(new /obj/item/clothing/shoes())

/mob/player/on_gain_client()
	. = ..()

	src.hand_toolbar = new /obj/screen/toolbar(src, src.hands, TRUE, ANCHOR_CENTER, ANCHOR_CENTER, ANCHOR_BOTTOM)
	src.slot_toolbar = new /obj/screen/toolbar(src, list(), FALSE, ANCHOR_LEFT, ANCHOR_LEFT, ANCHOR_CENTER)

	var/list/toolbar_slots = src.build_slot_toolbars()
	for (var/obj/screen/toolbar/T in toolbar_slots)
		slot_toolbar.add_screen(T)


/mob/player/on_lose_client()
	. = ..()

	for (var/slotname in src.slot_toolbars)
		del(src.slot_toolbars[slotname])
	src.slot_toolbars = list()

	del(src.hand_toolbar)
	src.hand_toolbar = null
	del(src.slot_toolbar)
	src.slot_toolbar = null
