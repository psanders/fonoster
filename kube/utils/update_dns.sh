#!/usr/bin/env bash

DNS_ZONE=fnzone
NAMESPACE=$1

. `dirname "$0"`/setup.cfg

IP=$(kubectl get svc fnapp --namespace=$NAMESPACE | awk '{print $3}' | tail -1)

if [ -z "$IP" ]
then
    exit 1
fi

echo "Updating record-set for namespace=$NAMESPACE and zone=$DNS_ZONE"

# Update DNS records if needed
if [ "$NAMESPACE" = "prod" ]; then
    sed -i "s/<IP>/$IP/" /opt/fn/resources/dns/fn-dns.yaml
    gcloud dns record-sets import /opt/fn/resources/dns/fn-dns.yaml --zone=$DNS_ZONE
elif [ "$NAMESPACE" = "qa" ]; then
    sed -i "s/<IP>/$IP/" /opt/fn/resources/dns/fn-dns-qa.yaml
    gcloud dns record-sets import /opt/fn/resources/dns/fn-dns-qa.yaml --zone=$DNS_ZONE
else
    echo "Unexpected NAMESPACE: $NAMESPACE"
fi

exit 0