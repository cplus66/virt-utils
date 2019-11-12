#!/bin/bash -xe
# Date: Nov 12, 2019
# Author: cplus.shen
# Description: virtual disk resize
# Usage: img-resize.sh image partition size
#          image: image name
#          partition: /dev/sda1 
#          size: 16G
# Next
# - Run parted and fix
# - Run fdisk
# - Run resize2fs /dev/vda1

if [ $# -ne 2 ]; then
  echo "%0 image size"
  exit 1
fi

IMAGE=$1
SIZE=$2

qemu-img resize $IMAGE $SIZE


