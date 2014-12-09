#!/bin/sh

if [ ! -d 'dsdv-tr' ]; then
	mkdir dsdv-tr
fi

for i in 0 15 30 60 150 300;
do 
	for j in 25 50 100;
	do
	  ns run.tcl -scen scenario/scen-${j}-${i} -tfc traffic/cbr-${j} -tr dsdv-tr/dsdv-${j}-${i}.tr -rpr 3 -nn ${j}
	done

done
