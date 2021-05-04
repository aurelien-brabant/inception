FROM		alpine:3.13.4

RUN 		apk -U upgrade && apk add vsftpd

COPY		./config/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN			{ echo "pwd"; echo "pwd"; } | adduser ftp_user
RUN			chown -R ftp_user:ftp_user /home/ftp_user

COPY		./scripts/entrypoint.sh /entrypoint.sh
RUN			chmod +x /entrypoint.sh

EXPOSE		21

CMD			[ "./entrypoint.sh" ]
