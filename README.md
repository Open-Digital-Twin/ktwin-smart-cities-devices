# KTWIN Smart Cities Devices

This repository contains the KTWIN devices implementation for the DTDL Smart Cities use case.

## Docker Build

```sh
docker build -f publisher.Dockerfile -t ghcr.io/open-digital-twin/ktwin-pole-device-publisher:0.1 --build-arg DEVICE_NAME=pole-device .
docker build -f subscriber.Dockerfile  -t ghcr.io/open-digital-twin/ktwin-pole-device-subscriber:0.1 --build-arg DEVICE_NAME=pole-device .
```

Build Local Development:

```sh
docker build -f publisher.Dockerfile -t dev.local/open-digital-twin/ktwin-pole-device-publisher:0.1 --build-arg DEVICE_NAME=pole-device .
docker build -f subscriber.Dockerfile  -t dev.local/open-digital-twin/ktwin-pole-device-subscriber:0.1 --build-arg DEVICE_NAME=pole-device .
kind load docker-image dev.local/open-digital-twin/ktwin-pole-device-publisher:0.1
kind load docker-image dev.local/open-digital-twin/ktwin-pole-device-subscriber:0.1
```

## Docker Run

```sh
docker run -it --rm \
    -e BROKER_ADDRESS=localhost \
    -e BROKER_PORT=1883 \
    -e BROKER_TOPIC=mytopic \
    -e CLIENT_ID=mqtt-client-id-publisher \
    -e USERNAME= \
    -e PASSWORD= \
    -e N_MESSAGES=3 \
    -e MESSAGE_PERIOD=1 \
    --network host \
    ghcr.io/open-digital-twin/ktwin-pole-device-publisher:0.1
```

```sh
docker run -it --rm \
    -e BROKER_ADDRESS=localhost \
    -e BROKER_PORT=1883 \
    -e BROKER_TOPIC=mytopic \
    -e CLIENT_ID=mqtt-client-id-subscriber\
    -e USERNAME= \
    -e PASSWORD= \
    --network host \
    ghcr.io/open-digital-twin/ktwin-pole-device-subscriber:0.1
```

## Kubernetes Run

Select AMD:

```sh
kubectl run -it --rm \
    -e BROKER_ADDRESS=localhost \
    -e BROKER_PORT=1883 \
    -e BROKER_TOPIC=mytopic \
    -e CLIENT_ID=mqtt-client-id \
    -e USERNAME= \
    -e PASSWORD= \
    -e N_MESSAGES=3 \
    -e MESSAGE_PERIOD=1 \
    --network host \
    ghcr.io/open-digital-twin/ktwin-pole-device:0.1
```
