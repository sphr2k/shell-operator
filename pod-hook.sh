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

  curlResult=$(curl --write-out '%{http_code}' --silent --output /dev/null -X PATCH \
    -H "Content-Type: application/json" \
    -d "${nodes}" \
    "${CADDY_API}/config/apps/http/servers/srv0/routes/0/handle/0/routes/0/handle/0/upstreams/")

  if [[ $curlResult == "200" ]]; then
    echo "Caddy upstream update: OK"
  else
    echo "Caddy upstream update: Error"
  fi

fi

