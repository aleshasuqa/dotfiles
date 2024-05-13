#!/bin/sh

CPU=$(printf "%.f\n" $(top -l 2 | grep -E "^CPU" | tail -1 | awk '{ print $3 + $5 }'))

CPUICON=􀫥

if [ ${#CPU} -eq 2 ]; then
    sketchybar -m --set $NAME icon=$CPUICON label="$CPU%"
else
    sketchybar -m --set $NAME icon=$CPUICON label="$CPU%"
fi
