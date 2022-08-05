/**
Clothing
**/

/obj/item/clothing

/obj/item/clothing/jumpsuit
	name = "grey jumpsuit"
	icon = 'assets/cc-by-sa-nc/icons_new/item/clothing/jumpsuits.dmi'
	icon_state = "grey"
	slots = list(SLOT_JACKET, SLOT_SUIT)
	internal_slots = list(new /obj/screen/inventoryslot/pocket(), new /obj/screen/inventoryslot/pocket())

/obj/item/clothing/gloves
	name = "gloves"
	icon = 'assets/cc-by-sa-nc/icons_new/item/clothing/gloves.dmi'
	icon_state = "yellow"
	slots = list(SLOT_GLOVES)

/obj/item/clothing/shoes
	name = "shoes"
	icon = 'assets/cc-by-sa-nc/icons_new/item/clothing/shoes.dmi'
	icon_state = "black"
	slots = list(SLOT_SHOES, SLOT_POCKET)
