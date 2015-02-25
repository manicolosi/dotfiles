# Make caps lock key the control modifier
setxkbmap -option 'caps:ctrl_modifier'

# Make single press on the caps lock key send the escape key
xcape -e 'Caps_Lock=Escape'

# Disable left control key
xmodmap -e 'keycode 37='

# TODO: Disable escape key. This breaks xcape, one solution would be to map
# escape to a keycode the keyboard cannot send first.
#xmodmap -e 'keycode 9='

# TODO: Should map actual left control and escape keys to some useful functions.
