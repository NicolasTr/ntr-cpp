#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

function build_thrift {
    cd $current_directory

    mkdir -p build/thrift/$1
    cp src/thrift/CMakeLists.txt build/thrift/$1/CMakeLists.txt

    cd build/thrift/$1
    cmake $2 .
    $3

    cd $current_directory
    mkdir -p dist/$1/lib
    find build/thrift/$1 | grep "[.]a$" | xargs -I {} cp -p {} dist/$1/lib
}

function copy_headers {
    mkdir -p $current_directory/dist/$1/inc
    cp -r $current_directory/build/thrift/src/lib/cpp/src/thrift $current_directory/dist/$1/inc/thrift
    find $current_directory/dist/$1/inc -type f | grep -E "h$|hxx$|hpp$|tcc$|ixx$|txx$" -v | xargs -I {} rm {}
}

build_thrift android-armeabi-v7a "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a" make
#build_thrift android-armeabi "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi" make
build_thrift android-x86 "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=x86" make

if [ "${PLATFORM}" == "darwin" ]
then
  build_thrift ios-os "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=OS -G Xcode" xcodebuild
  build_thrift ios-simulator "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=SIMULATOR -G Xcode" xcodebuild
  copy_headers ios-os
  copy_headers ios-simulator
else
  build_thrift ${PLATFORM} "" make
  copy_headers ${PLATFORM}
fi

copy_headers android-armeabi-v7a
#copy_headers android-armeabi
copy_headers android-x86

