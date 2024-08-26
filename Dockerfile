# syntax=docker/dockerfile:1
#
ARG IMAGEBASE=frommakefile
#
FROM ${IMAGEBASE}
#
ENV INTERFACES=eth0
#
RUN set -xe \
    && apk add --no-cache --purge -uU \
        dhcp \
        tzdata \
    && mkdir -p /var/lib/dhcp/ \
    && touch /var/lib/dhcp/dhcpd.leases \
    && rm -rf /var/cache/apk/* /tmp/*
#
COPY root/ /
#
VOLUME /etc/dhcp/
#
EXPOSE 67/udp 67/tcp
#
ENTRYPOINT ["/init"]
