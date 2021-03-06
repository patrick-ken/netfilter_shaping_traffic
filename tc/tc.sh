#!/bin/bash
TC=/sbin/tc
IF=eth0
DNLD1=1mbps
DNLD2=1mbps
DNLD3=1mbps
DNLD4=1mbps
DNLD5=1mbps
DNLD6=1mbps
DNLD7=1mbps
DNLD8=1mbps
DNLD9=1mbps
DNLD10=1mbps
IP1=1.1.1.1
IP2=1.1.1.3
IP3=1.1.1.4
IP4=1.1.1.5
IP5=1.1.1.6
IP6=1.1.1.7
IP7=1.1.1.8
IP8=1.1.1.9
IP9=1.1.1.10
IP10=1.1.1.11

start(){
	$TC qdisc add dev $IF root handle 1: htb default 100

	$TC class add dev $IF parent 1: classid 1:1 htb rate 100mbps
	$TC class add dev $IF parent 1:1 classid 1:10 htb rate $DNLD1 ceil $DNLD1
	$TC class add dev $IF parent 1:1 classid 1:11 htb rate $DNLD2 ceil $DNLD2
	$TC class add dev $IF parent 1:1 classid 1:12 htb rate $DNLD3 ceil $DNLD3
	$TC class add dev $IF parent 1:1 classid 1:13 htb rate $DNLD4 ceil $DNLD4
	$TC class add dev $IF parent 1:1 classid 1:14 htb rate $DNLD5 ceil $DNLD5
	$TC class add dev $IF parent 1:1 classid 1:15 htb rate $DNLD6 ceil $DNLD6
	$TC class add dev $IF parent 1:1 classid 1:16 htb rate $DNLD7 ceil $DNLD7
	$TC class add dev $IF parent 1:1 classid 1:17 htb rate $DNLD8 ceil $DNLD8
	$TC class add dev $IF parent 1:1 classid 1:18 htb rate $DNLD9 ceil $DNLD9
	$TC class add dev $IF parent 1:1 classid 1:19 htb rate $DNLD10 ceil $DNLD10


	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP1 flowid 1:10
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP2 flowid 1:11
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP3 flowid 1:12
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP4 flowid 1:13
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP5 flowid 1:14
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP6 flowid 1:15
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP7 flowid 1:16
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP8 flowid 1:17
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP9 flowid 1:18
	$TC filter add dev $IF parent 1:0 protocol ip prio 16 u32 match ip dst $IP10 flowid 1:19
}

stop(){
	tc qdisc del dev eth0 root
}
restart(){
	stop
	sleep 1
	start
}
case "$1" in
start)
echo -n "Starting bandwidth shaping:"
start
echo "done"
;;
stop)
echo -n "Stopping bandwidth shaping:"
stop
echo "done"
;;
restart)
echo -n "Restarting bandwidth shaping:"
restart
echo "done"
;;
*)
pwd = $(pwd)
echo "Wrong usage"
;;
esac

exit 0
