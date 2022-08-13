#!/bin/bash
# Installs drivers etc.

cd /opt
sudo wget http://www.mellanox.com/downloads/ofed/MLNX_OFED-5.3-1.0.0.1/MLNX_OFED_LINUX-5.3-1.0.0.1-ubuntu20.04-x86_64.tgz
sudo tar -xzvf MLNX_OFED_LINUX-5.3-1.0.0.1-ubuntu20.04-x86_64.tgz

cd MLNX_OFED_LINUX-5.3-1.0.0.1-ubuntu20.04-x86_64
sudo ./mlnxofedinstall --auto-add-kernel-support --without-fw-update --force

cd ~
sudo /etc/init.d/openibd restart

sudo systemctl enable rshim
sudo systemctl start rshim

sudo echo "DISPLAY_LEVEL 1" | sudo tee /dev/rshim0/misc

sudo cp ~/cloudlab-bootstrap/01-netcfg.yaml /etc/netplan
sudo systemctl restart systemd-networkd
sudo netplan apply

sudo wget https://content.mellanox.com/BlueField/BFBs/Ubuntu20.04/DOCA_v1.0_BlueField_OS_Ubuntu_20.04-5.3-1.0.0.0-3.6.0.11699-1-aarch64.bfb
sudo cp ~/cloudlab-bootstrap/bf.cfg ~
apt-get install pv
bfb-install --rshim /dev/rshim0 --bfb DOCA_v1.0_BlueField_OS_Ubuntu_20.04–5.3–1.0.0.0–3.6.0.11699–1-aarch64.bfb --config bf.cfg
