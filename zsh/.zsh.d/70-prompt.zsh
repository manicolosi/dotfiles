# Vi-mode

VI_MODE_CMD='%F{yellow}#'
VI_MODE_INS='%F{white}%%'
VI_MODE_PROMPT=$VI_MODE_INS

function zle-line-init zle-keymap-select {
    VI_MODE_PROMPT="${${KEYMAP/vicmd/${VI_MODE_CMD}}/(main|viins)/${VI_MODE_INS}}%f"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# VCS Info

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn

function zsh_git_prompt_precmd {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats '%u%c %F{green}%b%k '
  } else {
    zstyle ':vcs_info:*' formats '%F{red}●%u%c %F{green}%b%k '
  }

  vcs_info
}

autoload -U add-zsh-hook

add-zsh-hook precmd zsh_git_prompt_precmd

function prompt_user_at_host {
  if [ -n "${SSH_CONNECTION}" ]; then
    echo "%{%F{yellow}%}%n%{$reset_color%}@%{%F{yellow}%}%m%{$reset_color%} "
  fi
}


function git_initials {
  initials=$(git config --get user.initials)
  if [[ -n "${initials}" ]]; then
    echo "%{%F{red}%}${initials}%{$reset_color%} "
  fi
}

# Prompt

PROMPT='$(prompt_user_at_host)$(git_initials)${vcs_info_msg_0_# }%{$reset_color%}%{%b%f%}%{%F{blue}%}$(truncated_pwd 3)%f%b ${VI_MODE_PROMPT} '
