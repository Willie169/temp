## Box64 and Wine in Chroot on Termux
### Install Box64
```
git clone https://github.com/ptitSeb/box64
cd box64
mkdir build; cd build; cmake .. -D ARM64=1 -DCMAKE_C_COMPILER=gcc -DBAD_SIGNAL=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo
make -j$(nproc)
sudo make install
sudo systemctl restart systemd-binfmt
```
### Use Box64
```
box64 ./your-32bit-application
```
### Install Wine:
```
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wine
```
### Set up Wine to use Box64 as its 32-bit x86 compatibility layer
```
export LD_PRELOAD=/usr/local/lib/box64/box64.so
```
### Use Wine
```
wine your-windows-application.exe
```