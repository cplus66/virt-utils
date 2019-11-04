#!/bin/bash -xe
# Date: 2017-0516
# Author: cplus.shen
# Description:
#   Usage: CPU="" RAM="" NET="" NET2="" virt-install.sh KVM_NAME IMAGE_NAME
#
#   - Remove KVM if it exists
#     virsh destory $KVM_VM_NAME
#     virsh undefine $KVM_VM_NAME
#
#   - Use "--network bridge=br1" if we need two ethernet interface (eth0, eth1)
#   - Use osinfo-query os to get --os-variant
#
# VM Configuration:
#   CPU  |  RAM                 | DISK
#   1    |  2048  = 64 / 24 * 1 |  64G = 2T / 24 * 1
#   2    |  4096  = 64 / 24 * 2 | 128G = 2T / 24 * 2
#   4    |  9128  = 64 / 24 * 4 | 256G = 2T / 24 * 4
#   8    |  16384 = 64 / 24 * 8 | 512G = 2T / 24 * 8

if [ $# -ne 2 ]; then
  echo "Usage: CPU={1|2|4|8} RAM={2048|4096|9128|16384} NET={br0|br1} NET2={br0|br1} $0 KVM_NAME IMAGE_NAME"
  exit 1
fi

if [ "x$CPU" == "x" ]; then
  CPU=2
fi

if [ "x$RAM" == "x" ]; then
  RAM=2048
fi

if [ "x$OS" == "x" ]; then
  OS=ubuntu18.04
fi

if [ "x$NET" == "x" ]; then
  NET=br0
fi


KVM_VM_NAME=$1

if [ "x$NET2" == "x" ]; then
  virt-install \
    --arch x86_64 \
    --vcpus $CPU \
    --ram $RAM \
    --os-variant $OS \
    --disk=$2,device=disk,bus=virtio,format=qcow2 \
    --import \
    --vnc \
    --noautoconsole  \
    --network bridge=$NET \
    --name $KVM_VM_NAME

else
  virt-install \
    --arch x86_64 \
    --vcpus $CPU \
    --ram $RAM \
    --os-variant $OS \
    --disk=$2,device=disk,bus=virtio,format=qcow2 \
    --import \
    --vnc \
    --noautoconsole  \
    --network bridge=$NET \
    --network bridge=$NET2 \
    --name $KVM_VM_NAME

fi
