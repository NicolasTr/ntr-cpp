#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

boost_version=1.55.0
boost_version_underscore=$(echo ${boost_version} | sed "s/[.]/_/g")

mkdir -p build/boost

cd build/boost
rm -rf boost_${boost_version_underscore} src
wget -c "http://iweb.dl.sourceforge.net/project/boost/boost/${boost_version}/boost_${boost_version_underscore}.tar.gz" -O boost_${boost_version_underscore}.tar.gz
tar xf boost_${boost_version_underscore}.tar.gz
mv boost_${boost_version_underscore} src
