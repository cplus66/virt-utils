#!/bin/bash -xe

LIST="esp-3000-ubu14-0 kernel yocto-4 vega-3500-sc-0 esp-9010-deb8-0"

for i in $LIST; do
  virsh start $i
done

