#!/bin/bash
picom &
conky &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xset r rate 350 40 &
