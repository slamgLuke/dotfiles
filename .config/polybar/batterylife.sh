#!/bin/bash
BATTERY_LIFE=`upower -d | grep -E "time to empty|time to full" | sed 's/^[^:]*://' | awk '{print $1$2}' | sed 's/h.*/h/' | sed 's/m.*/m/'`
echo "$BATTERY_LIFE"
