#include "array.h"

#include <stdio.h>
#include <stdlib.h>

Array* newArray(int length)
{
	Array* tmp = (Array*)malloc(sizeof(Array));
	if (tmp == NULL)
	{
		printf("Failed to allocate memory for array\n");
		return NULL;
	}

	tmp->length = length;
	tmp->data = (float*)malloc(sizeof(float) * length);

	if (tmp->data == NULL)
	{
		printf("Failed to allocate memory for array data\n");
		return NULL;
	}

	return tmp;
}
