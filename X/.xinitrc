#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

####################

#gnome-keyring-daemon --start # for deepin
export SSH_AUTH_SOCK

export QT_QPA_PLATFORMTHEME=gtk2

# wine fix
export STAGING_WRITECOPY=1
# wine fonts
FREETYPE_PROPERTIES="truetype:interpreter-version=35"

# turn off bell sound
xset b off

export TERMINAL=termite

redshift-gtk -l 50.25:17.25 &

xbindkeys
setxkbmap -option caps:escape
sleep 15 && tilda &

# XFCE
ksuperkey
compton &
nm-applet &
exec startxfce4

# DEEPIN
#export DESKTOP_SESSION=gnome
#exec startdde

# I3
#exec i3
