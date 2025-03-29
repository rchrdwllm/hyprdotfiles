#!/bin/bash

wallpaper_path=~/Pictures/wallpaper.png

if [ ! -f "$wallpaper_path" ]; then
	notify-send -a "swww" "No wallpaper found" "$wallpaper_path"
	exit 1
fi

swww img $wallpaper_path --transition-type grow --transition-fps 60 --transition-duration 0.5 --transition-bezier 0.65,0,0.35,1 --transition-pos 0.794,0.972 --transition-step 1
