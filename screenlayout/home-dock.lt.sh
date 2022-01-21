#!/bin/sh

xrandr --output DVI-D-0 --off
xrandr --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --primary --mode 2560x1440 --pos 1920x0 --rotate normal
xrandr --output DP-0 --off 
xrandr --output DP-1 --off
xrandr --output DP-3 --off
xrandr --output DP-4 --off
xrandr --output DP-5 --off
xrandr --output eDP-1-1 --off
xrandr --output DP-1-1 --off
xrandr --output HDMI-1-1 --off
xrandr --output DP-1-2 --off
xrandr --output HDMI-1-2 --off
