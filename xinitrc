#!/usr/bin/env bash

xrdb ~/.Xresources

# Polish layout,
# swap caps lock with escape,
# kill xorg with ctrl-alt-backspace,
# have numpad "del" key output dot, not comma,
# use numpad without numlock
#setxkbmap pl -option caps:swapescape -option terminate:ctrl_alt_bksp -option kpdl:dot -option numpad:mac

# Bind keys specified in .xbindkeysrc
#xbindkeys

# Adjust scrolling speed
#echo 2 > /tmp/libinput_discrete_deltay_multiplier
#imwheel -b 45

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
#[ -f /opt/urserver/urserver ] && /opt/urserver/urserver --daemon

# Keystroke repeat delay (default: 400 30)
# In gnome dconf settings overwrite these
#xset r rate 220 25

# Enable MangoHud in all vulkan programs
#MANGOHUD=1

#export CALIBRE_USE_SYSTEM_THEME=1

# Screen lock
# xscreensaver &
#xscreensaver --no-splash &

# Samsung 700t laptop
# xmodmap -e "keycode 94 = Shift_L"
#export MOZ_USE_XINPUT2=1

#export QT_AUTO_SCREEN_SCALE_FACTOR=1.25

#export TERMINAL=alacritty
#export FILE_MANAGER=nemo

# Korean keyboard
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx
#fcitx5 -d

### EXEC ###

#exec awesome &> ~/.awesomelog

# Set a normal cursor, because xmonad doesn't do it........
#xsetroot -cursor_name left_ptr
#exec xmonad

# exec startlxqt

# exec startdde

# export DESKTOP_SESSION=plasma
# exec startplasma-x11
# dbus-run-session startplasma-wayland

# export XDG_CURRENT_DESKTOP=Budgie:GNOME
# exec budgie-desktop

# io.elementary.wingpanel &
# plank &
# exec gala

export QT_QPA_PLATFORMTHEME=qt6ct
#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11

# libadwaita workaround
#export GTK_THEME=Qogir-Dark
#export QT_STYLE_OVERRIDE=adwaita-dark
#blueman-applet &
#exec gnome-session

# GTK_IM_MODULE=ibus
# QT_IM_MODULE=ibus
# XMODIFIERS=@im=ibus
# ibus-daemon -drxR

exec bspwm
