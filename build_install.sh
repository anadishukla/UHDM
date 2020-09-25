# /bin/sh
if [ -z "$UHDM_PREFIX" ] ; then
   echo "UHDM_PREFIX is unset" 
   export UHDM_PREFIX="../install"
fi
export CWD="$PWD" 

uhdm_release(){
  export CWD="$PWD" 
  mkdir -p build
  cd build
  cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$UHDM_PREFIX
  cmake --build .
  cd $CWD
}

uhdm_debug(){
  export CWD="$PWD" 
  mkdir -p build
  cd build
  cmake ../ -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=$UHDM_PREFIX
  cmake --build .
  cd $CWD
}

uhdm_test_windows(){
  export CWD="$PWD" 
  mkdir -p build
  cd build
  cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$UHDM_PREFIX
  cmake --build . --target UnitTests
  cd $CWD
}

uhdm_test_unix(){
  export CWD="$PWD" 
  mkdir -p build
  cd build
  cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$UHDM_PREFIX
  cmake --build . --target UnitTests
  ctest --output-on-failure
  cd $CWD
}

uhdm_test_junit(){
  export CWD="$PWD" 
  release
  cd build && ctest --no-compress-output -T Test -C RelWithDebInfo --output-on-failure
  xsltproc .github/kokoro/ctest2junit.xsl build/Testing/*/Test.xml > build/test_results.xml
  cd $CWD
}


uhdm_clean(){
  echo $PWD
  export CWD=$PWD
  echo $CWD
  rm -f src/*
  rm -rf headers/*
  rm -rf build
  cd $CWD
}

uhdm_install(){ 
  export CWD="$PWD" 
  mkdir -p build
  cd build
  cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$UHDM_PREFIX
  mkdir -p $UHDM_PREFIX
  cmake --build . --target install
  cd $CWD
}

uhdm_uninstall(){
  export CWD="$PWD" 
  rm -rf ${PREFIX}/lib/uhdm
  rm -rf ${PREFIX}/include/uhdm
  cd $CWD
}

uhdm_build(){
  export CWD="$PWD" 
  mkdir -p build
  cd build
  cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$UHDM_PREFIX
  cd $CWD
}

uhdm_test_install(){
  export CWD="$PWD" 
  set CXX="g++"
  ${CXX} -std=c++14 -g tests/test1.cpp -I${UHDM_PREFIX}/include/uhdm -I${UHDM_PREFIX}/include/uhdm/include ${UHDM_PREFIX}/lib/uhdm/libuhdm.a ${UHDM_PREFIX}/lib/uhdm/libcapnp.a ${UHDM_PREFIX}/lib/uhdm/libkj.a -ldl -lutil -lm -lrt -lpthread -o test_inst
  ./test_inst
  cd $CWD
}
#for arg in $@
#do
#   if [ "$arg" = "release" ]; then 
#	   release
#   fi
#   if [ "$arg" = "debug" ]; then 
#	   debug
#   fi
#   if [ "$arg" = "test_windows" ]; then 
#	   test_windows
#   fi
#   if [ "$arg" = "test_unix" ]; then 
#	   test_unix
#   fi
#   if [ "$arg" = "test_junit" ]; then 
#	   test_junit
#   fi
#   if [ "$arg" = "clean" ]; then 
#	   clean
#   fi
#   if [ "$arg" = "install" ]; then 
#	   install
#   fi
#   if [ "$arg" = "uninstall" ]; then 
#	   uninstall
#   fi
#   if [ "$arg" = "build" ]; then 
#	   build
#   fi
#   if [ "$arg" = "test_install" ]; then 
#	   test_install
#   fi
#done
