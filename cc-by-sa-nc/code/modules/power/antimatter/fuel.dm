/obj/item/weapon/fuel
	name = "Magnetic Storage Ring"
	desc = "A magnetic storage ring."
	icon = 'cc-by-sa-nc/icons/obj/items.dmi'
	icon_state = "rcdammo"
	opacity = 0
	density = 0
	anchored = 0.0
	var/fuel = 0
	var/s_time = 1.0
	var/content = null

/obj/item/weapon/fuel/H
	name = "Hydrogen storage ring"
	content = "Hydrogen"
	fuel = 1e-12		//pico-kilogram

/obj/item/weapon/fuel/antiH
	name = "Anti-Hydrogen storage ring"
	content = "Anti-Hydrogen"
	fuel = 1e-12		//pico-kilogram

/obj/item/weapon/fuel/attackby(obj/item/weapon/fuel/F, mob/user)
	if(istype(src, /obj/item/weapon/fuel/antiH))
		if(istype(F, /obj/item/weapon/fuel/antiH))
			src.fuel += F.fuel
			F.fuel = 0
			user << "You have added the anti-Hydorgen to the storage ring, it now contains [src.fuel]kg"
		if(istype(F, /obj/item/weapon/fuel/H))
			src.fuel += F.fuel
			del(F)
			src:annihilation(src.fuel)
	if(istype(src, /obj/item/weapon/fuel/H))
		if(istype(F, /obj/item/weapon/fuel/H))
			src.fuel += F.fuel
			F.fuel = 0
			user << "You have added the Hydorgen to the storage ring, it now contains [src.fuel]kg"
		if(istype(F, /obj/item/weapon/fuel/antiH))
			src.fuel += F.fuel
			del(src)
			F:annihilation(F.fuel)

/obj/item/weapon/fuel/antiH/proc/annihilation(var/mass)

	del(src)
	return


/obj/item/weapon/fuel/examine()
	set src in view(1)
	if(usr && !usr.stat)
		usr << "A magnetic storage ring, it contains [fuel]kg of [content ? content : "nothing"]."

/obj/item/weapon/fuel/proc/injest(mob/M as mob)
	switch(content)
		if("Anti-Hydrogen")
			M.gib(1)
		if("Hydrogen")
			M << "\blue You feel very light, as if you might just float away..."
	del(src)
	return

/obj/item/weapon/fuel/attack(mob/M as mob, mob/user as mob)
	if (user != M)
		var/obj/equip_e/human/O = new /obj/equip_e/human(  )
		O.source = user
		O.target = M
		O.item = src
		O.s_loc = user.loc
		O.t_loc = M.loc
		O.place = "fuel"
		M.requests += O
		spawn( 0 )
			O.process()
			return
	else
		for(var/mob/O in viewers(M, null))
			O.show_message(text("\red [M] ate the [content ? content : "empty canister"]!"), 1)
		src.injest(M)
