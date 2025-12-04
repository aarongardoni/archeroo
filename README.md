# Arch Linux Setup

This is my Arch Linux desktop setup. I was inspired when playing around with [Omarchy](https://omarchy.org) to create my own custom setup from scratch.

![Desktop screenshot](/images/screenshot.png)

## Installation

### Assumptions
- UEFI
- Intel CPU
- Nvidia GPU (Turing)

Follow the [Arch Linux installation guide](https://wiki.archlinux.org/title/Installation_guide).

You can also read through the post install recommendations.

#### Post Arch Install

1. Install packages.
```
./root-install.sh
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

4. Run the user install script.
```
./user-install.sh
```

5. Enjoy!

# TODO: I haven't scripted any of the setup required for starting systemd services etc

