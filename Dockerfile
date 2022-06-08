FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

COPY ./earnapp_init.sh /usr/local/bin/

# hadolint ignore=DL3008
RUN apt-get update -qq \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        libatomic1 \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && /usr/local/bin/earnapp_init.sh

COPY ./docker-entrypoint.d/ /docker-entrypoint.d/
COPY ./docker-entrypoint.sh /

VOLUME [ "/etc/earnapp" ]
VOLUME [ "/sys/fs/cgroup" ]

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["earnapp", "run"]
