FROM gcr.io/stacksmith-images/minideb:jessie-r2

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=wordpress \
    BITNAMI_IMAGE_VERSION=4.6.1-r4 \
    PATH=/opt/bitnami/php/bin:/opt/bitnami/mysql/bin/:$PATH
    
# Additional modules required
RUN bitnami-pkg unpack apache-2.4.23-9 --checksum 25bf5b82662874c21b0c0614c057d06b4a8ec14d8a76181053b691a9dfbf7f94
RUN bitnami-pkg unpack php-5.6.27-2 --checksum 84d7fe4036a4218afd79b006c9fad55eab3cfec7a47d3a86183805f863813001
RUN bitnami-pkg install libphp-5.6.27-0 --checksum f9039cc69834334187c9b55fc20bf3be818cd87a2088ced2732fead1d1bfb2d6
RUN bitnami-pkg install mysql-client-10.1.19-0 --checksum fdbc292bedabeaf0148d66770b8aa0ab88012ce67b459d6ba2b46446c91bb79c

# Install wordpress
RUN bitnami-pkg unpack wordpress-4.6.1-3 --checksum e4b84683d2dc62910b86e617634eba1ea05083004f7dae145827c56236c5511b

COPY rootfs /

VOLUME ["/bitnami/wordpress", "/bitnami/apache", "/bitnami/php"]

EXPOSE 80 443

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["nami", "start", "--foreground", "apache"]
