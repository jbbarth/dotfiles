export KONG_PG_HOST=docker.for.mac.localhost
# stick on v0.12.3 until plugins are compatible with 0.13.x
export KONG_DOCKER_VERSION=0.12-alpine

export KONG_ADDR=localhost
export KONG_PROXY_ADDR=$KONG_ADDR:8000
export KONG_ADMIN_ADDR=$KONG_ADDR:8001

# plugin development
export KONG_VERSION=0.12.3
