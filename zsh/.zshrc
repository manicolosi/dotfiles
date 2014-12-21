# Load configuration files

for config in $HOME/.{zsh,shell}.d/*(N); do
  source $config
done
