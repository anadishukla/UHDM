# /bin/sh

clean(){
  echo "DO CLEAN"
  rm -f src/*
  rm -rf headers/*
  rm -rf build
}


build(){
  echo "MAKE BUILD"
  set PREFIX="../install"
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
}

tests(){
  echo "Run CMAKE UnitTests"
  cmake --build . --target UnitTests
}

clean
build
tests
