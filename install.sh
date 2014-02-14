#!/bin/bash

BASE_DIR=$(dirname $0)
cd $BASE_DIR

TARGET=$HOME
PACKAGES=$(ls -d */ | xargs realpath --relative-to=$PWD)

for PACKAGE in $PACKAGES; do
  echo "Stowing $PACKAGE..."
  stow --target=$TARGET $PACKAGE
done
