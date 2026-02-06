prepend_path "/usr/local/bin"
prepend_path "${HOME}/.local/bin"
prepend_path "${HOME}/bin"
prepend_path "/opt/homebrew/opt/curl/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"
