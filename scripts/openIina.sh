#/bin/bash
if [ ! -z "$1" ]; then 
    /Applications/IINA.app/Contents/MacOS/iina-cli --mpv-screen=0 --mpv-geometry=50%+0-0 "$1"
fi
if [ ! -z "$2" ]; then 
    /Applications/IINA.app/Contents/MacOS/iina-cli --mpv-screen=0 --mpv-geometry=50%-0+0 "$2"
fi
if [ ! -z "$3" ]; then 
    /Applications/IINA.app/Contents/MacOS/iina-cli --mpv-screen=0 --mpv-geometry=50%+0+0 "$3"
fi
if [ ! -z "$4" ]; then 
    /Applications/IINA.app/Contents/MacOS/iina-cli --mpv-screen=0 --mpv-geometry=50%-0-0 "$4"
fi
if [ ! -z "$5" ]; then 
    /Applications/IINA.app/Contents/MacOS/iina-cli --mpv-screen=1 --mpv-geometry=1440x960+4000-0 "$5"
fi
if [ ! -z "$6" ]; then 
    /Applications/IINA.app/Contents/MacOS/iina-cli --mpv-screen=1 --mpv-geometry=1440x960+4000-50% "$6"
fi
if [ ! -z "$7" ]; then 
    /Applications/IINA.app/Contents/MacOS/iina-cli --mpv-screen=1 --mpv-geometry=1440x960+4000+0 "$7"
fi

