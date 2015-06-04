#!/usr/bin/env bash 

# TODO: make udev rule for dock/undock

PrimaryMonitorPreference=("LVDS" "VGA" "DP-1")

ConnectedMonitors=($(xrandr | grep " connected" | awk '{print $1}'))
DisconnectedMonitors=($(xrandr | grep " disconnected" | awk '{print $1}' ))


# Turn off disconnected monitors
for Monitor in ${DisconnectedMonitors[*]}
do
	echo "Disable disonnected monitor: $Monitor"
	xrandr --output $Monitor --off
done

# Turn on connected monitors
for Monitor in ${ConnectedMonitors[*]}
do
	echo "Enable connected monitor: $Monitor"
	xrandr --output $Monitor --auto
done

# Set primary monitor
if [[ ${#ConnectedMonitors[*]} == 1 ]]; then
	echo "Set primary monitor: $Monitor (only monitor)"
	xrandr --output $Monitor --primary
else 
	for Monitor in ${PrimaryMonitorPreference[*]}
	do
		if [[ " ${ConnectedMonitors[*]} " == *" $Monitor "* ]]; then
			echo "   Set Primary (by preference)"
			xrandr --output $Monitor --primary
			break # There can only be one
		fi
	done
fi



