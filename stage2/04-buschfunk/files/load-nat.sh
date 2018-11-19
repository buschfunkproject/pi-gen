#!/bin/sh

iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A  POSTROUTING -o wlan0 -j MASQUERADE
