#!/bin/bash
# Setup rshim and other things for BlueField

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

