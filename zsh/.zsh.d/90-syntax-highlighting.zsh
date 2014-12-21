### Syntax Highlighting

case "${OSTYPE}" in
  darwin*)
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
  linux*)
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
esac

ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
