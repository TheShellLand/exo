#!/bin/bash

# Set up my ubuntu



apps=/tmp/apps


#cd $(dirname "$0")

apt update
apt install -f -y

mkdir "$apps"
log="$apps/install.log"

progress=1
total=31

# Macbuntu for 16.10 install
echo "[*] [ $progress/$total ] Installing cerebro"
cerebro=cerebro.deb
if [ ! -f $apps/mac-fonts.zip ]; then
    wget -O $apps/$cerebro https://github.com/KELiON/cerebro/releases/download/0.2.6/cerebro_0.2.6_amd64.deb
    dpkg -i $apps/$cerebro 2>>$log && let progress++
    #rm $apps/$cerebro
else
    dpkg -i $apps/$cerebro 2>>$log && let progress++
fi


echo "[*] [ $progress/$total ] Installing Macbuntu"
apt install -y software-properties-common 2>>$log && let progress++
add-apt-repository -y ppa:noobslab/macbuntu
apt update

apt install -y gnome-tweak-tool 2>>$log && let progress++
apt install -y ubuntu-gnome-desktop 2>>$log && let progress++
#apt install -y ubuntu-desktop 2>>$log && let progress++

apt install -y plank 2>>$log && let progress++
apt install -y macbuntu-os-plank-theme-lts-v8 2>>$log && let progress++
apt install -y macbuntu-os-icons-lts-v8 2>>$log && let progress++
apt install -y macbuntu-os-ithemes-lts-v8 2>>$log && let progress++
apt install -y slingscold 2>>$log && let progress++
#apt install -y albert 2>>$log && let progress++

apt install -y libreoffice-style-sifr 2>>$log && let progress++
fonts=mac-fonts.zip
if [ ! -f $apps/$fonts ]; then
	wget -O $apps/$fonts http://drive.noobslab.com/data/Mac/macfonts.zip
	unzip $apps/$fonts -d /usr/share/fonts
	#rm $apps/$fonts
else
	unzip -o $apps/mac-fonts.zip -d /usr/share/fonts
fi
fc-cache -f -v 
let progress++


# Disable Mouse Acceleration for X server
echo "[*] [ $progress/$total ] Disable X mouse acceleration"
cat > /usr/share/X11/xorg.conf.d/50-mouse-acceleration.conf <<EOF
Section "InputClass"
    Identifier "My Mouse"
    MatchIsPointer "yes"
    Option "AccelerationProfile" "-1"
    Option "AccelerationScheme" "none"
    Option "AccelSpeed" "-1"
EndSection
EOF
let progress++


# OpenVPN
echo "[*] [ $progress/$total ] Installing OpenVPN"
apt install -y openvpn 2>>$log && let progress++


# Virt-Viewer
echo "[*] [ $progress/$total ] Installing virt-viewer"
apt install -y virt-viewer 2>>$log && let progress++


# tmux
echo "[*] [ $progress/$total ] Installing tmux"
apt install -y tmux 2>>$log && let progress++


# CIFS
#echo "[*] [ $progress/$total ] Installing samba tools"
#apt install -y cifs-utils 2>>$log && let progress++


# Chrome
echo "[*] [ $progress/$total ] Installing Chrome"
chrome=chrome.deb
if [ ! -f $apps/$chrome ]; then
	wget -O $apps/$chrome 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
	dpkg -i $apps/$chrome 2>>$log && let progress++
	#rm $apps/$chrome
else
	dpkg -i $apps/$chrome 2>>$log && let progress++
fi
apt install -f -y 2>>$log && let progress++


# PlayOnLinux
echo "[*] [ $progress/$total ] Installing PlayOnLinux"
pol=PlayOnLinux.deb
if [ ! -f $apps/$pol ]; then
	wget -O $apps/$pol 'http://repository.playonlinux.com/PlayOnLinux/4.2.10/PlayOnLinux_4.2.10.deb'
	dpkg -i $apps/$pol 2>>$log && let progress++
	#rm $apps/$pol
else
	dpkg -i $apps/$pol 2>>$log && let progress++
fi
if [ -d usr ]; then
	rsync -rti usr /
fi
dpkg --add-architecture i386
apt update
apt install -y wine-stable 2>>$log && let progress++
apt install -f -y 2>>$log && let progress++


# Pycharm
echo "[*] [ $progress/$total ] Installing Pycharm"
pycharm=pycharm.tgz
if [ ! -f $apps/$pycharm ]; then
	wget -O $apps/$pycharm 'https://download-cf.jetbrains.com/python/pycharm-community-2017.1.1.tar.gz'
	tar zxf $apps/$pycharm -C /opt 2>>$log && let progress++
	#rm $apps/$pycharm
else
	tar zxf $apps/$pycharm -C /opt 2>>$log && let progress++
fi
if [ ! -f /usr/local/bin/pycharm ]; then
    ln -s /opt/*/*/pycharm.sh /usr/local/bin/pycharm
else
    rm /usr/local/bin/pycharm
    ln -s /opt/*/*/pycharm.sh /usr/local/bin/pycharm
fi
apt install -y git 2>>$log && let progress++
apt install -y python3-pip 2>>$log && let progress++


# Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update
#apt-get install -y code
apt-get install -y code-insiders 2>>$log && let progress++


# nmap
echo "[*] [ $progress/$total ] Installing nmap"
apt install -y nmap 2>>$log && let progress++


# wireshark
echo "[*] [ $progress/$total ] Installing wireshark"
apt install -y wireshark 2>>$log && let progress++


# QTQR
echo "[*] [ $progress/$total ] Installing QTQR"
apt install -y qtqr 2>>$log && let progress++


# VLC
echo "[*] [ $progress/$total ] Installing VLC"
apt install -y vlc 2>>$log && let progress++


# Virtualbox
echo "[*] [ $progress/$total ] Installing VLC"
apt install -y virtualbox 2>>$log && let progress++


# Skype
echo "[*] [ $progress/$total ] Installing Skype"
dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y"
curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skype-stable.list
apt update
apt install -y skypeforlinux 2>>$log && let progress++


# iotop
echo "[*] [ $progress/$total ] Installing iotop"
apt install -y iotop 2>>$log && let progress++


# iftop
echo "[*] [ $progress/$total ] Installing iftop"
apt install -y iftop 2>>$log && let progress++



echo "[*] [ $progress/$total ] Done"
