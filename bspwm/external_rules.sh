#!/bin/bash
window_id="$1"
window_class="$2"
window_instance="$3"
consequences="$4"
window_title="$(xwininfo -id "$window_id" | sed ' /^xwininfo/!d ; s,.*"\(.*\)".*,\1,')"

main() {
  case "$window_class" in
    "yakuake")
      xdotool windowmove $window_id -- -2000 0
      ;;
    "Spotify")
      echo "desktop=^4"
      ;;
    "")
      sleep 0.5
      window_class=$(xprop -id $window_id | grep "WM_CLASS" | sed 's/.*"\(.*\)"/\1/g' ) 
      window_instance="${window_class,,}"
      [[ -n "$window_class" ]] && main
      ;;
    *)
      echo "Nothing found... $1  $2  $3  $4"
      ;;
  esac
}

main

echo "window_id: $1" >> /tmp/.rules_cmd.log
echo "window_title: $window_title" >> /tmp/.rules_cmd.log
echo "window_class: $window_class" >> /tmp/.rules_cmd.log
echo "window_instance: $window_instance" >> /tmp/.rules_cmd.log
echo "consequences: $4" >> /tmp/.rules_cmd.log
