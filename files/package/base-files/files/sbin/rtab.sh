#!/bin/sh
file="/tmp/rtab.lock"
if [ ! -f "$file" ]; then
    touch /tmp/rtab.lock
    /etc/init.d/redsocks start
    iptables -t nat -N REDSOCKS
	iptables -t nat	-A REDSOCKS -d 0.0.0.0 -j RETURN
	iptables -t nat	-A REDSOCKS -d 255.255.255.255 -j RETURN
	iptables -t nat	-A REDSOCKS -d 10.0.0.0/8 -j RETURN
	iptables -t nat	-A REDSOCKS -d 127.0.0.0/8 -j RETURN
	iptables -t nat	-A REDSOCKS -d 169.254.0.0/16 -j RETURN
	iptables -t nat	-A REDSOCKS -d 172.16.0.0/12 -j RETURN
	iptables -t nat	-A REDSOCKS -d 192.168.0.0/16 -j RETURN
	iptables -t nat	-A REDSOCKS -d 224.0.0.0/4 -j RETURN
	iptables -t nat	-A REDSOCKS -d 240.0.0.0/4 -j RETURN
	iptables -t nat	-A REDSOCKS -d 255.255.255.255 -j RETURN
	iptables -t nat	-A REDSOCKS -p tcp -j REDIRECT --to-ports 1081
	iptables -t nat	-A PREROUTING -p tcp -j REDSOCKS
    for n in $(cat /etc/chinadns_chnroute.txt)
    do
    iptables -t nat -I REDSOCKS -d $n -j RETURN
    done
    rm /tmp/rtab.lock
fi
