# /bin/sh

release(){
  cmake --build .
}

debug(){
  set PREFIX="../install"
  mkdir -p build
  cd build
  cmake ../ -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$PREFIX
  cmake --build .
}

test_windows(){
  build
  cmake --build . --target UnitTests
}

test_unix(){
  build
  cmake --build . --target UnitTests
  cd build && ctest --output-on-failure
}

test_junit(){
  release
  cd build && ctest --no-compress-output -T Test -C RelWithDebInfo --output-on-failure
  xsltproc .github/kokoro/ctest2junit.xsl build/Testing/*/Test.xml > build/test_results.xml
}


clean(){
  rm -f src/*
  rm -rf headers/*
  rm -rf build
}

install(){ 
  set PREFIX="../install"
  build
  mkdir -p $PREFIX
  cmake --build . --target install
}

uninstall(){
  set PREFIX="../install"
  rm -rf ${PREFIX}/lib/uhdm
  rm -rf ${PREFIX}/include/uhdm
}

build(){
  set PREFIX="../install"
  mkdir -p build
  cd build
  cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PREFIX
}

test_install(){
  set CXX="g++"
  $(CXX) -std=c++14 -g tests/test1.cpp -I$(PREFIX)/include/uhdm -I$(PREFIX)/include/uhdm/include $(PREFIX)/lib/uhdm/libuhdm.a $(PREFIX)/lib/uhdm/libcapnp.a $(PREFIX)/lib/uhdm/libkj.a -ldl -lutil -lm -lrt -lpthread -o test_inst
  ./test_inst
}

for arg in $@
do
   if [ "$arg" = "release" ]; then 
	   release
   fi
   if [ "$arg" = "debug" ]; then 
	   debug
   fi
   if [ "$arg" = "test_windows" ]; then 
	   test_windows
   fi
   if [ "$arg" = "test_unix" ]; then 
	   test_unix
   fi
   if [ "$arg" = "test_junit" ]; then 
	   test_junit
   fi
   if [ "$arg" = "clean" ]; then 
	   clean
   fi
   if [ "$arg" = "install" ]; then 
	   install
   fi
   if [ "$arg" = "uninstall" ]; then 
	   uninstall
   fi
   if [ "$arg" = "build" ]; then 
	   build
   fi
   if [ "$arg" = "test_install" ]; then 
	   test_install
   fi
done
