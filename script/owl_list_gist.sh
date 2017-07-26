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
  ID=`basename $DIR`
  if [ -f $DIR/readme.md ]; then
    INFO=`head -n 1 $DIR/readme.md`
  fi
  echo -e "$ID\t$INFO"
done
