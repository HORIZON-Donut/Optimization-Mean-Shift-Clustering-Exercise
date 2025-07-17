#!/bin/bash

case $OSTYPE in

	linux*)
		PLATFORM="linux"
		;;
	
	msys*)
		PLATFORM="windw"
		;;
	*)
		PLATFORM="unknow"
		;;
esac

echo "Build on platform: $PLATFORM"

LINUX_CC="gcc"
WIN64_CC="x86_64-w64-mingw32-gcc"

TEST="test"
SRC="srcs"
OBJS="objs"
DEBUG="debug"
INCLUDE="includes"

SRCS=$(find $SRC -name "*.c")
INCLUDES=$(find $INCLUDE -mindepth 0 -type d | sed "s|^|-I|" | tr '\n' ' ')

CFLAGES="-Wall -Wextra"
LDFLAGES=

LINUX_CFLAGES=" "
WIN64_CFLAGES=" "

LINUX_LDFLAGES=" "
WIN64_LDFLAGES=" "

LINUX_SOURCE="Linux"
LINUX_TEST="TestLinux"

WIN64_SOURCE="Windows"
WIN64_TEST="TestWindows"

LINUX_TARGET=" "
WIN64_TARGET=" "

LINUX_TESTTARGET="bin/Linux/test/run"
WIN64_TESTTARGET="bin/Win64/test/run"

#Cleaning function
clean()
{
	echo "Clean up object file and target"
	rm -rf $OBJS/* $(dirname $LINUX_TESTTARGET)/* $(dirname $WIN64_TESTTARGET)/*
}

#Compile implementation section
compile()
{
	local CC=$1
	local Source=$2
	local cFlages=$3

	mkdir -p $OBJS/$Source

	echo "Compiling soruce file..."
	for src_file in $SRCS; do
		obj_file="$OBJS/$Source/$(basename ${src_file%.c}.o)"
		echo "compiling $src_file --> $obj_file"
		$CC $CFLAGES $INCLUDES $cFlages -c $src_file -o $obj_file
	done
}

compileTest()
{
	local CC=$1
	local Entry=$2
	local TESTTARGET=$3
	local cFlages=$4

	mkdir -p $OBJS/$Entry

	echo "Compiling test file..."
	for test_file in $TEST/*.c; do
		test_obj="$OBJS/$Entry/$(basename ${test_file%.c}.o)"
		echo "Compiling $test_file --> $test_obj"
		$CC $CFLAGES $INCLUDES $cFlages -c $test_file -o $test_obj
	done
}

#Build implementation section
buildTarget()
{
	local CC=$1
	local Source=$2
	local target=$3
	local ldFlages=$4

	echo "Linking object file"

	objs_files=$(ls $OBJS/$Source/*.o)
	echo "Object file:"
	echo "$objs_files"
	echo "Build target: $target"

	$CC $LDFLAGES $ldFlages -o $target $objs_files
}

buildTest()
{
	local CC=$1
	local Source=$2
	local Entry=$3
	local TESTTARGET=$4
	local ldFlages=$5

	mkdir -p $(dirname $TESTTARGET)

	echo "Linking object file and build test"
	Index=1
	obj_files=$(ls $OBJS/$Source/*.o)
	for Entry in $OBJS/$Entry/*.o; do
		padded=$(printf "%04d" "$Index")
		echo "Source File:"
		echo "$obj_files"
		echo "Build Target: $TESTTARGET$padded"
		$CC $LDFLAGES $ldFlages -o $TESTTARGET$padded $Entry $obj_files

		Index=$(($Index+1))
	done
}

#Compile execution section
compileAllTest()
{
	compileTest $LINUX_CC $LINUX_TEST $LINUX_TESTTARGET $LINUX_CFLAGES
	compileTest $WIN64_CC $WIN64_TEST $WIN64_TESTTARGET $LINUX_CFLAGES
}

compileAllTarget()
{
	compile $LINUX_CC $LINUX_SOURCE $LINUX_CFLAGES
	compile $WIN64_CC $WIN64_SOURCE $WIN64_CFLAGES
}

compileAll()
{
	compileAllTarget
	compileAllTest
}

#Build execution section
buildAllTest()
{
	buildTest $LINUX_CC $LINUX_SOURCE $LINUX_TEST $LINUX_TESTTARGET $LINUX_LDFLAGES
	buildTest $WIN64_CC $WIN64_SOURCE $WIN64_TEST $WIN64_TESTTARGET $WIN64_LDFLAGES
}

buildAllTarget()
{
	buildTarget $LINUX_CC $LINUX_SOURCE $LINUX_TARGET $LINUX_LDFLAGES
	buildTarget $WIN64_CC $WIN64_SOURCE $WIN64_TARGET $WIN64_LDFLAGES
}

buildAll()
{
	buildAllTarget
	buildAllTest
}

#Test Section
test_linux()
{
	echo "------------------------------"
	echo "Test Linux build"
	for exe in $(dirname $LINUX_TESTTARGET)/*; do
		echo "Test $exe"
		$exe
	done
}

test_win64()
{
	echo "------------------------------"
	echo "Test Windows build"
	for exe in $(dirname $WIN64_TESTTARGET)/*; do
		echo "Test $exe"
		$exe
	done
}

#Command gateway section

compileGateWay()
{
	case $1 in
		
		"all")
		compileAll
		;;
		
		"linux")
		compile $LINUX_CC $LINUX_SOURCE $LINUX_CFLAGES
		;;

		"windows")
		compile $WIN64_CC $WIN64_SOURCE $WIN64_CFLAGES
		;;

		"test")
		compileAllTest
		;;

		*)
		compileAll
		;;

	esac
}

buildTargetGateway()
{
	case $1 in

		"all")
		buildAllTarget
		;;

		"linux")
		buildTarget $LINUX_CC $LINUX_SOURCE $LINUX_TARGET $LINUX_LDFLAGES
		;;

		"windows")
		buildTarget $WIN64_CC $WIN64_SOURCE $WIN64_TARGET $WIN64_LDFLAGES
		;;

		*)
		echo "Invalid target"
		;;

	esac
}

buildGateWay()
{
	case $1 in
		
		"all")
		buildAll
		;;
		
		"target")
		buildTargetGateway $2
		;;

		"test")
		buildAllTest
		;;

		*)
		echo "No build target"
		;;
	
	esac
}

testGateWay()
{
	case $1 in
		
		"all")
		test_linux
		test_win64
		;;

		"linux")
		test_linux
		;;

		"windows")
		test_win64
		;;

		*)
		test_linux
		test_win64
		;;
	
	esac
}

#Main entry section
case $1 in
	
	"compile")
	compileGateWay $2
	;;

	"build")
	buildGateWay $2 $3
	;;

	"test")
	testGateWay $2
	;;

	"clean")
	clean
	;;

	*)
	echo "Nothing to do without command"
	;;
esac
