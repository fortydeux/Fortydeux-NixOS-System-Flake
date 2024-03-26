#!/usr/bin/env bash

# Get the current resolution of the primary display
resolution_width=$(wlr-randr --json | jq -r '.[] | select(.name=="eDP-1") | .modes[] | select(.current==true) | .width')

# Set conditions
if [ "$resolution_width" -gt 1920 ] && [ "$resolution_width" -le 2880 ]; then
    scale=1.5
elif [ "$resolution_width" -gt 2880 ]; then
    scale=2.0
else
    scale=1.0
fi

# Echo message and set new scale
echo "Detected resolution width: $resolution_width, setting scale to $scale"
wlr-randr --output eDP-1 --scale $scale
