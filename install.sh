echo "Installing rchrdwllm's dotfiles..."
echo "Installing base Hyprland packages..."

paru -S libdrm pixman libxkbcommon python libxml2 llvm libpng gegl mtdev swww waybar xdg-desktop-portal-wlr wlroots xdg-desktop-portal neovim gedit brightnessctl pavucontrol alsa-utils grim slurp wl-clipboard mpv python-pip blueberry bluez bluez-utils ranger ts-node zsh ttf-jetbrains-mono ttf-jetbrains-mono-nerd inotify-tools thunar ark playerctl pamixer whitesur-icon-theme-git whitesur-cursor-theme-git whitesur-gtk-theme-git xdg-user-dirs nwg-look python-pillow pywal-discord-git viewnior gnome-keyring neofetch imagemagick wtype inter-font nodejs bun-bin jdk-openjdk noto-fonts-emoji ttf-droid alsa-firmware tumbler wal-telegram-git google-chrome visual-studio-code-bin discord betterdiscordctl betterdiscord-git telegram-desktop obs-studio vlc python-pywal16 swaync wlogout wofi fish starship pyenv npm pokemon-colorscripts-git hyprshot ueberzug lazygit

cp -r .config $HOME
cp -r wallpapers $HOME/Pictures

systemctl enable bluetooth.service

cd $HOME/.cache
mkdir wal
cd wal
touch mode
echo "dark" >|${HOME}/.cache/wal
