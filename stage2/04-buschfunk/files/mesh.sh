#!/bin/sh

MYIP=$(cat /etc/network/interfaces.d/mesh | grep address | awk '{print $NF}')
MYESSID=$(cat /etc/network/interfaces.d/mesh | grep essid | awk '{print $NF}')
MYCHAN=$(cat /etc/network/interfaces.d/mesh | grep channel | awk '{print $NF}')

echo "Setting ip $MYIP"
ifconfig wlan0 $MYIP/24

ifconfig wlan0 down

echo "Setting mode ad-hoc"
iwconfig wlan0 mode ad-hoc
echo "Setting essid $MYESSID"
iwconfig wlan0 essid $MYESSID
echo "Setting channel $MYCHAN"
iwconfig wlan0 channel $MYCHAN

ifconfig wlan0 up

