/mob/living/silicon/ai
	name = "AI"
	voice_name = "synthesized voice"
	icon = 'cc-by-sa-nc/icons/mob/mob.dmi'//
	icon_state = "ai"
	var/network = "AI Satellite"
	var/obj/machinery/camera/current = null
	var/list/connected_robots = list()
	var/aiRestorePowerRoutine = 0
	var/datum/ai_laws/laws_object = null
	//var/list/laws = list()
	var/alarms = list("Motion"=list(), "Fire"=list(), "Atmosphere"=list(), "Power"=list())
	var/viewalerts = 0

	var/processing_time = 100
	var/fire_res_on_core = 0