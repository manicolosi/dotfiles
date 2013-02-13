### Options

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U add-zsh-hook
autoload -Uz vcs_info

setopt prompt_subst            # Allow substitutions in prompt
setopt transient_rprompt       # Hide rprompt after command

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

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn

function zsh_git_prompt_precmd {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats '%K{black}%u%c %F{green}%b%k '
  } else {
    zstyle ':vcs_info:*' formats '%K{black}%F{red}●%u%c %F{green}%b%k '
  }

  vcs_info
}
precmd_functions+='zsh_git_prompt_precmd'

PROMPT='${vcs_info_msg_0_}%{$reset_color%}%{%b%f%}%{%F{blue}%}$(truncated_pwd 3)%f%b ${VI_MODE_PROMPT} '

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

VI_MODE_CMD='%F{yellow}#'
VI_MODE_INS='%F{white}%%'
VI_MODE_PROMPT=$VI_MODE_INS

# When Zsh starts up this isn't display until the next prompt. Also if cmd
# mode is entered and then the next prompt is shown, it still shows that cmd
# mode is enabled even though its in insert mode.
function zle-line-init zle-keymap-select {
    VI_MODE_PROMPT="${${KEYMAP/vicmd/${VI_MODE_CMD}}/(main|viins)/${VI_MODE_INS}}%f"
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

export ANDROID_SDK="$HOME/lib/android-sdk"

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

### Environmental Variables

# TODO: Make sure the terminal supports this first
# TODO: This should be depended on the current TERM, so we don't set
# screen-256color to xterm-256color
#export TERM="xterm-256color"

export EDITOR="vim"
export PATH="$HOME/bin:/usr/local/bin:$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools"
typeset -U PATH

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Syntax Highlighting

#source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
