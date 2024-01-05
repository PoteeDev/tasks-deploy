# Deploy

## Dev cluster

```
k3d cluster create --k3s-arg "--disable=traefik@server:*"
k3d cluster edit k3s-default --port-add 80:80@loadbalancer
```

### Install zitadel

Add helm repos
```
helm repo add cockroachdb https://charts.cockroachdb.com/
helm repo add zitadel https://charts.zitadel.com
helm repo add oauth2-proxy https://oauth2-proxy.github.io/manifests
helm repo add nginx-stable https://helm.nginx.com/stable
```

Install database and zitadel
```
helm install crdb cockroachdb/cockroachdb -f values/dev/crdb.yml

# Install ZITADEL
helm install my-zitadel zitadel/zitadel  -f values/dev/zitadel.yml
```


```
helm install oauth oauth2-proxy/oauth2-proxy -f values/dev/oauth2-proxy.yml
```

```
helm install nginx-ingress nginx-stable/nginx-ingress
```


```
helm repo add minio https://charts.min.io/
helm install minio minio/minio -f values/dev/minio.yml
```