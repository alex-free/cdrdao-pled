#!/bin/bash

cd "$(dirname "$0")"
version=$(cd cdrdao; git rev-parse --short HEAD)-pled-1.0.3
arch=$(uname -p)
rm -rf build-tmp cdrdao-$version-$arch cdrdao-$version-$arch.zip

# Just clean built binaries/releases from source and exit now if given the argument 'clean'
if [ "$1" == "clean" ]; then
    exit 0
fi

mkdir -p build-tmp cdrdao-$version-$arch cdrdao-$version-$arch/licenses
cp -rp cdrdao build-tmp
cd build-tmp/cdrdao
autoreconf
set -e
./configure
make -j`nproc`
cd ../../
./pled/pled build-tmp/cdrdao/dao/cdrdao build-tmp/cdrdao-pled
./pled/pled build-tmp/cdrdao/utils/toc2cue build-tmp/toc2cue-pled
./pled/pled build-tmp/cdrdao/utils/cue2toc build-tmp/cue2toc-pled
# dump shared libraries/wrapper/executable from cdrdao to release bin directory
cp -r build-tmp/cdrdao-pled/* cdrdao-$version-$arch/
cp -r build-tmp/toc2cue-pled/* cdrdao-$version-$arch/
cp -r build-tmp/cue2toc-pled/* cdrdao-$version-$arch/
rm -rf build-tmp
# Copy licenses to release 
cp  cdrdao/COPYING cdrdao-$version-$arch/licenses/cdrdao-license.txt
cp  pled/unlicense.txt cdrdao-$version-$arch/licenses/pled.txt
# Copy docs
cp -r readme.md changelog.md cdrdao-$version-$arch/
cp -r images cdrdao-$version-$arch/
chmod -R 777 cdrdao-$version-$arch
zip -r cdrdao-$version-$arch.zip cdrdao-$version-$arch
