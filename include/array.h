#ifndef INCLUDE_ARRAY_H
#define INCLUDE_ARRAY_H

typedef struct Array2D
{
	int row;
	int col;

	int** data;
}Array2D;

int new2Darray(int row, int col, Array2D* newArr);
int sumArray2D(Array2D arr, int** result);

#endif
