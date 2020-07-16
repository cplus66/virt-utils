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
  echo "Usgae: $0 <image> <ip>"
  exit 1
fi

if [ "x$OS" == "x" ]; then
  OS=ubuntu
fi

IMAGE_NAME=$1
IP=$2
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sed -e "s/IP_ADDR/$IP/g" template/interfaces > interfaces
sudo virt-customize -a $IMAGE_NAME --upload $BASEDIR/interfaces:/etc/network
#sudo virt-customize -a $IMAGE_NAME --run-command 'apt install -y resolvconf'
#sudo virt-customize -a $IMAGE_NAME --run-command 'rm -f /etc/resolv.conf'
rm -f interfaces

