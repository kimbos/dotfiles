#!/bin/bash


if [[ -d "$HOME/.wine2_ss13" ]]; then
	WINEDEBUG=fixme-all  WINEARCH=win32 WINEPREFIX=$HOME/.wine2_ss13 wine "C:\Program Files\BYOND\bin\byond.exe"
else
	echo "install"
	#sudo apt-get install wine winetricks
	#sudo dpkg --add-architecture i386
	#sudo apt-get update


	#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 wineboot
	#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks corefonts
	#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks allfonts
	#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks wsh56 wsh57 jscript mfc42 vcrun6
	#not needed? WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks ie7
	#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks ie8

	#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 wine 501_byond.exe
fi


