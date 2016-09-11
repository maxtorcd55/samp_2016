stock split(string[],array[10][64])
{
	new i = 0, index = 0;
	while (i < strlen(string) && i >= 0)
	{
	    new find[64];
	    i = token_by_delim(string,find,',',i+1);
	    array[index] = find;
	    index ++;
	}
}

stock string_replace(string[], find, replace)
{
    for(new i=0; string[i]; i++)
    {
        if(string[i] == find)
        {
            string[i] = replace;
        }
    }
}

stock token_by_delim(const string[], return_str[], delim, start_index)
{
	new x=0;
	while(string[start_index] != EOS && string[start_index] != delim) {
	    return_str[x] = string[start_index];
	    x++;
	    start_index++;
	}
	return_str[x] = EOS;
	if(string[start_index] == EOS) start_index = (-1);
	return start_index;
}
stock IsNumeric(const string[]) //By Jan "DracoBlue" Schï¿½tze (edited by Gabriel "Larcius" Cordes
{
	new length=strlen(string);
	if(length==0)
	{
		return 0;
	}
	for (new i=0; i<length; i++)
	{
		if (!((string[i] <= '9' && string[i] >= '0') || (i==0 && (string[i]=='-' || string[i]=='+'))))
		{
			return false;
		}
	}
	return 0;
}


stock numberToStipes(Float: num)
{
	new strip[64];
	print("ok");
	for (new i=0; i<floatround(num, floatround_floor); i++)
	{
        format(strip,sizeof(strip), "%s|",strip);
	}
	return strip;
}

stock binarySearch(array[],length,ToSearch) {
	new lb=0,ub=length-1,z=0;
	while(lb<=ub) {
	    z=(lb+ub)/2;
	    if(array[z]<ToSearch) lb=z+1;
	    else if(array[z]>ToSearch) ub=z-1;
	    else return (z+1);
	}
	return -1;
}

stock quickSortAsc(array[], left, right) {  // can cause stack overflow on extremly large arrays
	new tempLeft = left,tempRight = right,pivot = array[(left + right) / 2],tempVar;
	while(tempLeft <= tempRight) {
		while(array[tempLeft] < pivot) {
			tempLeft++;
		}
		while(array[tempRight] > pivot) {
			tempRight--;
		}
    	if(tempLeft <= tempRight) {
        	tempVar = array[tempLeft], array[tempLeft] = array[tempRight], array[tempRight] = tempVar;
        	tempLeft++, tempRight--;
		}
	}
	if(left < tempRight) {
		quickSortAsc(array, left, tempRight);
	}
	if(tempLeft < right) {
		quickSortAsc(array, tempLeft, right);
	}
}
