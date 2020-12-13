/obj/sun
	name = "Sun"
	desc = "The Sun. You shouldn't see this, kinda."
	icon = 'cc-by-sa-nc/icons/obj/janitor.dmi'
	icon_state = "caution"
	anchored = TRUE
	invisibility = 101

/obj/sun/New()
	..()
	set_light(12,1000)
