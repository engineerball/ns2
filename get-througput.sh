#!/bin/sh
red='\033[0;31m'
NC='\033[0m'

if [ ! -d 'aodv-report' ]; then
	mkdir aodv-report
fi

for i in 25 50 100;
do 
	for j in 0 15 30 60 150 300;
	do
          echo -en ${red}'AODV\tn='${i}', p='${j}';\t' 
	  gawk -f awk-scripts/througput.awk aodv-tr/aodv-${i}-${j}.tr 
          echo -en ${NC}'DSR\tn='${i}', p='${j}';\t' 
	  gawk -f awk-scripts/througput.awk dsr-tr/dsr-${i}-${j}.tr 
	  echo ""
	done

done
