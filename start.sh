#!/usr/bin/env bash

set -ex

minikube status

docker-compose down -v
docker-compose up -d

sleep 10

export KC_DB_URL_HOST=$(ifconfig |
    grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' |
    grep -Eo '([0-9]*\.){3}[0-9]*' |
    grep -v '127.0.0.1' |
    head -n 1)

kubectl apply -k ./
