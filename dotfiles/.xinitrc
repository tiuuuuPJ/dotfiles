#!/bin/sh

[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

xrdb -merge ~/.Xresources
fcitx -rd &
exec xmonad
