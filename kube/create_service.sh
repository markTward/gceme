#! /bin/bash

# create gceme service on dev, staging and production namespaces

kubectl create -f ./namespace-dev.yaml
kubectl --namespace=dev create -f ./service_frontend.yaml
kubectl --namespace=dev create -f ./service_backend.yaml 
kubectl --namespace=dev create -f ./frontend.yaml 
kubectl --namespace=dev create -f ./backend.yaml 

kubectl create -f ./namespace-staging.yaml
kubectl --namespace=staging create -f ./service_frontend.yaml
kubectl --namespace=staging create -f ./service_backend.yaml
kubectl --namespace=staging create -f ./frontend.yaml
kubectl --namespace=staging create -f ./backend.yaml

kubectl create -f ./namespace-prod.yaml
kubectl --namespace=production create -f ./service_frontend.yaml
kubectl --namespace=production create -f ./service_backend.yaml
kubectl --namespace=production create -f ./frontend.yaml
kubectl --namespace=production create -f ./backend.yaml
