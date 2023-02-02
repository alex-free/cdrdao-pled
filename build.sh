#!/bin/bash
cd "$(dirname "$0")"
version=$(cd cdrdao; git rev-parse --short HEAD)-pled-1.0.2
arch=$(uname -p)
rm -rf build-tmp cdrdao-$version-$arch cdrdao-$version-$arch.zip
# Just clean built binaries/releases from source and exit now if given the argument 'clean'
if [ "$1" == "clean" ]; then
    exit 0
fi

mkdir -p build-tmp cdrdao-$version-$arch cdrdao-$version-$arch/licenses
cp -rp cdrdao build-tmp
cd build-tmp/cdrdao
./autogen.sh
autoreconf
set -e
./configure
make -j`nproc`
../../pled/pled dao/cdrdao
../../pled/pled utils/toc2cue
../../pled/pled utils/cue2toc
# dump shared libraries/wrapper/executable from cdrdao to release bin directory
cp -rp cdrdao-pled/* ../../cdrdao-$version-$arch/
cp -rp toc2cue-pled/* ../../cdrdao-$version-$arch/
cp -rp cue2toc-pled/* ../../cdrdao-$version-$arch/
cd ../../
rm -rf build-tmp
chmod -R 775 cdrdao-$version-$arch/cdrdao
# Copy licenses to release
cp -rp cdrdao/COPYING cdrdao-$version-$arch/licenses/cdrdao-license.txt
cp -rp pled/unlicense.txt cdrdao-$version-$arch/licenses/pled.txt
# Generate HTML
./gen-html.sh
cp -p readme.md cdrdao-$version-$arch/readme.md
cp -p readme.html cdrdao-$version-$arch/readme.html
cp -rp images cdrdao-$version-$arch/
# Copy documentation to release
# cp -rp readme.html readme.md images cdrdao-$version-$arch/
zip -r cdrdao-$version-$arch.zip cdrdao-$version-$arch
