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
picom -b --experimental-backends
# Wallpaper
feh --bg-fill ~/Pictures/wallpaper.jpg
# Live wallpaper
#xwinwrap -g 1920x1080 -ni -ov -- mpv --hwdec=auto --loop=inf -wid WID ~/Pictures/wallpaperlive.mp4 &
# Flash windows on focus change
#flashfocus &
#alttab &

# Enable MangoHud in all vulkan programs
MANGOHUD=1

#exec awesome &> ~/.awesomelog
# Set a normal cursor, because xmonad doesn't do it........
xsetroot -cursor_name left_ptr
exec xmonad
