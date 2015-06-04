#!/usr/bin/env bash 

LAPTOP="LVDS1"
VGA1="VGA1"
HDMI3="HDMI3"
DP1="DP-1"

if (xrandr | grep "$LAPTOP connected"); then
	echo "active: laptop"
	#xbacklight -set 100
	xrandr --output $VGA1 --off
	xrandr --output $HDMI3 --off
	xrandr --output $LAPTOP --auto --primary
elif (xrandr | grep "$DP1 connected"); then
	echo "active: DPI"
	xrandr --output $DP1 --auto --primary 
else 
	echo "active: docking"
	xrandr --output $LAPTOP --off
	xrandr --output $HDMI3 --auto
	xrandr --output $VGA1 --auto --left-of $HDMI3 --primary
fi

