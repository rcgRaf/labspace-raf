#!/bin/bash

exit 0

#===WARNING=================================================================================================================

# !!! DO NOT RUN THIS BLINDLY !!! 
# !!! THESE ARE HINTS ONLY !!! 

#===Variables===============================================================================================================

# Export Variables
#
export PROJECT_NAME="labspace"
export SPACE="Labspace"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$SPACE"
export DEPLOYER="$USER_WSL"
#

#===Files===================================================================================================================

mkdir -p $ARTIFACTS/home/user/.ssh
mkdir -p $ARTIFACTS/root

# Put your keys in $ARTIFACTS/home/user/.ssh/
#
# id_rsa_$DEPLOYER.key (encrypted)
# id_rsa_$DEPLOYER.pub
# id_rsa_vagrant.key (unecrypted)
# id_rsa_vagrant.pub

#===WSL=====================================================================================================================

# Enable SUDO with NOPASSWD: sudo vi /etc/sudoers
# Edit Lines:
#
# %sudo   ALL=(ALL:ALL) NOPASSWD: ALL
#

# Configure WSL Options:
#
sudo su -
cat > /etc/wsl.conf <<-EOT
[automount]
enabled = true
options = "metadata,umask=22,fmask=11"
mountFsTab = false

[network]
generateHosts = true
generateResolvConf = true
EOT
exit
#

# Terminate and Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

#---------------------------------------------------------------------------------------------------------------------------

# !!! EXPORT VARIABLES AGAIN !!!

#---------------------------------------------------------------------------------------------------------------------------

# Update and Install Prerequisites
#
sudo apt update
sudo apt upgrade -y
#
sudo apt install -y wget
sudo apt install -y git
#

# Configure SSH
#
mkdir -p $HOME_WSL/.ssh && chmod 700 $HOME_WSL/.ssh
cp $ARTIFACTS/home/user/.ssh/id_rsa_*.pub $HOME_WSL/.ssh/ && chmod 644 $HOME_WSL/.ssh/id_rsa_*.pub
cp $ARTIFACTS/home/user/.ssh/id_rsa_*.key $HOME_WSL/.ssh/ && chmod 600 $HOME_WSL/.ssh/id_rsa_*.key
cat $HOME_WSL/.ssh/id_rsa_$USER_WSL.pub > $HOME_WSL/.ssh/authorized_keys
#

# Configure SSH Server: sudo vi /etc/ssh/sshd_config
# Edit and uncomment ines:
#
# Port 2222
#

# Enable SSH Server
#
sudo ssh-keygen -A
sudo service ssh --full-restart
#

# Install SSH Keys loader (optional)
#
mkdir -p $HOME_WSL/.local/gbin
wget -P $HOME_WSL/.local/gbin/ https://raw.githubusercontent.com/arabadj/public-scripts/main/ssh-load-linux
wget -P $HOME_WSL/.local/gbin/ https://raw.githubusercontent.com/arabadj/public-scripts/main/ssh-load-windows
chmod +x $HOME_WSL/.local/gbin/ssh-load-*
#
mkdir -p $ARTIFACTS/home/user/.local/gbin
cp $HOME_WSL/.local/gbin/ssh-load-* $ARTIFACTS/home/user/.local/gbin/
#
$HOME_WSL/.local/gbin/ssh-load-linux install
bash

#===Git=====================================================================================================================

# Clone Repo
#
mkdir -p $HOME_WIN/Work
#
[ ! -d $HOME_WIN/Work/$PROJECT_NAME ] && git -C $HOME_WIN/Work clone https://github.com/arabadj/$PROJECT_NAME.git
[ -d $HOME_WIN/Work/$PROJECT_NAME ] && git -C $HOME_WIN/Work/$PROJECT_NAME pull 
#

# Fix Repo
#
cd $HOME_WIN/Work/$PROJECT_NAME/
git config --unset core.filemode
git config --unset core.autocrlf
git config --unset core.ignorecase
#

#===Ansible=================================================================================================================

# Install ANSIBLE
#
sudo apt install -y ansible
#

# Configure WSL
#
cd $HOME_WIN/Work/$PROJECT_NAME && ./wsl/provision.sh
#

#===Vagrant=================================================================================================================

# Install Vagrant
#
cd $HOME_WSL/install && sudo apt install ./vagrant_2.2.9_x86_64.deb
bash
#

# Run Vagrants
#
cd $HOME_WIN/Work/$PROJECT_NAME && ./vagrant/lab-centos/up.sh
cd $HOME_WIN/Work/$PROJECT_NAME && ./vagrant/lab-ubuntu/up.sh
#

# Connect to VMs
#
ssh -A 192.168.73.81
ssh -A 192.168.73.82
#

#===========================================================================================================================
