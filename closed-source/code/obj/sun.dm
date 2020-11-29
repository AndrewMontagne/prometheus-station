/obj/sun
	name = "Sun"
	desc = "The Sun. You shouldn't see this, kinda."
	icon = 'cc-by-sa-nc/icons/obj/janitor.dmi'
	icon_state = "caution"
/obj/sun/New()
	..()
	set_light(999999,999999)
