# Load configuration files

for config in $HOME/.{zsh,shell}.d/*(N); do
  source $config
done

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

. "$HOME/.local/bin/env"
