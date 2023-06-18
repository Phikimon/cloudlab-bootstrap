#!/usr/bin/bash

set -x

# Commands that could be required but without which you
# would not be able to clone this repo:
#
# sudo ip addr add 192.168.100.2/30 dev tmfifo_net0
# sudo ip route add default via 192.168.100.1
# echo 'nameserver 8.8.8.8' | sudo tee /etc/resolv.conf
cd ~
git clone https://github.com/Phikimon/dot_files/
mv ./dot_files/.vimrc .
echo "export VISUAL=vim" | tee -a ~/.bashrc
echo "export EDITOR=vim" | tee -a ~/.bashrc
