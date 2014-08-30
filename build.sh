#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

$current_directory/01_download_boost.sh
$current_directory/02_build_boost.sh
$current_directory/03_download_thrift.sh
$current_directory/04_build_thrift.sh
$current_directory/05_download_botan.sh
$current_directory/06_build_botan.sh
$current_directory/07_download_sqlite.sh
$current_directory/08_build_sqlite.sh
$current_directory/09_download_odb.sh
$current_directory/10_build_odb.sh

#find $current_directory/dist -type f | grep -E ".a$" | xargs -I {} lipo -info {} | grep architecture
rm -f ntr-cpp-$(uname).tar.gz
tar zcf ntr-cpp-$(uname).tar.gz dist/
