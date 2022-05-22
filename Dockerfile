FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# hadolint ignore=DL3008
RUN apt-get update -qq \
	&& apt-get upgrade -y \
	&& apt-get install --no-install-recommends -y \
		ca-certificates \
		wget \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* \
        && wget -q https://brightdata.com/static/earnapp/install.sh -O /tmp/earnapp.sh \
	&& chmod a+x /tmp/earnapp.sh \
	&& /tmp/earnapp.sh -y

VOLUME [ "/etc/earnapp" ]
VOLUME [ "/sys/fs/cgroup" ]
