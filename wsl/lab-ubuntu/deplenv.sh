#!/bin/bash

#===========================================================================================================================
CWD=$(pwd); BASE=$(dirname $0); cd $BASE
while [ -z "$PROJECT_ROOT" ]; do
    [ -f ./environment.sh ] && export PROJECT_ROOT=$(pwd) && source ./environment.sh
    [ "$(pwd)" == "/mnt/c" ] && echo "Unknown \$PROJECT_ROOT, terminating..." && exit 0; cd ..; done; cd $CWD
for FUNCTION in $(cat $PROJECT_ROOT/environment.sh | grep "^function" | awk '{print $2}'); do 
    export -f $FUNCTION; done
#===========================================================================================================================
cd $PROJECT_ROOT
#===========================================================================================================================

sudo service ssh start
ansible-playbook -i loclhost, $CONFIGURE_ROOT/deplenv.yml 
sudo service ssh stop

#===========================================================================================================================

