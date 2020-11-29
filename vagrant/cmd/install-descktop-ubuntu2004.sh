#/bin/sh

#===========================================================================================================================
# [ -z "$(cat /etc/*release* | grep 'CentOS-8')" ] && echo "Wrong OS Version. Exiting..." && exit 0
#===========================================================================================================================

sudo apt update
sudo apt upgrade -y 

sudo apt install kde-plasma-desktop

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install ./google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

#===========================================================================================================================
