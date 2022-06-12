FROM debian:bullseye-slim

LABEL org.opencontainers.image.authors "Paul Brüdgam"
LABEL org.opencontainers.image.description "Multi-Arch Docker-Image for https://earnapp.com/"
LABEL org.opencontainers.image.source "https://github.com/paulbruedgam/earnapp-docker"
LABEL org.opencontainers.image.url "https://github.com/paulbruedgam/earnapp-docker"
LABEL org.opencontainers.image.title "Earnapp Docker"

ENV DEBIAN_FRONTEND=noninteractive

COPY ./earnapp_init.sh /usr/local/bin/

# hadolint ignore=DL3008
RUN apt-get update -qq \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && /usr/local/bin/earnapp_init.sh

COPY ./docker-entrypoint.d/ /docker-entrypoint.d/
COPY ./docker-entrypoint.sh /

VOLUME [ "/etc/earnapp" ]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["earnapp", "run"]
