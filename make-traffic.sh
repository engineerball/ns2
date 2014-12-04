#!/bin/sh


cbrgen_bin='/opt/ns2/ns-2.35/indep-utils/cmu-scen-gen/cbrgen.tcl'

if [ ! -d traffic ]; then
	mkdir traffic
fi


for i in 25 50 100; 
	do ns ${cbrgen_bin} -type cbr -nn ${i} -seed $RANDOM -mc 5 -rate 5.0 > traffic/cbr-${i}; 
done

ls -la traffic
