#!/bin/bash
###########################################################
# Engineering Ubuntu Workstation on Lubuntu osboxes
# 2017.08.15
# by Dymaxion.kim@gmail.com
###########################################################


# Repositories
add-apt-repository -y ppa:numix/ppa
add-apt-repository -y ppa:inkscape.dev/stable
add-apt-repository -y ppa:otto-kesselgulasch/gimp
add-apt-repository -y ppa:libreoffice/ppa
add-apt-repository -y ppa:jonathonf/ffmpeg-3
add-apt-repository -y ppa:openshot.developers/ppa
add-apt-repository -y ppa:webupd8team/atom
add-apt-repository -y ppa:freecad-maintainers/freecad-stable
apt-add-repository -y ppa:hodong/nimf
apt-add-repository -y ppa:elmer-csc-ubuntu/elmer-csc-ppa
add-apt-repository -y ppa:octave/stable


# Distro Update
apt -y update
apt -y full-upgrade
apt -y dist-upgrade


# VirtualBox
apt -y install build-essential linux-headers-`uname -r`
sh /media/osboxes/VBOXADDITIONS*/VBoxLinuxAdditions.run
usermod -G vboxsf -a osboxes


# Fonts
# Noto CJK, Nanum, D2 Coding
apt -y install fonts-noto-cjk fonts-nanum* language-pack-ko

wget https://github.com/naver/d2codingfont/releases/download/VER1.21/D2Coding-1.2.zip
mkdir /usr/share/fonts/truetype/D2Coding
unzip D2Coding-1.2.zip -d /usr/share/fonts/truetype/D2Coding/
rm -rf /usr/share/fonts/truetype/D2Coding/__MACOSX
rm D2Coding-1.2.zip
fc-cache -f -v


# Numix theme
apt -y install numix-gtk-theme numix-icon-theme* numix-wallpaper-*


# Basic Utilies
apt -y install inkscape gimp convertall qalculate vlc browser-plugin-vlc libreoffice libreoffice-help-ko expect pluma htop


# ffmpeg
apt -y install ffmpeg libav-tools x264 x265


# OpenShot
apt -y install openshot-qt


# Atom
apt -y install atom


# FreeCAD & Netgen
apt -y install freecad netgen

mv /usr/share/netgen/drawing.tcl /usr/share/netgen/drawing.tcl.bak
cp ./drawing.tcl /usr/share/netgen/drawing.tcl


# Nimf
apt -y install nimf im-config
im-config -n nimf
# nimf-settings


# Nimf, Evince 충돌문제 해결
# https://github.com/cogniti/nimf/issues/1
mv /etc/apparmor.d/usr.bin.evince /etc/apparmor.d/usr.bin.evince.bak
cp /home/osboxes/github/Elmer_Examples_for_CADG/CADG_02_Elmer_Install/usr.bin.evince /etc/apparmor.d/usr.bin.evince


# Python pip
#apt -y install python-pip
#pip install --upgrade pip


# Pandoc
apt -y install texlive-full pandoc
#pip install pandoc


# GNU Octave
apt -y install octave liboctave-dev
chown -hR osboxes:osboxes /home/osboxes/.config/octave


