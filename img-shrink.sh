#!/bin/bash
mv $1 $1.backup
sudo qemu-img convert -O qcow2 -c $1.backup $1
rm -f $1.backup
