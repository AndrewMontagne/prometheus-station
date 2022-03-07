var/global/list/icon_smoothing_lut = list()

/// This contains a lookup table for every possible icon smoothing combination
/controller/smoothing/New()
	. = ..()
	
	icon_smoothing_lut["00"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["01"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["02"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["03"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["04"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["05"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["06"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["07"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["08"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["09"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["010"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["011"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["012"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["013"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["014"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["015"] = list("1-i","2-i","3-i","4-i")
	icon_smoothing_lut["10"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["11"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["12"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["13"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["14"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["15"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["16"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["17"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["18"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["19"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["110"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["111"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["112"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["113"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["114"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["115"] = list("1-n","2-n","3-i","4-i")
	icon_smoothing_lut["20"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["21"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["22"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["23"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["24"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["25"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["26"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["27"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["28"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["29"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["210"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["211"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["212"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["213"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["214"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["215"] = list("1-i","2-e","3-i","4-e")
	icon_smoothing_lut["30"] = list("1-n","2-ne","3-i","4-e")
	icon_smoothing_lut["31"] = list("1-n","2-f","3-i","4-e")
	icon_smoothing_lut["32"] = list("1-n","2-ne","3-i","4-e")
	icon_smoothing_lut["33"] = list("1-n","2-f","3-i","4-e")
	icon_smoothing_lut["34"] = list("1-n","2-ne","3-i","4-e")
	icon_smoothing_lut["35"] = list("1-n","2-f","3-i","4-e")
	icon_smoothing_lut["36"] = list("1-n","2-ne","3-i","4-e")
	icon_smoothing_lut["37"] = list("1-n","2-f","3-i","4-e")
	icon_smoothing_lut["38"] = list("1-n","2-ne","3-i","4-e")
	icon_smoothing_lut["39"] = list("1-n","2-f","3-i","4-e")
	icon_smoothing_lut["310"] = list("1-n","2-ne","3-i","4-e")
	icon_smoothing_lut["311"] = list("1-n","2-f","3-i","4-e")
	icon_smoothing_lut["312"] = list("1-n","2-ne","3-i","4-e")
	icon_smoothing_lut["313"] = list("1-n","2-f","3-i","4-e")
	icon_smoothing_lut["314"] = list("1-n","2-ne","3-i","4-e")
	icon_smoothing_lut["315"] = list("1-n","2-f","3-i","4-e")
	icon_smoothing_lut["40"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["41"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["42"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["43"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["44"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["45"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["46"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["47"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["48"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["49"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["410"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["411"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["412"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["413"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["414"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["415"] = list("1-i","2-i","3-s","4-s")
	icon_smoothing_lut["50"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["51"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["52"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["53"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["54"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["55"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["56"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["57"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["58"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["59"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["510"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["511"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["512"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["513"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["514"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["515"] = list("1-n","2-n","3-s","4-s")
	icon_smoothing_lut["60"] = list("1-i","2-e","3-s","4-se")
	icon_smoothing_lut["61"] = list("1-i","2-e","3-s","4-se")
	icon_smoothing_lut["62"] = list("1-i","2-e","3-s","4-f")
	icon_smoothing_lut["63"] = list("1-i","2-e","3-s","4-f")
	icon_smoothing_lut["64"] = list("1-i","2-e","3-s","4-se")
	icon_smoothing_lut["65"] = list("1-i","2-e","3-s","4-se")
	icon_smoothing_lut["66"] = list("1-i","2-e","3-s","4-f")
	icon_smoothing_lut["67"] = list("1-i","2-e","3-s","4-f")
	icon_smoothing_lut["68"] = list("1-i","2-e","3-s","4-se")
	icon_smoothing_lut["69"] = list("1-i","2-e","3-s","4-se")
	icon_smoothing_lut["610"] = list("1-i","2-e","3-s","4-f")
	icon_smoothing_lut["611"] = list("1-i","2-e","3-s","4-f")
	icon_smoothing_lut["612"] = list("1-i","2-e","3-s","4-se")
	icon_smoothing_lut["613"] = list("1-i","2-e","3-s","4-se")
	icon_smoothing_lut["614"] = list("1-i","2-e","3-s","4-f")
	icon_smoothing_lut["615"] = list("1-i","2-e","3-s","4-f")
	icon_smoothing_lut["70"] = list("1-n","2-ne","3-s","4-se")
	icon_smoothing_lut["71"] = list("1-n","2-f","3-s","4-se")
	icon_smoothing_lut["72"] = list("1-n","2-ne","3-s","4-f")
	icon_smoothing_lut["73"] = list("1-n","2-f","3-s","4-f")
	icon_smoothing_lut["74"] = list("1-n","2-ne","3-s","4-se")
	icon_smoothing_lut["75"] = list("1-n","2-f","3-s","4-se")
	icon_smoothing_lut["76"] = list("1-n","2-ne","3-s","4-f")
	icon_smoothing_lut["77"] = list("1-n","2-f","3-s","4-f")
	icon_smoothing_lut["78"] = list("1-n","2-ne","3-s","4-se")
	icon_smoothing_lut["79"] = list("1-n","2-f","3-s","4-se")
	icon_smoothing_lut["710"] = list("1-n","2-ne","3-s","4-f")
	icon_smoothing_lut["711"] = list("1-n","2-f","3-s","4-f")
	icon_smoothing_lut["712"] = list("1-n","2-ne","3-s","4-se")
	icon_smoothing_lut["713"] = list("1-n","2-f","3-s","4-se")
	icon_smoothing_lut["714"] = list("1-n","2-ne","3-s","4-f")
	icon_smoothing_lut["715"] = list("1-n","2-f","3-s","4-f")
	icon_smoothing_lut["80"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["81"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["82"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["83"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["84"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["85"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["86"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["87"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["88"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["89"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["810"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["811"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["812"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["813"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["814"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["815"] = list("1-w","2-i","3-w","4-i")
	icon_smoothing_lut["90"] = list("1-nw","2-n","3-w","4-i")
	icon_smoothing_lut["91"] = list("1-nw","2-n","3-w","4-i")
	icon_smoothing_lut["92"] = list("1-nw","2-n","3-w","4-i")
	icon_smoothing_lut["93"] = list("1-nw","2-n","3-w","4-i")
	icon_smoothing_lut["94"] = list("1-nw","2-n","3-w","4-i")
	icon_smoothing_lut["95"] = list("1-nw","2-n","3-w","4-i")
	icon_smoothing_lut["96"] = list("1-nw","2-n","3-w","4-i")
	icon_smoothing_lut["97"] = list("1-nw","2-n","3-w","4-i")
	icon_smoothing_lut["98"] = list("1-f","2-n","3-w","4-i")
	icon_smoothing_lut["99"] = list("1-f","2-n","3-w","4-i")
	icon_smoothing_lut["910"] = list("1-f","2-n","3-w","4-i")
	icon_smoothing_lut["911"] = list("1-f","2-n","3-w","4-i")
	icon_smoothing_lut["912"] = list("1-f","2-n","3-w","4-i")
	icon_smoothing_lut["913"] = list("1-f","2-n","3-w","4-i")
	icon_smoothing_lut["914"] = list("1-f","2-n","3-w","4-i")
	icon_smoothing_lut["915"] = list("1-f","2-n","3-w","4-i")
	icon_smoothing_lut["100"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["101"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["102"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["103"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["104"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["105"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["106"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["107"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["108"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["109"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["1010"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["1011"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["1012"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["1013"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["1014"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["1015"] = list("1-w","2-e","3-w","4-e")
	icon_smoothing_lut["110"] = list("1-nw","2-ne","3-w","4-e")
	icon_smoothing_lut["111"] = list("1-nw","2-f","3-w","4-e")
	icon_smoothing_lut["112"] = list("1-nw","2-ne","3-w","4-e")
	icon_smoothing_lut["113"] = list("1-nw","2-f","3-w","4-e")
	icon_smoothing_lut["114"] = list("1-nw","2-ne","3-w","4-e")
	icon_smoothing_lut["115"] = list("1-nw","2-f","3-w","4-e")
	icon_smoothing_lut["116"] = list("1-nw","2-ne","3-w","4-e")
	icon_smoothing_lut["117"] = list("1-nw","2-f","3-w","4-e")
	icon_smoothing_lut["118"] = list("1-f","2-ne","3-w","4-e")
	icon_smoothing_lut["119"] = list("1-f","2-f","3-w","4-e")
	icon_smoothing_lut["1110"] = list("1-f","2-ne","3-w","4-e")
	icon_smoothing_lut["1111"] = list("1-f","2-f","3-w","4-e")
	icon_smoothing_lut["1112"] = list("1-f","2-ne","3-w","4-e")
	icon_smoothing_lut["1113"] = list("1-f","2-f","3-w","4-e")
	icon_smoothing_lut["1114"] = list("1-f","2-ne","3-w","4-e")
	icon_smoothing_lut["1115"] = list("1-f","2-f","3-w","4-e")
	icon_smoothing_lut["120"] = list("1-w","2-i","3-sw","4-s")
	icon_smoothing_lut["121"] = list("1-w","2-i","3-sw","4-s")
	icon_smoothing_lut["122"] = list("1-w","2-i","3-sw","4-s")
	icon_smoothing_lut["123"] = list("1-w","2-i","3-sw","4-s")
	icon_smoothing_lut["124"] = list("1-w","2-i","3-f","4-s")
	icon_smoothing_lut["125"] = list("1-w","2-i","3-f","4-s")
	icon_smoothing_lut["126"] = list("1-w","2-i","3-f","4-s")
	icon_smoothing_lut["127"] = list("1-w","2-i","3-f","4-s")
	icon_smoothing_lut["128"] = list("1-w","2-i","3-sw","4-s")
	icon_smoothing_lut["129"] = list("1-w","2-i","3-sw","4-s")
	icon_smoothing_lut["1210"] = list("1-w","2-i","3-sw","4-s")
	icon_smoothing_lut["1211"] = list("1-w","2-i","3-sw","4-s")
	icon_smoothing_lut["1212"] = list("1-w","2-i","3-f","4-s")
	icon_smoothing_lut["1213"] = list("1-w","2-i","3-f","4-s")
	icon_smoothing_lut["1214"] = list("1-w","2-i","3-f","4-s")
	icon_smoothing_lut["1215"] = list("1-w","2-i","3-f","4-s")
	icon_smoothing_lut["130"] = list("1-nw","2-n","3-sw","4-s")
	icon_smoothing_lut["131"] = list("1-nw","2-n","3-sw","4-s")
	icon_smoothing_lut["132"] = list("1-nw","2-n","3-sw","4-s")
	icon_smoothing_lut["133"] = list("1-nw","2-n","3-sw","4-s")
	icon_smoothing_lut["134"] = list("1-nw","2-n","3-f","4-s")
	icon_smoothing_lut["135"] = list("1-nw","2-n","3-f","4-s")
	icon_smoothing_lut["136"] = list("1-nw","2-n","3-f","4-s")
	icon_smoothing_lut["137"] = list("1-nw","2-n","3-f","4-s")
	icon_smoothing_lut["138"] = list("1-f","2-n","3-sw","4-s")
	icon_smoothing_lut["139"] = list("1-f","2-n","3-sw","4-s")
	icon_smoothing_lut["1310"] = list("1-f","2-n","3-sw","4-s")
	icon_smoothing_lut["1311"] = list("1-f","2-n","3-sw","4-s")
	icon_smoothing_lut["1312"] = list("1-f","2-n","3-f","4-s")
	icon_smoothing_lut["1313"] = list("1-f","2-n","3-f","4-s")
	icon_smoothing_lut["1314"] = list("1-f","2-n","3-f","4-s")
	icon_smoothing_lut["1315"] = list("1-f","2-n","3-f","4-s")
	icon_smoothing_lut["140"] = list("1-w","2-e","3-sw","4-se")
	icon_smoothing_lut["141"] = list("1-w","2-e","3-sw","4-se")
	icon_smoothing_lut["142"] = list("1-w","2-e","3-sw","4-f")
	icon_smoothing_lut["143"] = list("1-w","2-e","3-sw","4-f")
	icon_smoothing_lut["144"] = list("1-w","2-e","3-f","4-se")
	icon_smoothing_lut["145"] = list("1-w","2-e","3-f","4-se")
	icon_smoothing_lut["146"] = list("1-w","2-e","3-f","4-f")
	icon_smoothing_lut["147"] = list("1-w","2-e","3-f","4-f")
	icon_smoothing_lut["148"] = list("1-w","2-e","3-sw","4-se")
	icon_smoothing_lut["149"] = list("1-w","2-e","3-sw","4-se")
	icon_smoothing_lut["1410"] = list("1-w","2-e","3-sw","4-f")
	icon_smoothing_lut["1411"] = list("1-w","2-e","3-sw","4-f")
	icon_smoothing_lut["1412"] = list("1-w","2-e","3-f","4-se")
	icon_smoothing_lut["1413"] = list("1-w","2-e","3-f","4-se")
	icon_smoothing_lut["1414"] = list("1-w","2-e","3-f","4-f")
	icon_smoothing_lut["1415"] = list("1-w","2-e","3-f","4-f")
	icon_smoothing_lut["150"] = list("1-nw","2-ne","3-sw","4-se")
	icon_smoothing_lut["151"] = list("1-nw","2-f","3-sw","4-se")
	icon_smoothing_lut["152"] = list("1-nw","2-ne","3-sw","4-f")
	icon_smoothing_lut["153"] = list("1-nw","2-f","3-sw","4-f")
	icon_smoothing_lut["154"] = list("1-nw","2-ne","3-f","4-se")
	icon_smoothing_lut["155"] = list("1-nw","2-f","3-f","4-se")
	icon_smoothing_lut["156"] = list("1-nw","2-ne","3-f","4-f")
	icon_smoothing_lut["157"] = list("1-nw","2-f","3-f","4-f")
	icon_smoothing_lut["158"] = list("1-f","2-ne","3-sw","4-se")
	icon_smoothing_lut["159"] = list("1-f","2-f","3-sw","4-se")
	icon_smoothing_lut["1510"] = list("1-f","2-ne","3-sw","4-f")
	icon_smoothing_lut["1511"] = list("1-f","2-f","3-sw","4-f")
	icon_smoothing_lut["1512"] = list("1-f","2-ne","3-f","4-se")
	icon_smoothing_lut["1513"] = list("1-f","2-f","3-f","4-se")
	icon_smoothing_lut["1514"] = list("1-f","2-ne","3-f","4-f")
	icon_smoothing_lut["1515"] = list("1-f","2-f","3-f","4-f")

	if (length(icon_smoothing_lut) != 0)
		return

	for (var/edges = 0, edges<16, edges++)
		for (var/corners = 0, corners<16, corners++)
			var/totalstate = src.lut_gen(edges, corners)
			world.log << "icon_smoothing_lut\[\"[edges][corners]\"\] = list([totalstate])"


/// Generate the LUT if needed
/controller/smoothing/proc/lut_gen(var/edges, var/corners)

	// NORTH WEST
	var/state = "i"
	if ((edges & SMOOTHING_DIR_W) && (edges & SMOOTHING_DIR_N))
		if (corners & SMOOTHING_DIR_NW)
			state = "f"
		else
			state = "nw"
	else if (edges & SMOOTHING_DIR_W)
		state = "w"
	else if (edges & SMOOTHING_DIR_N)
		state = "n"

	var/totalstate = "\"1-[state]\","

	// NORTH EAST
	state = "i"
	if ((edges & SMOOTHING_DIR_E) && (edges & SMOOTHING_DIR_N))
		if (corners & SMOOTHING_DIR_NE)
			state = "f"
		else
			state = "ne"
	else if (edges & SMOOTHING_DIR_E)
		state = "e"
	else if (edges & SMOOTHING_DIR_N)
		state = "n"

	totalstate += "\"2-[state]\","

	// SOUTH WEST
	state = "i"
	if ((edges & SMOOTHING_DIR_W) && (edges & SMOOTHING_DIR_S))
		if (corners & SMOOTHING_DIR_SW)
			state = "f"
		else
			state = "sw"
	else if (edges & SMOOTHING_DIR_W)
		state = "w"
	else if (edges & SMOOTHING_DIR_S)
		state = "s"

	totalstate += "\"3-[state]\","

	// SOUTH EAST
	state = "i"
	if ((edges & SMOOTHING_DIR_E) && (edges & SMOOTHING_DIR_S))
		if (corners & SMOOTHING_DIR_SE)
			state = "f"
		else
			state = "se"
	else if (edges & SMOOTHING_DIR_E)
		state = "e"
	else if (edges & SMOOTHING_DIR_S)
		state = "s"

	totalstate += "\"4-[state]\""

	return totalstate
