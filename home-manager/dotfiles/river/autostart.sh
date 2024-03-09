#!/bin/bash

# Authentication dialog

wlr-randr --output eDP-1 --scale 2.0

# Start Kanshi which also starts Yambar
pkill -f kanshi
kanshi &

pkill -f swaybg
swaybg -m fill -i ~/.config/hypr/Wallpapers/Professional/balloon-wp.jpg &

pkill -f i3bar-river
i3bar-river &

pkill -f dunst
dunst &

pkill -f wlsunset
wlsunset -l 57.4 -L -1.9 &

export wallpaper='~/.config/hypr/Wallpapers/Professional/balloon-wp.jpg'

pkill -f swayidle
swayidle -w \
	timeout 300 'swaylock -f -i $wallpaper' \
	timeout 600 'wlopm --off \*;swaylock -F -i ~/~/.config/hypr/Wallpapers/Professional/balloon-wp.jpg' resume 'wlopm --on \*' \
	before-sleep 'swaylock -f -i $wallpaper' &
