#!/bin/sh

MEM=$(memory_pressure | grep "System-wide" | awk '{ print $5 }')

MEMICON=

sketchybar -m --set $NAME icon=$MEMICON label="$MEM"
