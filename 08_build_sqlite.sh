#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

function build_sqlite {
    cd $current_directory

    mkdir -p build/sqlite/$1
    cp src/sqlite/CMakeLists.txt build/sqlite/$1/CMakeLists.txt

    cd build/sqlite/$1
    cmake $2 -DDIST_DIRECTORY=$current_directory/dist/$1 .
    $3

    cd $current_directory
    mkdir -p dist/$1/lib
    find build/sqlite/$1 | grep "[.]a$" | xargs -I {} cp -p {} dist/$1/lib
}

function copy_headers {
    mkdir -p $current_directory/dist/$1/inc
    cp -r $current_directory/build/sqlite/src/sqlite/* $current_directory/dist/$1/inc
    find $current_directory/dist/$1/inc -type f | grep -E "h$|hxx$|hpp$|tcc$|ixx$|txx$" -v | xargs -I {} rm {}
}

build_sqlite android-armeabi-v7a "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a" make
#build_sqlite android-armeabi "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi" make
build_sqlite android-x86 "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=x86" make

if [ "${PLATFORM}" == "darwin" ]
then
  build_sqlite ios-os "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=OS -G Xcode" xcodebuild
  build_sqlite ios-simulator "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=SIMULATOR -G Xcode" xcodebuild
  copy_headers ios-os
  copy_headers ios-simulator
else
  build_sqlite ${PLATFORM} "" make
  copy_headers ${PLATFORM}
fi

copy_headers android-armeabi-v7a
#copy_headers android-armeabi
copy_headers android-x86

