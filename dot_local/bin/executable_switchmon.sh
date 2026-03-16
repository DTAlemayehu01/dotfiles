#!/bin/sh
 
case "$1" in
    #DP) xrandr --output DP-1 --primary --mode 1920x1080 --output HDMI-1 --off ;;
    #HDMI) xrandr --output HDMI-1 --primary --mode 1920x1080 --output eDP --off ;;
    SINGLE) xrandr --output eDP --primary --mode 1920x1080 --output HDMI-1-0 --off ;;
    SINGLE2) xrandr --output eDP --primary --mode 1280x720 --output HDMI-1-1 --off ;;
    LAB_DESK_1) xrandr --output eDP --primary --mode 1920x1080 --output HDMI-1-0 --mode 1920x1080 --right-of eDP ;;
    LAB_DESK_2) xrandr --output eDP --primary --mode 1920x1080 --output DP-1-0 --mode 1920x1080 --left-of eDP ;;
    LAB_DESK_3) xrandr --output eDP --primary --mode 1920x1080 --output DP-1-9 --mode 1920x1080 --left-of eDP ;;
    #TV) xrandr --output eDP --primary --mode 1920x1080 --output HDMI-1-0 --mode 1920x1080 --same-as eDP ;;
    TV) xrandr --output HDMI-1-0 --primary --mode 1920x1080 --output eDP --primary --mode 1920x1080 --same-as HDMI-1-0 ;;
    *) printf '%s\n' "You must provide an argument: SINGLE, LAB_DESK_1, LAB_DESK_2, or TV" ;;
esac
