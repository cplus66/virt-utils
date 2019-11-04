#!/bin/bash -xe
# Date: 2017-0516
# Author: cplus.shen
# Description:
#   Usage: KVM_VM_NAME="" IMAGE_NAME="" CPU="" RAM="" NET="" virt-install.sh
#
#   Remove KVM if it exists
#     virsh destory $KVM_VM_NAME
#     virsh undefine $KVM_VM_NAME
#
#   Adde "--network bridge=br1" if we have two ethernet interface
#

if [ $# -ne 2 ]; then
  echo "Usage CPU="" RAM="" $0 KVM_NAME IMGAGE_NAME"
  exit 1
fi

if [ "x$CPU" == "x" ]; then
  CPU=2
fi

if [ "x$RAM" == "x" ]; then
  RAM=2048
fi

KVM_VM_NAME=$1

virt-install \
    --arch x86_64 \
    --vcpus $CPU \
    --ram $RAM \
    --os-variant ubuntu18.04 \
    --disk=$2,device=disk,bus=virtio,format=qcow2 \
    --import \
    --vnc \
    --noautoconsole  \
    --network bridge=br0 \
    --name $KVM_VM_NAME

