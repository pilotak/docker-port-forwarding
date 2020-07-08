# Port Forwarding for Docker
![Docker Build](https://github.com/pilotak/docker-port-forwarding/workflows/docker%20build/badge.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/pilotak/port-forwarding) ![Docker Size](https://img.shields.io/docker/image-size/pilotak/port-forwarding?color=orange)


## Using docker
```sh
docker run -d --name port-forwarding --cap-add=NET_ADMIN -e TARGET_IP=192.168.1.100 -e TARGET_PORT=12345 -p 8123:8000 pilotak/rpi-port-forward
```

## Using docker-compose
```yaml
version: "3"
services:
  port-forwarding:
    container_name: port-forwarding
    restart: always
    image: pilotak/port-forwarding
    environment:
      - TARGET_IP=192.168.1.100
      - TARGET_PORT=12345
    cap-add:
      - NET_ADMIN
    ports:
      - 8123:8000
```

## Environmental variables
| Variable | | Default value | Allowed values |
| --- | --- | :---:| :---: |
| `TARGET_IP` | **required** | | |
| `TARGET_PORT` | **required** | 80 | 1-65535 |
| `LOCAL_PORT` | optional | 8000 | 1-65535 |