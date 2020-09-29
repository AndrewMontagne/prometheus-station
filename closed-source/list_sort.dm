/proc/list_bubblesort(list/L, sort_var)
	var i, j
	for(i=L.len, i>0, i--)
		for(j=1, j<i, j++)
			var/datum/l_j = L[j]
			var/datum/l_j1 = L[j + 1]
			if(l_j.vars[sort_var] > l_j1.vars[sort_var])
				L.Swap(j, j+1)
	return L
	
// The following functions are adapted from http://www.byond.com/developer/theodis/quicksort

/proc/_QSPartition(list/L, l, r, cmp)
	var s,m,pivot

	ASSERT(l != r)

	s = l
	m = (l+r)>>1

	if(_QSCmp(cmp, L[l], L[m]) > 0)
		L.Swap(l, m)
	if(_QSCmp(cmp, L[l], L[r]) > 0)
		L.Swap(l, r)
	if(_QSCmp(cmp, L[m], L[r]) > 0)
		L.Swap(m, r)

	L.Swap(m,r-1)
	pivot = r-1
	r--
	while(1)
		do
			l++
		while(_QSCmp(cmp, L[l], L[pivot]) < 0)
		do
			r--
		while(_QSCmp(cmp, L[r], L[pivot]) > 0)
		if(l < r)
			L.Swap(l,r)
		else
			break;
	L.Swap(l,pivot)
	return l - s

/proc/_QSCmp(cmp, datum/a, datum/b)
	if(!istext(cmp))
		return call(cmp)(a,b)

	return a.vars[cmp] < b.vars[cmp]


/proc/list_quicksort(list/L, cmp, start = 1, end = L.len)
	if(start < end)
		if(end - start + 1 < 10) // Insert sort short lists
			list_insertsort(L, cmp, start, end)
		else
			var/i = _QSPartition(L, start, end, cmp);
			list_quicksort(L, cmp, start, start + i);
			list_quicksort(L, cmp, start + i + 1, end);

/proc/list_insertsort(L[], cmp, start = 1, end = L.len)
	for(var/i = start; i <= end; i++)
		var/val = L[i]
		var/j = i - 1
		while(j >= start && _QSCmp(cmp, L[j], val) > 0)
			L[j+1] = L[j]
			j--
		L[j+1] = val
