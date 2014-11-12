#!/bin/sh

TPM_REPO="https://github.com/tmux-plugins/tpm"
TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
  git clone "$TPM_REPO" "$TPM_DIR"
fi
