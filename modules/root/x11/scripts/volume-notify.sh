#!/usr/bin/env bash

# check parameters
if [ $# -ne 2 ] && [ $# -ne 1 ] ; then
    echo "Usage: $0 [increase|decrease|toggle] [value]"
    exit 1
fi

# parameters
action=$1
value=$2

# main
case $action in
    increase)
        pamixer -i "$value"
        # get status
        volume=$(pamixer --get-volume)
       ;;
    decrease)
        pamixer -d "$value"
        # get status
        volume=$(pamixer --get-volume)
        ;;
    toggle)
        pamixer -t
        volume=$(pamixer --get-mute)
        ;;
    *)
        echo "Invalid action. Use 'increase' or 'decrease' or 'toggle'."
        exit 1
        ;;
esac

# dunst
dunstify -t 1000 -r 9995 -u normal "Volume" "${action} to: ${volume}"
