#!/usr/bin/env bash

# check whether gist is installed
gist -v >/dev/null 2>&1 || { echo >&2 "Error: 'gist' is not installed!"; exit 1; }

# check for valid directory
DIRNAME=$1
if [ ! -f $DIRNAME/\#readme.md ]; then
    echo "usage: `basename $0` <dirname>"
    echo "       <dirname>/#readme.md must exist"
    exit 1
fi
cd $DIRNAME

NAME=`head -n 1 \#readme.md`
FILES=`ls * | xargs echo`

# add new or upate a gist
NAME="Owl's Gist"
GISTFILE=gist.id
if [ ! -f $GISTFILE ]; then
    echo "empty" > $GISTFILE

    echo "Uploading new gist"
    INFO=`gist -p -d "$NAME" $GISTFILE`

    GIST=`echo $INFO | sed -n 's/^https:\/\/gist.github.com\/*//p'`
    echo $GIST > $GISTFILE

    TMP_DIR=`mktemp -d`
    git clone git@gist.github.com:$GIST.git $TMP_DIR
    cp $FILES $GISTFILE $TMP_DIR/
    (cd $TMP_DIR; git add .; git commit -m "zoo upload"; git push)
else
    GIST=`cat $GISTFILE`

    echo "Updating gist $GIST"
    TMP_DIR=`mktemp -d`
    git clone git@gist.github.com:$GIST.git $TMP_DIR
    cp $FILES $GISTFILE $TMP_DIR/
    (cd $TMP_DIR; git add .; git commit -m "zoo upload"; git push)
fi

RESULT=$?
if [ $RESULT -eq 0 ]; then
    echo "Gist url: $INFO"
    echo "Share your gist ($GIST) at https://github.com/ryanrhymes/owl"
else
    echo "Failed!"
fi
