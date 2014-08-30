#!/bin/bash -ex

current_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $current_directory/_shared.sh

sqlite_amalgamation_version=3071201

mkdir -p build/sqlite

cd build/sqlite
rm -rf sqlite-amalgamation-${sqlite_amalgamation_version} src
wget -c "https://sqlite.org/sqlite-amalgamation-${sqlite_amalgamation_version}.zip" -O sqlite-amalgamation-${sqlite_amalgamation_version}.zip
unzip sqlite-amalgamation-${sqlite_amalgamation_version}.zip
mkdir -p src
mv sqlite-amalgamation-${sqlite_amalgamation_version} src/sqlite-amalgamation
git clone https://github.com/OlivierJG/botansqlite3.git src/botansqlite3

mkdir -p src/sqlite
cd src/sqlite
cp ../sqlite-amalgamation/* ./
#cp ../botansqlite3/* ./
#patch -p0 < ../botansqlite3/sqlite3-amalgamation.patch

rm -rf ../sqlite-amalgamation ../botansqlite3
