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
pushd /usr/share/applications;
  # TODO: This should come from packages or something
  apps=("zen" "slack" "ghostty" "bolt-launcher" "firefox" "nvim" "spotify" "discord")

  for file in *; do
    # Check if the item is a regular file
    if [ -f "$file" ]; then
      found=false

      for app in "${apps[@]}"; do
        if [[ "$file" == *"$app"* ]]; then
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

mkdir -p ~/wallpapers/
mkdir -p ~/screenshots/
mkdir -p ~/videos/

cp -rv config/* ~/.config/
cp -rv wallpapers/* ~/wallpapers/

cp -rv bash/.* ~/
