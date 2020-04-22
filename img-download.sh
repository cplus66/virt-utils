#!/bin/bash -xe
# Date: Apr 22, 2020
# Author: cplus.shen
# Description: download image from server

if [ $# -ne 1 ]; then
  echo "Usage: $0 <u18|u16|centos-7>"
  exit 1
fi

case "$1" in
  u18)
    wget http://172.17.5.195/tftp/IMAGE/bionic-server-cloudimg-amd64_0.3.img
    ;;
  u16)
    wget http://172.17.5.195/tftp/IMAGE/xenial-server-cloudimg-amd64-disk1_0.2.img
    ;;
  centos-7)
    wget http://172.17.5.195/tftp/IMAGE/CentOS-7-x86_64-GenericCloud-1907_0.2.qcow2
    ;;

  *)
    ;;
esac

exit 0
