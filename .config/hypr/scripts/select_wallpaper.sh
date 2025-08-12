#!/bin/bash

export PATH="${PATH}:${HOME}/.local/bin/"

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
APP_NAME="Wallpaper selector"
MODE=$(cat "$HOME/.config/hypr/color_mode")
ROFI_LAUNCHER="$HOME/.config/rofi/launchers/type-1"
ROFI_THEME='style-1'

menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}

validate_image_directory() {
	if [ ! -d "$WALLPAPER_DIR" ]; then
		notify-send -a "$APP_NAME" "Image directory does not exist" "$WALLPAPER_DIR"
		exit 1
	fi
}

validate_images() {
	if [ "$1" -eq 0 ]; then
		notify-send -a "$APP_NAME" "No images found" "$WALLPAPER_DIR"
		exit 1
	fi
}

validate_image() {
	if [ ! -f "$1" ]; then
		echo "$APP_NAME" "Selected file is not a valid image" "$1"
		exit 1
	fi
}

set_new_wallpaper() {
	wallpaper="$1"

    [ -L "$HOME/Pictures/wallpaper.png" ] && rm "$HOME/Pictures/wallpaper.png"
    ln -s "$wallpaper" "$HOME/Pictures/wallpaper.png"

	swww img "$wallpaper" --transition-type grow --transition-fps 120 --transition-duration 1 --transition-bezier 0.65,0,0.35,1 --transition-pos 0.794,0.972 --transition-step 7
}

send_notification() {
  notify-send -a "$APP_NAME" "Wallpaper changed" "$random_image" -i "$CURRENT_IMAGE"
}

apply_wal_theme() {
	wallpaper="$1"
    
    if [ "$MODE" = "light" ]; then
		wal -i "$wallpaper" --cols16 -s -t -l --backend colorthief

		pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
		
		matugen image "$wallpaper" --show-colors --mode light

    	pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
	elif [ "$MODE" = "dark" ]; then
		wal -i "$wallpaper" --cols16 -s -t --backend colorthief

		pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar

		matugen image "$wallpaper" --show-colors

		pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
	fi

	pywal-discord -t default
    walogram -s > /dev/null
    spicetify apply -q -n
    swaync-client -rs
    swaync-client --reload-css
}

main() {
    image="$(ls $WALLPAPER_DIR | rofi -dmenu -i -p "  Select wallpaper: " -theme ${ROFI_LAUNCHER}/${ROFI_THEME}.rasi)"
    selected_wallpaper=$WALLPAPER_DIR/$image

    validate_image_directory
	validate_image "$selected_wallpaper"

    images=("$WALLPAPER_DIR"/*)

    validate_images "${#images[@]}"
    apply_wal_theme "$selected_wallpaper"
    set_new_wallpaper "$selected_wallpaper"
    send_notification
}

main
