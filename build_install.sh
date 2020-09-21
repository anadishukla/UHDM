# /bin/sh
pwd
which rm
rm -f src/*
rm -rf headers/*
rm -rf build
ls

set PREFIX="../install"
echo $PREFIX
#BUILD
mkdir -p build
cd build
echo "CMAKE 1"
cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX
cmake build
echo "cmake build UnitTests"
cmake build UnitTests
ctest --output-on-failure
#	$(MAKE) -C build install
echo CMAKE VERSION
which cmake
set MAKE=`which cmake`
echo "MAKE=$MAKE"
#cd build && ctest --output-on-failure
#$(MAKE) -C build install
cmake
#echo "G++ BUILD"
##TEST_INSTALL
#g++ -std=c++14 -g tests/test1.cpp -I$PREFIX/include/uhdm -I$PREFIX/include/uhdm/include $PREFIX/lib/uhdm/libuhdm.a $PREFIX/lib/uhdm/libcapnp.a $PREFIX/lib/uhdm/libkj.a -ldl -lutil -lm -lrt -lpthread -o test_inst
#./test_inst



