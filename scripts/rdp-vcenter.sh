#!/bin/bash

Server="10.7.0.35"
User="mgk\admkb"


ResX=$(echo "scale=0;($(xrandr | grep " primary " |  awk '{print $4}' | awk -F '+' '{print $1}' | awk -F 'x' '{print $1}'))" | bc)
ResY=$(echo "scale=0;($(xrandr | grep " primary " |  awk '{print $4}' | awk -F '+' '{print $1}' | awk -F 'x' '{print $2}')-40)" | bc)
Size=${ResX}x${ResY}

echo ${Size}

rdesktop -k no -u ${User} ${Server} -r clipboard:PRIMARYCLIPBOARD -K -r disk:down=$HOME/Downloads -g ${Size}