# Elmer
apt -y install elmerfem-csc
cp /usr/share/ElmerGUI/edf-extra/*.xml /usr/share/ElmerGUI/edf/

mkdir /usr/share/ElmerGUI/icons
wget -O /usr/share/ElmerGUI/icons/Mesh3D.png "https://raw.githubusercontent.com/tehnick/elmerfem/master/ElmerGUI/Application/icons/Mesh3D.png"

echo '' >> /home/osboxes/.bashrc
echo '# ElmerGUI' >> /home/osboxes/.bashrc
echo 'ELMERGUI_HOME=/usr/share/ElmerGUI' >> /home/osboxes/.bashrc
echo 'ELMERSOLVER_HOME=/usr/share/elmersolver' >> /home/osboxes/.bashrc
echo 'ELMERLIB=/usr/lib/elmersolver' >> /home/osboxes/.bashrc
echo 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ELMERLIB:$ELMERSOLVER_HOME/lib' >> /home/osboxes/.bashrc

echo '#!/bin/bash' > /usr/bin/Start_Elmer.sh
echo 'export ELMERGUI_HOME=/usr/share/ElmerGUI' >> /usr/bin/Start_Elmer.sh
echo 'export ELMERSOLVER_HOME=/usr/share/elmersolver' >> /usr/bin/Start_Elmer.sh
echo 'export ELMERLIB=/usr/lib/elmersolver' >> /usr/bin/Start_Elmer.sh
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ELMERLIB:$ELMERSOLVER_HOME/lib' >> /usr/bin/Start_Elmer.sh
echo '/usr/bin/ElmerGUI' >> /usr/bin/Start_Elmer.sh

chmod +x /usr/bin/Start_Elmer.sh

echo '[Desktop Entry]' > /usr/share/applications/ElmerGUI.desktop
echo 'Encoding=UTF-8' >> /usr/share/applications/ElmerGUI.desktop
echo 'Name=Elmer' >> /usr/share/applications/ElmerGUI.desktop
echo 'Comment=Elmer FEA software' >> /usr/share/applications/ElmerGUI.desktop
echo 'Exec=Start_Elmer.sh' >> /usr/share/applications/ElmerGUI.desktop
echo 'Icon=/usr/share/ElmerGUI/icons/Mesh3D.png' >> /usr/share/applications/ElmerGUI.desktop
echo 'StartupNotify=true' >> /usr/share/applications/ElmerGUI.desktop
echo 'Terminal=false' >> /usr/share/applications/ElmerGUI.desktop
echo 'Type=Application' >> /usr/share/applications/ElmerGUI.desktop
echo 'Categories=Education;' >> /usr/share/applications/ElmerGUI.desktop


# Gmsh
wget -O Gmsh.tgz "http://gmsh.info/bin/Linux/gmsh-3.0.4-Linux64.tgz"
tar -xvzf Gmsh.tgz
mv ./gmsh* /home/osboxes/Gmsh
rm Gmsh.tgz

echo '' >> ~/.bashrc
echo '# Gmsh' >> ~/.bashrc
echo 'export PATH="/home/osboxes/Gmsh/bin:$PATH"' >> ~/.bashrc

echo '[Desktop Entry]' > /usr/share/applications/Gmsh.desktop
echo 'Encoding=UTF-8' >> /usr/share/applications/Gmsh.desktop
echo 'Name=Gmsh' >> /usr/share/applications/Gmsh.desktop
echo 'Comment=Mesh Generator' >> /usr/share/applications/Gmsh.desktop
echo 'Exec=/home/osboxes/Gmsh/bin/gmsh' >> /usr/share/applications/Gmsh.desktop
echo 'Icon=/home/osboxes/Gmsh/share/doc/gmsh/tutorial/image.png' >> /usr/share/applications/Gmsh.desktop
echo 'StartupNotify=true' >> /usr/share/applications/Gmsh.desktop
echo 'Terminal=false' >> /usr/share/applications/Gmsh.desktop
echo 'Type=Application' >> /usr/share/applications/Gmsh.desktop
echo 'Categories=Education;' >> /usr/share/applications/Gmsh.desktop


# Paraview
wget -O Paraview.tar.gz "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.4&type=binary&os=linux64&downloadFile=ParaView-5.4.1-RC3-Qt5-OpenGL2-MPI-Linux-64bit.tar.gz"
tar -xvzf Paraview.tar.gz
mv ./ParaView-* /home/osboxes/Paraview
rm Paraview.tar.gz

echo '' >> ~/.bashrc
echo '# Paraview' >> ~/.bashrc
echo 'export PATH="/home/osboxes/Paraview/bin:$PATH"' >> ~/.bashrc

echo '[Desktop Entry]' > /usr/share/applications/Paraview.desktop
echo 'Encoding=UTF-8' >> /usr/share/applications/Paraview.desktop
echo 'Name=Paraview' >> /usr/share/applications/Paraview.desktop
echo 'Comment=Data Analysis and Visualization' >> /usr/share/applications/Paraview.desktop
echo 'Exec=/home/osboxes/Paraview/bin/paraview' >> /usr/share/applications/Paraview.desktop
echo 'Icon=/home/osboxes/Paraview/share/icons/hicolor/32x32/apps/paraview.png' >> /usr/share/applications/Paraview.desktop
echo 'StartupNotify=true' >> /usr/share/applications/Paraview.desktop
echo 'Terminal=false' >> /usr/share/applications/Paraview.desktop
echo 'Type=Application' >> /usr/share/applications/Paraview.desktop
echo 'Categories=Education;' >> /usr/share/applications/Paraview.desktop


# Salome
wget -O Salome.tgz "http://www.salome-platform.org/downloads/current-version/DownloadDistr?platform=UB16.04&version=8.2.0"
tar -xvzf Salome.tgz
mv ./SALOME-* /home/osboxes/Salome
rm Salome.tgz

echo '' >> ~/.bashrc
echo '# Salome' >> ~/.bashrc
echo 'export PATH="/home/osboxes/Salome:$PATH"' >> ~/.bashrc

echo '[Desktop Entry]' > /usr/share/applications/Salome.desktop
echo 'Encoding=UTF-8' >> /usr/share/applications/Salome.desktop
echo 'Name=Salome' >> /usr/share/applications/Salome.desktop
echo 'Comment=Pre/Post Processing' >> /usr/share/applications/Salome.desktop
echo 'Exec=/home/osboxes/Salome/salome' >> /usr/share/applications/Salome.desktop
echo 'Icon=/home/osboxes/Salome/BINARIES-UB16.04/SALOME/share/salome/resources/salome_profile/splash.png' >> /usr/share/applications/Salome.desktop
#echo 'Icon=/home/osboxes/Salome/BINARIES-UB16.04/SMESH/share/doc/salome/gui/SMESH/blocFissure/_images/01_CubeAngle.png' >> /usr/share/applications/Salome.desktop
echo 'StartupNotify=true' >> /usr/share/applications/Salome.desktop
echo 'Terminal=false' >> /usr/share/applications/Salome.desktop
echo 'Type=Application' >> /usr/share/applications/Salome.desktop
echo 'Categories=Education;' >> /usr/share/applications/Salome.desktop



## Desktop Environment

# lxterminal.conf
mv /home/osboxes/.config/lxterminal/lxterminal.conf /home/osboxes/.config/lxterminal/lxterminal.conf.bak
cp ./lxterminal.conf /home/osboxes/.config/lxterminal/lxterminal.conf

# GTK-3.0
mv /home/osboxes/.config/gtk-3.0/settings.ini /home/osboxes/.config/gtk-3.0/settings.ini.bak
cp ./settings.ini /home/osboxes/.config/gtk-3.0/settings.ini

# lxsession
mv /home/osboxes/.config/lxsession/Lubuntu/desktop.conf /home/osboxes/.config/lxsession/Lubuntu/desktop.conf.bak
cp ./desktop.conf /home/osboxes/.config/lxsession/Lubuntu/desktop.conf

# openbox
mv /home/osboxes/.config/openbox/lubuntu-rc.xml /home/osboxes/.config/openbox/lubuntu-rc.xml.bak
cp /lubuntu-rc.xml /home/osboxes/.config/openbox/lubuntu-rc.xml

# pcmanfm
mv /home/osboxes/.config/pcmanfm/lubuntu/desktop-items-0.conf /home/osboxes/.config/pcmanfm/lubuntu/desktop-items-0.conf.bak
cp ./desktop-items-0.conf /home/osboxes/.config/pcmanfm/lubuntu/desktop-items-0.conf

# Locale
echo 'LANG="ko_KR.UTF-8"' > /etc/default/locale

# Timezone
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Pulseaudio for Firefox 52 Sound
apt install pulseaudio pavucontrol

# Fin
echo 'Finished!'
