#define ui_oxygen "hotbar:0,0"
#define ui_toxin "hotbar:1,0"
#define ui_internal "hotbar:2,0"
#define ui_fire "hotbar:3,0"
#define ui_temp "hotbar:4,0"
#define ui_health "hotbar:5,0"
#define ui_sleep "hotbar:6,0"

#define ui_mask "inventory:-1,0"
#define ui_head "inventory:0,0"
#define ui_ears "inventory:1,0"

#define ui_oclothing "inventory:0,1"
#define ui_rhand "inventory:-1,1"
#define ui_lhand "inventory:1,1"

#define ui_iclothing "inventory:0,2"
#define ui_id "inventory:-1,2"
#define ui_back "inventory:1,2"

#define ui_storage1 "inventory:-1,3"
#define ui_belt "inventory:0,3"
#define ui_storage2 "inventory:1,3"

#define ui_shoes "inventory:0,4"
#define ui_gloves "inventory:-1,4"
#define ui_glasses "inventory:1,4"


#define ui_pull "inventory:-0.5,10"
#define ui_throw "inventory:-0.5,9"
#define ui_dropbutton "inventory:-0.5,8"
#define ui_hand "inventory:-0.5,7"

#define ui_zonesel "inventory:0.5,10"
#define ui_movi "inventory:0.5,9"
#define ui_rest "inventory:0.5,8"
#define ui_resist "inventory:0.5,7"

#define ui_iarrowleft "inventory:-1,6"
#define ui_acti "inventory:0,6"
#define ui_iarrowright "inventory:1,6"

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

	if(istype(mymob, /mob/living/silicon/ai))
		src.ai_hud()
		return

	if(istype(mymob, /mob/living/silicon/robot))
		src.robot_hud()
		return

	if(istype(mymob, /mob/dead/observer))
		src.ghost_hud()
		return
