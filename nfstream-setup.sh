#!/bin/bash
# Installs NFStream


sudo apt update
sudo apt install python3.8-venv
cd ~
python3 -m venv env
source env/bin/activate
pip install nfstream
deactivate
