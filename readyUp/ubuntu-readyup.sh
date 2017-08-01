#!/bin/bash

# Set up my ubuntu


apps=/tmp/apps

cd $(dirname "$0")

if [ ! -d "$apps" ]; then
	mkdir "$apps"
fi

progress=1
total=40


echo "[*] Updating repository"
apt update
echo "[*] Installing missing dependencies"
apt install -f -y


# Macbuntu for 16.10 install
# echo "[*] [ $progress/$total ] Installing cerebro"
# cerebro=cerebro.deb
# if [ ! -f $apps/mac-fonts.zip ]; then
#     wget -q -O $apps/$cerebro https://github.com/KELiON/cerebro/releases/download/0.2.6/cerebro_0.2.6_amd64.deb
#     dpkg -i $apps/$cerebro && let progress++
#     #rm $apps/$cerebro
# else
#     dpkg -i $apps/$cerebro && let progress++
# fi


echo "[*] [ $progress/$total ] Installing Macbuntu"
apt install -y software-properties-common && let progress++ && echo "[*] [ $progress/$total ] Installed software-properties-common"
add-apt-repository -y ppa:noobslab/macbuntu
apt update

#apt remove -y lightdm
apt install -y gnome-tweak-tool && let progress++ && echo "[*] [ $progress/$total ] Installed gnome-tweak-tool"
apt install -y ubuntu-gnome-desktop && let progress++ && echo "[*] [ $progress/$total ] Installed ubuntu-gnome-desktop"
#apt install -y ubuntu-desktop && let progress++ && echo "[*] [ $progress/$total ] Installed ubuntu-desktop"

apt install -y plank && let progress++ && echo "[*] [ $progress/$total ] Installed plank"
echo "[*] [ $progress/$total ] Installing Plank themes"
if [ ! -d "~/.local/share/plank/themes" ]; then mkdir -p "~/.local/share/plank/themes"; fi
theme=plank-themes.zip
if [ ! -f $apps/$theme ]; then
	wget -q -O $apps/$theme "https://github.com/KenHarkey/plank-themes/archive/master.zip"
	unzip $apps/$theme -d $apps
	cp -r $apps/plank-themes-master/anti-shade ~/.local/share/plank/themes
	cp -r $apps/plank-themes-master/paperterial ~/.local/share/plank/themes
	cp -r $apps/plank-themes-master/shade ~/.local/share/plank/themes
else
	unzip $apps/$theme -d $apps
	cp -r $apps/plank-themes-master/anti-shade ~/.local/share/plank/themes
	cp -r $apps/plank-themes-master/paperterial ~/.local/share/plank/themes
	cp -r $apps/plank-themes-master/shade ~/.local/share/plank/themes
fi

apt install -y macbuntu-os-plank-theme-lts-v7 && let progress++ && echo "[*] [ $progress/$total ] Installed macbuntu-os-plank-themes"
apt install -y macbuntu-os-icons-lts-v7 && let progress++ && echo "[*] [ $progress/$total ] Installed macbuntu-os-icons-lts"
apt install -y macbuntu-os-ithemes-lts-v7 && let progress++ && echo "[*] [ $progress/$total ] Installed macbuntu-os-ithemes"
apt install -y libreoffice-style-sifr && let progress++ && echo "[*] [ $progress/$total ] Installed libreoffice styles"
#apt install -y slingscold && let progress++ && echo "[*] [ $progress/$total ] Installed slingscold"
#apt install -y albert && let progress++ && echo "[*] [ $progress/$total ] Installed albert"

echo "[*] [ $progress/$total ] Installing OSX Arc Collection"
theme=osx-arc-collection.deb
if [ ! -f $apps/$theme ]; then
	wget -q -O $apps/$theme 'https://github.com/LinxGem33/OSX-Arc-White/releases/download/v1.4.3/osx-arc-collection_1.4.3_amd64.deb'
	dpkg -i $apps/$theme && let progress++
	#rm $apps/$chrome
else
	dpkg -i $apps/$theme && let progress++
fi


# Put buttons on left side
gsettings set org.gnome.desktop.wm.preferences button-layout "close,minimize,maximize:"


# oranchelo-icon-theme
echo "[*] [ $progress/$total ] Installing oranchelo-icon-theme"
add-apt-repository -y ppa:oranchelo/oranchelo-icon-theme
apt-get update
apt-get install -y oranchelo-icon-theme && let progress++


# arc-icon-theme
echo "[*] [ $progress/$total ] Installing arc-icon-theme"
if [ ! -d "$apps/arc-icon-theme" ]; then mkdir "$apps/arc-icon-theme"; fi
if [ ! -d $apps/arc-icon-theme/Arc ]; then
    git clone https://github.com/horst3180/arc-icon-theme.git "$apps/arc-icon-theme"
    cp -r $apps/arc-icon-theme/Arc /usr/share/icons && let progress++
