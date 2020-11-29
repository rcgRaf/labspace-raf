#!/bin/bash

sudo yum --enablerepo=epel,PowerTools group install -y "KDE Plasma Workspaces" "base-x"
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum localinstall -y google-chrome-stable_current_x86_64.rpm
sudo rm -f google-chrome-stable_current_x86_64.rpm
