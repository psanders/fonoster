#!/usr/bin/env sh

USAGE=$(cat <<-END
To run this image you must provide the following environment variables:

    ASTERISK_EXTERN_ADDR
    ASTERISK_SIPPROXY_HOST
    ASTERISK_SIPPROXY_USERNAME
    ASTERISK_SIPPROXY_SECRET
    ASTERISK_FASTAGI_HOST
    ASTERISK_MANAGER_SECRET

END
)

[ -z "$ASTERISK_BINDADDR" ]         && { export ASTERISK_BINDADDR='0.0.0.0:5060'; }
[ -z "$ASTERISK_SIPPROXY_PORT" ] && { export ASTERISK_SIPPROXY_PORT='5060'; }
[ -z "$ASTERISK_MANAGER_BINDADDR" ] && { export ASTERISK_MANAGER_BINDADDR='0.0.0.0'; }
[ -z "$ASTERISK_MANAGER_PORT" ]     && { export ASTERISK_MANAGER_PORT='5038'; }
[ -z "$ASTERISK_FASTAGI_PORT" ]     && { export ASTERISK_FASTAGI_PORT='4573'; }
[ -z "$ASTERISK_LOCALNETS" ]        && { export ASTERISK_LOCALNETS=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}'); }
[ -z "$ASTERISK_MANAGER_USERNAME" ] && { export ASTERISK_MANAGER_USERNAME='admin'; }

[ -z "$ASTERISK_EXTERN_ADDR" ]       ||
[ -z "$ASTERISK_SIPPROXY_HOST" ]     ||
[ -z "$ASTERISK_SIPPROXY_USERNAME" ] ||
[ -z "$ASTERISK_SIPPROXY_SECRET" ]   ||
[ -z "$ASTERISK_FASTAGI_HOST" ]      ||
[ -z "$ASTERISK_MANAGER_SECRET" ]    && {
    echo "$USAGE"
    exit 1
}

sed -i.bak "s|ASTERISK_BINDADDR_PLACEHOLDER|${ASTERISK_BINDADDR}|g" /etc/asterisk/sip.conf
sed -i.bak "s|ASTERISK_EXTERN_ADDR_PLACEHOLDER|${ASTERISK_EXTERN_ADDR}|g" /etc/asterisk/sip.conf
sed -i.bak "s|ASTERISK_LOCALNETS_PLACEHOLDER|${ASTERISK_LOCALNETS}|g" /etc/asterisk/sip.conf
sed -i.bak "s|ASTERISK_SIPPROXY_HOST_PLACEHOLDER|${ASTERISK_SIPPROXY_HOST}|g" /etc/asterisk/sip.conf
sed -i.bak "s|ASTERISK_SIPPROXY_PORT_PLACEHOLDER|${ASTERISK_SIPPROXY_PORT}|g" /etc/asterisk/sip.conf
sed -i.bak "s|ASTERISK_SIPPROXY_USERNAME_PLACEHOLDER|${ASTERISK_SIPPROXY_USERNAME}|g" /etc/asterisk/sip.conf
sed -i.bak "s|ASTERISK_SIPPROXY_USERNAME_PLACEHOLDER|${ASTERISK_SIPPROXY_USERNAME}|g" /etc/asterisk/extensions.conf
sed -i.bak "s|ASTERISK_SIPPROXY_SECRET_PLACEHOLDER|${ASTERISK_SIPPROXY_SECRET}|g" /etc/asterisk/sip.conf
sed -i.bak "s|ASTERISK_FASTAGI_HOST_PLACEHOLDER|${ASTERISK_FASTAGI_HOST}|g" /etc/asterisk/extensions.conf
sed -i.bak "s|ASTERISK_FASTAGI_PORT_PLACEHOLDER|${ASTERISK_FASTAGI_PORT}|g" /etc/asterisk/extensions.conf
sed -i.bak "s|ASTERISK_MANAGER_BINDADDR_PLACEHOLDER|${ASTERISK_MANAGER_BINDADDR}|g" /etc/asterisk/manager.conf
sed -i.bak "s|ASTERISK_MANAGER_PORT_PLACEHOLDER|${ASTERISK_MANAGER_PORT}|g" /etc/asterisk/manager.conf
sed -i.bak "s|ASTERISK_MANAGER_USERNAME_PLACEHOLDER|${ASTERISK_MANAGER_USERNAME}|g" /etc/asterisk/manager.conf
sed -i.bak "s|ASTERISK_MANAGER_SECRET_PLACEHOLDER|${ASTERISK_MANAGER_SECRET}|g" /etc/asterisk/manager.conf

asterisk

while sleep 3600; do :; done
