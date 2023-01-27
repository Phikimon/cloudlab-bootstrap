#!/usr/bin/bash
# Installs DPDK and Pktgen on an Arm machine

sudo apt update
sudo apt install libnuma-dev python3-pyelftools
sudo apt install meson ninja-build

cd /opt
wget https://fast.dpdk.org/rel/dpdk-20.11.1.tar.xz
tar -xJvf dpdk-20.11.1.tar.xz
cd dpdk-stable-20.11.1
export RTE_SDK=/opt/dpdk-stable-20.11.1
export RTE_TARGET=arm64-armv8a-linuxapp-gcc
meson -Dexamples=all build
ninja -C build
ninja -C build install
ldconfig

cd ..
wget https://git.dpdk.org/apps/pktgen-dpdk/snapshot/pktgen-dpdk-pktgen-21.02.0.tar.xz
tar -xJvf pktgen-dpdk-pktgen-21.02.0.tar.xz

# Manually editing these files to solve errors.
sudo sed -i '9d' /usr/local/include/rte_spinlock.h
sudo sed -i '9d' /usr/local/include/rte_atomic_32.h

cd pktgen-dpdk-pktgen-21.02.0
make
make install

cd /opt/pktgen-dpdk-pktgen-21.02.0/Builddir
sudo ninja install

cd ~

echo 1024 | sudo tee /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages