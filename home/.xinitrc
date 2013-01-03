[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
VBoxClient-all &
exec openbox-session
