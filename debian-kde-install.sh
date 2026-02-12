#!/usr/bin/env bash
#
# Script to install Debian & KDE & Extras
# I made this mainly for me but feel free to use :)
#

# Update packages and install KDE
sudo apt update && sudo apt upgrade -y
sudo apt install kde-standard sddm konsole dolphin plasma-discover -y
sudo systemctl enable sddm

# Remove bloat lol
sudo apt purge -y \
firefox-esr \
kdeconnect \
kmail \
konqueror \
sweeper \
ktnef

# Install essentials with apt
sudo apt install -y \
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

# Install Flatpak for special programs
sudo apt install flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Programs
flatpak install --assumeyes flathub \
org.mozilla.firefox \
org.libreoffice.LibreOffice \
com.discordapp.Discord \
com.visualstudio.code \
org.gimp.GIMP \
org.videolan.VLC

# Update all Flatpak programs
sudo flatpak update --assumeyes

# Reboot at the end :)
echo Installation finished!
read -p "Do you want to continue? [y/n] " answer
case "$answer" in
    [Yy]* ) echo "OK, continuing...";;
    [Nn]* ) echo "Aborted"; exit 1;;
    * ) echo "Invalid response"; exit 1;;
esac
echo Rebooting now...
sleep 3
sudo reboot
