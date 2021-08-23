#!/bin/bash -xe

LIST="esp-3000-ubu14-0 kernel yocto-4 vega-3500-sc-0 esp-9010-deb8-0 openssl-0 openssl-1 openssl-2 centos-7.9 jetpack-4"

for i in $LIST; do
  virsh start $i
done

