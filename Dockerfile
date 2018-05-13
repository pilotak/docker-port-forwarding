FROM arm32v7/debian:stretch-slim

ARG DEF_TARGET_PORT=80

ENV TARGET_PORT=$DEF_TARGET_PORT

RUN apt-get update \
&& apt-get -y install systemd iptables

EXPOSE $LOCAL_PORT

CMD grep -qF -- "net.ipv4.ip_forward=1" /etc/sysctl.conf || echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf \
&& iptables -F \
&& iptables -t nat -F \
&& iptables -X \
&& iptables -t nat -A PREROUTING -p tcp -m tcp --dport $LOCAL_PORT -j DNAT --to-destination $TARGET_IP:$TARGET_PORT \
&& iptables -t nat -A POSTROUTING -d $TARGET_IP -p tcp -m tcp --dport $TARGET_PORT -j MASQUERADE \
&& echo "forwarding $LOCAL_PORT to $TARGET_IP:$TARGET_PORT" \
&& while true; do sleep 1; done
