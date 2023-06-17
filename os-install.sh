#!/bin/bash
# Reinstalls the OS on the BlueField.
# SSH Username: ubuntu
# Password: Ubuntu1!

set -x

sudo wget https://content.mellanox.com/BlueField/BFBs/Ubuntu20.04/DOCA_v1.0_BlueField_OS_Ubuntu_20.04-5.3-1.0.0.0-3.6.0.11699-1-aarch64.bfb
sudo cp ~/cloudlab-bootstrap/bf.cfg ~
apt-get install pv
bfb-install --rshim /dev/rshim0 --bfb DOCA_v1.0_BlueField_OS_Ubuntu_20.04-5.3-1.0.0.0-3.6.0.11699-1-aarch64.bfb --config bf.cfg
