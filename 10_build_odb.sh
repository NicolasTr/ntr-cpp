#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

function build_odb {
    cd $current_directory

    mkdir -p build/odb/$1
    cp src/odb/CMakeLists.txt build/odb/$1/CMakeLists.txt

    cd build/odb/$1
    cmake $2 -DDIST_DIRECTORY=$current_directory/dist/$1 -DANDROID_NDK_API_LEVEL=${ANDROID_NDK_API_LEVEL} .
    $3

    cd $current_directory
    mkdir -p dist/$1/lib
    find build/odb/$1 | grep "[.]a$" | xargs -I {} cp -p {} dist/$1/lib
}

function copy_headers {
    cp -r $current_directory/build/odb/src/libodb/odb/ $current_directory/dist/$1/inc/odb
    cp -r $current_directory/build/odb/src/libodb-qt/odb/ $current_directory/dist/$1/inc/odb
    cp -r $current_directory/build/odb/src/libodb-sqlite/odb/ $current_directory/dist/$1/inc/odb
    cp -r $current_directory/build/odb/src/libodb/odb/ $current_directory/dist/$1/inc
    cp -r $current_directory/build/odb/src/libodb-qt/odb/ $current_directory/dist/$1/inc
    cp -r $current_directory/build/odb/src/libodb-sqlite/odb/ $current_directory/dist/$1/inc
    find $current_directory/dist/$1/inc -type f | grep -E "h$|hxx$|hpp$|tcc$|ixx$|txx$" -v | xargs -I {} rm {}
}

build_odb android-armeabi-v7a "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a" make
#build_odb android-armeabi "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi" make

if [ "${PLATFORM}" == "darwin" ]
then
  build_odb ios-os "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=OS -G Xcode" xcodebuild
  build_odb ios-simulator "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=SIMULATOR -G Xcode" xcodebuild
  copy_headers ios-os
  copy_headers ios-simulator
else
  build_odb ${PLATFORM} "" make
  copy_headers ${PLATFORM}
fi

copy_headers android-armeabi-v7a
#copy_headers android-armeabi
