#!/bin/bash

readonly BASE_DIR=$(dirname $0)
readonly TARGET="$HOME"
readonly ARGS="$@"

install_package() {
  local package=$1

  echo -n "Stowing ${package}... "

  if [ ! -d "$package" ]; then
    echo -e "Directory not found!"
    return 255
  fi

  stow --ignore="install.sh" --target="$TARGET" "$package"

  if [ -x "$package/install.sh" ]; then
    echo -n "Running install script..."
    ./$package/install.sh
  fi

  echo
}

main() {
  cd $BASE_DIR

  local packages
  if [ -n "$ARGS" ]; then
    packages="$ARGS"
  else
    packages=$(ls -d */ | xargs realpath --relative-to=$PWD)
  fi

  for package in $packages; do
    install_package $package
  done
}

main
