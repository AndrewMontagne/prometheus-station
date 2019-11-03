/mob/dead/observer/Login()
	..()

	src.client.screen = null
	src.client.screen += base_hud()


	if (!isturf(src.loc))
		src.client.eye = src.loc
		src.client.perspective = EYE_PERSPECTIVE

	return