#!/bin/bash
ch=$(echo -e "Lock\nLogout\nSuspend\nShutdown\nReboot" | dmenu)

if [[ $ch = "Lock" ]]; then
    i3lock -c 002b36
elif [[ $ch = "Logout" ]]; then
  ch=$(echo -e 'Yes\nNo' | dmenu -p 'Are you sure?')
  if [[ $ch = "Yes" ]]; then
    xdotool key ctrl+super+q
  fi
elif [[ $ch = "Suspend" ]]; then
  ch=$(echo -e 'Yes\nNo' | dmenu -p 'Are you sure?')
  if [[ $ch = "Yes" ]]; then
    sudo systemctl suspend
  fi
elif [[ $ch = "Lock" ]]; then
  i3lock
elif [[ $ch = "Shutdown" ]]; then
  ch=$(echo -e 'Yes\nNo' | dmenu -p 'Are you sure?')
  if [[ $ch = "Yes" ]]; then
    sudo shutdown now
  fi
elif [[ $ch = "Reboot" ]]; then
  ch=$(echo -e 'Yes\nNo' | dmenu -p 'Are you sure?')
  if [[ $ch = "Yes" ]]; then
    sudo reboot
  fi
fi
