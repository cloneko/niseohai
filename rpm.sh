#!/bin/sh

echo '"rpm":{'
RPMS=`rpm -qa --queryformat '"%{NAME}" : { "velease": "%{RELEASE}", "arch": "%{ARCH}" \}' | sed 's/,$//'` 
echo $RPMS
echo '},'


