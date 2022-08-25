# Keycloak Proof-of-Concept

A minimal Keycloak proof-of-concept consisting of three components:

- A non-production Keycloak deployment for Kubernetes.
- A NodeJS HTTP API that leverages the `keycloak-connect` package.
- A Python example client that implements the _Resource Owner Password Flow_.

## Deploy the Keycloak service

First, create a Minikube cluster if necessary:

```
minikube start --cpus="max" --memory="max"
```

Then, run the start script. This will deploy a Compose stack with a PostgreSQL instance that is automatically initialized with a Keycloak database dump. It will also create the necessary Kubernetes resources for a minimal Keycloak deployment:

```
./start.sh
```

## Run the Node API

```
cd nodejs-api
npm install
npm run start
```

## Run the Python client

```
cd py-client
virtualenv .venv
.venv/bin/pip install -r requirements.txt
.venv/bin/python client.py
```
