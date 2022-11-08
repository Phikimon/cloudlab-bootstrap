cd /usr/src/
sudo wget https://fast.dpdk.org/rel/dpdk-21.11.2.tar.xz
sudo tar xf dpdk-21.11.2.tar.xz
sudo export DPDK_DIR=/usr/src/dpdk-stable-21.11.2
sudo cd $DPDK_DIR

sudo export DPDK_BUILD=$DPDK_DIR/build
sudo meson build
sudo ninja -C build
sudo ninja -C build install
sudo ldconfig

cd /usr/src/
sudo wget https://www.openvswitch.org/releases/openvswitch-2.17.3.tar.gz
sudo tar -xf openvswitch-2.17.3.tar.gz
cd openvswitch-2.17.3
sudo ./boot.sh
sudo ./configure.sh --with-dpdk=static
sudo make
sudo make install
