#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d/*; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi

[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources         # update x resources db

# xscreensaver -no-splash &
# xsetroot -cursor_name left_ptr &
# dropboxd &
# $HOME/bin/ton &
# pasystray &
# wicd-client --tray &
# kbdd &

# # Old xmonad Ubuntu stuff
# # set keyboard layouts 0, 1, and 2
# setxkbmap -layout "de,de,us" -variant "nodeadkeys,legacy,"
# exec xmonad

setxkbmap -layout de -model pc105 -variant deadtilde
# exec startxfce4
xbindkeys
# /usr/bin/dropbox &
exec i3
