#!/usr/bin/env bash

GIST=$1
DIRNAME=$2

if [ -z $DIRNAME ]; then
  DIRNAME="$HOME/.owl/zoo"
fi
if [ -d $DIRNAME ]; then
  mkdir -p $DIRNAME
fi

if [ -z $GIST ]; then
  echo "usage: `basename $0` <gist_id> <dirname>"
  exit 1
fi

GIST_DIR=$(echo $GIST | tr '/' '-')
MODEL_DIR="$DIRNAME/$GIST_DIR"

if [ -d $MODEL_DIR ]; then
    echo "Warning: $MODEL_DIR already exists, overwriting!"
fi

echo "Downloading the gist to $MODEL_DIR ..."
mkdir -p $MODEL_DIR
wget https://gist.github.com/$GIST/download -O $MODEL_DIR/gist.zip
unzip -o -j $MODEL_DIR/gist.zip -d $MODEL_DIR
rm $MODEL_DIR/gist.zip
echo "Succeed!"
