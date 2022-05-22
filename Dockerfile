FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
	&& apt-get upgrade -y \
	&& apt-get install --no-install-recommends -y \
		ca-certificates \
		wget \
        && wget https://brightdata.com/static/earnapp/install.sh -O /tmp/earnapp.sh \
	&& chmod a+x /tmp/earnapp.sh \
	&& /tmp/earnapp.sh -y

VOLUME [ "/etc/earnapp" ]
VOLUME [ "/sys/fs/cgroup" ]
