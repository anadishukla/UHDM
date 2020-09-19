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
#$(MAKE) -C build install
g++ -std=c++14 -g tests/test1.cpp -I$(PREFIX)/include/uhdm -I$(PREFIX)/include/uhdm/include $(PREFIX)/lib/uhdm/libuhdm.a $(PREFIX)/lib/uhdm/libcapnp.a $(PREFIX)/lib/uhdm/libkj.a -ldl -lutil -lm -lrt -lpthread -o test_inst


