#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

function build_botan {
    cd $current_directory

    mkdir -p build/botan/$1
    cp src/botan/CMakeLists.txt build/botan/$1/CMakeLists.txt

    cd build/botan/$1
    cmake $2 .
    $3

    cd $current_directory
    mkdir -p dist/$1/lib
    find build/botan/$1 | grep "[.]a$" | xargs -I {} cp -p {} dist/$1/lib
}

function copy_headers {
    mkdir -p $current_directory/dist/$1/inc/botan
    cp $current_directory/build/botan/src/botan-$2/botan_all.h $current_directory/dist/$1/inc/botan_all.h
    cp $current_directory/build/botan/src/botan-$2/botan_all.h $current_directory/dist/$1/inc/botan/init.h
    cp $current_directory/build/botan/src/botan-$2/botan_all.h $current_directory/dist/$1/inc/botan/types.h
    cp $current_directory/build/botan/src/botan-$2/botan_all.h $current_directory/dist/$1/inc/botan/botan.h
    cp $current_directory/build/botan/src/botan-$2/botan_all.h $current_directory/dist/$1/inc/botan/loadstor.h
    find $current_directory/dist/$1/inc -type f | grep -E "h$|hxx$|hpp$|tcc$|ixx$|txx$" -v | xargs -I {} rm {}
}

build_botan android-armeabi-v7a "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi-v7a -DBOTAN_PLATFORM=linux-armv7a" make
#build_botan android-armeabi "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=armeabi -DBOTAN_PLATFORM=linux-arm" make
build_botan android-x86 "-DCMAKE_TOOLCHAIN_FILE=$current_directory/android.toolchain.cmake -DANDROID_ABI=x86 -DBOTAN_PLATFORM=linux-x86" make

if [ "${PLATFORM}" == "darwin" ]
then
  build_botan ios-os "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=OS -G Xcode -DBOTAN_PLATFORM=darwin-armv7" xcodebuild
  build_botan ios-simulator "-DCMAKE_TOOLCHAIN_FILE=$current_directory/ios.toolchain.cmake -DIOS_PLATFORM=SIMULATOR -G Xcode -DBOTAN_PLATFORM=darwin-i386" xcodebuild
  copy_headers ios-os darwin-armv7
  copy_headers ios-simulator darwin-i386
else
  build_botan ${PLATFORM} "-DBOTAN_PLATFORM=linux-x86_64" make
  copy_headers ${PLATFORM} linux-x86_64
fi

copy_headers android-armeabi-v7a linux-armv7a
#copy_headers android-armeabi linux-arm
copy_headers android-x86 linux-x86



#    mkdir -p build/botan-$1
#    cp src/botan_CMakeLists.txt build/botan-$1/CMakeLists.txt
#    cd build/botan-$1
#    #cat CMakeLists.txt
#    cmake $2 .
#    make    
#    
#    cd $current_directory
#    mkdir -p out-libs/$1
#    find build/botan-$1 | grep "[.]a$" | xargs -i cp -p "{}" out-libs/$1/    
#}
#
#build_botan android-armeabi-v7a "-DCMAKE_TOOLCHAIN_FILE=${ANDTOOLCHAIN} -DANDROID_ABI=armeabi-v7a"
#build_botan android-armeabi "-DCMAKE_TOOLCHAIN_FILE=${ANDTOOLCHAIN} -DANDROID_ABI=armeabi"
#build_botan local
#
#function copy_botan_headers {
#    # Copy botan_all.h
#    cd $current_directory/src/botan/src-$1
#    mkdir -p $current_directory/out-include/$2
#    cp botan_all.h $current_directory/out-include/$2/  
#    
#    # Symlink some files that will be used by sqlite
#    cd $current_directory/out-include/$2
#    rm -rf botan
#    mkdir -p botan
#    ln -s ../botan_all.h botan/init.h
#    ln -s ../botan_all.h botan/botan.h
#    ln -s ../botan_all.h botan/loadstor.h
#}
#
#copy_botan_headers local local
#copy_botan_headers arm android-armeabi
#copy_botan_headers arm android-armeabi-v7a
