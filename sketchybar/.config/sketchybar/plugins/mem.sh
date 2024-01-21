#!/bin/sh

MEM=$(printf "%.f\n" $(top -l 1 | grep -E "^Phys" | awk '{ print $2 / 8000 * 100 }'))

MEMICON=

sketchybar -m --set $NAME icon=$MEMICON label="$MEM%"
