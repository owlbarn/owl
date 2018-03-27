#!/usr/bin/env bash

DIRNAME=$1

if [ -z $DIRNAME ]; then
  DIRNAME="$HOME/.owl/zoo"
fi
if [ -d $DIRNAME ]; then
  mkdir -p $DIRNAME
fi

DIRS=`ls -d $DIRNAME/* | xargs echo`

for DIR in $DIRS; do

  if [ -f $DIR ]; then
    continue;
  fi

  ID=`basename $DIR`
  SUBDIR=`ls -dt $DIR/* | head -n 1 | xargs echo`

  if [ -f $DIR/\#readme.md ]; then
    INFO=`head -n 1 $DIR/\#readme.md`
  elif [ -f $SUBDIR/\#readme.md ]; then
    INFO=`head -n 1 $SUBDIR/\#readme.md`
  else
    INFO=""
  fi
  echo -e "$ID\t$INFO"
done
