function setup() {
  local theme_file=$(cat ~/.shell-theme)
  source $theme_file
}

function change_theme() {
  local root_dir="$HOME/code/base16-shell/scripts"
  local theme=$1

  echo "${root_dir}/base16-${theme}.sh" > ~/.shell-theme

  echo "set background=dark" > ~/.vim_theme
  echo "colorscheme base16-${theme}" >> ~/.vim_theme

  setup
}

setup
