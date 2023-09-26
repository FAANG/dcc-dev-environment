#!/bin/bash

cp ~/.ssh/idkey.pub ./idkey.pub

docker build -t dcc-dev-img:latest --no-cache .

docker tag dcc-dev-img:latest milm/dcc-dev-img:latest
docker push milm/dcc-dev-img:latest

kubectl delete -f ssh-service.yaml
kubectl apply -f ssh-service.yaml
