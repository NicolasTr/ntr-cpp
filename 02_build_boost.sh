#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

function build_boost {
    cd $current_directory

    mkdir -p build/boost/$1
    cp src/boost/CMakeLists.txt build/boost/$1/CMakeLists.txt
    cp src/boost/BoostConfig.cmake.in build/boost/$1/BoostConfig.cmake.in
    
    cd build/boost/$1
    cmake $2 .
    $3    
    
    cd $current_directory
    mkdir -p dist/$1/lib
    find build/boost/$1 | grep "[.]a$" | xargs -I {} cp -p {} dist/$1/lib    
}

function copy_headers {
    mkdir -p $current_directory/dist/$1/inc
    cp -r $current_directory/build/boost/src/boost $current_directory/dist/$1/inc/boost
    find $current_directory/dist/$1/inc -type f | grep -E "h$|hxx$|hpp$|tcc$|ixx$|txx$" -v | xargs -I {} rm {}
}

build_boost android-armeabi-v7a "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a" make
#build_boost android-armeabi "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi" make

if [ "${PLATFORM}" == "darwin" ]
then
  build_boost ios-os "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=OS -G Xcode" xcodebuild
  build_boost ios-simulator "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=SIMULATOR -G Xcode" xcodebuild
  copy_headers ios-os
  copy_headers ios-simulator
else
  build_boost ${PLATFORM} "" make
  copy_headers ${PLATFORM}
fi

copy_headers android-armeabi-v7a
#copy_headers android-armeabi
