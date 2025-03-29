#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
IMAGE_DIR="$HOME/Pictures/wallpapers"
CURRENT_IMAGE="$HOME/Pictures/wallpaper.png"
APP_NAME="Wallpaper selector"
SET_WALLPAPER_SCRIPT="$HOME/.config/hypr/scripts/set_wallpaper.sh"
APPLY_WAL_THEME_SCRIPT="$HOME/.config/hypr/scripts/apply_wal_theme.sh"

menu() {
    find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}

validate_image_directory() {
	if [ ! -d "$IMAGE_DIR" ]; then
		notify-send -a "$APP_NAME" "Image directory does not exist" "$IMAGE_DIR"
		exit 1
	fi
}

validate_images() {
	if [ "$1" -eq 0 ]; then
		notify-send -a "$APP_NAME" "No images found" "$IMAGE_DIR"
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
	ln -sf "$1" "$CURRENT_IMAGE"
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
  . "$APPLY_WAL_THEME_SCRIPT"
}

main() {
    choice=$(menu | wofi -c ~/.config/wofi/wallpaper -s ~/.config/wofi/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')

    validate_image_directory
    images=("$IMAGE_DIR"/*)
    validate_images "${#images[@]}"
    set_new_wallpaper "$selected_wallpaper"
    restart_environment
    send_notification
    apply_wal_theme
    swaync-client -rs
    swaync-client --reload-css
}

main
