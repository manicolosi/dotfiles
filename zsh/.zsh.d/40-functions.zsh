function truncated_pwd() {
  n=$1 # n = number of directories to show in full (n = 3, /a/b/c/dee/ee/eff)
  dir=${PWD/#${HOME}/\~}

  # split our path on /
  dirs=("${(s:/:)dir}")
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

function prepend_path() {
  path[1,0]=($1(N-/))
}

function title {
  case $TERM in
    xterm*|rxvt*)
      print -Pn "\e]0;$1\a"
      ;;
    screen*)
      print -Pn "\ek$1:q\e\\"
      ;;
  esac
}
