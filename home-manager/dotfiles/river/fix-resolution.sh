#!/usr/bin/env bash

# Get the current resolution of the primary display
resolution=$(wlr-randr --json | jq -r '.[] | select(.name=="eDP-1") | .modes[] | select(.current==true) | .width')

# Replace PRIMARY_DISPLAY_NAME with your actual primary display name, e.g., eDP-1. You can find it by just running `wlr-randr --json` and checking the names.

if [ "$resolution" -gt 1920 ]; then
    scale=2
else
    scale=1
fi

# Apply the scale factor
# This command will vary based on your window manager and how it accepts dynamic configuration changes.
# For Wayfire, you might use wf-config or wcm. For others, you might directly use their command interface, e.g., `riverctl output * scale $scale` for River.

echo "Detected resolution width: $resolution, setting scale to $scale"
wlr-randr --output eDP-1 --scale $scale
