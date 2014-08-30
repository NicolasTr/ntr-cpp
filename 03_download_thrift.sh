#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

thrift_version=0.9.1

mkdir -p build/thrift

rm -rf build/thrift/src
git clone https://github.com/apache/thrift.git build/thrift/src
cd build/thrift/src
git checkout origin/$thrift_version

cp $current_directory/src/thrift/config.h lib/cpp/src/thrift/config.h
