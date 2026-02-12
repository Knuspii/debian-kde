![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white)
![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Flatpak](https://img.shields.io/badge/flatpak-%234A90D9.svg?style=for-the-badge&logo=flatpak&logoColor=white)

# How to install Debian with KDE Window-Manager

## Install Debian
Install latest Debian from here: https://www.debian.org/distrib \
Go through the install process. \
At the software selection part only choose the "system tools" and nothing else.

## Complete install Script with my Configs Etc.:
Just copy and paste this in your terminal. \
<code>sudo bash -c "$(curl -sL https://github.com/knuspii/debian-kde/debian-kde-install.sh)"</code>

## The Script:
<pre>
#!/usr/bin/env bash
#
# Script to install Debian & KDE & Extras
# I made this mainly for me but feel free to use :)
#

# Update packages and install KDE
sudo apt install && sudo apt upgrade -y
sudo apt install kde-standard sddm konsole dolphin plasma-discover -y
sudo systemctl enable sddm

# Install essentials with apt
sudo apt install -y \
ssh \
fastfetch \
git \
curl \
wget \
vlc \
unrar \
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
flatpak install --assumeyes flathub

# Programs
flatpak install --assumeyes \
org.mozilla.firefox \
org.libreoffice.LibreOffice \
com.discordapp.Discord \
com.visualstudio.code \
org.gimp.GIMP

# Update all Flatpak programs
sudo flatpak update -y

# Reboot at the end :)
echo Installation finished!
read -p "Are you sure you want to continue? [y/n] " answer
case "$answer" in
    [Yy]* ) echo "OK, continuing...";;
    [Nn]* ) echo "Aborted"; exit 1;;
    * ) echo "Invalid response"; exit 1;;
esac
echo Rebooting now...
sleep 10
sudo reboot
</pre>
