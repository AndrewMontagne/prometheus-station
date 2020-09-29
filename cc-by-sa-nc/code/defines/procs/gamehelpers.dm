/proc/dopage(src,target)
	var/href_list
	var/href
	href_list = params2list("src=\ref[src]&[target]=1")
	href = "src=\ref[src];[target]=1"
	src:Topic(href, href_list)
	return null

/proc/get_area(O)
	var/location = O
	var/i
	for(i=1, i<=20, i++)
		if(!isarea(location))
			location = location:loc
		else
			return location
	return FALSE

/proc/get_area_name(N) //get area by it's name

	for(var/area/A in world)
		if(A.name == N)
			return A
	return FALSE

/proc/in_range(source, user)
	if(get_dist(source, user) <= 1)
		return TRUE
	return FALSE

/proc/circlerange(center=usr,radius=3)

	var/turf/centerturf = get_turf(center)
	var/list/turfs = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/atom/T in range(radius, centerturf))
		var/dx = T.x - centerturf.x
		var/dy = T.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			turfs += T

	//turfs += centerturf
	return turfs

/proc/circleview(center=usr,radius=3)

	var/turf/centerturf = get_turf(center)
	var/list/turfs = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/atom/T in view(radius, centerturf))
		var/dx = T.x - centerturf.x
		var/dy = T.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			turfs += T

	//turfs += centerturf
	return turfs
