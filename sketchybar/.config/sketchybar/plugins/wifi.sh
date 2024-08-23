#!/usr/bin/env sh

if [ "$er" = "" ]; then
    wname=$(networksetup -getairportnetwork en0 | awk '{print $4}')
    CURR_IP="$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}')"

    WIFIACTIVEICON=􀙇
    WIFIINACTIVEICON=􀙈
    sketchybar --set $NAME icon=$WIFIACTIVEICON label="$wname $CURR_IP"
else
    sketchybar --set $NAME icon=$WIFIINACTIVEICON label=""
fi
