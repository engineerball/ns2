#!/bin/sh

BACKUP='backup'
if [ ! -d ${BACKUP} ]
then
	mkdir ${BACKUP}
fi
	
for round in {1..10}; do
	echo 'Round '${round}
	sh make-scenario.sh
	sh make-traffic.sh
	sh run-aodv.sh
	sh run-dsdv.sh
	sh run-dsr.sh
	sh get-report.sh ${round}	
	tar czf ${BACKUP}/round-${round}.tar.gz scenario traffic aodv-tr dsdv-tr dsr-tr
	rm -Rf aodv-tr dsdv-tr dsr-tr scenario traffic
	
done
