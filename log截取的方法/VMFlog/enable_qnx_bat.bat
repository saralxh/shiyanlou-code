#!/bin/bash

echo "waiting for adb protocol enumeration"
adb wait-for-device && adb devices

echo "Please set the host ethernet address to 192.168.10.1 before proceed further"

echo "switching the device to ROOT user"
adb root

echo "setting up the ip address for QNX & Android"
adb shell iptables -F
adb shell iptables -F -t nat
adb shell iptables -F -t mangle
adb shell iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
adb shell ifconfig eth1 192.168.10.2 up
adb shell ifconfig eth0 192.168.1.2
adb shell ifconfig -a

echo "ip address set successful"

echo "telnet 192.168.1.1 --> for QNX Shell"
echo "adb connect 192.168.1.2:5555 --> for Android"

pause

