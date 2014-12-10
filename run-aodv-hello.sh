#!/bin/sh

for round in {1..10}
do
	tar xzf backup/round-${round}.tar.gz 
	rm -Rf aodv-tr dsdv-tr dsr-tr
	sh run-aodv.sh
	sh get-aodv-packets.sh >> report-packets/aodv-${round}.txt
	sh get-aodv-pdr.sh >> report-pdr/aodv-${round}.txt
	sh get-aodv-througput.sh >> report-througput/aodv-${round}.txt
	sh get-aodv-overhead.sh >> report-overhead/aodv-${round}.txt
	rm -Rf aodv-tr traffic scenario 
done
