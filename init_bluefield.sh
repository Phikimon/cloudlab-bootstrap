#!/usr/bin/bash

set -x

echo 'nameserver 8.8.8.8' | sudo tee /etc/resolv.conf
cd ~
git clone https://github.com/Phikimon/dot_files/
mv ./dot_files/.vimrc .
echo "export VISUAL=vim" | tee -a ~/.bashrc
echo "export EDITOR=vim" | tee -a ~/.bashrc
