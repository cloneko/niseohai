#!/bin/sh

DPKG=`dpkg --list | awk '{print "\""$2"\":{\"version\":"$3"\",\"arch\": \""$4"\"},"}'`
DPKG=`echo $DPKG | sed 's/,$//'`
echo $DPKG
