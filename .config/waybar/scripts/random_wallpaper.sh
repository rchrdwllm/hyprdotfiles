#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
APP_NAME="Wallpaper selector"
MODE=$(cat "$HOME/.config/hypr/color_mode")

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

select_random_image() {
	local random_image="${images[RANDOM % ${#images[@]}]}"

	if [ ! -f "$CURRENT_IMAGE" ]; then
		echo "$random_image"
	else
		local selected_image
		while :; do
			selected_image="$random_image"
			[ "$selected_image" -ef "$CURRENT_IMAGE" ] || break
		done
		echo "$selected_image"
	fi
}

set_new_wallpaper() {
	wallpaper="$1"

    [ -L "$HOME/Pictures/wallpaper.png" ] && rm "$HOME/Pictures/wallpaper.png"
    ln -s "$wallpaper" "$HOME/Pictures/wallpaper.png"

	swww img "$wallpaper" --transition-type grow --transition-fps 120 --transition-duration 1 --transition-bezier 0.65,0,0.35,1 --transition-pos 0.794,0.972 --transition-step 7
}

restart_environment() {
	if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
		. "$SET_WALLPAPER_SCRIPT"
	else
		i3-msg restart
	fi
}

send_notification() {
  notify-send -a "$APP_NAME" "Wallpaper changed" "$random_image" -i "$CURRENT_IMAGE"
}

apply_wal_theme() {
	wallpaper="$1"

	if [ "$MODE" = "light" ]; then
		wal -i "$wallpaper" --cols16 -s -t -l

		pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
	
		hellwal -i "$wallpaper" --check-contrast --light

    	pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
	elif [ "$MODE" = "dark" ]; then
		wal -i "$wallpaper" --cols16 -s -t

		pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar

		hellwal -i "$wallpaper" --check-contrast

		pgrep -x "waybar" > /dev/null && killall -SIGUSR2 waybar
	fi

	pywal-discord -t default
    walogram -s > /dev/null
    spicetify apply -q -n
    swaync-client -rs
    swaync-client --reload-css
}

waybar_restart() {
	if pgrep -x "waybar" >/dev/null; then
		killall waybar
	fi

	waybar &
}

main() {
	validate_image_directory

	images=("$WALLPAPER_DIR"/*)

	validate_images "${#images[@]}"

	random_image=$(select_random_image)

	apply_wal_theme "$random_image"
	set_new_wallpaper "$random_image"
	waybar_restart
	send_notification
}

main