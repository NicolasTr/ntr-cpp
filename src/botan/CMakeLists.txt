cmake_minimum_required(VERSION 2.6.3)
project(botan)

set(botan_root ${CMAKE_CURRENT_SOURCE_DIR}/../src/botan-${BOTAN_PLATFORM} CACHE PATH "Botan repo")

set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} -g -fPIC" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -fPIC -fexceptions -frtti")

if(NOT "${IOS_PLATFORM}" STREQUAL "")

elseif(NOT "${ANDROID_ABI}" STREQUAL "")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DBOTAN_USE_GCC_INLINE_ASM=0")
    include_directories("${ANDROID_NDK}/sources/cxx-stl/gnu-libstdc++/4.8/include")
    include_directories("${ANDROID_NDK}/platforms/android-${ANDROID_NDK_API_LEVEL}/arch-arm/usr/include/")
else()

endif()

add_library(botan STATIC ${botan_root}/botan_all.cpp)

