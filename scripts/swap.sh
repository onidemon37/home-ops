#!/usr/bin/env bash
# File     : remote-exec.bash
# Created  : <2023-08-18 Mon 13:31:00 BST>
# Modified : <2023-10-07 Fri 13:31:00 BST>
# Limb     : home-ops

# Maintainer : 2023 Edino Moniz <edinomoniz@gmail.com>

## Commentary:
#
# This script will create and mount a swap partition from sdb

# Replace sdx with your device name
DEVICE=/dev/sdb

# Create an empty partition on sdx using fdisk
echo "Creating an empty partition on $DEVICE"
sudo fdisk $DEVICE <<EOF
n
p



t
82
w
EOF

# Format the partition with mkswap
echo "Formatting the partition with mkswap"
sudo mkswap $DEVICE

# Get the UUID of the swap partition using blkid
echo "Getting the UUID of the swap partition"
UUID=$(sudo blkid -o value -s UUID $DEVICE)

# Check if the UUID is not empty
if [ -n "$UUID" ]; then
  # Check if the swap partition is already in /etc/fstab
  grep -q "$UUID" /etc/fstab
  # If not, append it to the file
  if [ $? -ne 0 ]; then
    echo "Adding the swap partition to /etc/fstab"
    echo "UUID=$UUID none swap sw 0 0" | sudo tee -a /etc/fstab
  fi
  # Enable the swap partition using swapon
  echo "Enabling the swap partition"
  sudo swapon -U "$UUID"
  # Check the status of the swap partition using free -m
  echo "Checking the status of the swap partition"
  free -m
else
  # If no UUID is found, print a message
  echo "No UUID found for $DEVICE"
fi

