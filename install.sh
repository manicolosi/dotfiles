#!/bin/bash

BASE_DIR=$(dirname $0)
cd $BASE_DIR

TARGET=$HOME
PACKAGES=$(ls -d */ | xargs realpath --relative-to=$PWD)

for PACKAGE in $PACKAGES; do
  echo "Stowing $PACKAGE..."
  stow --ignore="install.sh" --target="$TARGET" "$PACKAGE"

  if [ -x "$PACKAGE/install.sh" ]; then
    echo "Running install script"
    ./$PACKAGE/install.sh
  fi
done
