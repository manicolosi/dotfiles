### Options

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U add-zsh-hook

setopt prompt_subst

### History

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt inc_append_history
setopt share_history

### Prompt

# From: http://www.reddit.com/r/zsh/comments/vopro/truncated_path_in_zsh_prompt/c5ecfb3
function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

# TODO: Prevent vars from being in global namespace
function truncated_pwd() {
  n=$1 # n = number of directories to show in full (n = 3, /a/b/c/dee/ee/eff)
  path2=$(collapse_pwd)

  # split our path on /
  dirs=("${(s:/:)path2}")
  dirs_length=$#dirs

  if [[ $dirs_length -ge $n ]]; then
    # we have more dirs than we want to show in full, so compact those down
    ((max=dirs_length - n))
    for (( i = 1; i <= $max; i++ )); do
      step="$dirs[$i]"
      if [[ -z $step ]]; then
        continue
      fi
      if [[ $step =~ "^\." ]]; then
        dirs[$i]=$step[0,2] #make .mydir => .m
      else
        dirs[$i]=$step[0,1] # make mydir => m
      fi

    done
  fi

  echo ${(j:/:)dirs}
}

PROMPT='%{%B%F{yellow}%}%n%{%b%f%}@%{%B%F{yellow}%}%m %{%F{blue}%}$(truncated_pwd 3)%{%b%f%} %% '

### Terminal Window Title

function title {
  case $TERM in
    xterm*)
      print -Pn "\e]0;$1\a"
      ;;
    screen)
      print -Pn "\ek$1:q\e\\"
      ;;
  esac
}

function my_term_title_preexec {
  emulate -L zsh
  setopt extended_glob
  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]}

  title "$CMD"
}

function my_term_title_precmd {
  title $(truncated_pwd 1)
}

add-zsh-hook precmd my_term_title_precmd
add-zsh-hook preexec my_term_title_preexec

### Vi Mode

function zle-line-init zle-keymap-select {
    RPS1="%{$fg_bold[green]%}${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}%{$reset_color%}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

### Key Bindings

bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

### Software Configuration

# Go
export GOPATH="$HOME/.go"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Android SDK

export ANDROID_SDK="$HOME/lib/android-sdks"

# Color output

case "${OSTYPE}" in
  darwin*)
    export CLICOLOR=1
    ;;
  linux*)
    alias ls='ls --color'
    ;;
esac

alias grep='grep --color'

### Aliases

alias ll='ls -lh'
alias la='ls -A'

alias t="todo.sh"

### Environmental Variables

# TODO: Make sure the terminal supports this first
# TODO: This should be depended on the current TERM, so we don't set
# screen-256color to xterm-256color
#export TERM="xterm-256color"

export EDITOR="vim"
export PATH="$HOME/bin:/usr/local/bin:$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools"
typeset -U PATH
