#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi


xrdb -merge ~/.Xresources

xsetroot -cursor_name left_ptr
setxkbmap -layout no

xmodmap -e "clear Lock" 
xmodmap -e "clear Control"
xmodmap -e "add control = Control_L"
xmodmap -e "keycode 66 = Control_R"
xmodmap -e "add mod3 = Control_R"

exec i3
