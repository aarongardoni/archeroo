#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo."
   exit 1
fi

mapfile -t app_pkgs < <(cat packages/official.packages | sort | uniq)

echo "Syncing pacman databases..."
pacman -Sy --noconfirm

echo "Starting installation of official packages..."

pacman -S --noconfirm "${app_pkgs[@]}"

echo "Installation complete."

