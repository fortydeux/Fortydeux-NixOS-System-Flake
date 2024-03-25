#!/bin/bash

# Authentication dialog

wlr-randr --output eDP-1 --scale 2.0

# Start Kanshi which also starts Yambar
pkill -f kanshi
kanshi &

pkill -f swaybg
swaybg -m fill -i ~/.config/river/wallpapers/balloon-wp.jpg &

pkill -f waybar
waybar -c ~/.config/river/waybar/config -s ~/.config/river/waybar/style.css &

pkill -f mako
mako &

pkill -f nm-applet
nm-applet &

pkill -f blueman-applet
blueman-applet &

pkill -f wlsunset
wlsunset -l 57.4 -L -1.9 &

pkill -f pcloud
pcloud & 

export wallpaper='~/.config/river/wallpapers/balloon-wp.jpg'

pkill -f swayidle
swayidle -w \
	timeout 900 'swaylock -f -i $wallpaper' \
	timeout 1200 'wlopm --off \*;swaylock -F -i ~/.config/river/wallpapers/balloon-wp.jpg' resume 'wlopm --on \*' \
	before-sleep 'swaylock -f -i $wallpaper' &
