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

# Use xev to get keycodes/names
xmodmap -e "clear Lock" 
xmodmap -e "clear Control"
xmodmap -e "add control = Control_L"
xmodmap -e "keycode 66 = Control_R"
xmodmap -e "add mod3 = Control_R"
#xmodmap -e "keycode 66 = Super_L" # keycode 66 = Caps Lock
#xmodmap -e "keycode 66 = Num_Lock" # keycode 66 = Caps Lock

exec i3
