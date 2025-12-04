#!/bin/bash

if [ "$EUID" -eq 0 ]; then
  echo "This script should not be run as root. Please run it as a regular user."
  exit 1
fi

if command -v yay &> /dev/null; then
    echo "yay is installed."
else
    echo "yay is not installed."

    echo
    echo "--- Installing yay"
    echo

    rm -rf yay
    git clone https://aur.archlinux.org/yay.git
    pushd yay
      makepkg -si
    popd
    rm -rf yay
fi

echo
echo "--- Installing packages"
echo

mapfile -t app_pkgs < <(cat packages/aur.packages | sort | uniq)

echo "Syncing yay databases..."
yay -Sy --noconfirm

echo "Starting installation of aur packages..."

yay -S --noconfirm --needed "${app_pkgs[@]}"

echo "Installation complete."

echo
echo "--- Creating sym links"
echo
pushd bin;
  for item in *; do
    # Check if the item is a regular file
    if [ -f "$item" ]; then
      chmod +x $item
      if [ -f "/usr/bin/$item" ]; then
        echo "symbolic link exists for "$(pwd)/$item" -> /usr/bin/$item"
      else
        sudo ln --symbolic --verbose "$(pwd)/$item" /usr/bin/
      fi
    fi
  done
popd

echo
echo "--- Updating desktop applications"
echo

mapfile -t app_pkgs < <(cat packages/aur.packages packages/official.packages | sed 's/-.*//' | sort | uniq)

exceptions=(
  "com.mitchellh.ghostty"
  "org.kde.gwenview"
)

pushd /usr/share/applications;
  for file in *.desktop; do
    # Check if the item is a regular file
    if [ -f "$file" ]; then
      app_stem=${file%.desktop}
      found=false

      for app_pkg in "${app_pkgs[@]}"; do
        if [[ "$app_pkg" == "$app_stem" ]]; then
          found=true
          break
        fi
      done

      for exception in "${exceptions[@]}"; do
        if [[ "$exception" == "$app_stem" ]]; then
          found=true
          break
        fi
      done

      # It's not in apps we want to hide it
      if [[ "$found" == "false" ]]; then
        if grep -q "Hidden=true" $file; then
          echo "hidden already $file"
        else
          echo "hidden $file"
          sudo echo "Hidden=true" | sudo tee -a $file
        fi
      else
        echo "not hidden $file"
      fi
    fi

  done
popd

DIRECTORY="$HOME/.tmux/plugins/tpm"

if [ -d "$DIRECTORY" ]; then
  echo "TPM installed already skipping..."
else
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo
echo "--- Copying files"
echo

echo "creating dirs..."
mkdir -p ~/wallpapers/
mkdir -p ~/screenshots/
mkdir -p ~/videos/

echo "running stow..."
stow --adopt -t ~/wallpapers/ wallpapers/
stow --adopt -t ~ bash
stow --adopt -t ~/.config config/

