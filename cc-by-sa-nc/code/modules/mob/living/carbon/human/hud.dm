/obj/hud/proc/human_hud()

	src.adding = list(  )
	src.other = list(  )
	src.intents = list(  )
	src.mon_blo = list(  )
	src.m_ints = list(  )
	src.mov_int = list(  )
	src.vimpaired = list(  )
	src.darkMask = list(  )

	var/obj/screen/using

	using = new src.h_type( src )
	using.name = "act_intent"
	using.dir = SOUTHWEST
	using.icon_state = (mymob.a_intent == "hurt" ? "harm" : mymob.a_intent)
	using.screen_loc = ui_acti
	using.layer = 20
	src.adding += using
	action_intent = using

	using = new src.h_type( src )
	using.name = "mov_intent"
	using.dir = SOUTHWEST
	using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
	using.screen_loc = ui_movi
	using.layer = 20
	src.adding += using
	move_intent = using

	using = new src.h_type( src )
	using.name = "arrowleft"
	using.icon_state = "s_arrow"
	using.dir = WEST
	using.screen_loc = ui_iarrowleft
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "arrowright"
	using.icon_state = "s_arrow"
	using.dir = EAST
	using.screen_loc = ui_iarrowright
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "drop"
	using.icon_state = "act_drop"
	using.screen_loc = ui_dropbutton
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "i_clothing"
	using.dir = SOUTH
	using.icon_state = "center"
	using.screen_loc = ui_iclothing
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "o_clothing"
	using.dir = SOUTH
	using.icon_state = "equip"
	using.screen_loc = ui_oclothing
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "r_hand"
	using.dir = WEST
	using.icon_state = "equip"
	using.screen_loc = ui_rhand
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "l_hand"
	using.dir = EAST
	using.icon_state = "equip"
	using.screen_loc = ui_lhand
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "id"
	using.dir = SOUTHWEST
	using.icon_state = "equip"
	using.screen_loc = ui_id
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "mask"
	using.dir = NORTH
	using.icon_state = "equip"
	using.screen_loc = ui_mask
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "back"
	using.dir = NORTHEAST
	using.icon_state = "equip"
	using.screen_loc = ui_back
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "storage1"
	using.icon_state = "pocket"
	using.screen_loc = ui_storage1
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "storage2"
	using.icon_state = "pocket"
	using.screen_loc = ui_storage2
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "resist"
	using.icon_state = "act_resist"
	using.screen_loc = ui_resist
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "other"
	using.icon_state = "other"
	using.screen_loc = ui_shoes
	using.layer = 20
	src.adding += using

	using = new src.h_type( src )
	using.name = "gloves"
	using.icon_state = "gloves"
	using.screen_loc = ui_gloves
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "eyes"
	using.icon_state = "glasses"
	using.screen_loc = ui_glasses
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "ears"
	using.icon_state = "ears"
	using.screen_loc = ui_ears
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "head"
	using.icon_state = "hair"
	using.screen_loc = ui_head
	using.layer = 19
	src.adding += using

	using = new src.h_type( src )
	using.name = "shoes"
	using.icon_state = "shoes"
	using.screen_loc = ui_shoes
	using.layer = 19
	src.other += using

	using = new src.h_type( src )
	using.name = "belt"
	using.icon_state = "belt"
	using.screen_loc = ui_belt
	using.layer = 19
	src.adding += using


	using = new src.h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "1,1 to 5,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "5,1 to 10,5"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "6,11 to 10,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using
	using = new src.h_type( src )
	using.name = null
	using.icon_state = "dither50"
	using.screen_loc = "11,1 to 15,15"
	using.layer = 17
	using.mouse_opacity = 0
	src.vimpaired += using

	mymob.throw_icon = new /obj/screen(null)
	mymob.throw_icon.icon_state = "act_throw_off"
	mymob.throw_icon.name = "throw"
	mymob.throw_icon.screen_loc = ui_throw

	mymob.oxygen = new /obj/screen( null )
	mymob.oxygen.icon_state = "oxy0"
	mymob.oxygen.name = "oxygen"
	mymob.oxygen.screen_loc = ui_oxygen

	mymob.toxin = new /obj/screen( null )
	mymob.toxin.icon = 'cc-by-sa-nc/icons/mob/screen1.dmi'
	mymob.toxin.icon_state = "tox0"
	mymob.toxin.name = "toxin"
	mymob.toxin.screen_loc = ui_toxin

	mymob.internals = new /obj/screen( null )
	mymob.internals.icon_state = "internal0"
	mymob.internals.name = "internal"
	mymob.internals.screen_loc = ui_internal

	mymob.fire = new /obj/screen( null )
	mymob.fire.icon_state = "fire0"
	mymob.fire.name = "fire"
	mymob.fire.screen_loc = ui_fire

	mymob.bodytemp = new /obj/screen( null )
	mymob.bodytemp.icon_state = "temp1"
	mymob.bodytemp.name = "body temperature"
	mymob.bodytemp.screen_loc = ui_temp

	mymob.healths = new /obj/screen( null )
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

	mymob.pullin = new /obj/screen( null )
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull

	mymob.blind = new /obj/screen( null )
	mymob.blind.icon_state = "black"
	mymob.blind.name = "blind"
	mymob.blind.screen_loc = "1,1 to 15,15"
	mymob.blind.layer = 17
	mymob.blind.invisibility = 101

	mymob.flash = new /obj/screen( null )
	mymob.flash.icon_state = "blank"
	mymob.flash.name = "flash"
	mymob.flash.screen_loc = "1,1 to 15,15"
	mymob.flash.layer = 17

	mymob.hands = new /obj/screen( null )
	mymob.hands.icon_state = "hand"
	mymob.hands.name = "hand"
	mymob.hands.screen_loc = ui_hand
	mymob.hands.dir = NORTH

	mymob.sleep = new /obj/screen( null )
	mymob.sleep.icon_state = "sleep0"
	mymob.sleep.name = "sleep"
	mymob.sleep.screen_loc = ui_sleep

	mymob.rest = new /obj/screen( null )
	mymob.rest.icon_state = "rest0"
	mymob.rest.name = "rest"
	mymob.rest.screen_loc = ui_rest

	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.screen_loc = ui_zonesel
	mymob.zone_sel.overlays = null
	mymob.zone_sel.overlays += image("icon" = 'cc-by-sa-nc/icons/mob/zone_sel.dmi', "icon_state" = text("[]", mymob.zone_sel.selecting))

	mymob.client.screen = null

	//, mymob.i_select, mymob.m_select
	mymob.client.screen += list( mymob.throw_icon, mymob.zone_sel, mymob.oxygen, mymob.toxin, mymob.bodytemp, mymob.internals, mymob.fire, mymob.hands, mymob.healths, mymob.pullin, mymob.blind, mymob.flash, mymob.rest, mymob.sleep) //, mymob.mach )
	mymob.client.screen += src.adding + src.other + mymob.base_hud()

	//if(istype(mymob,/mob/living/carbon/monkey)) mymob.client.screen += src.mon_blo

	return
