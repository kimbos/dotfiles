#!/usr/bin/env bash 

# TODO: make udev rule for dock/undock

PrimaryMonitorPreference=("LVDS1" "VGA1" "DP-1")

ConnectedMonitors=($(xrandr | grep " connected" | awk '{print $1}'))
DisconnectedMonitors=($(xrandr | grep " disconnected" | awk '{print $1}' ))


# Docking?
if [[ ${ConnectedMonitors[*]} == *"LVDS1"* ]] && [[ ${#ConnectedMonitors[*]} -gt 1 ]]; then
	echo "Docking"
	Docking=True
	ConnectedMonitors=("${ConnectedMonitors[@]/"LVDS1"}")
fi

# Get the primary monitor
if [[ ${#ConnectedMonitors[*]} == 1 ]]; then
	echo "Primary monitor: $Monitor (only monitor)"
	Primary=$Monitor
else
	for Monitor in ${PrimaryMonitorPreference[*]}
	do
		if [[ " ${ConnectedMonitors[*]} " == *" $Monitor "* ]]; then
			echo "Primary: $Monitor (by preference)"
			Primary=$Monitor	
			break # There can only be one
		fi
	done
fi

# Turn on connected monitors
for Monitor in ${ConnectedMonitors[*]}
do
	if [[ $Monitor == $Primary ]]; then
		echo "Enable primary monitor: $Monitor"
		xrandr --output $Monitor --auto --primary
	else
		echo "Enable connected monitor: $Monitor"
		xrandr --output $Monitor --auto --right-of $Primary
	fi
done

# Turn off disconnected monitors
for Monitor in ${DisconnectedMonitors[*]}
do
	echo "Disable monitor: $Monitor"
	xrandr --output $Monitor --off
done

