#!/bin/bash

# ssh-keygen -t rsa -b 4096 -C "mansurova.m94@gmail.com" -f ~/.ssh/idkey
cp ~/.ssh/idkey.pub ./idkey.pub

mkdir ./credentials

export KUBECONFIG=/Users/mansurova/k8s_configs/config_faang

kubectl get secret postgres-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_postgres.yaml
kubectl get secret trackhubs-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_trackhubs.yaml
kubectl get secret email-host-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_email-host.yaml
kubectl get secret gcp-es-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_gcp-es.yaml
kubectl get secret aws-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_aws.yaml
kubectl get secret minio-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_minio.yaml

docker build -t dcc-dev-img:latest --no-cache .

docker tag dcc-dev-img:latest milm/dcc-dev-img:latest
docker push milm/dcc-dev-img:latest

# docker run -p 3000:22 -d --name dcc-dev-local milm/dcc-dev-img:latest
# docker exec -it dcc-dev-local /bin/bash
# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <docker-id>
# ssh sshuser@0.0.0.0 -p 3000 -i ~/.ssh/idkey

# kubectl apply -f ssh-pod.yaml
# kubectl port-forward -n dev ssh-server-pod-test 2222:22
# ssh -p 2222 sshuser@localhost -i ~/.ssh/idkey
# lsof -i :2222

kubectl apply -f ssh-service.yaml

# kubectl port-forward -n dev ssh-server-pod 2222:22
# ssh -p 2222 sshuser@localhost -i ~/.ssh/idkey

# ssh -p 8000 sshuser@45.88.81.193 -i ~/.ssh/idkey
