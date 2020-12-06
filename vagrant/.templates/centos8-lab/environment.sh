#!/bin/bash

#===VARIABLES===============================================================================================================
export PROJECT_NAME="lab-centos"
export SPACE="Labspace"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$SPACE"
export DEPLOYER="$USER_WSL"
export DEPLOYER="$USER_WSL"
#---------------------------------------------------------------------------------------------------------------------------
export CONFIGURE_ROOT="$PROJECT_ROOT/provisioning"
#---------------------------------------------------------------------------------------------------------------------------
export VAGRANT_HOSTNAME="$PROJECT_NAME"
export VAGRANT_ID="81"
export VAGRANT_NETPREFIX_NAT="192.168.71"
export VAGRANT_NETPREFIX_PRIVATE="192.168.73"
export VAGRANT_NETWORK_NAT="$VAGRANT_NETPREFIX_NAT.0/24"
export VAGRANT_NETWORK_PRIVATE="$VAGRANT_NETPREFIX_PRIVATE.$VAGRANT_ID"
export VAGRANT_SSH_PORT="22$VAGRANT_ID"
export VAGRANT_SSH_PRIVATE_KEY="$HOME_WIN/.ssh/id_rsa_vagrant.key"
export VAGRANT_SSH_PUBLIC_KEY="$HOME_WIN/.ssh/id_rsa_vagrant.pub"
export VAGRANT_SSH_INSECURE_KEY="$HOME_WIN/.vagrant.d/insecure_private_key"
#---------------------------------------------------------------------------------------------------------------------------
export ANSIBLE_DEPLOYER="$DEPLOYER"
export ANSIBLE_ACTION_WARNINGS="False"
export ANSIBLE_STDOUT_CALLBACK="yaml"
export ANSIBLE_LOAD_CALLBACK_PLUGINS="True"
export ANSIBLE_SSH_PIPELINING="True"
export ANSIBLE_HOST_PATTERN_MISMATCH="ignore"
export ANSIBLE_DISPLAY_SKIPPED_HOSTS="False"
#===========================================================================================================================
