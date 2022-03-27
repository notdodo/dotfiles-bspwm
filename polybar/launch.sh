#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can also use 
polybar-msg cmd quit || killall -q polybar

# Launch bars
echo "---" | tee /tmp/.polybar1.log /tmp/.polybar2.log
if lspci | grep -q "GeForce GTX 1070" || xrandr | grep -q "HDMI-2 connected"; then
  polybar -c ~/.config/polybar/config.ini mainbar-bspwm >>/tmp/.polybar1.log 2>&1 & disown
  polybar -c ~/.config/polybar/config.ini mainbar-bspwm-extra >>/tmp/.polybar2.log 2>&1 & disown
else
  polybar -c ~/.config/polybar/config.ini mainbar-bspwm-nodock >>/tmp/.polybar1.log 2>&1 & disown
fi
