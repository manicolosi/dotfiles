xrdb -merge "$HOME/.Xresources"
for resource in $HOME/.Xresources.d/*; do
  xrdb -merge "$resource"
done
