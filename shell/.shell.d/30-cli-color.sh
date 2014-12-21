# Color output

case "${OSTYPE}" in
  darwin*)
    export CLICOLOR=1
    ;;
  linux*)
    alias ls='ls --color=auto'
    ;;
esac

alias grep='grep --color'
