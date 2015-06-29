#!/bin/sh
# ~/.xinitrc
eval `cat ~/.fehbg`
xmodmap ~/.xmodmaprc
xset r rate 250 60
/usr/bin/start-pulseaudio-x11
exec i3