else
    cp -r $apps/arc-icon-theme/Arc /usr/share/icons && let progress++
fi


# capitaine-cursors
echo "[*] [ $progress/$total ] Installing capitaine-cursors"
file=capitaine-cursors.tgz
if [ ! -d $apps/capitaine-cursors ]; then mkdir $apps/capitaine-cursors; fi
if [ ! -f $apps/$file ]; then
    wget -q -O $apps/$file https://dl.opendesktop.org/api/files/download/id/1489948557/capitaine-cursors-r2.tar.gz
    tar zxf $apps/$file -C $apps/capitaine-cursors
    mv $apps/capitaine-cursors/capitaine-cursors-r2/bin/xcursors $apps/capitaine-cursors/capitaine-cursors-r2/bin/capitaine-cursors && let progress++
    cp -r $apps/capitaine-cursors/capitaine-cursors-r2/bin/capitaine-cursors /usr/share/icons && let progress++
else
    tar zxf $apps/$file -C $apps/capitaine-cursors
    mv $apps/capitaine-cursors/capitaine-cursors-r2/bin/xcursors $apps/capitaine-cursors/capitaine-cursors-r2/bin/capitaine-cursors && let progress++
    cp -r $apps/capitaine-cursors/capitaine-cursors-r2/bin/capitaine-cursors /usr/share/icons && let progress++
fi


apt install -y libreoffice-style-sifr && let progress++ && echo "[*] [ $progress/$total ] Installed libreoffice styles"
fonts=mac-fonts.zip
if [ ! -f $apps/$fonts ]; then
	wget -q -O $apps/$fonts http://drive.noobslab.com/data/Mac/macfonts.zip
	unzip $apps/$fonts -d /usr/share/fonts && let progress++ && echo "[*] [ $progress/$total ] Installed Mac fonts"
	#rm $apps/$fonts
else
	unzip -o $apps/mac-fonts.zip -d /usr/share/fonts && let progress++ && echo "[*] [ $progress/$total ] Installed Mac fonts"
fi
fc-cache -f -v && (let progress++ && echo "[*] [ $progress/$total ] Updating font cache")


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


# Fix Nautilus recent files bug
#echo 'Environment=DISPLAY=:0' >> /usr/lib/systemd/user/gvfs-daemon.service


# OpenVPN
echo "[*] [ $progress/$total ] Installing OpenVPN"
apt install -y openvpn && let progress++


# Virt-Viewer
echo "[*] [ $progress/$total ] Installing virt-viewer"
apt install -y virt-viewer && let progress++


# x11vnc
echo "[*] [ $progress/$total ] Installing x11vnc"
apt install -y x11vnc && let progress++


# tmux
echo "[*] [ $progress/$total ] Installing tmux"
apt install -y tmux && let progress++


# CIFS
#echo "[*] [ $progress/$total ] Installing samba tools"
#apt install -y cifs-utils && let progress++


# Chrome
echo "[*] [ $progress/$total ] Installing Chrome"
chrome=chrome.deb
if [ ! -f $apps/$chrome ]; then
	wget -q -O $apps/$chrome 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
	dpkg -i $apps/$chrome && let progress++
	#rm $apps/$chrome
else
	dpkg -i $apps/$chrome && let progress++
fi
apt install -f -y && let progress++


# PlayOnLinux
echo "[*] [ $progress/$total ] Installing PlayOnLinux"
pol=PlayOnLinux.deb
if [ ! -f $apps/$pol ]; then
	wget -q -O $apps/$pol 'https://www.playonlinux.com/script_files/PlayOnLinux/4.2.12/PlayOnLinux_4.2.12.deb'
	dpkg -i $apps/$pol && let progress++
	#rm $apps/$pol
else
	dpkg -i $apps/$pol && let progress++
fi
if [ -d usr ]; then
	rsync -rti usr /
fi
apt install -f -y && let progress++
dpkg --add-architecture i386
apt update
apt install -y wine && let progress++
apt install -y winbind && let progress++
apt install -f -y && let progress++


# Pycharm
echo "[*] [ $progress/$total ] Installing Pycharm"
pycharm=pycharm.tgz
if [ ! -d '/opt/pycharm' ]; then mkdir /opt/pycharm; fi
if [ ! -f $apps/$pycharm ]; then
	wget -q -O $apps/$pycharm 'https://download.jetbrains.com/python/pycharm-community-2017.2.tar.gz'
	tar zxf $apps/$pycharm -C /opt/pycharm && let progress++
	#rm $apps/$pycharm
