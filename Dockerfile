FROM flant/shell-operator:latest
RUN apk add --update-cache \
    curl \
 && rm -rf /var/cache/apk/*
ADD nodes-hook.sh /hooks
