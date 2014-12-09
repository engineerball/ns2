#!/bin/sh

if [ ! -d 'aodv-tr' ]; then
	mkdir aodv-tr
fi

for i in 0 15 30 60 150 300;
do 
	for j in 25 50 100;
	do
	  ns run.tcl -scen scenario/scen-${j}-${i} -tfc traffic/cbr-${j} -tr aodv-tr/aodv-${j}-${i}.tr -rpr 2 -nn ${j}	
	done

done
