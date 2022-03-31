var/global/datum/globals/GLOBALS = new()

/datum/globals

/datum/globals/New()
	. = ..()
	src.tag = "globals"

/// The message of the day
VAR_GLOBAL(motd) = "Message of the day!"
