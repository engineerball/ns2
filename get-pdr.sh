#!/bin/sh
red='\033[0;31m'
NC='\033[0m'

if [ ! -d 'report-througput' ]; then
	mkdir report-througput
fi

for i in 25 50 100;
do 
	for j in 0 15 30 60 150 300;
	do
          echo -en ${red}'AODV\tn='${i}', p='${j}';\t' 
	  gawk -f awk-scripts/pdr.awk aodv-tr/aodv-${i}-${j}.tr 
          echo -en ${NC}'DSR\tn='${i}', p='${j}';\t' 
	  gawk -f awk-scripts/pdr.awk dsr-tr/dsr-${i}-${j}.tr 
	  echo -en 'DSDV\tn='${i}', p='${j}';\t'
	  gawk -f awk-scripts/pdr.awk dsdv-tr/dsdv-${i}-${j}.tr 
	done

done
