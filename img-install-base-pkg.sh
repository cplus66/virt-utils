#!/bin/bash
# Date: Nov 04, 2019
# Author: cplus.shen
# Description: Install debian based package on VM image

virt-customize -v -x --run-command 'sudo apt install -y ifupdown; sudo apt install -y vlan' -a $1
