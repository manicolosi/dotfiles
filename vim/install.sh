#!/bin/sh

VUNDLE_REPO="https://github.com/gmarik/Vundle.vim.git"
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"

if [ ! -d "$VUNDLE_DIR" ]; then
  git clone "$VUNDLE_REPO" "$VUNDLE_DIR"
fi

vim +PluginInstall +qall
