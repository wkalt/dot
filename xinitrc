#!/bin/sh
# ~/.xinitrc
~/.fehbg
/usr/bin/urxvtd -q -f -o
xmodmap ~/.xmodmaprc
xset r rate 250 60
/usr/bin/start-pulseaudio-x11
exec i3
