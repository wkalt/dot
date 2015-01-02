#!/bin/sh
# ~/.xinitrc
# key remaps
eval `cat ~/.fehbg`
xmodmap ~/.xmodmaprc
xset r rate 250 60
/usr/bin/start-pulseaudio-x11
exec i3 --shmlog=size=26214400
