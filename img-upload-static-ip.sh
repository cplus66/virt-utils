#!/bin/bash
# Date: Apr 15, 2020
# Author: cplus.shen
# Description: upload Ubuntu network static IP configuration
# Usgae: img-upload-authorized-keys.sh image ip
#        image: image name
#        IP: 192.168.10.x
# Environment:
#        OS: ubuntu | debian

if [ $# -ne 2 ]; then
  echo "Usgae: OS={centos|ubuntu} $0 <image> <ip>"
  exit 1
fi

if [ "x$OS" == "x" ]; then
  OS=ubuntu
fi

BASEDIR=$(dirname "$0")
IMAGE_NAME=$1
IP=$2

sed -e "s/IP_ADDR/$IP/g" template/interfaces > interfaces
sudo virt-customize -a $IMAGE_NAME  --upload $BASEDIR/template/interfaces:/etc/network/interfaces
rm -f interfaces

