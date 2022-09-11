#!/bin/bash
# Setup rshim and other things for BlueField

sudo systemctl enable rshim
sudo systemctl start rshim

sudo echo "DISPLAY_LEVEL 1" | sudo tee /dev/rshim0/misc

sudo cp ~/cloudlab-bootstrap/01-netcfg.yaml /etc/netplan
sudo systemctl restart systemd-networkd
sudo netplan apply
