#! /usr/bin/env bash
git add --all
git commit -m "Auto-Commit"
git push

sleep 5

kubectl delete -f deploy.yaml
kubectl apply -f deploy.yaml
