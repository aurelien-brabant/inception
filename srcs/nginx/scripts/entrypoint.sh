#! /bin/sh

if ! cat .runtime_config_done; then
	# Create self signed certificate
	mkdir -p ${CERTS_DIR} 2> /dev/null
	openssl req -newkey rsa:4096				\
		-x509									\
		-nodes									\
		-out ${CERTS_DIR}/${DOMAIN_NAME}.crt	\
		-keyout ${CERTS_DIR}/${DOMAIN_NAME}.key	\
		-subj "/C=FR/CN=${DOMAIN_NAME}"

	# Edit nginx configuration to fit provided environment
	sed -i "s|CERT_TEMPLATE|${CERTS_DIR}/${DOMAIN_NAME}|g" /etc/nginx/http.d/default.conf
	sed -i "s|KEY_TEMPLATE|${CERTS_DIR}/${DOMAIN_NAME}|g" /etc/nginx/http.d/default.conf
	sed -i "s/TLS_VERSION_TEMPLATE/${TLS_VERSION}/g" /etc/nginx/http.d/default.conf
	sed -i "s/SERVER_NAME_TEMPLATE/${DOMAIN_NAME}/g" /etc/nginx/http.d/default.conf
	sed -i "s/PHP_FPM_HOST_TEMPLATE/${PHP_FPM_HOST}/g" /etc/nginx/http.d/default.conf
	sed -i "s/PHP_FPM_PORT_TEMPLATE/${PHP_FPM_PORT}/g" /etc/nginx/http.d/default.conf

	touch .runtime_config_done
fi

# start nginx without daemonization
nginx -g "daemon off;"
