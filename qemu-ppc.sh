#!/bin/bash -xe
IMAGE=CentOS-7-x86_64-GenericCloud-1511_root.qcow
#IMAGE=cirros-0.3.5-x86_64-disk.img 

qemu-system-x86_64 -hda $IMAGE -m 512 \
-netdev user,id=user.0 -device rtl8139,netdev=user.0 \
-msg timestamp=on

exit 0

/usr/bin/qemu-system-ppc -name VM -S -machine ppce500,accel=tcg,usb=off -m 2048 \
-realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 -uuid 5ac36ab9-1a51-40f1-bb70-27c353f539f3 \
-nographic -no-user-config -nodefaults \
-chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-VM/monitor.sock,server,nowait \
-mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown \
-boot strict=on \
-kernel /home/cplus/u-boot \
-device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x2 -drive file=/home/cplus/debian_wheezy_powerpc_standard.qcow2,format=qcow2,if=sd,index=0 \
-netdev tap,fd=26,id=hostnet0 \
-device rtl8139,netdev=hostnet0,id=net0,mac=52:54:00:ea:14:0f,bus=pci.0,addr=0x1 \
-serial pty -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x3 -msg timestamp=on


#qemu-system-x86_64 -enable-kvm -name VM -S \
#-machine pc-i440fx-xenial,accel=kvm,usb=off \
#-cpu Nehalem -m 2048 -realtime mlock=off -smp 2,sockets=2,cores=1,threads=1 \
#-uuid c1c3ca72-1a4b-40a4-900f-ae81a28188de -no-user-config -nodefaults  \
#-rtc base=utc,driftfix=slew \
#-no-hpet \
#-no-shutdown -global PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 \
#-boot strict=on \
#-drive file=$IMAGE,format=qcow2,if=none,id=drive-virtio-disk0 \
#-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 \
#-vnc 127.0.0.1:0 \
#-device cirrus-vga,id=video0,bus=pci.0,addr=0x2 \
#-netdev tap,ifname=tap0,script=no,downscript=no,id=hostnet0 \
#-device rtl8139,netdev=hostnet0,id=net0,mac=52:54:00:98:6c:2e,bus=pci.0,addr=0x3 \
#-msg timestamp=on
#-msg timestamp=on

#-global kvm-pit.lost_tick_policy=discard \
#-chardev pty,id=charserial0 \
#-device isa-serial,chardev=charserial0,id=serial0 \
#-nographic \
#-chardev pty,id=charserial0 \
#-device isa-serial,chardev=charserial0,id=serial0 \
