#! /usr/bin/env bash
docker build . -t janwer/shell-operator:monitor-pods
docker push janwer/shell-operator:monitor-pods


kubectl delete -f deploy.yaml
kubectl apply -f deploy.yaml
