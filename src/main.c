#include <stdio.h>

#include "array.h"

int main()
{
	Array2D data;

	new2Darray(6, 2, &data);

	data.data[0][0] = 1;
	data.data[1][0] = 1;
	data.data[2][0] = 2;
	data.data[3][0] = 3;
	data.data[4][0] = 4;
	data.data[5][0] = 4;

	data.data[0][1] = 2;
	data.data[1][1] = 5;
	data.data[2][1] = 4;
	data.data[3][1] = 2;
	data.data[4][1] = 3;
	data.data[5][1] = 5;

	/*for (int i = 0; i < data.row; i++)
	{
		printf("Data %d: %d, %d", i, data.data[i][0], data.data[i][1]);
	}*/

	return 0;
}
