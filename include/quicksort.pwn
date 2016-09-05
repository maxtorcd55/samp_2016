forward quickSortAsc(array[], left, right);
public quickSortAsc(array[], left, right)
{

    	new tempLeft = left,tempRight = right,pivot = array[(left + right) / 2],tempVar;
    	while(tempLeft <= tempRight)
    	{
   			while(array[tempLeft] < pivot) tempLeft++;
    		while(array[tempRight] > pivot) tempRight--;

        	if(tempLeft <= tempRight)
        	{
            	tempVar = array[tempLeft], array[tempLeft] = array[tempRight], array[tempRight] = tempVar;
            	tempLeft++, tempRight--;
			}
 		}
    	if(left < tempRight) quickSortAsc(array, left, tempRight);
    	if(tempLeft < right) quickSortAsc(array, tempLeft, right);
}
