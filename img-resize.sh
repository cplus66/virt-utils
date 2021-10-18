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
  echo "OS=ubuntu-18 $0 image size"
  exit 1
fi

IMAGE=$1
SIZE=$2
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo qemu-img resize $IMAGE $SIZE

if [ x$OS == "xubuntu-18" ]; then
  sudo virt-customize -a $IMAGE --upload $DIR/img-resize-sda.exp:/root
  sudo virt-customize -a $IMAGE --run-command "/root/img-resize-sda.exp; rm /root/img-resize-sda.exp"
elif [ x$OS == "xdebian-10" ]; then
  sudo virt-customize -a $IMAGE --upload $DIR/img-resize-vda-debian.exp:/root
  sudo virt-customize -a $IMAGE --run-command "/root/img-resize-vda-debian.exp; rm /root/img-resize-vda-debian.exp"
else

  cat << EOF
ubuntu 14.04 or ubuntu 16.04: run parted, fdisk ,resize2fs and grub PARTUUID
centos: run parted and fdisk

mount --bind /dev /mnt/dev &&
mount --bind /dev/pts /mnt/dev/pts &&
mount --bind /proc /mnt/proc &&
mount --bind /sys /mnt/sys"
EOF

fi
