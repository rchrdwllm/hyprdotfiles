#!/bin/bash

THEME_FILE="/tmp/theme_variant"
wal_arguments=""

if [ -s "$THEME_FILE" ]; then
  case $(<"$THEME_FILE") in
    "light") wal_arguments="lighten -l" ;;
  esac
fi

hellwal -i ~/Pictures/wallpapers/city.png

pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar

walogram -s > /dev/null
spicetify apply -q -n
swaync-client -rs
swaync-client --reload-css
