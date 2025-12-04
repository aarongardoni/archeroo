#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ]; then
  export GTK_THEME=Adwaita:dark
  exec river > ~/.river.log 2>&1
fi
