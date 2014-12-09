BEGIN{
recvs = 0;
routing_packets = 0;
}

{
if (( $1 == "r") &&  ( $7 == "cbr" ) && ( $4 =="AGT" ))  recvs++;
if (($1 == "s" || $1 == "f") && $4 == "RTR" && ( $7 =="AODV" || $7 =="message" || $7 =="DSR"|| $7 =="DSDV") ) routing_packets++;
#if (($1 == "s" || $1 == "f") && $4 == "RTR" && $7 =="AODV")    routing_packets++;    # 1

}

END{
printf("NRL = %.3f", routing_packets/recvs);
}
