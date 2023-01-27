#!/usr/bin/bash
# Run this script on the host machine. Switches the BlueField to Separated Host Mode or Embedded CPU Mode.
# Usage: ./switch_mode.sh separated or ./switch_mode.sh embedded

FILENAMES=$(sudo mst status -v | grep BlueField2 | grep -o "/dev/mst/[a-zA-Z0-9_.]*")

if [ $1 == "separated" ]
then
        MODE=0
else
        MODE=1
fi

for PORT in $FILENAMES
do
        sudo mlxconfig -y -d $PORT s INTERNAL_CPU_MODEL=$MODE
done