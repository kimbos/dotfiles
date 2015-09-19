#!/bin/bash


if [[ -d "$HOME/.wine_might6" ]]; then

	WINEDEBUG=fixme-all  WINEARCH=win32 WINEPREFIX=$HOME/.wine_might6 wine32 "C:\GOG Games\Might and Magic 6\MM6.exe" &> $HOME/ss13.log
else
	echo "install"
	#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 winetricks vcrun2008
	#WINEARCH=win32 WINEPREFIX=$HOME/.wine_ss13 wine setup_mm6.exe
fi


