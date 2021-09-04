#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can also use 
polybar-msg cmd quit || killall -q polybar

# Launch bars
echo "---" | tee /tmp/polybar1.log /tmp/polybar2.log
polybar mainbar-bspwm >>/tmp/polybar1.log 2>&1 & disown
polybar mainbar-bspwm-extra >>/tmp/polybar2.log 2>&1 & disown
