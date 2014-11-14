#!/bin/sh

if [ ! -d 'dsr-tr' ]; then
	mkdir dsr-tr
fi

for i in 0 15 30 60 150 300;
do 
	for j in 25 50 100;
	do
	  ns run.tcl -scen scenario/scen-${j}-${i} -tfc traffic/cbr-${j} -tr dsr-tr/dsr-${j}-${i}.tr -rpr 1 -nn ${j}	
	done

done
