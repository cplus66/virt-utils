# virt-utils
## Libvirt
Scripts to launch VM by using virsh

## QEMU
Scripts to launch VM by using qemu-system-*

## Customized VM Images
Reset password
Remove cloud-init package
Strink the image to reduce the size

### Grub Setting

/etc/default/grub
```
--- GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+++ GRUB_CMDLINE_LINUX_DEFAULT="console=tty1 console=ttyS0"
```
/boot/grub/grub.cfg
```
root@worker-1:/boot/grub# blkid
/dev/vda1: LABEL="cloudimg-rootfs" UUID="cc3a13c5-c36c-4021-af14-6ff186f0b4bd" TYPE="ext4" PARTUUID="449d38a0-6fb9-49a4-957a-7200ca81a85a"
/dev/vda15: LABEL="UEFI" UUID="B3F7-84B8" TYPE="vfat" PARTUUID="7222db1b-da3d-47c4-8503-0ac9d0128337"
/dev/vda14: PARTUUID="5ed90f1e-b2f4-4ae9-8a51-cffdc03a3820"

root@worker-1:/boot/grub# vi grub.cfg
        if [ x$feature_platform_search_hint = xy ]; then
          search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-eff
i=hd0,gpt1 --hint-baremetal=ahci0,gpt1  cc3a13c5-c36c-4021-af14-6ff186f0b4bd
        else
          search --no-floppy --fs-uuid --set=root cc3a13c5-c36c-4021-af14-6ff1866
f0b4bd  
        fi
        linux   /boot/vmlinuz-4.15.0-65-generic root=UUID=cc3a13c5-c36c-4021-af11
4-6ff186f0b4bd ro  console=tty1 console=ttyS0

```


## useful Commands

List inactive VM
```
virsh list --inactive
```
