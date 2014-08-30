#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

# 1) Android NDK
if [ "$(uname)" == Darwin ]
then
    rm -rf android-ndk-${ANDROID_NDK_VERSION}-${PLATFORM}-x86
    wget -c http://dl.google.com/android/ndk/android-ndk-${ANDROID_NDK_VERSION}-${PLATFORM}-x86.tar.bz2 -O android-ndk-${ANDROID_NDK_VERSION}-${PLATFORM}-x86.tar.bz2
    tar xf android-ndk-${ANDROID_NDK_VERSION}-${PLATFORM}-x86.tar.bz2
else
    rm -rf android-ndk-${ANDROID_NDK_VERSION}-${PLATFORM}-x86_64
    wget -c http://dl.google.com/android/ndk/android-ndk-${ANDROID_NDK_VERSION}-${PLATFORM}-x86_64.tar.bz2 -O android-ndk-${ANDROID_NDK_VERSION}-${PLATFORM}-x86_64.tar.bz2
    tar xf android-ndk-${ANDROID_NDK_VERSION}-${PLATFORM}-x86_64.tar.bz2
fi

chown -R $USER android-ndk-${ANDROID_NDK_VERSION}

# 2) cmake
#rm -f *.toolchain.cmake
wget -c https://raw.githubusercontent.com/taka-no-me/android-cmake/763b9f6ec43bf66f3b586669b68b9b6374c8f4b5/android.toolchain.cmake -O android.toolchain.cmake
wget -c https://ios-cmake.googlecode.com/hg/toolchain/iOS.cmake -O ios.toolchain.cmake
