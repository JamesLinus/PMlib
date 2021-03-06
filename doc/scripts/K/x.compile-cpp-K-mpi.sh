#!/bin/bash
#	source /home/system/Env_base
set -x

PMLIB_DIR=${HOME}/pmlib/install_K
PMLIB_INCLUDES="-I${PMLIB_DIR}/include "
PMLIB_LDFLAGS="-L${PMLIB_DIR}/lib -lPMmpi -lpapi_ext "
# 京コンピュータではPAPIは以下にインストールされている
#	計算ノード		/usr/lib64
#	ログインノード	/opt/FJSVXosDevkit/sparc64fx/target/usr/lib64
PAPI_LDFLAGS="-lpapi -lpfm "

INCLUDES="${PMLIB_INCLUDES} ${PAPI_INCLUDES}"
LDFLAGS="${PMLIB_LDFLAGS} ${PAPI_LDFLAGS} -w -Nfjcex"

WRK_DIR=${HOME}/pmlib/tmp
mkdir -p $WRK_DIR
cd $WRK_DIR; if [ $? != 0 ] ; then echo '@@@ Directory error @@@'; exit; fi

#	MY_SRC=${HOME}/pmlib/scripts/src_test
#	cp $MY_SRC/pmlib_test.cpp main.cpp
MY_SRC=${HOME}/pmlib/PMlib/doc/src_tutorial
cp $MY_SRC/mpi_pmlib.cpp  main.cpp

CXXFLAGS="-Kopenmp,fast -Ntl_notrt -DK_COMPUTER  -DUSE_PAPI"

mpiFCCpx ${CXXFLAGS} ${INCLUDES} -o a.out main.cpp ${LDFLAGS}

ls -l
file a.out
