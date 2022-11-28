[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
  # exec startwl
	#XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland
fi
