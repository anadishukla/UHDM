# /bin/sh
pwd
which rm
rm -f src/*
rm -rf headers/*
rm -rf build
ls

set PREFIX="/usr/local"
mkdir -p build
cd build; cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(PREFIX)
mkdir -p $(PREFIX)
#	$(MAKE) -C build install
which cmake
set MAKE=`which cmake`
echo $MAKE
$(MAKE) -C build install


