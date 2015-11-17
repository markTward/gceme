#!/usr/bin/env bash

# fast global teardown
# kubectl delete namespace dev
# kubectl delete namespace staging
# kubectl delete namespace production

kubectl --namespace=dev delete svc gceme-backend
kubectl --namespace=dev delete svc gceme-frontend
kubectl --namespace=dev delete rc gceme-backend
kubectl --namespace=dev delete rc gceme-frontend

kubectl --namespace=staging delete svc gceme-backend
kubectl --namespace=staging delete svc gceme-frontend
kubectl --namespace=staging delete rc gceme-backend
kubectl --namespace=staging delete rc gceme-frontend

kubectl --namespace=production delete svc gceme-backend
kubectl --namespace=production delete svc gceme-frontend
kubectl --namespace=production delete rc gceme-backend
kubectl --namespace=production delete rc gceme-frontend


