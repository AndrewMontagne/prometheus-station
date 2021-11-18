
/** 
Base class for player mobs intended for normal gameplay.

All playable mobs should inherit from this class. Mobs not inheriting from this class are for technical internal use only.
**/
/mob/player
	icon = 'assets/cc-by-sa-nc/icons/mob/human.dmi'
	icon_state = "body_m_s"
	maximum_hitpoints = 100
	hitpoints = 100
	var/obj/screen/toolbar/toolbar
	var/list/hands

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
	
	src.hands = list(hand_r, hand_l, jacket, gloves, shoes, belt, hat, ears, glasses)
	src.screen |= src.hands

	src.tryequip(new /obj/item/clothing/jumpsuit())
	src.tryequip(new /obj/item/clothing/shoes())

/mob/player/on_gain_client()
	. = ..()

	var/obj/screen/inventoryslot/ears/drop = new(src)
	var/obj/screen/inventoryslot/ears/drop2 = new(src)
	var/obj/screen/inventoryslot/ears/drop3 = new(src)
	var/list/obj/screen/aaaa = list(drop, drop2, drop3)
	src.client.screen |= aaaa
	var/obj/screen/toolbar/nested_toolbar = null
	nested_toolbar =	new /obj/screen/toolbar(src.client.map_panes["mapwindow.map"], aaaa,      TRUE, ANCHOR_CENTER)
	src.toolbar = 		new /obj/screen/toolbar(src.client.map_panes["mapwindow.map"], src.hands, FALSE, ANCHOR_CENTER, ANCHOR_RIGHT, ANCHOR_CENTER)
	src.toolbar.add_screen(nested_toolbar)
	src.toolbar.loc = src

/mob/player/on_lose_client()
	. = ..()
	del(src.toolbar)
	src.toolbar = null
