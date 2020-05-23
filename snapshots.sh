#!/bin/bash
set -e
set -x

sudo btrfs subvolume create /data/subvol
sudo btrfs subvolume create /data/backups

# create file
sudo touch /data/subvol/test_file_1

# create read-only backup snapshot
sudo btrfs subvolume snapshot -r /data/subvol /data/backups/subvol

sudo btrfs subvolume list /data/ 

# check content
ls -al /data/subvol
ls -al /data/backups/subvol

# delete test file
sudo rm /data/subvol/test_file_1

ls -al /data/subvol
ls -al /data/backups/subvol

# restore backup
sudo btrfs subvolume delete /data/subvol
sudo btrfs subvolume snapshot /data/backups/subvol /data/subvol

# check after restore
ls -al /data/subvol
ls -al /data/backups/subvol


# clean up after script
sudo btrfs subvolume delete /data/subvol
sudo btrfs subvolume delete /data/backups/subvol/
sudo btrfs subvolume delete /data/backups
