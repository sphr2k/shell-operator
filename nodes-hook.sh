NODES=$(kubectl get pod -n ingress-nginx -l=app.kubernetes.io/name=ingress-nginx -ojson | jq '[ .items[] | {dial: (.status.hostIP + ":32080")} ]')

echo $NODES


curl -v -X PATCH \
        -H "Content-Type: application/json" \
        -d '[{"dial": "172.25.2.203:32080"}, {"dial": "172.25.2.167:32080"}]' \
        "localhost:2019/config/apps/http/servers/srv0/routes/0/handle/0/routes/0/handle/0/upstreams/"


#!/usr/bin/env bash

if [[ $1 == "--config" ]] ; then
  cat <<EOF
configVersion: v1
kubernetes:
- apiVersion: v1
  kind: Pod
  executeHookOnEvent: ["Added"]
EOF
else
  nodes=$(kubectl get pod -n ingress-nginx -l=app.kubernetes.io/name=ingress-nginx -ojson | jq '[ .items[] | {dial: (.status.hostIP + ":32080")} ]')
  podName=$(jq -r .[0].object.metadata.name $BINDING_CONTEXT_PATH)
  echo "Pod added: '${podName}'"
  echo "Nodes array: '$nodes'"
fi
