### Key Bindings

bindkey -v
bindkey '\e[3~' delete-char
bindkey "^R" history-incremental-search-backward

# Allow deleting past the start char of insert mode
# http://www.zsh.org/mla/users/2009/msg00812.html
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^U" backward-kill-line
bindkey "^K" kill-line

# Emacs line keybindings in insert mode
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# http://www.zsh.org/mla/users/2009/msg01038.html
# Force file completion with C-x f
zle -C complete-files complete-word _generic
zstyle ':completion:complete-files:*' completer _files
bindkey '^xf' complete-files

# Bash-style command editing with C-x-e
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

cdParentKey() {
  pushd .. > /dev/null
  zle reset-prompt
}

zle -N cdParentKey
bindkey "^n" cdParentKey

cdBackKey() {
  popd > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    zle reset-prompt
  fi
}

zle -N cdBackKey
bindkey "^p" cdBackKey

# Ctrl-w - delete a full WORD (including colon, dot, comma, quotes...)
# https://unix.stackexchange.com/a/586378
my-backward-kill-word () {
    # Add pipe, colon, comma, single/double quotes to word chars
    local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>|:,"'"'"
    zle -f kill # Append to the kill ring on subsequent kills.
    zle backward-kill-word
}
zle -N my-backward-kill-word
bindkey '^w' my-backward-kill-word

bindkey "^G" remove_last_history  # Ctrl+G will now remove the last command
