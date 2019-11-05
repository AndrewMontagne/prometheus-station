/obj/screen/space
    screen_loc = "SOUTH, WEST"
    plane = -90
    icon = 'space.dmi'
    icon_state = "animate"
    name = "space"
    mouse_opacity = 0


/client/proc/get_parallax()
    var/global/obj/screen/space/parallax = null
    if(isnull(parallax))
        parallax = new()
    return parallax

/obj/screen/space/New()
    var/list/view_dims = splittext(world.view,"x")
    var/width = world.view
    var/height = world.view
    if(length(view_dims) == 2)
        width = text2num(view_dims[1])
        height = text2num(view_dims[2])

    var/icon/space1 = new(icon, "animate1")
    space1.Scale(width * 32, height * 32)
    var/icon/space2 = new(icon, "animate2")
    space2.Scale(width * 32, height * 32)
    var/icon/space3 = new(icon, "animate3")
    space3.Scale(width * 32, height * 32)
    var/icon/space4 = new(icon, "animate4")
    space4.Scale(width * 32, height * 32)
    
    for(var/x = 0, x < width, x++)
        for(var/y = 0, y < height, y++)
            var/icon/ID = icon(icon, icon_state="[pick(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25)]")
            var/icon/space = pick(space1, space2, space2, space3, space3, space3, space4, space4, space4)
            space.Blend(ID, ICON_OVERLAY, 1 + (x * 32), 1 + (y * 32))
    
    icon = space1
    overlays += space2
    overlays += space3
    overlays += space4
