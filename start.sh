#!/bin/sh

#Remove all ftp users
grep '/ftp/' /etc/passwd | cut -d':' -f1 | xargs -n1 deluser

# Used to run custom commands inside container
if [ ! -z "$1" ]; then
    exec "$@"
else
    exec mkdir -p $ROOT_DIR
    exec /usr/sbin/vsftpd -opasv_min_port=21000 -opasv_max_port=21100 -opasv_address=$ADDRESS /etc/vsftpd/vsftpd.conf
    exec rc-service vsftpd start
    exec rc-update add vsftpd default
fi
