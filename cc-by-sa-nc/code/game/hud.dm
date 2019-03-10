
#define ui_dropbutton "SOUTH,7"
#define ui_swapbutton "SOUTH,7"
#define ui_iclothing "SOUTH,2"
#define ui_oclothing "SOUTH+1,2"
//#define ui_headset "SOUTH,8"
#define ui_rhand "SOUTH+1,1"
#define ui_lhand "SOUTH+1,3"
#define ui_id "SOUTH,1"
#define ui_mask "SOUTH+2,1"
#define ui_back "SOUTH+2,3"
#define ui_storage1 "SOUTH,4"
#define ui_storage2 "SOUTH,5"
#define ui_resist "EAST,SOUTH"
#define ui_gloves "SOUTH+1,5"
#define ui_glasses "SOUTH+1,7"
#define ui_ears "SOUTH+1,6"
#define ui_head "SOUTH+2,2"
#define ui_shoes "SOUTH+1,4"
#define ui_belt "SOUTH,3"
#define ui_throw "SOUTH,8"
#define ui_oxygen "EAST, NORTH-4"
#define ui_toxin "EAST, NORTH-6"
#define ui_internal "EAST, NORTH-2"
#define ui_fire "EAST, NORTH-8"
#define ui_temp "EAST, NORTH-10"
#define ui_health "EAST, NORTH-11"
#define ui_pull "SOUTH,10"
#define ui_hand "SOUTH,6"
#define ui_sleep "EAST, NORTH-12"
#define ui_rest "EAST, NORTH-13"

#define ui_acti "SOUTH,12"
#define ui_movi "SOUTH,14"

#define ui_iarrowleft "SOUTH,11"
#define ui_iarrowright "SOUTH,13"

mob/living/carbon/uses_hud = 1

obj/hud/New()
	src.instantiate()
	..()
	return


/obj/hud/proc/other_update()

	if(!mymob) return
	if(show_otherinventory)
		if(mymob:shoes) mymob:shoes:screen_loc = ui_shoes
		if(mymob:gloves) mymob:gloves:screen_loc = ui_gloves
		if(mymob:ears) mymob:ears:screen_loc = ui_ears
//		if(mymob:w_radio) mymob:w_radio:screen_loc = ui_headset
		if(mymob:glasses) mymob:glasses:screen_loc = ui_glasses
	else
		if(mymob:shoes) mymob:shoes:screen_loc = null
		if(mymob:gloves) mymob:gloves:screen_loc = null
		if(mymob:ears) mymob:ears:screen_loc = null
//		if(mymob:w_radio) mymob:w_radio:screen_loc = null
		if(mymob:glasses) mymob:glasses:screen_loc = null


/obj/hud/var/show_otherinventory = 1
/obj/hud/var/obj/screen/action_intent
/obj/hud/var/obj/screen/move_intent

/obj/hud/proc/instantiate()

	mymob = src.loc
	ASSERT(istype(mymob, /mob))

	if(!mymob.uses_hud) return

	if(istype(mymob, /mob/living/carbon/human))
		src.human_hud()
		return

	if(istype(mymob, /mob/living/carbon/monkey))
		src.monkey_hud()
		return

	//aliens
	if(istype(mymob, /mob/living/carbon/alien/larva))
		src.larva_hud()
	else if(istype(mymob, /mob/living/carbon/alien))
		src.alien_hud()
		return

	if(istype(mymob, /mob/living/silicon/ai))
		src.ai_hud()
		return

	if(istype(mymob, /mob/living/silicon/robot))
		src.robot_hud()
		return

	if(istype(mymob, /mob/dead/observer))
		src.ghost_hud()
		return
