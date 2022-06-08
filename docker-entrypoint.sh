#!/bin/bash
set -e

echo "Container's IP address: $(awk 'END{print $1}' /etc/hosts)"
echo "Public IP address: $(wget -qO- ipinfo.io/ip)"

if [[ "$1" = "earnapp" && "$2" = "run" ]]; then
  for file in /docker-entrypoint.d/*.sh; do
    test -x "${file}" && "${file}"
  done
  /usr/bin/earnapp autoupgrade &
  echo "If not registered. Please register this container to earn money."
  /usr/bin/earnapp register
  sleep 15
fi 

"$@"
