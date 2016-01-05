#!/bin/bash

function _find_up() {
  filename=$1

  pushd $PWD 2>&1 > /dev/null

  while [ ! -f $filename -a "$PWD" != "/" ]; do
    cd ..
  done

  if [ -f $filename ]; then
    echo "$PWD/$filename"
  fi

  popd 2>&1 > /dev/null
}

function _make() {
  makefile=$(_find_up Makefile)

  if [ -z "$makefile" ]; then
    return 1
  fi

  make -f $makefile "$@"
}

alias m="_make"
