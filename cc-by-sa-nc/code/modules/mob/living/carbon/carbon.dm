/mob/living/carbon/Move(NewLoc, direct)
	. = ..()
	if(.)
		if(src.nutrition)
			src.nutrition--

/mob/living/carbon/relaymove(var/mob/user, direction)
	return

/mob/living/carbon/gib(give_medal)
	for(var/mob/M in src)
		M.loc = src.loc
		for(var/mob/N in viewers(src, null))
			if(N.client)
				N.show_message(text("\red <B>[M] bursts out of [src]!</B>"), 2)
	. = ..(give_medal)