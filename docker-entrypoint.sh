#!/bin/bash
set -e

if [ "$1" = "earnapp" ] && [ "$2" = "run" ]; then
  for file in /docker-entrypoint.d/*.sh; do
    test -x "${file}" && "${file}"
  done

  PUB_IP="$(wget -qO- ipinfo.io/ip)"

  cat <<REGISTER
###############################################################################
Your public IP address: ${PUB_IP}
You can check the quality of your IP under:
https://earnapp.com/ip-checker/
$(/usr/bin/earnapp register)
###############################################################################

REGISTER
  sleep 15
fi 

"$@"
