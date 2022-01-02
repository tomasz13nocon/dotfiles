#!/bin/sh

xrdb ~/.Xresources
# Polish layout,
# swap caps lock with escape,
# kill xorg with ctrl-alt-backspace,
# have numpad "del" key output dot, not comma,
# use numpad without numlock
setxkbmap pl -option caps:swapescape -option terminate:ctrl_alt_bksp -option kpdl:dot -option numpad:mac
# Bind keys specified in .xbindkeysrc
xbindkeys
# Adjust scrolling speed
echo 2 > /tmp/libinput_discrete_deltay_multiplier
# Compositor
#picom -b --experimental-backends
# Wallpaper
#feh --bg-fill ~/Pictures/wallpaper.jpg
# Live wallpaper
#xwinwrap -g 1920x1080 -ni -ov -- mpv --hwdec=auto --loop=inf -wid WID ~/Pictures/wallpaperlive.mp4 &
# Flash windows on focus change
#flashfocus &
#alttab &
# Unified Remote
/opt/urserver/urserver --daemon
# Keystroke repeat delay
xset r rate 250
# Enable MangoHud in all vulkan programs
MANGOHUD=1
# Google API stuff to make chromium sync work
export GOOGLE_DEFAULT_CLIENT_ID=114775368064-atevfk1e8f9lletb18b9l02h8luhv048.apps.googleusercontent.com
export GOOGLE_DEFAULT_CLIENT_SECRET=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
export GOOGLE_API_KEY=AIzaSyBUaFNDDxqFpTG6Tn47fSPRaOodLtxqiy0

### EXEC ###

#exec awesome &> ~/.awesomelog

# Set a normal cursor, because xmonad doesn't do it........
#xsetroot -cursor_name left_ptr
#exec xmonad

export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
exec gnome-session

#export DESKTOP_SESSION=plasma
#exec startplasma-x11
