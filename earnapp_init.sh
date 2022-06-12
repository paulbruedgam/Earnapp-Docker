#!/bin/bash
VERSION="$(wget -qO- https://brightdata.com/static/earnapp/install.sh| awk -F= '/^VERSION/ { gsub("\"",""); print $2 }')"

# Simulate systemd
ln -sv /bin/true /usr/bin/systemctl
mkdir -pv /etc/systemd/system

# Create earnapp dirs based on https://brightdata.com/static/earnapp/install.sh
mkdir -pv /etc/earnapp
touch /etc/earnapp/status
chmod -vR u+wr /etc/earnapp

# Download the correct binary
OS_ARCH="$(uname -m)"
case "${OS_ARCH}" in
    "x86_64"|"amd64") file="earnapp-x64-${VERSION}";;
    "armv7l"|"armv6l") file="earnapp-arm7l-${VERSION}";;
    "aarch64"|"arm64") file="earnapp-aarch64-${VERSION}";;
    *)  echo "${OS_ARCH} not supported"; exit 1;;
esac
wget -qc "https://cdn.brightdata.com/static/${file}" -O /usr/bin/earnapp
chmod +x /usr/bin/earnapp
