#ifndef INCLUDE_ARRAY_H
#define INCLUDE_ARRAY_H

typedef struct Array
{
	int length;

	float* data;
}Array;

Array* newArray(int length);

#endif
