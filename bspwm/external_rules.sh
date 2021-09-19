#!/bin/bash
window_id="$1"
window_class="$2"
window_instance="$3"
consequences="$4"

main() {
  case "$window_class" in
    "Thunderbird")
      window_title="$(xwininfo -id "$window_id")"
      [[ $window_title == *"Empty "* ]] &&  echo "state=floating"
      ;;
    "yakuake")
      xdotool windowmove $window_id -- -2000 0
      ;;
    "Spotify")
      if lspci | grep -q "GeForce GTX 1070"; then
        echo "desktop=^4"
      else
        echo "desktop=^9"
      fi
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
echo "window_class: $window_class" >> /tmp/.rules_cmd.log
echo "window_instance: $window_instance" >> /tmp/.rules_cmd.log
echo "consequences: $4" >> /tmp/.rules_cmd.log
