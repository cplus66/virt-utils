#!/bin/bash -e
#Date: May 10, 2021
#Author: cplus.shen
#Description: list VM image file.
#Usage: ./virt-image-list.sh [--inactive]

if [ x$1 == "x--inactive" ]; then
  LIST="$(virsh list --inactive | sed 1,2d | awk '{print $2}')"
else
  LIST="$(virsh list | sed 1,2d | awk '{print $2}')"
fi

for i in $LIST; do
  NAME=$i
  FILE=$(virsh domblklist $i | sed 1,2d | awk '{print $2}')
  echo ${NAME},${FILE}
done
