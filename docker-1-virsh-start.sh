#!/bin/bash -xe

LIST="esp-9010-deb10-1 yocto-3 bcn-ipv6-1 esp-9010b-1 esp-9010b-2 vega-3500-3"

for i in $LIST; do
  virsh start $i
done
