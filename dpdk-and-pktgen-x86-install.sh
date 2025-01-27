#!/usr/bin/bash
# Installs DPDK and Pktgen on an x86 machine
set -x

sudo apt update -y
sudo apt install -y libnuma-dev python3-pyelftools meson ninja-build liblua5.3-dev libcjson-dev

cd /opt
sudo wget https://fast.dpdk.org/rel/dpdk-22.11.2.tar.xz
sudo tar -xJvf dpdk-22.11.2.tar.xz
cd dpdk-stable-22.11.2
export RTE_SDK=/opt/dpdk-stable-22.11.2
export RTE_TARGET=x86_64-native-linuxapp-gcc
meson build
ninja -C build
ninja -C build install
ldconfig

cd ..
sudo git clone https://github.com/Phikimon/Pktgen-DPDK
cd Pktgen-DPDK
sudo git checkout tune_range
sudo make buildlua
sudo ldconfig

cd Builddir/
sudo ninja install

cd ~

echo 4096 | sudo tee /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
