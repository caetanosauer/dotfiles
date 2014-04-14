#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d/*; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
     --expand true --width 10 --transparent true --tint 0x191970 --height 12 &

xrdb -merge ~/.Xresources         # update x resources db

xscreensaver -no-splash &
xsetroot -cursor_name left_ptr &
dropboxd &

exec xmonad
