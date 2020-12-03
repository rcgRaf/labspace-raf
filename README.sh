#!/bin/bash

exit 0

#===WARNING=================================================================================================================

# !!! DO NOT RUN THIS BLINDLY !!! 
# !!! THESE ARE HINTS ONLY !!! 

#===Files===================================================================================================================

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

mkdir -p $ARTIFACTS/home/user/.ssh
mkdir -p $ARTIFACTS/root

# Put your keys in $ARTIFACTS/home/user/.ssh/
#
# id_rsa_$DEPLOYER.key (encrypted)
# id_rsa_$DEPLOYER.pub
# id_rsa_vagrant.key (unecrypted)
# id_rsa_vagrant.pub

#===WSL=====================================================================================================================

# Enable SUDO with NOPASSWD 
#
sudo vi /etc/sudoers
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

# Terminate and Re-Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

# Update and Install Prerequisites
#
sudo apt update
sudo apt upgrade -y
#
sudo apt install -y wget
sudo apt install -y git
#

# Terminate and Re-Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

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

# Configure SSH
#
mkdir -p $HOME_WSL/.ssh && chmod 700 $HOME_WSL/.ssh
cp $ARTIFACTS/home/user/.ssh/id_rsa_*.pub $HOME_WSL/.ssh/ && chmod 644 $HOME_WSL/.ssh/id_rsa_*.pub
cp $ARTIFACTS/home/user/.ssh/id_rsa_*.pub $HOME_WSL/.ssh/ && chmod 644 $HOME_WSL/.ssh/id_rsa_*.pub
cp $ARTIFACTS/home/user/.ssh/id_rsa_*.key $HOME_WSL/.ssh/ && chmod 600 $HOME_WSL/.ssh/id_rsa_*.key
cp $ARTIFACTS/home/user/.ssh/id_*.key $HOME_WSL/.ssh/ && chmod 600 $HOME_WSL/.ssh/id_*.key
cat $HOME_WSL/.ssh/id_rsa_$USER_WSL.pub > $HOME_WSL/.ssh/authorized_keys
#

# Configure SSH Server
#
sudo vi /etc/ssh/sshd_config
#
# Edit and uncomment ines:
#
# Port 2222
#

# Enable SSH Server
#
sudo ssh-keygen -A
sudo service ssh --full-restart
#

# Modify Bashrc
#
echo "# Add Paths" >> $HOME/.bashrc
echo "export PATH=\"\$HOME/.local/gbin:\$PATH\"" >> $HOME/.bashrc
echo "" >> $HOME/.bashrc
echo "# Modify Prompt" >> $HOME/.bashrc
echo "export PS1='\[\033[01;32m\]\u@\$WSL_DISTRO_NAME:\[\033[34m\]\w\$\[\033[00m\] '" >> $HOME/.bashrc
echo "" >> $HOME/.bashrc
#

# Install SSH Keys loader
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
#

# Terminate and Re-Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

#===Git=====================================================================================================================

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
# Load SSH Keys
#
ssh-load-linux
#

# Clone Repo
#
mkdir -p $HOME_WIN/Work/spaces
#
[ ! -d $HOME_WIN/Work/spaces/$PROJECT_NAME ] && git -C $HOME_WIN/Work/spaces clone https://github.com/arabadj/$PROJECT_NAME.git
[ -d $HOME_WIN/Work/spaces/$PROJECT_NAME ] && git -C $HOME_WIN/Work/spaces/$PROJECT_NAME pull 
#

# Fix Repo
#
cd $HOME_WIN/Work/spaces/$PROJECT_NAME/
git config --unset core.filemode
git config --unset core.autocrlf
git config --unset core.ignorecase
#

#===Ansible=================================================================================================================

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
# Load SSH Keys
#
ssh-load-linux
#

# Install ANSIBLE
#
sudo apt install -y ansible
#

# Configure WSL
#
cd $HOME_WIN/Work/spaces/$PROJECT_NAME && ./wsl/provision.sh
#

# Configure Windows
#
cd $HOME_WIN/Work/spaces/$PROJECT_NAME && ./wsl/winstrap.sh
#

# Terminate and Re-Open WSL again
#
wsl.exe -t $WSL_DISTRO_NAME
#

# To Provision WSL: Go to your ./wsl directory
#
ssh-load-linux
#
./bootstrap.sh  # Base provisioning
./profile.sh    # Profile provisioning
./deplenv.sh    # Deployment environment provisioning
./provision.sh  # Provisions above listed provisioning
./pullconfig.sh # Syncs artifacts from WSL to Artifacts
./winstrap.sh   # Does some Windows configuration

#===VirtualBox==============================================================================================================

# Set your "Default Machine Folder" with gui to:
#
# C:\Users\$USER_WIN\VirtualBox
#

# Set your "VirtualBox Host-Only Ethernet Adapter" IPv4 Address with gui to:
#
# 192.168.73.1
#

#===Vagrant=================================================================================================================

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
# Load SSH Keys
#
ssh-load-linux
#

# Install Vagrant
#
cd $HOME_WSL/install && sudo apt install ./vagrant_2.2.9_x86_64.deb
#

# Run and Provision boxes: Go to your Vagrantfile directories
#
ssh-load-linux
#
./up.sh         # Boots a box and provisions it
./halt.sh       # Halts a box
./reload.sh     # Reloads a box
./destroy.sh    # Destroys a box
./ssh.sh        # Connects to a box with "vagrant" user only from the localhost
#
./bootstrap.sh  # Base provisioning
./profile.sh    # Profile provisioning
./deplenv.sh    # Deployment environment provisioning
./provision.sh  # Provisions above listed provisioning

# Connect to VMs
#
ssh -A 192.168.73.81
ssh -A 192.168.73.82
#

#===========================================================================================================================
