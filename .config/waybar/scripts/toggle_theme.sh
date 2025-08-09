#!/bin/bash

MODE=$(cat "$HOME/.config/hypr/color_mode")
WALLPAPER_FILE=$(readlink "$HOME/Pictures/wallpaper.png")

switch_theme() {
    if [ "$MODE" = "light" ]; then
        echo "dark" > "$HOME/.config/hypr/color_mode"
    elif [ "$MODE" = "dark" ]; then
        echo "light" > "$HOME/.config/hypr/color_mode"
    fi
}

toggle_colors() {
    new_mode=$(cat "$HOME/.config/hypr/color_mode")

    if [ "$new_mode" = "light" ]; then
        wal -i "$WALLPAPER_FILE" --cols16 -s -t -l

        pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
      
        hellwal -i "$WALLPAPER_FILE" --check-contrast --light

        pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar

        gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    elif [ "$new_mode" = "dark" ]; then
        wal -i "$WALLPAPER_FILE" --cols16 -s -t

        pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
      
        hellwal -i "$WALLPAPER_FILE" --check-contrast

        pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar

        gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
        gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
    fi
}

waybar_restart() {
	if pgrep -x "waybar" >/dev/null; then
		killall waybar
	fi

	waybar &
}

main() {
    switch_theme
    toggle_colors
    waybar_restart
}

main