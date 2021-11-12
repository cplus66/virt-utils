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
ssh-add ~/.ssh/github_rsa
git clone git@github.com:cplus66/virt-utils.git
```
or
```
ssh-agent bash
ssh-add ~/.ssh/github_rsa
```

# VM Network Configuration
## Yocto Systemd Networkd

```
cat << EOF > 20-wired.network
# enp0s3.network
[Match]
Name=enp0s3

[Network]
#DHCP=ipv4
VLAN=vlan1001
EOF
cat << EOF > vlan1001.netdev
[NetDev]
Name=vlan1001
Kind=vlan

[VLAN]
Id=1001
EOF
cat << EOF > vlan1001.network
[Match]
Name=vlan1001

[Network]
DHCP=no
Address=192.168.10.42/24
Gateway=192.168.10.1
DNS=8.8.8.8

LinkLocalAddressing=no
EOF
```

# Create a New VM Host
- hostnamectl set-hostname $HOSTNAME
- edit /etc/hosts
- edit /etc/network/interfaces

# Resize VM Disk Size (Ubuntu 20.04)
- blkid
- parted
- fdisk
- resize2fs
- edit /etc/default/grub.d/40-force-partuuid.cfg
- update-grub
