#!/bin/bash
# Date: Dec 23, 2019
# Author: cplus.shen
# Description: shrink the image size

if [ $# -ne 1 ]; then
  echo "Usage: $0 <image name>"
  exit 1 
fi

mv $1 $1.backup
sudo qemu-img convert -O qcow2 -c $1.backup $1
rm -f $1.backup
