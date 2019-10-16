#!/bin/bash -xe
# Date: 2017-0516
# Author: cplus.shen
# Description: bootup powerpc e500 U-boot
# usage: virt-install-ppc.sh <disk.img> <u-boot>

KVM_VM_NAME=VM
set +e 
virsh destroy  $KVM_VM_NAME
virsh undefine $KVM_VM_NAME
set -e
virt-install \
    --arch ppc \
    --machine ppce500 \
    --boot kernel=$2 \
    --ram 2048 \
    --vcpus 2 \
    --disk=$1,device=disk,bus=sd,format=qcow2 \
    --import \
    --network bridge=br0 \
    --name $KVM_VM_NAME 

#    --vnc \
#    --noautoconsole  \
