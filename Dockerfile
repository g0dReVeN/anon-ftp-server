FROM alpine:latest

RUN apk upgrade --update-cache --available && \
    apk add openssl vsftpd ufw && \
    rm -rf /var/cache/apk/* && \
    ufw allow OpenSSH && \
    ufw allow 21/tcp && \
    ufw allow 990/tcp && \
    ufw allow 21000:21100/tcp && \
    ufw enable && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem

COPY start.sh /bin/start_vsftpd.sh
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

ENTRYPOINT ["/bin/start_vsftpd.sh"]

EXPOSE 21 990 21000-21100