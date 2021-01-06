#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.

# Source the Xprofile
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Source the Xresources
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources

if [ "$(tty)" = "/dev/tty1" ]; then 
    exec bspwm
elif [ "$(tty)" = "/dev/tty2" ]; then
    exec startxfce4
fi
