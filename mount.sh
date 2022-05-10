echo "unmounting smb file systems (force)"
umount */*/*
kill -9 `ps aux | grep mount.cifs | awk '{print $2}'`

