#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

. `dirname "$0"`/setup.cfg

NAMESPACE=$1
TAG=$2

# Update deployment resources tag and pv/pvc name
sed -i "s/:1.0/:$TAG/" /opt/fn/resources/deployment/*.yaml

if [ "$NAMESPACE" = "qa" ]; then
    kubectl --namespace=$NAMESPACE apply -f /opt/fn/resources/deployment/mongodb-qa.yaml
elif [ "$NAMESPACE" = "prod" ]; then
    kubectl --namespace=$NAMESPACE apply -f /opt/fn/resources/deployment/mongodb.yaml
fi

kubectl --namespace=$NAMESPACE apply -f /opt/fn/resources/deployment/app.yaml
kubectl --namespace=$NAMESPACE apply -f /opt/fn/resources/deployment/ast.yaml
