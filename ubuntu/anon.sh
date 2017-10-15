#!/bin/bash


#w=wlx00c0ca90009e
w=wlp58s0
scans=/root/airodump

if [ ! -d $scans ]; then mkdir $scans; fi

service network-manager stop && \
ifconfig $w down && \
macchanger -r $w

if [ ! -z "$1" ]; then
	wpa_supplicant -i $w -c "$1"
fi

airodump-ng -b a $w -M -U -w $scans/$w-$(date +%FT%T)-5GHz
airodump-ng -b g $w -M -U -w $scans/$w-$(date +%FT%T)-2GHz

ifconfig $w down && \
macchanger -r $w && \
iwconfig $w mode managed && \
ifconfig $w up

