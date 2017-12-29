#!/bin/bash -xe
IMAGE=CentOS-7-x86_64-GenericCloud-1511_root.qcow
IMAGE=cirros-0.3.5-x86_64-disk.img 

qemu-system-i386 \
  -nographic \
  -net bridge -net nic,model=virtio \
  -netdev bridge,id=network0,br=br0 \
  -device e1000,netdev=network0,mac=52:54:00:12:34:57 \
  -hda cirros-0.3.5-x86_64-disk.img \
  -kernel bzImage \
  -m 512 \
  -bios u-boot.rom 

#  -msg timestamp=on

#  -hda $IMAGE \
