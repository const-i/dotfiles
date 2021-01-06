#!/bin/bash

if [[ -z $DISPLAY ]]; then
    if [[ $(tty) = /dev/tty1 ]] || [[ $(tty) = /dev/tty2 ]]; then
        exec startx
    fi
fi
