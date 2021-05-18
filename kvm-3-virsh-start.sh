#!/bin/bash -xe

LIST="dio-yocto-2 jetpack-0 yocto-1 atca-9113-wr8-2 esp-9400-ubuntu esp-9010-2"

for i in $LIST; do
  virsh start $i
done
