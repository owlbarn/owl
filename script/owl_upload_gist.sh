#!/usr/bin/env bash

# check whether gist is installed
gist -v >/dev/null 2>&1 || { echo >&2 "Error: 'gist' is not installed!"; exit 1; }

# check for valid directory
DIRNAME=$1
if [ ! -f $DIRNAME/readme.md ]; then
    echo "usage: `basename $0` <dirname>"
    echo "       <dirname>/readme.md must exist"
    exit 1
fi
cd $DIRNAME

# force to log into github
gist --login

NAME=`head -n 1 readme.md`
FILES=`ls * | xargs echo`

# add new or upate a gist
GISTFILE=gist.id
if [ ! -f $GISTFILE ]; then
    echo "empty" > $GISTFILE

    echo "Uploading new gist"
    INFO=`gist -p -d "$NAME" $FILES $GISTFILE`
    echo $INFO

    GIST=`echo $INFO | sed -n 's/^https:\/\/gist.github.com\/*//p'`
    echo $GIST > $GISTFILE
    gist -u $GIST $GISTFILE
else
    GIST=`cat $GISTFILE`
    echo "Updating gist $GIST"
    gist -u $GIST -d "$NAME" $FILES
fi

RESULT=$?
if [ $RESULT -eq 0 ]; then
    echo "Succeed! Share your gist at https://???"
else
    echo "Failed!"
fi
