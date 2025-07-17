#include "array.h"
#include <stdlib.h>

int new2Darray(int row, int col, Array2D* newArr)
{
	newArr->row = row;
	newArr->col = col;

	newArr->data = (int**)malloc(sizeof(int) * row * col);

	return 0;
}
int sumArray2D(Array2D arr, int** result)
{
	return 0;
}

