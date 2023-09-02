# KTWIN Smart Cities Devices

This repository contains the KTWIN devices implementation for the DTDL Smart Cities use case.

## Docker Build

```sh
docker build -t ghcr.io/open-digital-twin/ktwin-pole-device:0.1 --build-arg DEVICE_NAME=pole-device .
```

## Docker Run

```sh
docker run -it --rm \
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
