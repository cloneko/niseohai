#!/bin/sh

WGETOPT='--no-check-certificate'

# Begin JSON
echo '{'

################################## # Hostname
HOSTNAME=`hostname`
echo '"hostname": "'$HOSTNAME'",'


# CPU Information 
CPU_MODELS=`grep 'model name' /proc/cpuinfo | sort | uniq | sed 's/[^:]*://'`
CPU_CORES=`grep 'model name' /proc/cpuinfo | wc -l | sed 's/ //g'`

# CPU Infomration Output
echo '"cpu":{'
echo '"model":"'$CPU_MODELS'",'
echo '"cores":'$CPU_CORES
echo '},'

# Physical Mem
MEM=`grep 'MemTotal' /proc/meminfo | awk '{print $2}'`
SWAP=`grep 'SwapTotal' /proc/meminfo | awk '{print $2}'`

echo '"memory":{'
echo '"physical":'$MEM','
echo '"swap":'$SWAP
echo '},'


# Disk Size
echo '"disk":{'
DISKS=`egrep '(sd[a-f]|id[a-f])[0-9]$' /proc/partitions | awk '{print "\""$4"\":"$3","}'`
DISKS=`echo $DISKS | sed 's/,$//'`
echo $DISKS
echo '},'

# IP Address
IPADDRESS=`/sbin/ip addr | grep inet | grep brd | awk '{print "\""$7"\":{\"ipv4\": \""$2"\",\"broadcast\": \""$4"\"},"}'  `

IPADDRESS=`echo $IPADDRESS | sed 's/,$//'`

echo '"network":{'
echo $IPADDRESS 
echo '},'

# Package List

wget $WGETOPT -q -O - https://raw.githubusercontent.com/cloneko/niseohai/master/rpm.sh | sh


# Dist
DIST=""

if test -e /etc/redhat-release ; then
	DIST=`cat /etc/redhat-release`
else
	if test -e /etc/turbolinux-release ; then
		DIST=`cat /etc/turbolinux-release`
	else
		if test -e /etc/system-release ; then
			DIST=`cat /etc/turbolinux-release`
		else
			DIST='Unknown'
		fi
	fi
fi

echo '"os":{'
echo "\"kernel\": \"linux\","
echo "\"distribution\": \"$DIST \""
echo '}'

##########################################################
# End JSON
echo '}'
