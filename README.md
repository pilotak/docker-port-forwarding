# Port Forwarding for Docker on Raspberry Pi 2 & 3
Remember to change not only `LOCAL_PORT` env but also exposed ports!
`TARGET_PORT` is optional and can be omitted, default target port is `80`

## Using docker
```sh
docker run -d --name port-forward --cap-add=NET_ADMIN -e LOCAL_PORT=8000 -e TARGET_IP=192.168.1.100 -e TARGET_PORT=80 -p 8000:8000 pilotak/rpi-port-forward
```

## Using docker-compose
```yaml
version: "3"
services:
  port-forward:
    container_name: port-forward
    restart: always
    image: pilotak/rpi-port-forward
    environment:
      - LOCAL_PORT=8000
      - TARGET_IP=192.168.1.100
      - TARGET_PORT=80
    cap-add:
      - NET_ADMIN
    ports:
      - 8000:8000

```
