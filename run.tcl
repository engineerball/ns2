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
set opt(stop)		900
set opt(scen)           "scenario/scen-50-000"
set opt(tfc)            "traffic/cbr-40-01"



if { $argc != 8 } {
        puts "Wrong no. of cmdline args."
        puts "Usage: ns run.tcl -scen <scen> -tfc <tfc> -tr <tr> -rpr <rpr>"
        exit 0
}

        for {set i 0} {$i < $argc} {incr i} {
                set arg [lindex $argv $i]
                if {[string range $arg 0 0] != "-"} continue
                set name [string range $arg 1 end]
#               puts $name
                set opt($name) [lindex $argv [expr $i+1]]
        }

        set opt(scen) [lindex $argv 1]
        set opt(tfc) [lindex $argv 3]

        if {$opt(rpr) == 1} {
        set opt(adhocRouting)   DSR
#        set opt(ifq)    CMUPriQueue
       set opt(ifq)    Queue/DropTail/PriQueue
        } else {
        set opt(adhocRouting)   AODV
        set opt(ifq) Queue/DropTail/PriQueue
        }

        puts $opt(scen)
        puts $opt(tfc)
        puts $opt(tr)

        puts $opt(adhocRouting)

### Setting The Simulator Objects
                  
      set ns_ [new Simulator]
#create the nam and trace file:
      set tracefd [open $opt(tr) w]
      $ns_ trace-all $tracefd

      set namtrace [open aodv.nam w]
      $ns_ namtrace-all-wireless $namtrace  $opt(x) $opt(y)

      set topo [new Topography]
      $topo load_flatgrid $opt(x) $opt(y)
      set god_ [create-god $opt(nn)]
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
	$ns_ initial_node_pos $node_($i) 70
      } 
                              
# Tell nodes when the simulation ends
for {set i 0} {$i < $opt(nn) } {incr i} {
    $ns_ at $opt(stop).000000001 "$node_($i) reset";
}

# tell nam the simulation stop time
#$ns_ at  $opt(stop)    "$ns_ nam-end-wireless $opt(stop)"
$ns_ at  $opt(stop).000000001 "puts \"NS EXITING...\" ; $ns_ halt"

      ## SETTING ANIMATION RATE 
$ns_ at 0.0 "$ns_ set-animation-rate 12.5ms"

            
      ### PROCEDURE TO STOP 

      proc stop {} {
            
                        global ns_ tracefd
                        $ns_ flush-trace
                        close $tracefd
      #                  exec nam aodv.nam &            
                        exit 0

                   }

      puts "Starting Simulation........"
      $ns_ at 25.0 "stop"
      $ns_ run
