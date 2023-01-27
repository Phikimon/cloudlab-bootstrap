#!/bin/bash
# Setup rshim, as well as forwarding for the BlueField, so that we can access the internet
# from within the Arm cores. This script is meant to be run after reinstalling the OS 
# on the BlueField (e.g., with the os-install.sh script)

sudo systemctl enable rshim
sudo systemctl start rshim

sudo echo "DISPLAY_LEVEL 1" | sudo tee /dev/rshim0/misc

sudo cp ~/cloudlab-bootstrap/01-netcfg.yaml /etc/netplan
sudo systemctl restart systemd-networkd
sudo netplan apply

sudo echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -A POSTROUTING -o eno1 -j MASQUERADE
sudo iptables -A FORWARD -o eno1 -j ACCEPT
sudo iptables -A FORWARD -m state --state ESTABLISHED,RELATED -i eno1 -j ACCEPT
