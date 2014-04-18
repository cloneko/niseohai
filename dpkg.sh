#!/bin/sh

DPKG=`dpkg --list |egrep '^[a-zA-Z1-9]'| awk '{print "\""$2"\":{\"version\":"$3"\",\"arch\": \""$4"\"},"}'`
DPKG=`echo $DPKG | sed 's/,$//'`

echo '"package": {'
echo $DPKG
echo '},'
