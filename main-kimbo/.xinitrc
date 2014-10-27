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
xmodmap -e "keycode 66 = Super_L"

#trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 2 --transparent true --alpha 0 --tint 0x000000 --height 18 &
#volti &


exec xmonad
