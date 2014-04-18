#!/bin/sh

echo '"package":{'
RPMS=`rpm -qa --queryformat '"%{NAME}" : { "velease": "%{RELEASE}", "arch": "%{ARCH}" \},' | sed 's/,$//'` 
echo $RPMS
echo '},'


