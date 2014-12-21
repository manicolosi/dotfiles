function my_term_title_preexec {
  emulate -L zsh
  setopt extended_glob
  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]}

  title "$CMD"
}

function my_term_title_precmd {
  case $TERM in
    xterm*|rxvt*)
      title "%n@%m:$(truncated_pwd 3)"
      ;;
    screen*)
      title "$(truncated_pwd 1)"
      ;;
  esac
}

autoload -U add-zsh-hook

add-zsh-hook precmd my_term_title_precmd
add-zsh-hook preexec my_term_title_preexec
