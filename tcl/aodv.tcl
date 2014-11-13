set opt(chan)           Channel/WirelessChannel    ;# channel type 
set opt(prop)           Propagation/TwoRayGround   ;# radio-propagation model 
set opt(netif)          Phy/WirelessPhy            ;# network interface type 
set opt(mac)            Mac/802_11                 ;# MAC type 
set opt(ifq)            Queue/DropTail/PriQueue    ;# interface queue type 
set opt(ll)             LL                         ;# link layer type 
set opt(ant)            Antenna/OmniAntenna        ;# antenna model 
set opt(ifqlen)         50                         ;# max packet in ifq 
set opt(nn)             50                         ;# number of mobilenodes 
set opt(rp)             AODV                       ;# routing protocol 
set opt(x)              1500   			   ;# X dimension of topography 
set opt(y)              1500  			   ;# Y dimension of topography   

set opt(scen)           "scenario/scen-50-000"
set opt(tfc)            "traffic/cbr-40-01"

### Setting The Simulator Objects
                  
      set ns_ [new Simulator]
#create the nam and trace file:
      set tracefd [open aodv.tr w]
      $ns_ trace-all $tracefd

      set namtrace [open aodv.nam w]
      $ns_ namtrace-all-wireless $namtrace  $opt(x) $opt(y)

      set topo [new Topography]
      $topo load_flatgrid $opt(x) $opt(y)
      create-god $opt(nn)
      set chan_1_ [new $opt(chan)]
      
#  Defining Node Configuration
                        
                  $ns_ node-config -adhocRouting $opt(rp) \
                   -llType $opt(ll) \
                   -macType $opt(mac) \
                   -ifqType $opt(ifq) \
                   -ifqLen $opt(ifqlen) \
                   -antType $opt(ant) \
                   -propType $opt(prop) \
                   -phyType $opt(netif) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace ON \
                   -movementTrace ON \
                   -channel $chan_1_

###  Creating The WIRELESS NODES
      for {set i 0} {$i < $opt(nn) } {incr i} {
        set node_($i) [$ns_ node]
	$node_($i) random-motion 0
      } 

            

###  Setting The Initial Positions of Nodes

      puts "Load node pattern..."
      source $opt(scen)
 
      ## Setting Thne Node movement
      puts "Load traffic..."
      source $opt(tfc)

      ## Setting The Node Size
      for {set i 0} {$i < $opt(nn) } {incr i} {
	$ns_ initial_node_pos $node($i) 70
      } 
                              

      ## SETTING ANIMATION RATE 
$ns_ at 0.0 "$ns_ set-animation-rate 12.5ms"

            
      ### PROCEDURE TO STOP 

      proc stop {} {
            
                        global ns_ tracefd
                        $ns_ flush-trace
                        close $tracefd
                        exec nam aodv.nam &            
                        exit 0

                   }

      puts "Starting Simulation........"
      $ns_ at 25.0 "stop"
      $ns_ run
