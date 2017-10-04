#!/bin/bash

DIST_ROOT=`pwd`
FLAGS=

usage() 
{ 
    echo "Usage: $0 [-i inputDir (Distribution root)]" 1>&2
    exit 1
}

while getopts "i:" opt; do
    case "${opt}" in
        i)
            DIST_ROOT=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# Framework Root Directory
FRAMEWORK_ROOT=$DIST_ROOT/Framework
# Shared library root directory.
SLIB_ROOT=$DIST_ROOT

echo "FRAMEWORK_ROOT=$FRAMEWORK_ROOT"
echo "SLIB_ROOT=$SLIB_ROOT"

# Copy Headers from the Framework to the shared library include directory.
mkdir -p $SLIB_ROOT/include/LumicastSdk
cp $FRAMEWORK_ROOT/LumicastSdk.framework/Versions/Current/Headers/*.h  $SLIB_ROOT/include/LumicastSdk

# Create the shared library sub-directories and copy the fat shared library from the Framework
mkdir -p $SLIB_ROOT/libs/iphoneos
mkdir -p $SLIB_ROOT/libs/iphonesimulator
cp $FRAMEWORK_ROOT/LumicastSdk.framework/Versions/Current/LumicastSdk  $SLIB_ROOT/libs

pushd $SLIB_ROOT/libs

# Separate out each shared library from the fat shared library.
lipo LumicastSdk  -thin armv7 -output libLumicastSdk-armv7.a
lipo LumicastSdk  -thin arm64 -output libLumicastSdk-arm64.a
lipo LumicastSdk  -thin i386 -output libLumicastSdk-i386.a
lipo LumicastSdk  -thin x86_64 -output libLumicastSdk-x86_64.a

# Generate a composite (fat) ARM only shared library.
lipo libLumicastSdk-armv7.a libLumicastSdk-arm64.a -create -output iphoneos/libLumicastSdk.a

# Generate a composite (fat) Simulation (x86) shared library.
lipo libLumicastSdk-i386.a libLumicastSdk-x86_64.a -create -output iphonesimulator/libLumicastSdk.a

# Just used to check if the shared libaries have the right architectures in them.
#lipo -info LumicastSdk
#lipo -info libLumicastSdk-armv7.a
#lipo -info libLumicastSdk-arm64.a
#lipo -info libLumicastSdk-i386.a
#lipo -info libLumicastSdk-x86_64.a
#lipo -info iphoneos/libLumicastSdk.a
#lipo -info iphonesimulator/libLumicastSdk.a

rm LumicastSdk
rm libLumicastSdk-armv7.a
rm libLumicastSdk-arm64.a
rm libLumicastSdk-i386.a
rm libLumicastSdk-x86_64.a



popd
