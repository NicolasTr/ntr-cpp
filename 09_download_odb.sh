#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

odb_version=2.3.0
odb_sqlite_version=2.3.0
odb_qt_version=2.3.1

mkdir -p build/odb

cd build/odb
rm -rf libodb-${odb_version} libodb-sqlite-${odb_sqlite_version} libodb-qt-${odb_qt_version} src
mkdir -p src

wget -c "http://www.codesynthesis.com/download/odb/2.3/libodb-${odb_version}.zip" -O "./libodb-${odb_version}.zip"
unzip "./libodb-${odb_version}.zip"
mv libodb-${odb_version} src/libodb

cd src/libodb
./configure
cd ../../

wget -c "http://www.codesynthesis.com/download/odb/2.3/libodb-sqlite-${odb_sqlite_version}.zip" -O "./libodb-sqlite-${odb_sqlite_version}.zip"
unzip "./libodb-sqlite-${odb_sqlite_version}.zip"
mv libodb-sqlite-${odb_sqlite_version} src/libodb-sqlite
touch src/libodb-sqlite/odb/sqlite/details/config.h

wget -c "http://www.codesynthesis.com/download/odb/2.3/libodb-qt-${odb_qt_version}.zip" -O "./libodb-qt-${odb_qt_version}.zip"
unzip "./libodb-qt-${odb_qt_version}.zip"
mv libodb-qt-${odb_qt_version} src/libodb-qt
touch src/libodb-qt/odb/qt/details/config.h
