#!/bin/sh

echo '"package":{'
RPMS=`rpm -qa --queryformat '"%{NAME}" : {"release" : "%{RELEASE}", "version": "%{VERSION}", "arch": "%{ARCH}" \},' | sed 's/,$//'` 
echo $RPMS
echo '},'


