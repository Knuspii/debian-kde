#!/usr/bin/env bash
#
# Script to install Debian & KDE & my configs
# I made this mainly for me but feel free to use
# Made by Knuspii
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

# Remove bloat
apt purge -y \
plasma-discover \
kwalletmanager \
kdeconnect \
kmail \
konqueror \
sweeper \
firefox-esr \
ark

# Install essentials with apt
apt install -y \
fonts-firacode \
ssh \
fastfetch \
git \
curl \
wget \
unzip \
nmap \
htop \
tree \
whois \
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
mkdir -p "$HOME_DIR/.config"
mkdir -p "$HOME_DIR/.config/conky"
mkdir -p "$HOME_DIR/.config/wallpaper"
mkdir -p "$HOME_DIR/.config/autostart"
mkdir -p "$HOME_DIR/.local/share"
mkdir -p "$HOME_DIR/.local/share/konsole"
# Download dotfiles
wget -qO "$HOME_DIR/.bashrc" ${url}/config/bashrc
wget -qO "$HOME_DIR/.bash_profile" ${url}/config/bashprofile
# Download configs
# KDE stuff
wget -qO "$HOME_DIR/.config/kdeglobals" ${url}/config/kdeglobals
wget -qO "$HOME_DIR/.config/backup-config.sh" ${url}/config/backup-config.sh
wget -qO "$HOME_DIR/.config/kglobalshortcutsrc" ${url}/config/kglobalshortcutsrc
wget -qO "$HOME_DIR/.config/kscreenlockerrc" ${url}/config/kscreenlockerrc
wget -qO "$HOME_DIR/.config/kwinrc" ${url}/config/kwinrc
wget -qO "$HOME_DIR/.config/plasma-org.kde.plasma.desktop-appletsrc" ${url}/config/plasma-org.kde.plasma.desktop-appletsrc
wget -qO "$HOME_DIR/.config/plasmarc" ${url}/config/plasmarc
wget -qO "$HOME_DIR/.config/konsolerc" ${url}/config/konsolerc
# Special stuff
wget -qO "$HOME_DIR/.local/share/konsole/Nice.profile" ${url}/local/share/konsole/Nice.profile
wget -qO "$HOME_DIR/.config/backup-config.sh" ${url}/config/backup-config.sh
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
org.keepassxc.KeePassXC \
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
    [Yy]* ) echo "OK, rebooting now...";;
    [Nn]* ) echo "Aborted"; exit 1;;
    * ) echo "Invalid response"; exit 1;;
esac
sleep 3
reboot

exit 0
