#!/bin/bash
###########################################################
# Engineering Ubuntu Workstation on Lubuntu osboxes
# 2017.08.15
# by Dymaxion.kim@gmail.com
###########################################################

# Howto
# 0. 설치 요구 조건
#    가급적 속도가 좋은 인터넷에 연결되어 있을 것.
#    PC의 CPU는 가급적 4스레드 이상 지원할 것.
#    PC의 메모리는 8GB 이상일 것.
# 1. 윈도OS PC에서 엔지니어링 연습용 리눅스 가상머신을 설치하는 것이 목표
# 2. 아래 주소로 가서 최신버전의 'Windows hosts' 바이너리설치파일을 다운로드 받아, 실행시켜 설치한다.
#    https://www.virtualbox.org/wiki/Downloads
# 3. 아래 주소로 가서 `Lubuntu 16.04.2 Xenial Xerus VirtualBox (VDI) 64bit` 파일을 다운로드 받는다.
#    http://www.osboxes.org/lubuntu/
# 4. 버츄얼박스를 실행시키고, '새로만들기' 버튼을 누른 후, 다운로드 받은 가상머신 파일을 연결해서 가상머신을 셋팅한다.
#    CPU 코어는 가급적 2개 이상 할당해 주고, RAM은 가급적 4096MB 이상 할당해 준다.
#    네트워크는 '브리지'로 선택해 준다.
# 5. 구축된 가상머신을 시작한다.  가상머신이 부팅되면 로그인 비밀번호는 'osboxes.org'를 쳐 준다.
# 6. 터미널을 열고 현재 홈디렉토리 위치에 있는지 확인한다.
# 7. 본 스크립트 파일을 다운로드 받는다.
# 8. 'chmod +x ./AutoSetup.sh' 명령을 쳐 넣어 실행 가능하도록 한다.
# 9. 버츄얼박스 메뉴의 '장치'에서 '게스트 확장 CD 이미지 삽입'을 선택해 준다.
# 10. 'sudo sh AutoSetup.sh' 명령을 쳐 넣어 스크립트를 실행한다.
# 11. 다 되면 가상머신을 재부팅한다.


# Repositories
add-apt-repository -y ppa:numix/ppa
add-apt-repository -y ppa:inkscape.dev/stable
add-apt-repository -y ppa:otto-kesselgulasch/gimp
add-apt-repository -y ppa:libreoffice/ppa
add-apt-repository -y ppa:jonathonf/ffmpeg-3
add-apt-repository -y ppa:openshot.developers/ppa
add-apt-repository -y ppa:webupd8team/atom
add-apt-repository -y ppa:freecad-maintainers/freecad-stable
apt-add-repository -y ppa:hodong/testing
apt-add-repository -y ppa:elmer-csc-ubuntu/elmer-csc-ppa
add-apt-repository -y ppa:octave/stable


# Distro Update
apt -y update
apt -y full-upgrade
apt -y dist-upgrade


# VirtualBox
apt -y install build-essential linux-headers-`uname -r`
cd /media/osboxes/VBOXADDITIONS*
sh ./VBoxLinuxAdditions.run
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
apt -y install inkscape gimp convertall qalculate vlc browser-plugin-vlc libreoffice libreoffice-help-ko expect pluma


# ffmpeg
apt -y install ffmpeg libav-tools x264 x265


# OpenShot
apt -y install openshot-qt


# Atom
apt -y install atom


# FreeCAD & Netgen
apt -y install freecad netgen

