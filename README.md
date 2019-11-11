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
'''
--- GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+++ GRUB_CMDLINE_LINUX_DEFAULT="console=tty1 console=ttyS0"
'''

## useful Commands

List inactive VM
```
virsh list --inactive
```
