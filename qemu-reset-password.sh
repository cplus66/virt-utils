#!/bin/bash -xe
sudo virt-customize --root-password password:qwerty -a $1
sudo virt-customize -v -x --run-command 'sudo apt-get remove -y cloud-init' -a $1
sudo virt-customize -v -x --run-command 'sudo yum remove -y cloud-init' -a $1
