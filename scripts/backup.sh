#!/bin/sh
DESTHOST=$2
DESTUSER=$1
LOGFILE='backup.log'

backup() {
  SOURCEPATH=$1
  DESTPATH=$2

  echo "Start backup from $SOURCEPATH to $DESTPATH (`/bin/date`)" #>> $LOGFILE

  ls -1A $SOURCEPATH|gxargs -d '\n' -n1 -P4 -I% rsync -axSzi --checksum --no-o --no-p --no-g --no-l --force --delete-excluded --exclude-from /Users/markus/scripts/backup_excludes -e "ssh -T" "$SOURCEPATH%" $DESTUSER@$DESTHOST:$DESTPATH

  echo "Completed $SOURCEPATH to $DESTPATH at: `/bin/date`" #>> $LOGFILE
}

echo "\n\n" >> $LOGFILE
echo "Starting backup script." #>> $LOGFILE

BACKUPID=$3
SOURCEPATH=$4
DESTPATH=$5

RUNTIME=`date +%s`
TESTDIR=$HOME
TESTFILE=$TESTDIR"/backup_token_$BACKUPID"

if [ -f $TESTFILE ]; then
  ORIGTIME=`stat -f "%a" $TESTFILE`
else
  ORIGTIME=0
fi
DIFFERENCE=`expr $RUNTIME - $ORIGTIME`

TIMEBEFOREUPDATE=`expr 3600 \* 24`

PING=`/sbin/ping -c 1 -W 1 $DESTHOST`

WAIT=0

while [ $WAIT -lt 10 ]
do 
    nc -z $DESTHOST 22 && break
    WAIT=$WAIT+1
    echo 'Waiting for remote sshd...' #>> $LOGFILE
    sleep 5 
done

if [[ $DIFFERENCE -gt $TIMEBEFOREUPDATE && $WAIT -lt 10 ]]; then
    touch $TESTFILE
    backup $SOURCEPATH $DESTPATH
    if [ -d "$IMAGESPATH" ]; then
        backup $IMAGESPATH $IMAGESDESTPATH
    fi
    #echo "Difference is now greater than 10 seconds: $DIFFERENCE seconds..."
elif [ $DIFFERENCE -lt $TIMEBEFOREUPDATE ]; then
    echo "$BACKUPID backup is still recent, not updating. (`/bin/date`)" #>> $LOGFILE
fi