mv /usr/share/netgen/drawing.tcl /usr/share/netgen/drawing.tcl.bak
echo '# -*- mode: TCL; fill-column: 75; tab-width: 8; coding: iso-latin-1-unix -*-' > /usr/share/netgen/drawing.tcl
echo '#' >> /usr/share/netgen/drawing.tcl
echo '# drawing.tcl --' >> /usr/share/netgen/drawing.tcl
echo '#' >> /usr/share/netgen/drawing.tcl
echo '#' >> /usr/share/netgen/drawing.tcl
echo '#  Creates a drawing frame, and binds mouse events' >> /usr/share/netgen/drawing.tcl
echo '#' >> /usr/share/netgen/drawing.tcl
echo 'set oldmousex 0' >> /usr/share/netgen/drawing.tcl
echo 'set oldmousey 0' >> /usr/share/netgen/drawing.tcl
echo '#' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '# if { 1 } {' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '# use this one for Togl 2.0' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '# if {[catch {togl .ndraw -width 400 -height 300  -rgba true -double true -depth true -privatecmap false -stereo false -indirect true -create init  -display draw -reshape reshape  }] } {' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '# changed -indirect true/false !!!' >> /usr/share/netgen/drawing.tcl
echo 'if {[catch {togl .ndraw -width 400 -height 300  -rgba true -double true -depth true -privatecmap false -stereo false -indirect false }] } {    ' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '    puts "no OpenGL" ' >> /usr/share/netgen/drawing.tcl
echo '} {' >> /usr/share/netgen/drawing.tcl
echo '    #' >> /usr/share/netgen/drawing.tcl
echo '    pack .ndraw -expand true -fill both -padx 10 -pady 10' >> /usr/share/netgen/drawing.tcl
echo '    #' >> /usr/share/netgen/drawing.tcl
echo '    bind .ndraw <Button-1> {' >> /usr/share/netgen/drawing.tcl
echo '  set oldmousex %x; set oldmousey %y;' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '    bind .ndraw <Button-2> {' >> /usr/share/netgen/drawing.tcl
echo '  set oldmousex %x; set oldmousey %y;' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '    bind .ndraw <Button-3> {' >> /usr/share/netgen/drawing.tcl
echo '  set oldmousex %x; set oldmousey %y;' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '    bind .ndraw <B1-Motion> {' >> /usr/share/netgen/drawing.tcl
echo '  Ng_MouseMove $oldmousex $oldmousey %x %y $drawmode' >> /usr/share/netgen/drawing.tcl
echo '  .ndraw render' >> /usr/share/netgen/drawing.tcl
echo '  set oldmousex %x; set oldmousey %y;' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '    bind .ndraw <Double-1> {' >> /usr/share/netgen/drawing.tcl
echo '  Ng_MouseDblClick %x %y' >> /usr/share/netgen/drawing.tcl
echo '  .ndraw render' >> /usr/share/netgen/drawing.tcl
echo '  if { [winfo exists .bcprop_dlg] } { bcpropdialog }' >> /usr/share/netgen/drawing.tcl
echo '  if { [winfo exists .surfacemeshsize_dlg] } { surfacemeshsizedialog }' >> /usr/share/netgen/drawing.tcl
echo '  if { [winfo exists .fieldlines_dlg] } { fieldlinesdialog }' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '    bind .ndraw <B2-Motion> {' >> /usr/share/netgen/drawing.tcl
echo '  Ng_MouseMove $oldmousex $oldmousey %x %y move' >> /usr/share/netgen/drawing.tcl
echo '  .ndraw render' >> /usr/share/netgen/drawing.tcl
echo '  set oldmousex %x; set oldmousey %y;' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '    bind .ndraw <B3-Motion> {' >> /usr/share/netgen/drawing.tcl
echo '  Ng_MouseMove $oldmousex $oldmousey %x %y zoom' >> /usr/share/netgen/drawing.tcl
echo '  .ndraw render' >> /usr/share/netgen/drawing.tcl
echo '  set oldmousex %x; set oldmousey %y;' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '}' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo 'proc popupcheckredraw { vari { x 0 } } {' >> /usr/share/netgen/drawing.tcl
echo '    upvar $vari varname' >> /usr/share/netgen/drawing.tcl
echo '    if { $varname == 1 } {' >> /usr/share/netgen/drawing.tcl
echo '  set varname 0' >> /usr/share/netgen/drawing.tcl
echo '    } {' >> /usr/share/netgen/drawing.tcl
echo '        #        puts "popup-redraw $vari"' >> /usr/share/netgen/drawing.tcl
echo '  Ng_Vis_Set parameters' >> /usr/share/netgen/drawing.tcl
echo '  redraw' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '}' >> /usr/share/netgen/drawing.tcl
echo 'proc popupcheckredraw2 { vari boolvar { x 0 } } {' >> /usr/share/netgen/drawing.tcl
echo '    upvar $vari varname' >> /usr/share/netgen/drawing.tcl
echo '    if { $varname == 1 } {' >> /usr/share/netgen/drawing.tcl
echo '  set varname 0' >> /usr/share/netgen/drawing.tcl
echo '    } {' >> /usr/share/netgen/drawing.tcl
echo '  Ng_SetVisParameters' >> /usr/share/netgen/drawing.tcl
echo '  if { $boolvar == 1 } { redraw }' >> /usr/share/netgen/drawing.tcl
echo '  Ng_SetVisParameters' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '}' >> /usr/share/netgen/drawing.tcl
echo 'proc popupcheckredraw3 { vari { x 0 } } {' >> /usr/share/netgen/drawing.tcl
echo '    upvar $vari varname' >> /usr/share/netgen/drawing.tcl
echo '    if { $varname == 1 } {' >> /usr/share/netgen/drawing.tcl
echo '  set varname 0' >> /usr/share/netgen/drawing.tcl
echo '    } {' >> /usr/share/netgen/drawing.tcl
echo '  Ng_Vis_Set parameters' >> /usr/share/netgen/drawing.tcl
echo '    }' >> /usr/share/netgen/drawing.tcl
echo '}' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo 'proc redraw { {x 0} } {' >> /usr/share/netgen/drawing.tcl
echo '    if {[winfo exists .ndraw]} { .ndraw render } ' >> /usr/share/netgen/drawing.tcl
echo '}' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Left> { Ng_MouseMove 0 0 -10 0 rotate; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Right> { Ng_MouseMove 0 0 10 0 rotate; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Up> { Ng_MouseMove 0 0 0 -10 rotate; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Down> { Ng_MouseMove 0 0 0 10 rotate; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Shift-Left> { Ng_MouseMove 0 0 -10 0 move; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Shift-Right> { Ng_MouseMove 0 0 10 0 move; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Shift-Up> { Ng_MouseMove 0 0 0 -10 move; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Shift-Down> { Ng_MouseMove 0 0 0 10 move; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Control-Up> { Ng_MouseMove 0 0 0 -10 zoom; redraw }' >> /usr/share/netgen/drawing.tcl
echo 'bind . <Control-Down> { Ng_MouseMove 0 0 0 10 zoom; redraw }' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo 'bind all <Button-4> \' >> /usr/share/netgen/drawing.tcl
echo '   {event generate [focus -displayof %W] <MouseWheel> -delta  120}' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo ' bind all <Button-5> \' >> /usr/share/netgen/drawing.tcl
echo '   {event generate [focus -displayof %W] <MouseWheel> -delta -120}' >> /usr/share/netgen/drawing.tcl
echo '' >> /usr/share/netgen/drawing.tcl
echo 'bind all <MouseWheel> { Ng_MouseMove 0 0 0 [expr {%D/-5}] zoom; redraw }' >> /usr/share/netgen/drawing.tcl


# Nimf
apt -y install nimf im-config
im-config -n nimf
# nimf-settings


# Python pip
apt -y install python-pip


# Pandoc
apt -y install texlive-full
pip install pandoc


# Elmer
apt -y install elmerfem-csc
cp /usr/share/ElmerGUI/edf-extra/*.xml /usr/share/ElmerGUI/edf/

wget -O /usr/share/applications/ElmerGUI.desktop "https://raw.githubusercontent.com/dankamongmen/sprezzos-world/master/packaging/elmerfem/debian/ElmerGUI.desktop"
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

sudo echo '[Desktop Entry]' > /usr/share/applications/ElmerGUI.desktop
sudo echo 'Encoding=UTF-8' >> /usr/share/applications/ElmerGUI.desktop
sudo echo 'Name=Elmer' >> /usr/share/applications/ElmerGUI.desktop
sudo echo 'Comment=Elmer FEA software' >> /usr/share/applications/ElmerGUI.desktop
sudo echo 'Exec=Start_Elmer.sh' >> /usr/share/applications/ElmerGUI.desktop
sudo echo 'Icon=/usr/share/ElmerGUI/icons/Mesh3D.png' >> /usr/share/applications/ElmerGUI.desktop
sudo echo 'StartupNotify=true' >> /usr/share/applications/ElmerGUI.desktop
sudo echo 'Terminal=false' >> /usr/share/applications/ElmerGUI.desktop
sudo echo 'Type=Application' >> /usr/share/applications/ElmerGUI.desktop
sudo echo 'Categories=Education;' >> /usr/share/applications/ElmerGUI.desktop


# Paraview
wget -O Paraview.tar.gz "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.4&type=binary&os=linux64&downloadFile=ParaView-5.4.1-RC3-Qt5-OpenGL2-MPI-Linux-64bit.tar.gz"
tar -xvzf Paraview.tar.gz
rm Paraview.tar.gz

echo '' >> ~/.bashrc
echo '# Paraview' >> ~/.bashrc
echo 'export PATH="/home/osboxes/Paraview/bin:$PATH"' >> ~/.bashrc


# Salome
wget -O Salome.tgz "http://www.salome-platform.org/downloads/current-version/DownloadDistr?platform=UB16.04&version=8.2.0"
tar -xvzf Salome.tgz
rm Salome.tgz

echo '' >> ~/.bashrc
echo '# Salome' >> ~/.bashrc
echo 'export PATH="/home/osboxes/Salome:$PATH"' >> ~/.bashrc


# Gmsh
wget -O Gmsh.tgz "http://gmsh.info/bin/Linux/gmsh-3.0.4-Linux64.tgz"
tar -xvzf Gmsh.tgz
mv gmsh* Gmsh
rm Gmsh.tgz

echo '' >> ~/.bashrc
echo '# Gmsh' >> ~/.bashrc
echo 'export PATH="/home/osboxes/Gmsh/bin:$PATH"' >> ~/.bashrc

sudo echo '[Desktop Entry]' > /usr/share/applications/Gmsh.desktop
sudo echo 'Encoding=UTF-8' >> /usr/share/applications/Gmsh.desktop
sudo echo 'Name=Gmsh' >> /usr/share/applications/Gmsh.desktop
sudo echo 'Comment=Mesh Generator' >> /usr/share/applications/Gmsh.desktop
sudo echo 'Exec=gmsh' >> /usr/share/applications/Gmsh.desktop
sudo echo 'Icon=/home/osboxes/Gmsh/share/doc/gmsh/tutorial/image.png' >> /usr/share/applications/Gmsh.desktop
sudo echo 'StartupNotify=true' >> /usr/share/applications/Gmsh.desktop
sudo echo 'Terminal=false' >> /usr/share/applications/Gmsh.desktop
sudo echo 'Type=Application' >> /usr/share/applications/Gmsh.desktop
sudo echo 'Categories=Education;' >> /usr/share/applications/Gmsh.desktop

# GNU Octave
apt -y install octave liboctave-dev
chown -hR osboxes:osboxes ~/.config/octave


# Locale
echo 'LANG="ko_KR.UTF-8"' > /etc/default/locale


# Fin
echo 'Finished!'
