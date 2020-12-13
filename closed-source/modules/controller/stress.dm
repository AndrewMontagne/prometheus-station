
/controller/stress
	var/hash = ""
	var/proof = ""
	var/match = ""
	var/a = "1:16:220813:andrew@montagne.uk"

/controller/stress/New(var/newmatch, var/newpriority)
	. = ..()

	src.priority = newpriority
	src.match = newmatch

/// Hashcache implementation
/controller/stress/process()
	. = ..()

	var/s = rand(5000,50000)

	while (TRUE)
		s += 1
		proof = "[a]::[s]"
		hash = md5(proof)
		if (copytext(hash,1,length(match) + 1) == match)
			break
		yield()
	
	LOG_TRACE("[src.priority] [src.hash]")
