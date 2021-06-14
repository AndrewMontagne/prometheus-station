/atom
	var/maximum_hitpoints = -1
	var/hitpoints = -1

/atom/proc/recieve_damage(var/damage, var/damage_type, var/atom/damage_source, var/atom/culprit)
	if (maximum_hitpoints < 0)
		return

	damage = src.check_damage_resistance(damage, damage_type, damage_source, culprit)

	if (damage >= src.hitpoints)
		src.on_broken(damage_type, damage_source, culprit)
	else
		src.hitpoints -= damage

/atom/proc/check_damage_resistance(var/damage, var/damage_type, var/atom/damage_source, var/atom/culprit)
	return damage

/atom/proc/on_broken(var/damage_type, var/atom/damage_source, var/atom/culprit)
	spawn(0) del(src)
