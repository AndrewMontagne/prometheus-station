world
	mob = /mob/new_player
	turf = /turf/space
	area = /area
	view = "19x17"

/world/Error(exception/E, datum/src)
	if(!istype(E))
		return ..()

	world.log << "RUNTIME ERROR [E.name] @ [E.file]:[E.line]\n[E.desc]"