#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.

# Source the Xprofile
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Source the Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources


#exec i3
exec bspwm
#exec awesome
#exec startxfce4
