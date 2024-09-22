## SSH
### Linux
#### Install and Setup:
```
sudo apt install openssh-server
sudo systemctl enable --now ssh
```
#### Edit Configuration 
```
sudo nano /etc/ssh/sshd_config
```
Change the following lines:
```
#Port 22
```
to:
```
Port 2222
```
You can change the port `2222` to the port you want.\
And change the line:
```
#PermitRootLogin prohibit-password
```
to:
```
PermitRootLogin yes
```
if you are connecting as root.\
Uncomment the lines:
```
ListenAddress 0.0.0.0
```
and
```
PasswordAuthentication yes
```
#### Start SSH 
```
sudo service ssh start
```
#### Restart SSH  
```
sudo service ssh restart
```
#### Stop SSH 
```
sudo service ssh stop
```
#### Disable SSH 
```
sudo systemctl disable ssh
```
#### Enable SSH 
```
sudo systemctl enable ssh
```
#### Check the Status
```
sudo service ssh status
```
#### Check Port Listening 
```
sudo ss -tuln | grep 22
```
#### Run
```
ssh user@localhost
```
Change the `user@localhost` to the actual user name and address.\
Run with port specified:
```
ssh user@localhost -p 2222
```
Change `2222` to the port you want to use.
### Termux
#### Install
```
apt install openssh
```
### Start Server
```
sshd
```
#### Run
```
ssh user@localhost
```
Change the `user@localhost` to the actual user name and address.\
Run with port specified:
```
ssh user@localhost -p 2222
```
Change `2222` to the port you want to use.
### Source
- [https://www.openssh.com/](https://www.openssh.com/)
- [https://ivonblog.com/posts/termux-qemu-system-linux/](https://ivonblog.com/posts/termux-qemu-system-linux/)