# dcc-dev-environment

## K8s credentials
### Get credentials from the default namespace and change their namespace to 'dev' then add credentials into your 'dev'-namespace
```bash
mkdir ./credentials
```
```bash
export KUBECONFIG=<path_to_K8s_config>
```
```bash
kubectl get secret postgres-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' | kubectl -n dev apply -f - && \
kubectl get secret trackhubs-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' | kubectl -n dev apply -f - && \
kubectl get secret email-host-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' | kubectl -n dev apply -f - && \
kubectl get secret gcp-es-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' | kubectl -n dev apply -f - && \
kubectl get secret aws-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' | kubectl -n dev apply -f - && \
kubectl get secret minio-credentials -n default -o yaml | sed 's#namespace: default#namespace: dev#' | kubectl -n dev apply -f -
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
