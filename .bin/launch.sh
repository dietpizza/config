#!/bin/bash
ch=$(echo -e "Backup\nFTPServer" | dmenu)
if [[ $ch = "Backup" ]]; then
  ~/.config/.bin/backup.sh
elif [[ $ch = "FTPServer" ]]; then
  alacritty -e ~/.config/.bin/ftpserver.sh
fi
