function setup() {
  local theme_file=$(cat ~/.shell-theme)
  source $theme_file
}

function change_theme() {
  local root_dir="$HOME/code/base16-shell"
  local theme=$1
  local mood=$2

  echo "${root_dir}/base16-${theme}.${mood}.sh" > ~/.shell-theme

  echo "set background=${mood}" > ~/.vim_theme
  echo "colorscheme base16-${theme}" >> ~/.vim_theme

  setup
}

setup
