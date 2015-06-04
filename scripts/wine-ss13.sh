#!/bin/bash

#apt-get install wine winetricks
#dpkg --add-architecture i386
#apt-get update
#apt-get install wine32

#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 wineboot
#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks corefonts
#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks allfonts
#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks wsh56 wsh57 jscript mfc42 vcrun6
#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks ie7
#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks ie8

#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 wine 501_byond.exe


WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 wine32 "C:\Program Files\BYOND\bin\byond.exe"
