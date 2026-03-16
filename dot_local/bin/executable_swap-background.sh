#!/bin/bash

directory=~/.config/hypr/wallpapers
monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`

if [ -d "$directory" ]; then
    random_background=$(ls $directory | shuf -n 1)

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload $directory/$random_background
    hyprctl hyprpaper wallpaper "$monitor, $directory/$random_background"

fi
