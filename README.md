# How to install Debian with KDE windows manager

## Install Debian
Install latest Debian from here: https://www.debian.org/distrib \
Go through the install process. \
At the software selection part only choose the "system tools" and nothing else.

## Install KDE
<pre>
sudo apt install && sudo apt upgrade -y
sudo apt install kde-standard sddm konsole dolphin plasma-discover
sudo systemctl enable sddm
sudo reboot
</pre>

## Extras
### Install extras
<pre>
sudo apt update && sudo apt upgrade -y
sudo apt install \
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
wireguard-tools \
python3 \
golang \
jq \
</pre>

### Install Flatpak
<pre>
sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub \
org.mozilla.firefox \
org.libreoffice.LibreOffice \
com.discordapp.Discord \
com.visualstudio.code \
org.gimp.GIMP

sudo flatpak update -y
sudo reboot
</pre>
