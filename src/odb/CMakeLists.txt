cmake_minimum_required(VERSION 2.6.3)
project(android-odb)

set(odb_root ${CMAKE_CURRENT_SOURCE_DIR}/../src/libodb CACHE PATH "ODB")
set(odb_sqlite_root ${CMAKE_CURRENT_SOURCE_DIR}/../src/libodb-sqlite CACHE PATH "ODB")
set(odb_qt_root ${CMAKE_CURRENT_SOURCE_DIR}/../src/libodb-qt CACHE PATH "ODB")

set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} -g -fPIC" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -fPIC")

file(GLOB_RECURSE odb_srcs_base "${odb_root}/odb/*.cxx")
file(GLOB_RECURSE odb_qt_srcs_base "${odb_qt_root}/odb/*.cxx")
set(odb_srcs ${odb_srcs_base} ${odb_qt_srcs_base})
list(REMOVE_ITEM odb_srcs "${odb_root}/odb/details/win32/once.cxx")
list(REMOVE_ITEM odb_srcs "${odb_root}/odb/details/win32/thread.cxx")
list(REMOVE_ITEM odb_srcs "${odb_root}/odb/details/win32/tls.cxx")
list(REMOVE_ITEM odb_srcs "${odb_root}/odb/details/win32/exceptions.cxx")
list(REMOVE_ITEM odb_srcs "${odb_root}/odb/details/win32/condition.cxx")

file(GLOB_RECURSE odb_sqlite_srcs_base "${odb_sqlite_root}/odb/*.cxx")
set(odb_sqlite_srcs ${odb_sqlite_srcs_base})

if(NOT "${IOS_PLATFORM}" STREQUAL "")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DODB_THREADS_NONE -stdlib=libc++ -std=c++11")
elseif(NOT "${ANDROID_ABI}" STREQUAL "")
    include_directories("${ANDROID_NDK}/sources/cxx-stl/gnu-libstdc++/4.8/include")
    include_directories("${ANDROID_NDK}/platforms/android-${ANDROID_NDK_API_LEVEL}/arch-arm/usr/include/")
    message("${ANDROID_NDK}/platforms/android-${ANDROID_NDK_API_LEVEL}/arch-arm/usr/include/")
    include_directories("${DIST_DIRECTORY}/inc")
else()

endif()

add_library(odb STATIC ${odb_srcs})
add_library(odb_sqlite STATIC ${odb_sqlite_srcs})
include_directories("${odb_root}")
include_directories("${odb_sqlite_root}")
include_directories("${odb_qt_root}")
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/../../../vendor/out-include/local")
