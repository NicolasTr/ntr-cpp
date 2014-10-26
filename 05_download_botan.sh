#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

botan_version=1.10.6

mkdir -p build/botan

cd build/botan
rm -rf Botan-$botan_version src
wget -c "http://files.randombit.net/botan/Botan-$botan_version.tgz" -O Botan-$botan_version.tgz
tar xf Botan-$botan_version.tgz
mkdir -p src

# See: http://www.tiwoc.de/blog/2013/03/building-the-botan-library-for-android/
function configure_botan {
    cd $current_directory/build/botan
    cp -r Botan-$botan_version src/botan-$1-$2
    cd src/botan-$1-$2
    ./configure.py --gen-amalgamation --cpu=$2 --os=$1 --cc=$3 --with-tr1=none
}

configure_botan linux x86_64 gcc
configure_botan linux x86 gcc
configure_botan linux arm gcc
configure_botan linux armv7a gcc

configure_botan darwin x86_64 clang
configure_botan darwin i386 clang
configure_botan darwin armv7 clang
