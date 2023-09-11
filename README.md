# dcc-dev-environment

## K8s credentials
### Get credentials from the default namespace and change their namespace to 'dev'
```bash
mkdir ./credentials
```
```bash
kubectl get secret postgres-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_postgres.yaml && \
kubectl get secret trackhubs-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_trackhubs.yaml && \
kubectl get secret email-host-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_email-host.yaml && \
kubectl get secret gcp-es-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_gcp-es.yaml && \
kubectl get secret aws-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_aws.yaml && \
kubectl get secret minio-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' > ./credentials/credentials_minio.yaml
```

### Add credentials into your 'dev'-namespace
```bash
kubectl -n dev apply -f ./credentials/credentials_postgres.yaml -f ./credentials/credentials_trackhubs.yaml \
-f ./credentials/credentials_email-host.yaml -f ./credentials/credentials_gcp-es.yaml \
-f ./credentials/credentials_aws.yaml -f ./credentials/credentials_minio.yaml
```

## Backend deployment in the 'dev'-namespace
```bash
kubectl apply --namespace=dev -f ./pvc.yml
kubectl apply --namespace=dev -f ./file-server/storage_pvc.yml

kubectl apply --namespace=dev -f ./validation/validation_svc+deployment.yml
```

## Creating 'dev'-container with ssh-server inside it
```bash
ssh-keygen -t rsa -b 4096 -C "name@gmail.com" -f ~/.ssh/idkey
```
```bash
export KUBECONFIG=<path_to_K8s_config>
```
```bash
cd ./dcc-dev
sh ./build.sh
```

### Logs && debug cheat sheet
```bash
kubectl get pvc -n dev

kubectl -n dev get services
kubectl -n dev get deployments
kubectl -n dev get pods

kubectl get events -n dev
kubectl -n dev describe pod <pod_name>
kubectl -n dev logs <pod_name>
kubectl get pods -n=dev -o=jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | xargs -I {} kubectl logs {} -n=dev --all-containers=true

kubectl exec -n dev -it ssh-server-pod -- /bin/bash
```
