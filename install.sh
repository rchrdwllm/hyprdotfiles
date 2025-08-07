echo "Installing rchrdwllm's dotfiles..."
echo "Installing base Hyprland packages..."

paru -S libdrm pixman pamixer blueberry biome libxkbcommon python python-pywal16 fastfetch pyenv libxml2 llvm libpng gegl mtdev swww waybar fish ranger xdg-desktop-portal-wlr wlroots timeshift xdg-desktop-portal neovim gedit brightnessctl pavucontrol alsa-utils grim slurp wl-clipboard mpv python-pip blueberry bluez bluez-utils ranger-git ts-node zsh ttf-jetbrains-mono ttf-jetbrains-mono-nerd inotify-tools ark playerctl whitesur-icon-theme-git whitesur-cursor-theme-git whitesur-gtk-theme-git xdg-user-dirs nwg-look python-pillow pywal-discord-git viewnior gnome-keyring imagemagick wtype inter-font nodejs bun-bin jdk-openjdk noto-fonts-emoji ttf-droid alsa-firmware tumbler wal-telegram-git google-chrome visual-studio-code-bin discord betterdiscordctl betterdiscord-git telegram-desktop obs-studio vlc python-pywal16 swaync wlogout wofi fish starship pyenv npm pokemon-colorscripts-git hyprshot ueberzug lazygit qt5 qt5-graphicaleffects qt5-quickcontrols2 qt5-svg qt6 unzip

cp -r .config $HOME
cp -r wallpapers $HOME/Pictures
cp -r .fonts $HOME

systemctl enable bluetooth.service

sudo cp -r ./etc/sddm.conf /etc
sudo mkdir -p /usr/local/share/fonts
sudo cp -r ./usr/local/share/fonts/* /usr/local/share/fonts
sudo cp -r ./usr/share/sddm/themes/sugar-candy /usr/share/sddm/themes

cd $HOME/.cache
mkdir wal
cd wal
touch mode
echo "dark" >|${HOME}/.cache/wal/mode
