/proc/list_bubblesort(list/L, sort_var)
	var i, j
	for(i=L.len, i>0, i--)
		for(j=1, j<i, j++)
			var/datum/l_j = L[j]
			var/datum/l_j1 = L[j + 1]
			if(l_j.vars[sort_var] > l_j1.vars[sort_var])
				L.Swap(j, j+1)
	return L
