#!/bin/bash
set -x
set -e

sudo mkdir -m 0777 /mnt/raid
sudo chown vagrant:vagrant /mnt/raid

# create RAID10 on 4 devices
sudo mkfs.btrfs -f -m raid10 -d raid10 /dev/sdc /dev/sdd /dev/sde /dev/sdf 
sudo mount /dev/sdc /mnt/raid

# check filesystem info
btrfs filesystem df /mnt/raid

