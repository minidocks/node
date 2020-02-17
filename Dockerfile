ARG package=nodejs-current<14
ARG base_version=3.11

FROM minidocks/base:3.8 AS v3.8

FROM minidocks/base:3.9 AS v3.9

FROM minidocks/base:3.10 AS v3.10

FROM minidocks/base:3.11 AS v3.11

FROM v$base_version AS latest
LABEL maintainer="Martin Hasoň <martin.hason@gmail.com>"

ENV NPM_CONFIG_CACHE=/npm-cache \
    YARN_CACHE_FOLDER=/yarn-cache \
    CLEAN="$CLEAN:\$NPM_CONFIG_CACHE/:\$YARN_CACHE_FOLDER/:/usr/lib/node_modules/npm/doc:/usr/lib/node_modules/npm/man:/usr/lib/node_modules/npm/html"

ARG package

RUN apk --update add $package \
    && mkdir -p "$NPM_CONFIG_CACHE" "$YARN_CACHE_FOLDER" && chmod 777 "$NPM_CONFIG_CACHE" "$YARN_CACHE_FOLDER" \
    && npm i -g npm@latest npm-check-updates yarn \
    && clean

COPY rootfs /

CMD [ "node" ]
