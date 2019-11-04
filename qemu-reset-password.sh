#!/bin/bash -xe
# Date: Nov 01, 2019
# Author: cplus.shen
# Description: reset root password

if [ $# -ne 2 ]; then
  echo OS={centos|ubuntu} $0 IMAGE_NAME PASSWORD  
  exit 1
fi

sudo virt-customize --root-password password:$2 -a $1

if [ "x$OS" == "x" ]; then
  OS=ubuntu
fi

if [ $OS == "ubuntu" ]; then
  sudo virt-customize -v -x --run-command 'sudo apt-get remove -y cloud-init' -a $1
else
  sudo virt-customize -v -x --run-command 'sudo yum remove -y cloud-init' -a $1
fi
