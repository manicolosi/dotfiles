### Syntax Highlighting

case "${OSTYPE}" in
  darwin*)
    # source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
  linux*)
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
esac

ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
