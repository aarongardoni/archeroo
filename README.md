# Arch Linux Setup

This is my Arch Linux desktop setup. I was inspired when playing around with [Omarchy](https://omarchy.org) to create my own custom setup from scratch.

![Desktop screenshot](/images/screenshot.png)

## Installation

### Assumptions
- UEFI
- Intel CPU
- Nvidia GPU (Turing)
- Wi-Fi

Follow the [Arch Linux installation guide](https://wiki.archlinux.org/title/Installation_guide).

You can also read through the post install recommendations.

#### Post Arch Install

1. Install git.
```
pacman -Sy git sudo neovim
```

2. Update `/etc/sudoers`.
```
## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL

## Same thing without a password
%wheel ALL=(ALL) NOPASSWD: /sbin/reboot, /sbin/poweroff
```

3. Create your user and add them to the wheel group.
```
useradd -m -G wheel -s /bin/bash aaron
```

4. Set a password.
```
passwd aaron
```

5. Change to user.
```
su aaron -
```

6. Clone.
```
mkdir -p ~/.code/
cd ~/code
git clone https://github.com/aarongardoni/archeroo.git
```

7. Install as root.
```
cd archeroo
sudo ./root-install.sh
```

8. Run the user install script.
```
./user-install.sh
```

9. Install tmux plugins.
```
# press the follwing keys
# Super+Shift+Enter -> launcher terminal
tmux
# Control+B Shift+i
```

10. Enjoy!

