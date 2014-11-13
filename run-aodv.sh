#!/bin/sh

if [ ! -d 'aodv-tr' ]; then
	mkdir aodv-tr
fi

for i in {0..10} ;
do 
	for j in {01..20};
	do
	  ns run.tcl -scen scenario/scen-50-${i}00 -tfc traffic/cbr-40-${j} -tr aodv-tr/aodv-${i}00-${j}.tr -rpr 2	
	done

done
