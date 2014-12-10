#!/bin/sh
CURRENT=`date +%s`
FILENAME="/root/ns2/`ps -ef | grep ns | grep run | awk '{ print $15}'`"
PID=`ps -ef | grep ns | grep run | awk '{ print $2 }'`
LASTMODIFY=`stat -c %Y ${FILENAME}`

TIMEDIFF=`expr ${CURRENT} - ${LASTMODIFY}`

if [ ${TIMEDIFF} -gt 90 ]
then
	kill ${PID}
fi


