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
        tzdata \
#
    # dhcp package unavailable in repos since v3.20
    && { \
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.20/main"; \
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.20/community"; \
    } > /tmp/repo3.20 \
    && apk add --no-cache \
        --repositories-file "/tmp/repo3.20" \
        dhcp \
#
    && mkdir -p /var/lib/dhcp/ \
    && touch /var/lib/dhcp/dhcpd.leases \
    && rm -rf /var/cache/apk/* /tmp/*
#
COPY root/ /
#
VOLUME /etc/dhcp/ /var/lib/dhcp/
#
EXPOSE 67/udp 67/tcp
#
ENTRYPOINT ["/init"]
