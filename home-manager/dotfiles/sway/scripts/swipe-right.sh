#!/usr/bin/env bash

# Get the current workspace
current_workspace=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true) | .num')

# Calculate the target workspace (current+1)
target_workspace=$((current_workspace - 1))

# Move the current container to the target workspace
#swaymsg "move container to workspace number $target_workspace"

# Optionally, switch to the new workspace
swaymsg "workspace number $target_workspace"