else
	tar zxf $apps/$pycharm -C /opt && let progress++
fi

cat > /usr/share/applications/pycharm.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Name=Pycharm IDE
Comment=The Smarter Way to Code
Exec=/bin/sh "/opt/pycharm/pycharm-community-2017.2/bin/pycharm.sh"
Icon=/opt/pycharm/pycharm-community-2017.2/bin/pycharm.png
Categories=Application;Development;Python;IDE
Version=1.0
Type=Application
Terminal=0
EOF

apt install -y git && let progress++
apt install -y python3-pip && let progress++


# Visual Studio Code
echo "[*] [ $progress/$total ] Visual Studio Code"
curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update
#apt-get install -y code && let progress++
apt-get install -y code-insiders && let progress++


# GitKraken
echo "[*] [ $progress/$total ] Installing GitKraken"
gitk=gitkraken.deb
if [ ! -f $apps/$gitk ]; then
	wget -q -O $apps/$gitk "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
	dpkg -i $apps/$gitk && let progress++
	#rm $apps/$pol
else
	dpkg -i $apps/$gitk && let progress++
fi
apt-get install -f -y && let progress++


# npm
echo "[*] [ $progress/$total ] Installing nmp"
apt install -y nmp && let progress++


# exfat
echo "[*] [ $progress/$total ] Installing exfat-utils"
apt install -y exfat-utils && let progress++


# nmap
echo "[*] [ $progress/$total ] Installing nmap"
apt install -y nmap && let progress++


# wireshark
echo "[*] [ $progress/$total ] Installing wireshark"
apt install -y wireshark && let progress++


# QTQR
echo "[*] [ $progress/$total ] Installing QTQR"
apt install -y qtqr && let progress++


# VLC
echo "[*] [ $progress/$total ] Installing VLC"
apt install -y vlc && let progress++


# Virtualbox
echo "[*] [ $progress/$total ] Installing Virtualbox"
apt install -y virtualbox && let progress++


# Emacs
echo "[*] [ $progress/$total ] Installing Emacs"
apt install -y emacs && let progress++


# Skype
echo "[*] [ $progress/$total ] Installing Skype"
dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y"
curl -s https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" > /etc/apt/sources.list.d/skype-stable.list
apt update
apt install -y skypeforlinux && let progress++


# iotop
#echo "[*] [ $progress/$total ] Installing iotop"
#apt install -y iotop && let progress++


# iftop
#echo "[*] [ $progress/$total ] Installing iftop"
#apt install -y iftop && let progress++


# glances
echo "[*] [ $progress/$total ] Installing glances"
apt install -y glances && let progress++


## Stacer
#echo "[*] [ $progress/$total ] Installing Stacer"
#stacer=stacer.deb
#if [ ! -f $apps/$stacer ]; then
#	wget -q -O $apps/$stacer 'https://github.com/oguzhaninan/Stacer/releases/download/v1.0.7/stacer_1.0.7_amd64.deb'
#	dpkg -i $apps/$stacer && let progress++
#else
#	dpkg -i $apps/$stacer && let progress++
#fi


# aircrack
echo "[*] [ $progress/$total ] Installing aircrack-ng"
apt install -y aircrack-ng && let progress++


# flux
echo "[*] [ $progress/$total ] Installing fluxgui"
add-apt-repository -y ppa:nathan-renniewaldock/flux
apt update
apt install -y fluxgui && let progress++


# darktable
echo "[*] [ $progress/$total ] Installing darktable"
apt install -y darktable && let progress++


# Veracrypt
echo "[*] [ $progress/$total ] Installing Veracrypt"
add-apt-repository -y ppa:unit193/encryption
apt update
apt install -y veracrypt && let progress++


# Java JDK 8 for NetBeans IDE
echo "[*] [ $progress/$total ] Installing Java JDK 8"
file=jdk.tgz
if [ ! -d '/opt/jdk' ]; then mkdir /opt/jdk; fi
if [ ! -f $apps/$file ]; then
	wget -q -O $apps/$file -c --header "Cookie: oraclelicense=accept-securebackup-cookie" 'http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz'
	tar zxf $apps/$file -C /opt/jdk && let progress++
else
	tar zxf $apps/$file -C /opt/jdk && let progress++
fi
if [ ! -f /usr/local/bin/javajdk ]; then
    ln -s /opt/jdk/jdk1.8.0_144/bin/java /usr/local/bin/javajdk
else
    rm /usr/local/bin/javajdk
    ln -s /opt/jdk/jdk1.8.0_144/bin/java /usr/local/bin/javajdk
