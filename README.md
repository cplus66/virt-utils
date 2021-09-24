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
- install JDK
- added "net.ifnames=0" to /etc/default/grub and line GRUB_CMDLINE_LINUX and update-grub

### Grub Setting

/etc/default/grub
```
--- GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+++ GRUB_CMDLINE_LINUX_DEFAULT="console=tty1 console=ttyS0"
```
/boot/grub/grub.cfg
```
root@worker-1:/boot/grub# blkid
/dev/vda1: LABEL="cloudimg-rootfs" UUID="cc3a13c5-c36c-4021-af14-6ff186f0b4bd" TYPE="ext4" 

root@worker-1:/boot/grub# vi grub.cfg
if [ x$feature_platform_search_hint = xy ]; then
  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-effi=hd0,gpt1 --hint-baremetal=ahci0,gpt1 cc3a13c5-c36c-4021-af14-6ff186f0b4bd
else
  search --no-floppy --fs-uuid --set=root cc3a13c5-c36c-4021-af14-6ff1866f0b4bd  
fi
linux   /boot/vmlinuz-4.15.0-65-generic root=UUID=cc3a13c5-c36c-4021-af14-6ff186f0b4bd ro  console=tty1 console=ttyS0

```

## Useful Commands

List inactive VM
```
virsh list --inactive
```

## Reference
- extlinux for Debian OpenStack Image. http://shallowsky.com/linux/extlinux.html
- virt-rescue for MBR or Image broken. http://libguestfs.org/virt-rescue.1.html
  Use root account for virt-rescue

# Git Access by using SSH
```
eval "$(ssh-agent -s)"
ssh-add .ssh/github_rsa
git clone git@github.com:cplus66/virt-utils.git
```
