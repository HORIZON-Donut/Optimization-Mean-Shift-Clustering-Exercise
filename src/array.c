#include "array.h"
#include <stdlib.h>

int new2Darray(int row, int col, Array2D* newArr)
{
	newArr->row = row;
	newArr->col = col;

	newArr->data = (int**)malloc(sizeof(int) * row * col);

	return 0;
}

int sumArray2D(Array2D* arr, int* result)
{
	int* tmp = (int*)malloc(sizeof(int) * arr->col);

	for(int i = 0; i < arr->row; i++)
	{
		for(int j = 0; j < arr->col; j++)
		{
			tmp[j] = tmp[j] + arr->data[i][j];
		}
	}

	result = tmp;
	free(tmp);

	return 0;
}

