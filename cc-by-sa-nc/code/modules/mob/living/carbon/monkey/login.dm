/mob/living/carbon/monkey/Login()
	..()

	update_clothing()

	if (!isturf(src.loc))
		src.client.eye = src.loc
		src.client.perspective = EYE_PERSPECTIVE
	if (src.stat == 2)
		src.verbs += /mob/proc/ghostize
	if(src.name == "monkey")
		src.name = text("monkey ([rand(1, 1000)])")
	src.real_name = src.name
	return