#!/bin/bash
if [ -d "/run/media/rohan/BK" ]; then
  notify-send "Backup: Started!"
  sudo rsync -ahHSAXv --delete --exclude={"/root/.npm/_cacache/*","/home/rohan/.npm/_cacache/*","/var/cache/pacman/pkg/*","/home/rohan/.cache/*","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / /run/media/rohan/BK/arch/
  notify-send "Backup: Complete!"
else
  notify-send "Backup: Partition not mounted!"
fi
exit
