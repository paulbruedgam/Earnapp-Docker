#!/usr/bin/env bash
# LICENSE_CODE ZON ISC
# Script based on original Script https://brightdata.com/static/earnapp/install.sh

NETWORK_RETRY=3
OS_ARCH=$(uname -m)
OS_NAME=$(uname -s)
OS_VER=$(uname -v)
PERR_URL="https://perr.luminati.io/client_cgi/perr"
PRINT_PERR=1
RID="$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom| fold -w 32 | head -n 1)"
RS=""
TS_START=$(date +"%s000")

escape_json()
{
    local strip_nl=${1//$'\n'/\\n}
    local strip_tabs=${strip_nl//$'\t'/\ }
    local strip_quotes=${strip_tabs//$'"'/\ }
    RS=$strip_quotes
}

perr()
{
    local name="$1" note="$2" ts=0 ret=0
    ts=$(date +"%s")
    escape_json "$note"
    local note=$RS url="${PERR_URL}/?id=earnapp_sh_${name}"
    local data="{\"uuid\": \"$RID\", \"timestamp\": \"$ts\", \"ver\": \"1.263.380\", \"info\": {\"platform\": \"$OS_NAME\", \"c_ts\": \"$ts\", \"c_up_ts\": \"$TS_START\", \"note\": \"$note\", \"os_ver\": \"$OS_VER\", \"os_arch\": \"$OS_ARCH\"}}"
    if ((PRINT_PERR)); then
        echo "perr ${url} ${data}"
    fi
    for ((i=0; i<NETWORK_RETRY; i++)); do
      wget -S --header "Content-Type: application/json" \
          -O /dev/null -o /dev/null --post-data="${data}" \
          --quiet "${url}" > /dev/null
        ret=$?
        if ((!ret)); then break; fi
    done
}

welcome_text(){
    echo "Installing EarnApp CLI"
    echo "Welcome to EarnApp for Linux and Raspberry Pi."
    echo "EarnApp makes you money by sharing your spare bandwidth."
    echo "You will need your EarnApp account username/password."
    echo "Visit earnapp.com to sign up if you don't have an account yet"
    echo
    echo "To use EarnApp, allow BrightData to occasionally access websites \
through your device. BrightData will only access public Internet web \
pages, not slow down your device or Internet and never access personal \
information, except IP address - see privacy policy and full terms of \
service on earnapp.com."
    echo 'By using this docker image you agree the terms.'
}

perr "start"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

welcome_text

echo "Installing..."
perr "consent_yes"

if [ ! -d "/etc/earnapp" ]; then
    perr "dir_create"
    echo "Creating directory /etc/earnapp"
    mkdir /etc/earnapp
    chmod a+wr /etc/earnapp/
    touch /etc/earnapp/status
    chmod a+wr /etc/earnapp/status
else
    perr "dir_existed"
    echo "System directory already exists"
fi

case "${OS_ARCH}" in
  "x86_64") perr "arch_x86_64";;
  "amd64") perr "arch_amd64";;
  "armv6l") perr "arch_armv6l";;
  "armv7l") perr "arch_armv7l";;
  "arm64") perr perr "arch_arm64";;
  "aarch64") perr "arch_aarch64";;
  *)  perr "arch_other";;
esac

perr "fetch_start"
sleep 5
perr "fetch_finished"
sleep 2
perr "install_run"
sleep 10
earnapp finish_install
perr "install_finished"
