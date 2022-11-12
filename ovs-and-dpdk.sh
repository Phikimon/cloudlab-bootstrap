sudo apt update
sudo apt install libnuma-dev python3-pyelftools
sudo apt install meson ninja-build

cd /usr/src/
sudo wget https://fast.dpdk.org/rel/dpdk-21.11.2.tar.xz
sudo tar xf dpdk-21.11.2.tar.xz
export DPDK_DIR=/usr/src/dpdk-stable-21.11.2
cd $DPDK_DIR

export DPDK_BUILD=$DPDK_DIR/build
sudo meson build
sudo ninja -C build
sudo ninja -C build install
sudo ldconfig

cd /usr/src/
sudo wget https://www.openvswitch.org/releases/openvswitch-2.17.3.tar.gz
sudo tar -xf openvswitch-2.17.3.tar.gz
cd openvswitch-2.17.3
sudo ./boot.sh
sudo ./configure --with-dpdk=static
sudo make
sudo make install

sudo mkdir -p /var/log/openvswitch
sudo touch /usr/local/var/log/openvswitch/ovs-vswitch.log

export PATH=$PATH:/usr/local/share/openvswitch/scripts
ovs-ctl start

sudo mkdir -p /usr/local/etc/openvswitch
sudo ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema

sudo mkdir -p /usr/local/var/run/openvswitch
sudo ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
    --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
    --private-key=db:Open_vSwitch,SSL,private_key \
    --certificate=db:Open_vSwitch,SSL,certificate \
    --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
    --pidfile --detach --log-file

sudo ovs-vsctl --no-wait init
sudo ovs-vswitchd --pidfile --detach --log-file
