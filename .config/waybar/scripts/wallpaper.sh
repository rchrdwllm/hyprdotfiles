#!/bin/bash

export PATH="${PATH}:${HOME}/.local/bin/"

DIR=$HOME/Wallpapers
PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

if [[ $(pidof swww) ]]; then
  pkill swww
fi

swww img ${DIR}/${RANDOMPICS} --transition-type grow --transition-fps 60 --transition-duration 0.5 --transition-bezier 0.65,0,0.35,1 --transition-pos 0.794,0.972 --transition-step 1

sleep 1.25

wal -i "$random_image" --cols16 -s -t

pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
	
hellwal -i "$random_image" --check-contrast

pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar

pywal-discord -t default
walogram -s > /dev/null
spicetify apply -q -n
swaync-client -rs
swaync-client --reload-css

. $HOME/.config/mako/update-colors.sh
