#!/bin/bash
# Installs drivers etc.

cd /opt
sudo wget http://www.mellanox.com/downloads/ofed/MLNX_OFED-5.3-1.0.0.1/MLNX_OFED_LINUX-5.3-1.0.0.1-ubuntu20.04-x86_64.tgz
sudo tar -xzvf MLNX_OFED_LINUX-5.3-1.0.0.1-ubuntu20.04-x86_64.tgz

cd MLNX_OFED_LINUX-5.3-1.0.0.1-ubuntu20.04-x86_64
sudo ./mlnxofedinstall --auto-add-kernel-support --without-fw-update --force

cd ~
sudo /etc/init.d/openibd restart
