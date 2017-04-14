#!/bin/bash

# Set up my ubuntu



apps=/tmp/apps


#cd $(dirname "$0")

apt update
apt install -f -y

mkdir "$apps"



# Macbuntu for 16.10 install
echo "[*] Installing cerebro"
cerebro=cerebro.deb
wget -O $apps/$cerebro https://github.com/KELiON/cerebro/releases/download/0.2.6/cerebro_0.2.6_amd64.deb
dpkg -i $apps/$cerebro
#rm $apps/$cerebro

echo "[*] Installing Macbuntu"
apt install -y software-properties-common
add-apt-repository -y ppa:noobslab/macbuntu
apt update

apt install -y gnome-tweak-tool
apt install -y ubuntu-gnome-desktop
#apt install -y ubuntu-desktop

apt install -y plank
apt install -y macbuntu-os-plank-theme-lts-v8
apt install -y macbuntu-os-icons-lts-v8
apt install -y macbuntu-os-ithemes-lts-v8
apt install -y slingscold
#apt install -y albert

apt install -y libreoffice-style-sifr
fonts=mac-fonts.zip
if [ ! -f $apps/mac-fonts.zip ]; then
	wget -O $apps/$fonts http://drive.noobslab.com/data/Mac/macfonts.zip
	unzip $apps/$fonts -d /usr/share/fonts
	#rm $apps/$fonts
else
	unzip $apps/mac-fonts.zip -d /usr/share/fonts
fi
fc-cache -f -v


# OpenVPN
echo "[*] Installing OpenVPN"
apt install -y openvpn


# Virt-Viewer
echo "[*] Installing virt-viewer"
apt install -y virt-viewer


# tmux
echo "[*] Installing tmux"
apt install -y tmux


# CIFS
#echo "[*] Installing samba tools"
#apt install -y cifs-utils


# Chrome
echo "[*] Installing Chrome"
chrome=chrome.deb
if [ ! -f $apps/$chrome ]; then
	wget -O $apps/$chrome 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
	dpkg -i $apps/$chrome
	#rm $apps/$chrome
else
	dpkg -i $apps/$chrome
fi
apt install -f -y


# PlayOnLinux
echo "[*] Installing PlayOnLinux"
pol=PlayOnLinux.deb
if [ ! -f $apps/$pol ]; then
	wget -O $apps/$pol 'http://repository.playonlinux.com/PlayOnLinux/4.2.10/PlayOnLinux_4.2.10.deb'
	dpkg -i $apps/$pol
	#rm $apps/$pol
else
	dpkg -i $apps/$pol
fi
if [ -d usr ]; then
	rsync -rti usr /
fi
dpkg --add-architecture i386
apt update
apt install -y wine-stable
apt install -f -y


# Pycharm
echo "[*] Installing Pycharm"
pycharm=pycharm.tgz
if [ ! -f $apps/$pycharm ]; then
	wget -O $apps/$pycharm 'https://download-cf.jetbrains.com/python/pycharm-community-2017.1.1.tar.gz'
	tar zxf $apps/$pycharm -C /opt
	#rm $apps/$pycharm
else
	tar zxf $apps/$pycharm -C /opt
fi
if [ ! -f /usr/local/bin/pycharm ]; then
    ln -s /opt/*/*/pycharm.sh /usr/local/bin/pycharm
else
    rm /usr/local/bin/pycharm
    ln -s /opt/*/*/pycharm.sh /usr/local/bin/pycharm
fi
apt install -y git
apt install -y python3-pip


# Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update
#apt-get install -y code
apt-get install -y code-insiders


# nmap
echo "[*] Installing nmap"
apt install -y nmap


# wireshark
echo "[*] Installing wireshark"
apt install -y wireshark


# QTQR
echo "[*] Installing QTQR"
apt install -y qtqr


# VLC
echo "[*] Installing VLC"
apt install -y vlc


# Virtualbox
echo "[*] Installing VLC"
apt install -y virtualbox


# Skype
echo "[*] Installing Skype"
dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y"
curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skype-stable.list
apt update
apt install -y skypeforlinux


# iotop
echo "[*] Installing iotop"
apt install -y iotop


# iftop
echo "[*] Installing iftop"
apt install -y iftop



echo "[*] Done"
