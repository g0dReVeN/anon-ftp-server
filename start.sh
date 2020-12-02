#!/bin/sh

#Remove all ftp users
grep '/ftp/' /etc/passwd | cut -d':' -f1 | xargs -n1 deluser

# Used to run custom commands inside container
if [ ! -z "$1" ]; then
    exec "$@"
else
    exec mkdir -p $ROOT_DIR
    exec /usr/sbin/vsftpd -opasv_min_port=$MIN_PORT -opasv_max_port=$MAX_PORT -opasv_address=$ADDRESS /etc/vsftpd/vsftpd.conf
fi
