#!/bin/sh
iptables-save | grep PREROUTING | grep REDSOCKS2 && exit 0
/etc/init.d/redsocks2 enabled && iptables -t nat -A PREROUTING -p tcp -j REDSOCKS2
