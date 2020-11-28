#!/bin/bash

#===VARIABLES===============================================================================================================
export PROJECT_NAME="wsl-ubuntu"
export SPACE="Labspace"
export USER_WSL="$USER"
export USER_WIN="$(whoami.exe | cut -d '\' -f 2 | tr -d '\n' | tr -d '\r')"
export HOME_WSL="$HOME"
export HOME_WIN="/mnt/c/Users/$USER_WIN"
export ARTIFACTS="$HOME_WIN/OneDrive/Artifacts/$SPACE"
export DEPLOYER="$USER_WSL"
#---------------------------------------------------------------------------------------------------------------------------
export CONFIGURE_ROOT="$PROJECT_ROOT/provisioning"
#---------------------------------------------------------------------------------------------------------------------------
export WSL_REMOTE_PORT="2222"
#---------------------------------------------------------------------------------------------------------------------------
export ANSIBLE_DEPLOYER="$DEPLOYER"
export ANSIBLE_REMOTE_USER="$ANSIBLE_DEPLOYER"
export ANSIBLE_SSH_ARGS="-C -o ForwardAgent=yes -o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no"
export ANSIBLE_ACTION_WARNINGS="False"
export ANSIBLE_STDOUT_CALLBACK="yaml"
export ANSIBLE_LOAD_CALLBACK_PLUGINS="True"
export ANSIBLE_SSH_PIPELINING="True"
export ANSIBLE_HOST_PATTERN_MISMATCH="ignore"
export ANSIBLE_DISPLAY_SKIPPED_HOSTS="False"
#===========================================================================================================================
