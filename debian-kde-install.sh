#!/usr/bin/env bash
#
# Script to install Debian & KDE & Extras
# I made this mainly for me but feel free to use :)
#

url="https://raw.githubusercontent.com/knuspii/debian-kde/main"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Update packages and install KDE
apt update && apt upgrade -y
apt install kde-plasma-desktop plasma-nm konsole sddm -y
systemctl enable sddm

# Remove bloat lol
apt purge -y \
firefox-esr \
kdeconnect \
kmail \
konqueror \
sweeper \
ark

# Install essentials with apt
apt install -y \
ssh \
fastfetch \
git \
curl \
wget \
unzip \
nmap \
htop \
tree \
traceroute \
conky-all \
wireguard-tools \
python3 \
golang \
jq

# Ask for target user
read -p "Enter username: " USERNAME
if ! id "$USERNAME" &>/dev/null; then
  echo "User does not exist."
  exit 1
fi

HOME_DIR=$(eval echo "~$USERNAME")
# Create needed directories
mkdir -p "$HOME_DIR/.config/conky"
mkdir -p "$HOME_DIR/.config/wallpaper"
mkdir -p "$HOME_DIR/.config/autostart"
# Download dotfiles
wget -qO "$HOME_DIR/.bashrc" ${url}/config/bashrc
wget -qO "$HOME_DIR/.bash_profile" ${url}/config/bashprofile
# Download configs
wget -qO "$HOME_DIR/.config/autostart/conky.desktop" ${url}/config/autostart/conky.desktop
wget -qO "$HOME_DIR/.config/autostart/terminal.desktopg" ${url}/config/autostart/terminal.desktop
wget -qO "$HOME_DIR/.config/wallpaper/wallpaper.png" ${url}/config/wallpaper/wallpaper.png
wget -qO "$HOME_DIR/.config/conky/conky.config" ${url}/config/conky/conky.config
# Fix ownership
chown -R "$USERNAME:$USERNAME" "$HOME_DIR"

# Install Flatpak
apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Programs
flatpak install --assumeyes flathub \
org.mozilla.firefox \
org.libreoffice.LibreOffice \
com.discordapp.Discord \
com.visualstudio.code \
org.gimp.GIMP \
org.videolan.VLC

# Update all Flatpak programs
flatpak update --assumeyes

# Reboot at the end :)
echo Installation finished!
read -p "Do you want to reboot? [y/n] " answer
case "$answer" in
    [Yy]* ) echo "OK, continuing...";;
    [Nn]* ) echo "Aborted"; exit 1;;
    * ) echo "Invalid response"; exit 1;;
esac
echo Rebooting now...
sleep 3
reboot
