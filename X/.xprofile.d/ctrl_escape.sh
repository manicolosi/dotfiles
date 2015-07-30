# Make caps lock key the control modifier
setxkbmap -option 'caps:ctrl_modifier'

# Make single press on the caps lock key send the escape key
xcape -e 'Caps_Lock=Escape'
