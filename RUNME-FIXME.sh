#!/bin/bash

#===Git=====================================================================================================================

# Fix Repo

CWD=$(pwd)

MYNAME="$(realpath $0)"
BASENAME="$(basename $MYNAME)"
MYDIR="$(dirname $MYNAME)"

pwd

cd $MYDIR
git config --unset core.filemode
git config --unset core.autocrlf
git config --unset core.ignorecase

pwd

cd $CWD

pwd

#===========================================================================================================================
