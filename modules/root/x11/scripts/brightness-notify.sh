#!/usr/bin/env bash

# check parameters
if [ $# -ne 2 ]; then
    echo "Usage: $0 [increase|decrease] [percentage|value]"
    exit 1
fi

# parameters
action=$1
value=$2

# main
case $action in
    increase)
        brightnessctl set "$value+"
        ;;
    decrease)
        brightnessctl set "$value-"
        ;;
    *)
        echo "Invalid action. Use 'increase' or 'decrease'."
        exit 1
        ;;
esac

# get status
brightness=$(( $(brightnessctl get) * 100 / 960 ))

# dunst
dunstify -t 1000 -r 9994 -u normal "Brightness " "${action} to: ${brightness}%"
