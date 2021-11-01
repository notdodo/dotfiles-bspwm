#!/usr/bin/env bash

function main() {
    DEFAULT_SINK_ID=$(pactl info |rg -o 'Default Sink: (.*)' -r '$1')
    VOLUME="$(pactl list sinks | rg -i ${DEFAULT_SINK_ID} | rg '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')"
    VOLUME="$(pactl list sinks|rg -i ${DEFAULT_SINK_ID} -A 7 | rg -io '(\d{0,3})%' -r '$1' | head -n 1)"
    IS_MUTED="$(pactl list sinks|rg -i ${DEFAULT_SINK_ID} -A 7 | rg "Mute: yes")"

    action=$1
    if [ "${action}" == "up" ]; then
      pactl set-sink-volume ${DEFAULT_SINK_ID} +2%
    elif [ "${action}" == "down" ]; then
        pactl set-sink-volume ${DEFAULT_SINK_ID} -2%
    elif [ "${action}" == "mute" ]; then
        pactl set-sink-mute ${DEFAULT_SINK_ID} toggle
    else
        if [ "${IS_MUTED}" != "" ]; then
            echo " ${VOLUME}%"
        else
            echo " ${VOLUME}%"
        fi
    fi
}

main "$@"
