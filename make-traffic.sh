#!/bin/sh


cbrgen_bin='/opt/ns2/ns-2.35/indep-utils/cmu-scen-gen/cbrgen.tcl'

if [ ! -d traffic ]; then
	mkdir traffic
fi


for i in {01..20}; 
	do ns ${cbrgen_bin}  -type cbr -nn 40 -seed $RANDOM -mc 5 -rate 5.0 > traffic/cbr-40-${i}; 
done

ls -la traffic
