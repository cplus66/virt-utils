#!/bin/bash
# Date: Nov 12, 2019
# Author: cplus.shen
# Description: upload Authorized keys
# Usgae: img-upload-authorized-keys.sh image user_id
#        image: image name
#        user_id: cp | br | te | tt 
# Environment:
#        OS: ubuntu | centos | debian

if [ $# -ne 2 ]; then
  echo "Usgae: OS={centos|ubuntu} $0 image user_id"
  exit 1
fi

if [ "x$OS" == "x" ]; then
  OS=ubuntu
fi

IMAGE_NAME=$1
USER_ID=$2

BASEDIR=$(dirname "$0")

sudo virt-customize -a $IMAGE_NAME  --upload $BASEDIR/public-keys/$USER_ID.pub:/home/$OS/.ssh/authorized_keys

if [ $OS == "centos" ]; then
  sudo virt-customize -a $IMAGE_NAME  --run-command "chmod 600 /home/centos/.ssh/authorized_keys && restorecon /home/centos/.ssh/authorized_keys" 
elif # ubuntu and debian
  sudo virt-customize -a $IMAGE_NAME  --run-command "chmod 600 /home/$OS/.ssh/authorized_keys" 
fi
