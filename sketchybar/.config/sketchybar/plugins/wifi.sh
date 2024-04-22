#!/usr/bin/env sh

a=$(networkQuality)
er=$(echo $a | grep Error)
if [ "$er" = "" ]; then
    wname=$(networksetup -getairportnetwork en0 | awk '{print $4}')
    ds=$(echo $a | awk '{print $6}')
    du=$(echo $a | awk '{print $7}')
    us=$(echo $a | awk '{print $10}')
    uu=$(echo $a | awk '{print $11}')
    sp=$(echo " ${ds:0:5} $du  ${us:0:5} $uu")
    CURR_IP="$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}')"

    WIFIACTIVEICON=􀙇
    WIFIINACTIVEICON=􀙈
    sketchybar --set $NAME icon="" label="$wname $sp"
else
    sketchybar --set $NAME icon=$WIFIINACTIVEICON label=""
fi
