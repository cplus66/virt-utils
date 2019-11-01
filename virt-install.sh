#!/bin/bash -xe
# Date: 2017-0516
# Author: cplus.shen

KVM_VM_NAME=VM
set +e 
virsh destroy  $KVM_VM_NAME
virsh undefine $KVM_VM_NAME
set -e
virt-install \
    --arch x86_64 \
    --ram 2048 \
    --vcpus 2 \
    --os-variant ubuntu18.04 \
    --disk=$1,device=disk,bus=virtio,format=qcow2 \
    --import \
    --vnc \
    --noautoconsole  \
    --network bridge=br0 \
    --name $KVM_VM_NAME

