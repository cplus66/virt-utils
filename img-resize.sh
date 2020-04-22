#!/bin/bash
# Date: Nov 12, 2019
# Author: cplus.shen
# Description: virtual disk resize
# Usage: OS=ubuntu img-resize.sh image partition size
#          image: image name
#          partition: /dev/sda1 
#          size: 16G
# Next
# - Run parted and fix
# - Run fdisk
# - Run resize2fs /dev/vda1

if [ $# -ne 2 ]; then
  echo "OS=ubuntu $0 image size"
  exit 1
fi

IMAGE=$1
SIZE=$2
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo qemu-img resize $IMAGE $SIZE

if [ x$OS == "xubuntu" ]; then
  #run parted, fdisk and resize2fs"
  sudo virt-customize -a $IMAGE --upload $DIR/img-resize-sda.exp:/root
  sudo virt-customize -a $IMAGE --run-command "/root/img-resize-sda.exp; rm /root/img-resize-sda.exp"
else
  echo "centos: run parted and fdisk"
fi
