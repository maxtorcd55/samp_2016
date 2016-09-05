// Binary Search
forward binarySearch(array[],length,ToSearch);
public binarySearch(array[],length,ToSearch)
{
	new lb=0,ub=length-1,z=0;
	while(lb<=ub)
	{
	    z=(lb+ub)/2;
	    if(array[z]<ToSearch) lb=z+1;
	    else if(array[z]>ToSearch) ub=z-1;
	    else return (z+1);

	}
	return -1;
}
