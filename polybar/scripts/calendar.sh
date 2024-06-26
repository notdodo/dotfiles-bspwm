#!/bin/bash

BAR_HEIGHT=30  # polybar height
BORDER_SIZE=1  # border size from your wm settings
YAD_WIDTH=222  # 222 is minimum possible value
YAD_HEIGHT=193 # 193 is minimum possible value
DATE_FORMAT="+%a %d %H:%M"

# Get active window information
active_window_info=$(xwininfo -id "$(xdotool getactivewindow)")
if [ -z "$active_window_info" ]; then
    echo "Error: Unable to get active window information."
    exit 1
fi

# Extract window properties
eval "$(echo "$active_window_info" | 
    sed -n -e 's/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p' \
           -e 's/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p' \
           -e 's/^ \+Width: \+\([0-9]\+\).*/WIDTH=\1/p' \
           -e 's/^ \+Height: \+\([0-9]\+\).*/HEIGHT=\1/p')"

# Function to show calendar popup
show_calendar_popup() {
    local pos_x=$(( WIDTH + x - YAD_WIDTH - 12 ))
    local pos_y=$(( BAR_HEIGHT + BORDER_SIZE))

    yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
        --width="$YAD_WIDTH" --height="$YAD_HEIGHT" --posx="$pos_x" --posy="$pos_y" \
        --title="yad-calendar" --borders=0 >/dev/null &
}

case "$1" in
    --popup)
        if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
            exit 0
        fi
        show_calendar_popup
        ;;
    *)
        date "$DATE_FORMAT"
        ;;
esac

exit 0
