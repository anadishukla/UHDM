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
cmake --version
which python
which python3
where python
where python3
mkdir -p build
cd build
echo "CMAKE at $PWD"
cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX
cmake --build .
echo "cmake build UnitTests"
cmake --build . --target UnitTests
echo "CTEST from here"
#ctest --output-on-failure
