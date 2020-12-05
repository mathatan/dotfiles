#!/bin/sh
user=$2
server=$3
localport=1202

if [ "$1" = "start" ]; then
    ssh -f -N -L $localport:localhost:5900 $user@$server
    open vnc://$user@localhost:$localport
elif [ "$1" = "stop" ]; then 
    kill -9 `pgrep -f $localport:localhost:5900`
else
    echo "Usage: vncTunneling.sh [start|stop] [user] [server]"
fi
