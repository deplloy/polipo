FROM alpine

MAINTAINER Deploy Bot <deplloyer@gmail.com>

RUN addgroup -S polipo && \
    adduser -S -D -H -s /bin/false -g "Polipo Proxy Service" -G polipo polipo && \
    set -x && \
    apk add --no-cache --virtual .build-deps alpine-sdk && \
    git clone https://github.com/jech/polipo && \
    cd /polipo && \
    make && \
    install polipo /usr/local/bin/ && \
    mkdir -p /usr/share/polipo/www /var/cache/polipo && \
    rm -rf /tmp/polipo && \
    apk del .build-deps

USER polipo

EXPOSE 8123

ENTRYPOINT ["polipo", "proxyAddress=0.0.0.0", "proxyPort=8123"]
