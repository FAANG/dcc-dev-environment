# dcc-dev-environment

## Get credentials from the default namespace
```bash
kubectl get secret postgres-credentials -n default -o yaml > credentials_postgres.yaml
kubectl get secret trackhubs-credentials -n default -o yaml > credentials_trackhubs.yaml
kubectl get secret email-host-credentials -n default -o yaml > credentials_email-host.yaml
kubectl get secret gcp-es-credentials -n default -o yaml > credentials_gcp-es.yaml
kubectl get secret aws-credentials -n default -o yaml > credentials_aws.yaml
kubectl get secret minio-credentials -n default -o yaml > credentials_minio.yaml
```

## Change the namespace to 'dev' and apply files for your 'dev'-namespace
```bash
kubectl apply -f ./credentials_postgres.yaml
kubectl apply -f ./credentials_trackhubs.yaml
kubectl apply -f ./credentials_email-host.yaml
kubectl apply -f ./credentials_gcp-es.yaml
kubectl apply -f ./credentials_aws.yaml
kubectl apply -f ./credentials_minio.yaml
```

## Deployment
```bash
kubectl apply --namespace=dev -f ./pvc.yml
kubectl apply --namespace=dev -f ./file-server/storage_pvc.yml
kubectl get pvc -n dev

kubectl apply --namespace=dev -f ./validation/validation_svc+deployment.yml
kubectl -n dev get services
kubectl -n dev get deployments
kubectl -n dev get pods
```

## Logs
```bash
kubectl get events -n dev
kubectl -n dev describe pod <pod_name>
kubectl -n dev logs <pod_name>
kubectl get pods -n=dev -o=jsonpath='{.items[*].metadata.name}' | tr ' ' '\n' | xargs -I {} kubectl logs {} -n=dev --all-containers=true
```
