#!/bin/bash

killall conky
conky 2>/dev/null &
killall lemonbar
/home/schlipak/bin/i3/lemonbar.sh | lemonbar -g 1880x40+20+20 -B "#2d2d2d" -F "#f8f8f2" -p -d -f FontAwesome-10 -f ionicons-11 -f "Roboto Condensed"-10
sleep 1
notify-send -t 2500 "Lemonbar successfully started" -i ~/.icons/info
