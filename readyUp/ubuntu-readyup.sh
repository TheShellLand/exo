#!/bin/bash

# Set up my ubuntu



apps=apps


cd $(dirname "$0")

apt update
apt install -f

if [ ! -d "$apps" ]; then mkdir "$apps"


# OpenVPN
echo "[*] Installing OpenVPN"
apt install -y openvpn


# Virt-Viewer
echo "[*] Installing virt-viewer"
apt install -y virt-viewer


# tmux
echo "[*] Installing tmux"
apt install -y tmux


# Chrome
echo "[*] Installing Chrome"
chrome=chrome.deb
if [ ! -f $apps/$chrome ]; then
	wget -O $apps/$chrome 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
	dpkg -i $apps/$chrome
	rm $chrome
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
apt install -f -y


# Pycharm
echo "[*] Installing Pycharm"
pycharm=pycharm.tgz
if [ ! -f $apps/$pycharm ]; then
	wget -O $apps/$pycharm 'https://download.jetbrains.com/python/pycharm-community-2017.1.tar.gz'
	tar zxf $apps/$pycharm -C /opt
	#rm $apps/$pycharm
else
	tar zxf $apps/$pycharm -C /opt
fi
ln -s /opt/*/*/pycharm.sh /usr/local/bin/pycharm
apt install -y git


# QTQR
echo "[*] Installing QTQR"
apt install -y qtqr
rm $chrome


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


echo "[*] Done"
