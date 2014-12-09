#!/bin/sh


setdest_bin='/opt/ns2/ns-2.35/indep-utils/cmu-scen-gen/setdest/setdest'

if [ ! -d scenario ]; then
	mkdir scenario
fi


for i in 0 15 30 60 150 300; do
	for j in 25 50 100; do
		${setdest_bin} -n ${j} -p ${i} -s 1 -M 13.8888889 -t 300 -x 1500 -y 1500 > scenario/scen-${j}-${i};
	done
done

ls -la scenario
