# virt-utils
## Libvirt
Scripts to launch VM by using virsh

## QEMU
Scripts to launch VM by using qemu-system-*

## Customized VM Images
- change root password to 'root' (OS=ubuntu img-reset-password.sh image password)
- added Garfield and Orchimaru into hosts
- added user 'ubuntu'
- added 'ubuntu' into sudo
- support authorized_keys upload (OS=ubuntu img-upload-authorized-keys.sh image user_id)
- change disk size to 8GB (img-resize.sh image 8G)
- shrik file size

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
          search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-effi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  cc3a13c5-c36c-4021-af14-6ff186f0b4bd
        else
          search --no-floppy --fs-uuid --set=root cc3a13c5-c36c-4021-af14-6ff1866f0b4bd  
        fi
        linux   /boot/vmlinuz-4.15.0-65-generic root=UUID=cc3a13c5-c36c-4021-af14-6ff186f0b4bd ro  console=tty1 console=ttyS0

```

### Upload Authorized keys
```
sudo virt-customize -a $undercloud_dst --run-command "mkdir -p /root/.ssh/" \
      --upload /home/stack/.ssh/id_rsa.pub:/root/.ssh/authorized_keys \
      --run-command "chmod 600 /root/.ssh/authorized_keys && restorecon /root/.ssh/authorized_keys" \
      --run-command "cp /root/.ssh/authorized_keys /home/stack/.ssh/" \
      --run-command "chown stack:stack /home/stack/.ssh/authorized_keys && chmod 600 /home/stack/.ssh/authorized_keys"
```

## useful Commands

List inactive VM
```
virsh list --inactive
```
