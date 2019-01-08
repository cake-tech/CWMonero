#!/bin/bash

SOURCE_DIR=`pwd`
EXTERNAL_DIR_PATH="$SOURCE_DIR/../SharedExternal"
EXTERNAL_SOURCES_DIR_PATH="$SOURCE_DIR/../SharedExternal"
BOOST_URL="https://github.com/fotolockr/ofxiOSBoost.git"
BOOST_DIR_PATH="$EXTERNAL_SOURCES_DIR_PATH/ofxiOSBoost"
OPEN_SSL_URL="https://github.com/x2on/OpenSSL-for-iPhone.git"
OPEN_SSL_DIR_PATH="$EXTERNAL_SOURCES_DIR_PATH/OpenSSL"
LMDB_DIR_URL="https://github.com/LMDB/lmdb.git"
LMDB_DIR_PATH="$EXTERNAL_SOURCES_DIR_PATH/lmdb/Sources"

if [ -z "$EXTERNAL_LIBS_PATH"]
then
  EXTERNAL_LIBS_PATH="$EXTERNAL_DIR_PATH/libs"
fi

EXTERNAL_BOOST_LIB_PATH="$EXTERNAL_LIBS_PATH/boost/lib"
EXTERNAL_BOOST_INCLUDE_PATH="$EXTERNAL_LIBS_PATH/boost/include"
EXTERNAL_OPENSSL_LIB_PATH="$EXTERNAL_LIBS_PATH/OpenSSL/lib"
EXTERNAL_OPENSSL_INCLUDE_PATH="$EXTERNAL_LIBS_PATH/OpenSSL/include"

echo "============================ Init external libs ============================"
mkdir -p $EXTERNAL_DIR_PATH

echo "============================ Boost ============================"

echo "Cloning ofxiOSBoost from - $BOOST_URL"
git clone -b build $BOOST_URL $BOOST_DIR_PATH
cd $BOOST_DIR_PATH/scripts/
export BOOST_LIBS="random regex graph random chrono thread signals filesystem system date_time locale serialization program_options"
./build-libc++

#copy to libs directory
mkdir -p $EXTERNAL_BOOST_LIB_PATH
mkdir -p $EXTERNAL_BOOST_INCLUDE_PATH
mv $BOOST_DIR_PATH/libs/boost/ios/* $EXTERNAL_BOOST_LIB_PATH/
mv $BOOST_DIR_PATH/libs/boost/include/* $EXTERNAL_BOOST_INCLUDE_PATH/

cd $SOURCE_DIR

echo "============================ OpenSSL ============================"

echo "Cloning Open SSL from - $OPEN_SSL_URL"
git clone $OPEN_SSL_URL $OPEN_SSL_DIR_PATH
cd $OPEN_SSL_DIR_PATH
./build-libssl.sh --version=1.0.2j --archs="x86_64 arm64 armv7s armv7" --targets="ios-sim-cross-x86_64 ios64-cross-arm64 ios-cross-armv7s ios-cross-armv7"

#copy to libs directory
mkdir -p $EXTERNAL_OPENSSL_LIB_PATH
mkdir -p $EXTERNAL_OPENSSL_INCLUDE_PATH
mv $OPEN_SSL_DIR_PATH/lib/* $EXTERNAL_OPENSSL_LIB_PATH/
mv $OPEN_SSL_DIR_PATH/include/* $EXTERNAL_OPENSSL_INCLUDE_PATH/

cd $SOURCE_DIR

echo "============================ LMDB ============================"
echo "Cloning lmdb from - $LMDB_DIR_URL"
git clone $LMDB_DIR_URL $LMDB_DIR_PATH
cd $LMDB_DIR_PATH
git checkout b9495245b4b96ad6698849e1c1c816c346f27c3c

cd $SOURCE_DIR