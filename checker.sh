#!/bin/sh

# Begin JSON
echo '{'

################################## 
# Hostname
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
DISKS=`egrep '(sd[a-f]|id[a-f])$' /proc/partitions | awk '{print "\""$4"\":"$3","}'`
DISKS=`echo $DISKS | sed 's/,$//'`
echo $DISKS
echo '},'

# IP Address
IPADDRESS=`ip addr | grep inet | grep brd | awk '{print "\""$7"\":{\"ipv4\": \""$2"\",\"broadcast\": \""$4"\"},"}'  `

IPADDRESS=`echo $IPADDRESS | sed 's/,$//'`

echo '"network":{'
echo $IPADDRESS 
echo '},'

##########################################################
# End JSON
echo '}'
