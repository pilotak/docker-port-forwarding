FROM alpine

ARG DEF_LOCAL_PORT=8000
ARG DEF_TARGET_IP=localhost
ARG DEF_TARGET_PORT=80

ENV LOCAL_PORT=$DEF_LOCAL_PORT
ENV TARGET_IP=$DEF_TARGET_IP
ENV TARGET_PORT=$DEF_TARGET_PORT

EXPOSE $LOCAL_PORT

RUN apk update \
    && apk add iptables \
    && rm -rf /var/cache/apk/*

CMD iptables -F \
    && iptables -t nat -F \
    && iptables -X \
    && iptables -t nat -A PREROUTING -p tcp -m tcp --dport $LOCAL_PORT -j DNAT --to-destination $TARGET_IP:$TARGET_PORT \
    && iptables -t nat -A POSTROUTING -d $TARGET_IP -p tcp -m tcp --dport $TARGET_PORT -j MASQUERADE \
    && echo "forwarding $TARGET_IP:$TARGET_PORT to localhost:$LOCAL_PORT" \
    && while true; do sleep 1; done