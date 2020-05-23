#!/bin/bash
set -x
set -e

sudo mkdir -m 0777 /mnt/data
sudo chown vagrant:vagrant /mnt/data

sudo mkdir -m 0777 /mnt/backup
sudo chown vagrant:vagrant /mnt/backup

# create RAID10 on 4 devices
sudo mkfs.btrfs -f /dev/sdc 
sudo mount /dev/sdc /mnt/data
sudo mkfs.btrfs -f /dev/sdd 
sudo mount /dev/sdd /mnt/backup

# create subvolume
sudo btrfs subvolume create /mnt/data/home

# create initial backup
sudo btrfs subvolume snapshot -r /mnt/data/home /mnt/data/home_backup
sync

sudo btrfs send /mnt/data/home_backup | sudo btrfs receive /mnt/backup

sudo btrfs subvolume list /mnt/data/
sudo btrfs subvolume list /mnt/backup/

# increment backup
sudo btrfs subvolume snapshot -r /mnt/data/home /mnt/data/home_backup_new
sync
sudo btrfs send -p /mnt/data/home_backup /mnt/data/home_backup_new | sudo btrfs receive /mnt/backup

ls -al /mnt/data
ls -al /mnt/backup

sudo btrfs subvolume list /mnt/data/
sudo btrfs subvolume list /mnt/backup/

## delete old, rename new backup
sudo btrfs subvolume delete /mnt/data/home_backup
sudo mv /mnt/data/home_backup_new /mnt/data/home_backup

sudo btrfs subvolume delete /mnt/backup/home_backup
sudo mv /mnt/backup/home_backup_new /mnt/backup/home_backup

ls -al /mnt/data
ls -al /mnt/backup

sudo btrfs subvolume list /mnt/data/
sudo btrfs subvolume list /mnt/backup/



