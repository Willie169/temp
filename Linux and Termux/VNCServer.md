```
curl -sLf https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/main/boostrap.sh | bash
```
Which contains:
```
#!/data/data/com.termux/files/usr/bin/env bash

clear 

#this script will configure a graphical user interface 
#(xfce4) in termux
#creator: @Yisus7u7v
cd $HOME

echo -e '\e[1;36m installing packages, it is necessary  \e[1m'
echo -e '''
\e[1;31m Download speed depends on
 your internet connection \e[1m'''

sleep 3

clear

echo -e '\e[1;36m installing xfce4 and basic apps...\e[1m'

sleep 1

apt update && apt upgrade -y
apt install -y wget
rm $PREFIX/etc/apt/sources.list.d/termux-desktop-xfce.list
wget -P $PREFIX/etc/apt/sources.list.d https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/gh-pages/termux-desktop-xfce.list
apt install -y x11-repo 
apt update
apt install -y xfce4 tigervnc xfce4-goodies termux-desktop-xfce breeze-cursor-theme kvantum ttf-microsoft-cascadia audacious leafpad pavucontrol-qt hexchat geany synaptic 
apt install -y firefox

echo "boostrap data..."
rm -rf $HOME/.backup
mkdir $HOME/.backup
mv $HOME/.config $HOME/.backup
mv $HOME/.vnc $HOME/.backup
cd $HOME

echo "Downloading wallpapers and xstartup..."
wget https://github.com/Yisus7u7/termux-desktop-lxqt/releases/download/data/termux_desktop_lxqt_data.tar.xz
tar -xvf termux_desktop_lxqt_data.tar.xz
rm termux_desktop_lxqt_data.tar.xz
rm .vnc/xstartup
wget https://github.com/Yisus7u7/termux-desktop-xfce/releases/download/desktop-5.0.3/data.tar.xz
tar -xvf data.tar.xz
rm data.tar.xz

echo "setup folders..."

mkdir $HOME/Desktop 
mkdir $HOME/Downloads 
mkdir $HOME/Templates 
mkdir $HOME/Public 
mkdir $HOME/Documents 
mkdir $HOME/Pictures 
mkdir $HOME/Videos 
termux-setup-storage

ln -s $HOME/storage/music Music 

cd $HOME/Desktop
wget https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/main/welcome/LEAME.txt
wget https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/main/welcome/README.txt
rm LEAME.txt README.txt
cd $HOME

mv $PREFIX/share/kvantum/* $PREFIX/share/Kvantum

echo -e """\e[1;32menjoy!!
To start the vnc server, use the command: vncserver to stop it, use the command: vncserver -kill: 1 Replace the: 1 with the port on which the vnc service is running\e[1m"""

exit
```
```
vncserver -listen tcp
```
For first time you will see it show something like New 'localhost:1 ()' desktop is localhost:1, then localhost:1 is your display ip address.
You can download VNC Viewer from CH Play to view your webdriver, use localhost:1 as the ip address.