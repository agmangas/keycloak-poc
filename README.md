# Keycloak Proof-of-Concept

A minimal proof-of-concept to get some experience with Keycloak.

```
docker-compose up -d
```

```
kubectl apply -f ./pgsecret.yml
kubectl get secret pgsecret -o yaml
```

```
export PG_HOST=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
```

```
helm install keycloak-poc -f keycloak.yml bitnami/keycloak \
--set externalDatabase.host=${PG_HOST}
```