# Connect

Add kubernetes cluster to your kubectl context

```
aws eks update-kubeconfig --region us-east-1 --name master-dev-cluster --profile master
```

## Validates that you have access to the cluster

```
kubectl get nodes
kubectl cluster-info
```

