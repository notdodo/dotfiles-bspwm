#!/usr/bin/env zsh

# Get id of all non-floating windows on current desktop
WINDOWS=(${(f)"$(bspc query -N -d focused -n .window)"})

# Get id of currently focused window
FOCUSED="$(bspc query -N -d focused -n .focused.window)"

FORMAT="-f3-"

isVim () {
  if [[ "${wname_complete:l}" == *"vim"* ]]; then
    echo " $(echo -n "${wname}" | cut -d '-' -f1)"
  else
    echo " ${wname}"
  fi
}

parse_windows() {
  #Get WM_CLASS string from all IDs
  windowlist=""
  private="(Private Browsing)"
  for wid in ${WINDOWS}; do
    local max_length="${1}"
    #Get window's class, title/name and PID
    local info=$(xprop -id "${wid}" WM_NAME WM_CLASS _NET_WM_PID)
    wclass="$(echo "${info}" | rg WM_CLASS | cut -d "=" -f2 | sed -e 's/\"//g')"
    wclass=($(awk -F ',' '{$1=$1} 1' <<< "${wclass}" ))
  
    # Get window's pid
    local wpid=$(echo "${info}" | rg _NET_WM_PID | cut -d " " -f3)
  
    #Get window's name
    local wname_complete="$(echo "$info" | rg WM_NAME)"
    local wname="$(echo -n "${wname_complete//\"}" | cut -d " " $FORMAT)"
  
    case "${wclass[2]}" in
      "Autopsy" )
        wname=" ${wname}" ;;
      "burp-StartBurp"| "install4j-burp-StartBurp" )
        wname=" ${wname}" ;;
      "Chromium"*|"Google-chrome")
        wname=" ${wname// - Google Chrome}" ;;
      "Firefox" )
        if test "${wname_complete#*$private}" != "${wname_complete}"; then
          wname=" ${wname// — Mozilla Firefox/}"
        else
          wname=" ${wname// — Mozilla Firefox/}"
        fi ;;
      "File-roller" )
        wname=" ${wname}" ;;
      "Gufw.py" )
        wname=" ${wname}" ;;
      "java" )
        wname=" ${wname}" ;;
      "libreoffice-calc" )
        wname=" ${wname// - LibreOffice Calc/}" ;;
      "libreoffice-impress" )
        wname=" ${wname// - LibreOffice Impress/}" ;;
      "Nm-connection-editor" )
        wname=" ${wname}" ;;
      "Mist" )
        wname=" ${wname}" ;;
      "Mumble" )
        wname=" ${wname}" ;;
      "Nemo"|"Pcmanfm"|"Thunar"|"dolphin" )
        wname=" ${wname// - File Manager/}" ;;
      "rdesktop"|"org.remmina.Remmina"|"Remote-viewer" )
        wname=" ${wname//- Remote Viewer/}";;
      "Slack" )
        wname=" ${wname}" ;;
      "Spotify" )
        wname=" Spotify" ;;
      "Steam" )
        wname=" ${wname}" ;;
      "Sublime_text"|"processing-app-Base"|"Code" )
        wname=" ${wname}" ;;
      "TelegramDesktop" )
        wname=" ${wname}" ;;
      "Terminator"|"XTerm"|"konsole"|"yakuake" )
        wname="$(isVim "${wname_complete}" "${wname}")"
        wname="${wname//sudo /}" ;;
      "Thunderbird" )
        wname=" ${wname// - Mozilla Thunderbird/}" ;;
      "Transmission-gtk" )
        wname=" ${wname}" ;;
      "vlc"|"mpv" )
        wname=" ${wname}" ;;
      "Viewnior" )
        wname=" ${wname}" ;;
      "VirtualBox" )
        wname=" ${wname}" ;;
      "Zathura" )
        wname=" $(basename ${wname})" ;;
      "zoom" )
        wname=" ${wname}" ;;
      *)
        case "${wclass[1]}" in
          "chromium" )
            wname=" ${wname}" ;;
          "guake" )
            wname="$(isVim "${wname_complete}" "${wname}")" ;;
          "VirtualBox" )
            wname=" ${wname}" ;;
          # Print the class, helps to make a new entry
          *)
            wname=" $wname ${wclass[2]} ${wclass[1]}" ;;
        esac
    esac
  
    # Default: click with middle click
    wname="%{A2:a:}${wname:0:${max_length}}%{A}"
  
    if [[ "${wid}" == "${FOCUSED}" ]]; then
      win="$(printf "%s" "%{F#2ECC71}${wname}%{F}")"
    else
      win="%{A1:bspc node -f ${wid}:}${wname}%{A}"
    fi
    windowlist="${windowlist} ${win}"
  done
}

parse_windows 150
#Result
if [[ ${#windowlist} -gt 300 ]]; then
  parse_windows 20
fi
if [[ ${#windowlist} -gt 400 ]]; then
  parse_windows 10
fi
echo "${windowlist}"
