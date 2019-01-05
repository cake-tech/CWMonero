#!/bin/bash

echo "Installing missing headers"

function link_file {
  if [ ! -f $1 ]; then
    ln -s $2 $1
  else
    echo "File $1 is already"
  fi
}

# vmmeter
mkdir -p /usr/local/include/sys
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/sys/vmmeter.h /usr/local/include/sys/vmmeter.h

# netinet
mkdir -p /usr/local/include/netinet
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/netinet/ip_var.h /usr/local/include/netinet/ip_var.h
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/netinet/udp_var.h /usr/local/include/netinet/udp_var.h

# IOKit
mkdir -p /usr/local/include/IOKit
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/IOTypes.h  /usr/local/include/IOKit/IOTypes.h
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/IOKitLib.h /usr/local/include/IOKit/IOKitLib.h
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/IOReturn.h /usr/local/include/IOKit/IOReturn.h
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/OSMessageNotification.h  /usr/local/include/IOKit/OSMessageNotification.h

# IOKit/ps
mkdir -p /usr/local/include/IOKit/ps
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/ps/IOPSKeys.h /usr/local/include/IOKit/ps/IOPSKeys.h
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/ps/IOPowerSources.h /usr/local/include/IOKit/ps/IOPowerSources.h

# libkern
mkdir -p /usr/local/include/libkern
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/libkern/OSTypes.h /usr/local/include/libkern/OSTypes.h
ln -s /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/IOKitKeys.h /usr/local/include/IOKit/IOKitKeys.h
