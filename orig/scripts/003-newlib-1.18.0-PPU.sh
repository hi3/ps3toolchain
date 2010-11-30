#!/bin/sh
# newlib-1.18.0-PPU.sh by Dan Peori (dan.peori@oopo.net)

## Download the source code.
wget --continue ftp://sources.redhat.com/pub/newlib/newlib-1.18.0.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf newlib-1.18.0 && tar xfvz newlib-1.18.0.tar.gz && cd newlib-1.18.0 || { exit 1; }

## Patch the source code.
cat ../../patches/newlib-1.18.0-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
../configure --prefix="$PS3DEV/ppu" --target="ppu" --disable-multilib --disable-nls --disable-shared || { exit 1; }

## Compile and install.
make -j 4 && make install || { exit 1; }

## Build the crt files from the ps3chain project.
## http://github.com/HACKERCHANNEL/ps3chain
cd ../../crt && make clean && make && make install || { exit 1; }
