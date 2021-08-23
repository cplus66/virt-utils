#!/bin/bash -xe

LIST="dio-yocto-1 esp-9010-0-debian10 esp-9010b yocto-2 esp-9400-terryt esp-9010-1 jetpack-2"

for i in $LIST; do
  virsh start $i
done

