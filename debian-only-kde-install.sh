#!/usr/bin/env bash
#
# Script to install Debian & KDE
# Made by Knuspii

url="https://raw.githubusercontent.com/knuspii/debian-kde/main"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Update packages and install KDE
apt update && apt upgrade -y
apt install kde-plasma-desktop plasma-nm konsole sddm -y
systemctl enable sddm

# Install essentials with apt
apt install -y \
ssh \
curl \
wget \
unzip \
htop \
tree \
whois \

exit 0
