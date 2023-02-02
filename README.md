# cloudlab-bootstrap

This repo contains a collection of scripts used to setup and automate certain tasks in the SmartNIC analytics FYP project, on CloudLab.
Some of the scripts here is based on the shell script in [this repo](https://github.com/cslev/smartnic_cloudlab) by Dr. Levente Csikor.

# Sequence of scripts

This is the rough order the scripts are meant to be run, when starting with a fresh setup on CloudLab.

## On the host

1. `mellanox-setup.sh`. This installs `MLNX_OFED`, which also gives us the `rshim` driver. 
2. `rshim-bluefield-setup.sh`. Ensures rshim is up and running. Configures packet forwarding to the BlueField so that the BlueField can access the internet.
3. `os-install.sh`. Installs ubuntu on the BlueField (username `ubuntu`, password `Ubuntu1!`). Re-installing the OS might not be necessary.
4. If DPDK/Pktgen is needed, `dpdk-and-pktgen-x86-install.sh`.

## In the BlueField

Once we can ssh into the BlueField, we can install DPDK/Pktgen there: `dpdk-and-pktgen-arm-install.sh`. 

# Other scripts

- `switch_mode.sh`: simple script to switch modes.
- `ovs-and-dpdk.sh`: installs DPDK, and OvS (from source) configured to support DPDK datapath. (For x86 machine).
- `nfstream-setup.sh`: simple script to install NFStream.
