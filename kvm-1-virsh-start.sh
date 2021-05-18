#!/bin/bash -xe

LIST="gw dio-yocto-0 esp-3000-ubu14-1 esp-9010-0 yocto-0 bcn-ipv6-0"

for i in $LIST; do
  virsh start $i
done
