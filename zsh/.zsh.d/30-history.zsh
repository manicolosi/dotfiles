HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

remove_from_history() {
  # Prevent the specified history line from being
  # saved.
  local HISTORY_IGNORE="${(b)$(fc -ln $1 $1)}"

  # Write out the history to file, excluding lines that
  # match `$HISTORY_IGNORE`.
  fc -W

  # Dispose of the current history and read the new
  # history from file.
  fc -p $HISTFILE $HISTSIZE $SAVEHIST

  # TA-DA!
  print "Deleted '$HISTORY_IGNORE' from history."
}

remove_last_history() {
  remove_from_history "-1"
}

zshaddhistory() {
 if [[ $1 == 'remove_last_history'* ]]; then
   return 1;
 elif [[ $1 == 'remove_from_history'* ]]; then
   return 1;
 else
   return 0;
 fi
}

zle -N remove_last_history
