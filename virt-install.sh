#!/bin/bash -e
# Date: 2017-0516
# Author: cplus.shen
# Description:
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
#

if [ $# -lt 2 ]; then
  echo "Usage: CPU={1|2|4|8} RAM={2048|4096|9128|16384} NET={default|bridge-ubu24|br0|br1} NET2={br0|br1}"
  echo "UEFI={0|1} DISK_BUS={usb,ide,scsi}"
  echo "$0 <KVM_NAME> <IMAGE_NAME> [IMAGE_NAME]"
  exit 1
fi

CPU=${CPU:-4}
RAM=${RAM:-4096}
OS=${OS:-generic}
NET=${NET:-default}
DISK_BUS=${DISK_BUS:-virtio}

if [ "x$UEFI" == "x" ]; then
  UEFI=""
else
  UEFI=" --boot uefi "
fi

KVM_VM_NAME=$1
NET_CONF=

if [ "x$NET" == "xdefault" ]; then
  NET_CONF="--network default,model=virtio"
 
elif [ "x$NET" == "xbridge-ubu24" ]; then
  NET_CONF="--network network=hostbridge"

elif [ "x$NET2" == "x" ]; then
  NET_CONF="--network bridge=$NET,model=virtio"

else
  NET_CONF="--network bridge=$NET,model=virtio"
  NET_CONF="$NET_CONF  --network bridge=$NET2,model=virtio"
fi

DISK_1=$2
DISK_CONF="--disk=${DISK_1},device=disk,bus=$DISK_BUS,format=qcow2 "

if [ $# -eq 3 ]; then
  DISK_2=$3
  DISK_CONF="$DISK_CONF --disk=${DISK_2},device=disk,bus=$DISK_BUS,format=qcow2"
fi

virt-install \
  --arch x86_64 \
  --vcpus $CPU \
  --ram $RAM \
  --os-variant $OS \
  --import \
  --vnc \
  --noautoconsole \
  --name $KVM_VM_NAME \
  $DISK_CONF \
  $UEFI \
  $NET_CONF
