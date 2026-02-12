# How to install Debian with KDE windows manager

## Install Debian
Install latest Debian from here: https://www.debian.org/distrib \
Go through the install process \
At the software selection part only choose the "system tools" and nothing else

## Install KDE
<pre>
sudo apt install && sudo apt upgrade -y
sudo apt install kde-standard sddm konsole dolphin kdeconnect plasma-discover
sudo systemctl enable sddm
sudo reboot
</pre>

## Extras
### Install Firefox LATEST
<pre>
wget -O- https://packages.mozilla.org/apt/repo-signing-key.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/mozilla.gpg > /dev/null
</pre>
