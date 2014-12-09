#!/bin/sh
red='\033[0;31m'
NC='\033[0m'

report=( througput packets pdr )
round=$1

for r in ${report[@]}
do
	if [ ! -d report-${r} ]; then
		mkdir report-${r}
	fi

for i in 25 50 100;
do 
	for j in 0 15 30 60 150 300;
	do
          echo -en 'AODV\tn='${i}', p='${j}';\t' >> report-${r}/${round}.txt
	  gawk -f awk-scripts/${r}.awk aodv-tr/aodv-${i}-${j}.tr  >> report-${r}/${round}.txt
          echo -en 'DSR\tn='${i}', p='${j}';\t'   >> report-${r}/${round}.txt
	  gawk -f awk-scripts/${r}.awk dsr-tr/dsr-${i}-${j}.tr   >> report-${r}/${round}.txt
	  echo -en 'DSDV\tn='${i}', p='${j}';\t'  >> report-${r}/${round}.txt
	  gawk -f awk-scripts/${r}.awk dsdv-tr/dsdv-${i}-${j}.tr   >> report-${r}/${round}.txt
	done

done

done
