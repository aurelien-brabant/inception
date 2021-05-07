FROM		alpine:3.13.4

RUN 		apk -U upgrade && apk add vsftpd

COPY		./config/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY		./scripts/entrypoint.sh /entrypoint.sh

EXPOSE		21

ENTRYPOINT	[ "sh", "entrypoint.sh" ]
