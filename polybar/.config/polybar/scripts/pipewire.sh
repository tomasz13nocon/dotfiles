#!/usr/bin/env bash

case $1 in
    "up")
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
	wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        ;;
    "down")
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
	wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        ;;
    "mute")
	wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

wpctl get-volume @DEFAULT_AUDIO_SINK@  | awk '{if ($3 == "[MUTED]") print "MM"; else print int($2 * 100)}'
