#!/bin/bash

echo "Start building..."

CC=gcc
CFLAGES="-Wall -Wextra -Iinclude"
LDFLAGES=

SRCS="src"
OBJS="objs"
TARGET="bin/run"

mkdir -p $OBJS
mkdir -p $(dirname $TARGET)

echo "Compiling soruce file..."
for src_file in $SRCS/*.c; do
	obj_file="$OBJS/$(basename ${src_file%.c}.o)"
	echo "compiling $src_file --> $obj_file"
	$CC $CFLAGES -c $src_file -o $obj_file
done

echo "Linking object file into $TARGET..."
obj_files=$(ls $OBJS/*.o)
$CC $LDFLAGES -o $TARGET $obj_files

echo "Build complete: $TARGET"

clean()
{
	echo "Clean up object file and target"
	rm -f $OBJS/*.o $TARGET
}

if [ "$1" == "clean" ]; then
	clean
fi
