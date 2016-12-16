#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "You must include NAMESPACE and TAG"
    exit 1
fi

TAG=$2
NAMESPACE=$1

echo "Deploying TAG -> $TAG to $NAMESPACE"

cp fnops/kube/deployment/app.yaml ./app.tmp.yaml
sed -i .bak "s/IMAGE_VERSION/$TAG/" app.tmp.yaml
kubectl --namespace=$NAMESPACE apply -f app.tmp.yaml

# Remove temporary files
rm app.tmp.*

say "New app was deployed"