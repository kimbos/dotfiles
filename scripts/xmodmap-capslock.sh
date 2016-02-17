

xmodmap -e "clear Lock" 
xmodmap -e "clear Control"
xmodmap -e "add control = Control_L"
xmodmap -e "keycode 66 = Control_R"
xmodmap -e "add mod3 = Control_R"
