#!/usr/bin/env bash 

PrimaryMonitorPreference=("LVDS1" "VGA1" "DP-1" "HDMI2")


AllMonitors=($(xrandr | grep "connected" | awk '{print $1}' ))
ConnectedMonitors=($(xrandr | grep " connected" | awk '{print $1}'))


# Detect docking
if [[ ${ConnectedMonitors[*]} == *"LVDS1"* ]] && [[ ${#ConnectedMonitors[*]} -gt 2 ]]; then
	# We assume it is a docking if there is a connected laptop screen + 2 or more external screens
	echo "Docking"
	ConnectedMonitors=("${ConnectedMonitors[@]/"LVDS1"}") # Disable laptop monitor
fi

# Turn off disconnected monitors
for Monitor in ${AllMonitors[*]}
do
	if [[ ${ConnectedMonitors[*]} != *"$Monitor"* ]]; then  
		echo "Disable monitor: $Monitor"
		xrandr --output $Monitor --off
	fi	
done


# Detect primary monitor 
Primary=${ConnectedMonitors[1]}
for Monitor in ${PrimaryMonitorPreference[*]}
do
	if [[ " ${ConnectedMonitors[*]} " == *" $Monitor "* ]]; then
		echo "Primary: $Monitor (by preference)"
		Primary=$Monitor	
		break # There can only be one
	fi
done


# Turn on connected monitors
for Monitor in ${ConnectedMonitors[*]}
do
	if [[ $Monitor == $Primary ]]; then
		echo "Enable primary monitor: $Monitor" >> $HOME/xrandr.log
		xrandr --output $Monitor --auto --primary
	else
		echo "Enable connected monitor: $Monitor" >> $HOME/xrandr.log
		xrandr --output $Monitor --auto --right-of $Primary
	fi
done


# workaround for i3bar not showing if primary monitor is set before i3 is started
if [[ $1 == "i3restart" ]]; then	
	i3-msg restart
fi
