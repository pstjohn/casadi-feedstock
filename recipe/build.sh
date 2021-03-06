if [ $PY3K == 1 ]; then
  CMAKE_FLAG="-DWITH_PYTHON3=ON" WITH_PYTHON3=ON PY3=ON PSF=3 PYTHONVERSION=35
else
  PYTHONVERSION=27 PSF="" CMAKE_FLAG="" TESTCOMMIT=ON
fi

if [ "$(uname)" == "Linux" ]
then
    # export CXXFLAGS="${CXXFLAGS} -L${PREFIX}/lib -lquadmath -lgfortran"
    export CXXFLAGS="${CXXFLAGS} -L${PREFIX}/lib -Wl,-rpath-link,${PREFIX}/lib"
fi

mkdir build
pushd build

cmake $CMAKE_FLAG \
  -DCMAKE_C_COMPILER=${CC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DWITH_SELFCONTAINED=OFF \
  -DWITH_PYTHON=ON \
  -DWITH_LAPACK=ON \
  -DWITH_IPOPT=ON \
  -DWITH_JSON=ON \
  -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX}\
  -DPYTHON_PREFIX=${SP_DIR} \
  $SRC_DIR

make VERBOSE=1 -j${CPU_COUNT}
make install
