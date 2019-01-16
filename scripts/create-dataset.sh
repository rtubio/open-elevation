#!/usr/bin/env bash

DATA_DIR="$1"

if [ ! -e "$DATA_DIR" ] ; then
    echo "$DATA_DIR does not exist!"
    exit -1
fi

for i in $DATA_DIR/*.tif
do
  echo "Processing $i..."
  bash scripts/create-tiles.sh "$i" 10 10
  mv -f "$i" "$i.bak"
done
