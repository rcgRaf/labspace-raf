#/bin/sh

#===========================================================================================================================
[ -z "$(cat /etc/*release* | grep 'CentOS-8')" ] && echo "Wrong OS Version. Exiting..." && exit 0
#===========================================================================================================================


sudo yum --enablerepo=epel,PowerTools group install -y "KDE Plasma Workspaces" "base-x"

sudo yum install -y gdm
sudo systemctl enable gdm
sudo systemctl start gdm

sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum localinstall -y google-chrome-stable_current_x86_64.rpm
sudo rm -f google-chrome-stable_current_x86_64.rpm

#===========================================================================================================================
