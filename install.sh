#!/bin/bash

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

echo
echo "--- Copying files"
echo

echo "creating dirs..."
mkdir -p ~/wallpapers/
mkdir -p ~/screenshots/
mkdir -p ~/videos/

echo "running stow..."
stow -t ~/wallpapers/ wallpapers/
stow -t ~ bash
stow -t ~/.config config/
