function __sha1sum {
  hash sha1sum 2>/dev/null
  if [[ $? -eq 0 ]]; then
    sha1sum "$@"
  else
    shasum "$@"
  fi
}

function __source {
  __sourcing=true
  source $1
  unset __sourcing
}

function confirm_source_envfile {
  if [[ -n "$__sourcing" ]]; then
    return
  fi

  if [ -f "$1" ]; then
    local file=$(realpath $1)
    touch $HOME/.envfiles

    local line=$(grep "$file" $HOME/.envfiles | head -n1)
    if [[ -n "$line" ]]; then
      grep "$file" $HOME/.envfiles | head -n1 | __sha1sum -c &> /dev/null
      if [[ $? -eq 0 ]]; then
        echo "Trusted envfile file found: $file. Sourcing."
        __source "$file"
      else
        echo "Trusted envfile file found: $file. SHA1 doesn't match!"
      fi
    else
      echo "Untrusted envfile file found: $file"
      read -k1 "cmd?Source/Trust/Nope it? [s/t/n] "
      echo
      if [[ "$cmd" = "s" ]]; then
        __source "$file"
      elif [[ "$cmd" = "t" ]]; then
        __source "$file"
        __sha1sum "$file" >> ~/.envfiles
      fi
    fi
  fi
}

function source_envfile {
  local dir=$(pwd)
  confirm_source_envfile "$dir/Envfile"
  confirm_source_envfile "$dir/../Envfile"
}

autoload -U add-zsh-hook

add-zsh-hook chpwd source_envfile

source_envfile
