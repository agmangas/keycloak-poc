#!/usr/bin/env bash

set -ex

minikube status

docker-compose down -v
docker-compose up -d

sleep 10

kubectl apply -f ./pgsecret.yml
kubectl get secret pgsecret -o yaml

PG_HOST=$(ifconfig |
    grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' |
    grep -Eo '([0-9]*\.){3}[0-9]*' |
    grep -v '127.0.0.1' |
    head -n 1)

helm install keycloak-poc -f keycloak.yml bitnami/keycloak \
    --set externalDatabase.host=${PG_HOST}
