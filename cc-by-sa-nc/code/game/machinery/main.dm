/obj/machinery/New()
	..()
	machines.Add(src)

/obj/machinery/Del()
	machines.Remove(src)
	..()

/obj/machinery/proc/process()
	return
