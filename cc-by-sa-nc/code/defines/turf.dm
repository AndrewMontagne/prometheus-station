/turf
	icon = 'cc-by-sa-nc/icons/turf/floors.dmi'
	var/intact = 1

	level = 1.0

	var
		blocks_air = 0
		icon_old = null
		pathweight = 1

/turf/simulated
	name = "station"
	var/wet = 0
	var/image/wet_overlay = null

	var/thermite = 0

/turf/simulated/floor/engine
	name = "reinforced floor"
	icon_state = "engine"

/turf/simulated/floor/engine/vacuum
	name = "vacuum floor"
	icon_state = "engine"


/turf/simulated/floor
	name = "floor"
	icon = 'cc-by-sa-nc/icons/turf/floors.dmi'
	icon_state = "floor"
	var/broken = 0
	var/burnt = 0

	airless
		name = "airless floor"

		New()
			..()
			name = "floor"

/turf/simulated/floor/plating
	name = "plating"
	icon_state = "plating"
	intact = 0

/turf/simulated/floor/plating/airless
	name = "airless plating"

	New()
		..()
		name = "plating"

/turf/simulated/floor/grid
	icon = 'cc-by-sa-nc/icons/turf/floors.dmi'
	icon_state = "bcircuit"

/turf/simulated/wall/r_wall
	name = "r wall"
	icon = 'cc-by-sa-nc/icons/turf/walls.dmi'
	icon_state = "r_wall"
	opacity = 1
	density = 1
	var/d_state = 0

/turf/simulated/wall
	name = "wall"
	icon = 'cc-by-sa-nc/icons/turf/walls.dmi'
	opacity = 1
	density = 1
	blocks_air = 1

/turf/simulated/shuttle
	name = "shuttle"
	icon = 'cc-by-sa-nc/icons/turf/shuttle.dmi'

/turf/simulated/shuttle/wall
	name = "wall"
	icon_state = "wall1"
	opacity = 1
	density = 1
	blocks_air = 1

/turf/simulated/shuttle/floor
	name = "floor"
	icon_state = "floor"

/turf/unsimulated
	name = "command"

/turf/unsimulated/floor
	name = "floor"
	icon = 'cc-by-sa-nc/icons/turf/floors.dmi'
	icon_state = "Floor3"

/turf/unsimulated/wall
	name = "wall"
	icon = 'cc-by-sa-nc/icons/turf/walls.dmi'
	icon_state = "riveted"
	opacity = 1
	density = 1

/turf/unsimulated/wall/other
	icon_state = "r_wall"

/turf/proc
	AdjacentTurfs()
		var/L[] = new()
		for(var/turf/simulated/t in oview(src,1))
			if(!t.density)
				if(!LinkBlocked(src, t) && !TurfBlockedNonWindow(t))
					L.Add(t)
		return L
	Distance(turf/t)
		if(get_dist(src,t) == 1)
			var/cost = (src.x - t.x) * (src.x - t.x) + (src.y - t.y) * (src.y - t.y)
			cost *= (pathweight+t.pathweight)/2
			return cost
		else
			return get_dist(src,t)
	AdjacentTurfsSpace()
		var/L[] = new()
		for(var/turf/t in oview(src,1))
			if(!t.density)
				if(!LinkBlocked(src, t) && !TurfBlockedNonWindow(t))
					L.Add(t)
		return L