fi


# NetBeans IDE
echo "[*] [ $progress/$total ] Installing NetBeans IDE"

cat > $apps/state.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?><!--
  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.

  Copyright 1997-2010 Oracle and/or its affiliates. All rights reserved.

  Oracle and Java are registered trademarks of Oracle and/or its affiliates.
  Other names may be trademarks of their respective owners.

  The contents of this file are subject to the terms of either the GNU General Public
  License Version 2 only ("GPL") or the Common Development and Distribution
  License("CDDL") (collectively, the "License"). You may not use this file except in
  compliance with the License. You can obtain a copy of the License at
  http://www.netbeans.org/cddl-gplv2.html or nbbuild/licenses/CDDL-GPL-2-CP. See the
  License for the specific language governing permissions and limitations under the
  License.  When distributing the software, include this License Header Notice in
  each file and include the License file at nbbuild/licenses/CDDL-GPL-2-CP.  Oracle
  designates this particular file as subject to the "Classpath" exception as provided
  by Oracle in the GPL Version 2 section of the License file that accompanied this code.
  If applicable, add the following below the License Header, with the fields enclosed
  by brackets [] replaced by your own identifying information:
  "Portions Copyrighted [year] [name of copyright owner]"

  Contributor(s):

  The Original Software is NetBeans. The Initial Developer of the Original Software
  is Sun Microsystems, Inc. Portions Copyright 1997-2007 Sun Microsystems, Inc. All
  Rights Reserved.

  If you wish your version of this file to be governed by only the CDDL or only the
  GPL Version 2, indicate your decision by adding "[Contributor] elects to include
  this software in this distribution under the [CDDL or GPL Version 2] license." If
  you do not indicate a single choice of license, a recipient has the option to
  distribute your version of this file under either the CDDL, the GPL Version 2 or
  to extend the choice of license to its licensees as provided above. However, if you
  add GPL Version 2 code and therefore, elected the GPL Version 2 license, then the
  option applies only if the new code is made subject to such option by the copyright
  holder.
--><state xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="state-file.xsd">
<components>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-base" version="8.2.0.0.201609300101">
            <properties>
                <property name="installation.location.windows">$N{install}/NetBeans 8.2</property>
                <property name="minimum.jdk.version">1.8.0</property>
                <property name="jdk.location">/opt/jdk/jdk1.8.0_144</property>
                <property name="installation.timestamp">1501283949078</property>
                <property name="start.menu.shortcut.location">all.users</property>
                <property name="installation.location.macosx">$N{install}/NetBeans/NetBeans 8.2.app</property>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
                <property name="desktop.shortcut.location">all.users</property>
                <property name="netbeans.summary.message.text">115 updates successfully installed.

</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-extide" version="8.2.0.0.201609300101">
            <properties>
                <property name="show-in-wizard">false</property>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-javase" version="8.2.0.0.201609300101">
            <properties>
                <property name="jre.allowed">false</property>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-javaee" version="8.2.0.0.201609300101">
            <properties>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="linux" status="to-be-installed" uid="nb-javame" version="8.2.0.0.201609300101">
            <properties>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-webcommon" version="8.2.0.0.201609300101">
            <properties>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-php" version="8.2.0.0.201609300101">
            <properties>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-cnd" version="8.2.0.0.201609300101">
            <properties>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-groovy" version="8.2.0.0.201609300101">
            <properties>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-installed" uid="nb-ergonomics" version="8.2.0.0.201609300101">
            <properties>
                <property name="installation.location">/opt/netbeans/netbeans-8.2</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-uninstalled" uid="glassfish-mod" version="4.1.1.0.1">
            <properties>
                <property name="jdk.location"/>
                <property name="installation.location">/usr/local/glassfish-4.1.1</property>
            </properties>
        </product>
        <product platform="windows linux solaris-sparc solaris-x86 macosx-ppc macosx-x86" status="to-be-uninstalled" uid="tomcat" version="8.0.27.0.0">
            <properties>
                <property name="installation.location">$N{install}/apache-tomcat-8.0.27</property>
                <property name="installation.location.windows">$E{ProgramFiles}/Apache Software Foundation/Apache Tomcat 8.0.27</property>
            </properties>
        </product>
    </components>
</state>
EOF

file=netbeans.sh
if [ ! -f $apps/$file ]; then
	wget -q -O $apps/$file 'http://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-linux.sh'
	chmod +x $apps/$file
    $apps/$file --silent --state $apps/state.xml && let progress++
else
	chmod +x $apps/$file
    $apps/$file --silent --state $apps/state.xml && let progress++
fi


echo "[*] Done"
