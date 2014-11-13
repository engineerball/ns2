#!/bin/sh


setdest_bin='/opt/ns2/ns-2.35/indep-utils/cmu-scen-gen/setdest/setdest'

if [ ! -d scenario ]; then
	mkdir scenario
fi


for i in {0..10}; do
	${setdest_bin} -n 50 -p ${i}00 -s 1 -M 13.8888889 -t 900 -x 1500 -y 1500 > scenario/scen-50-${i}00;
done

ls -la scenario
