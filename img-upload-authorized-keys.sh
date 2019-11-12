#!/bin/bash
# Date: Nov 12, 2019
# Author: cplus.shen
# Description: upload Authorized keys
# Usgae: img-upload-authorized-keys.sh image os_dist user_id
#        image: image name
#        os_dist: ubuntu | centos | debian
#        user_id: cp | br | te | tt 

if [ $# -ne 3 ]; then
  echo "Usgae: %0 image os_dist user_id"
  exit 1
fi

IMAGE_NAME=$1
OS_DIST=$2
USER_ID=$3

BASEDIR=$(dirname "$0")

virt-customize -a $IMAGE_NAME  --upload $BASEDIR/public-keys/$USER_ID.pub:/home/$OS_DIST/.ssh/authorized_keys
