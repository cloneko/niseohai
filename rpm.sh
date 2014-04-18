#!/bin/sh

echo '"package":{'
RPMS=`rpm -qa --queryformat '"%{NAME}" : { "version": "%{RELEASE}", "arch": "%{ARCH}" \},' | sed 's/,$//'` 
echo $RPMS
echo '},'


