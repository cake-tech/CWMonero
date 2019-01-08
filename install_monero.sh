#!/bin/bash

SOURCE_DIR=`pwd`
EXTERNAL_DIR_PATH="$SOURCE_DIR/External"
EXTERNAL_UTILS_DIR_PATH="`pwd`/../SharedExternal"
EXTERNAL_SOURCES_DIR_PATH="$SOURCE_DIR/../SharedExternal"
BOOST_URL="https://github.com/fotolockr/ofxiOSBoost.git"
BOOST_DIR_PATH="$EXTERNAL_SOURCES_DIR_PATH/ofxiOSBoost"
OPEN_SSL_URL="https://github.com/x2on/OpenSSL-for-iPhone.git"
OPEN_SSL_DIR_PATH="$EXTERNAL_SOURCES_DIR_PATH/OpenSSL"
MONERO_CORE_URL="https://github.com/fotolockr/monero-gui.git"
MONERO_CORE_DIR_PATH="$EXTERNAL_DIR_PATH/monero-gui"
MONERO_URL="https://github.com/fotolockr/monero.git"
MONERO_DIR_PATH="$MONERO_CORE_DIR_PATH/monero"

if [ -z "$EXTERNAL_LIBS_PATH"]
then
  EXTERNAL_LIBS_PATH="$EXTERNAL_UTILS_DIR_PATH/libs"
fi

EXTERNAL_MONERO_LIB_PATH="$EXTERNAL_LIBS_PATH/monero/libs"
EXTERNAL_MONERO_INCLUDE_PATH="$EXTERNAL_LIBS_PATH/monero/include"

echo "Export Boost vars"
export BOOST_LIBRARYDIR="${EXTERNAL_UTILS_DIR_PATH}/ofxiOSBoost/build/ios/prefix/lib"
export BOOST_LIBRARYDIR_x86_64="${EXTERNAL_UTILS_DIR_PATH}/ofxiOSBoost/build/libs/boost/lib/x86_64"
export BOOST_INCLUDEDIR="${EXTERNAL_UTILS_DIR_PATH}/ofxiOSBoost/build/ios/prefix/include"
echo "Export OpenSSL vars"
export OPENSSL_INCLUDE_DIR="${EXTERNAL_UTILS_DIR_PATH}/OpenSSL/include"
export OPENSSL_ROOT_DIR="${EXTERNAL_UTILS_DIR_PATH}/OpenSSL/lib"
export SODIUM_LIBRARY=$SODIUM_LIBRARY_PATH
export SODIUM_INCLUDE=$SODIUM_INCLUDE_PATH
mkdir -p monero/build
./ios_get_libwallet.api.sh
echo "Copy dependencies"
mkdir -p $EXTERNAL_MONERO_LIB_PATH
mkdir -p $EXTERNAL_MONERO_LIB_PATH/lib-ios
mkdir -p $EXTERNAL_MONERO_LIB_PATH/lib
mkdir -p $EXTERNAL_MONERO_LIB_PATH/lib-x86_64
mkdir -p $EXTERNAL_MONERO_INCLUDE_PATH
mkdir -p $EXTERNAL_MONERO_INCLUDE_PATH/src
mkdir -p $EXTERNAL_MONERO_INCLUDE_PATH/external
mkdir -p $EXTERNAL_MONERO_INCLUDE_PATH/contrib

mv $MONERO_DIR_PATH/lib-ios/* $EXTERNAL_MONERO_LIB_PATH/lib-ios/
mv $MONERO_DIR_PATH/lib/* $EXTERNAL_MONERO_LIB_PATH/lib/
mv $MONERO_DIR_PATH/lib-x86_64/* $EXTERNAL_MONERO_LIB_PATH/lib-x86_64/
mv $MONERO_DIR_PATH/src/* $EXTERNAL_MONERO_INCLUDE_PATH/src
mv $MONERO_DIR_PATH/external/* $EXTERNAL_MONERO_INCLUDE_PATH/external
mv $MONERO_DIR_PATH/contrib/* $EXTERNAL_MONERO_INCLUDE_PATH/contrib