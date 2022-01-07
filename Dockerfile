FROM flant/shell-operator:latest
RUN apk add --update-cache \
    curl \
 && rm -rf /var/cache/apk/*
ADD pod-hook.sh /hooks
