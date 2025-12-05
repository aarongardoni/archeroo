#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo."
   exit 1
fi

mapfile -t app_pkgs < <(cat packages/official.packages | sort | uniq)

echo "Syncing pacman databases..."
pacman -Sy --noconfirm

echo "Starting installation of official packages..."

pacman -S --noconfirm --needed "${app_pkgs[@]}"

echo "Installation complete."

systemctl enable systemd-resolved
systemctl start systemd-resolved
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
systemctl restart systemd-resolved

cat <<EOF > /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true
EOF
systemctl enable iwd
systemctl start iwd

systemctl enable bluetooth
systemctl start bluetooth

