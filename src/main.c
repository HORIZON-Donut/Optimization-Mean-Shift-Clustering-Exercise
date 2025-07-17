#include <stdio.h>

#include "array.h"

int main()
{
	Array* arr_data = newArray(2);

	arr_data->data[0] = 0;
	arr_data->data[1] = 1;

	printf("Coordinate: %f, %f", arr_data->data[0], arr_data->data[1]);

	return 0;
}
