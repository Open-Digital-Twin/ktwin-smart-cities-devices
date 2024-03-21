# Battery Device

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
    -e NUMBER_DEVICES=5 \
    -e BROKER_TOPIC_0=mytopic-01 \
    -e CLIENT_ID_0=mqtt-client-id-publisher-01 \
    -e BROKER_TOPIC_1=mytopic-02 \
    -e CLIENT_ID_1=mqtt-client-id-publisher-02 \
    -e BROKER_TOPIC_2=mytopic-03 \
    -e CLIENT_ID_2=mqtt-client-id-publisher-03 \
    -e BROKER_TOPIC_3=mytopic-04 \
    -e CLIENT_ID_3=mqtt-client-id-publisher-04 \
    -e BROKER_TOPIC_4=mytopic-05 \
    -e CLIENT_ID_4=mqtt-client-id-publisher-05 \
    -e USERNAME= \
    -e PASSWORD= \
    -e MESSAGE_WINDOWS="5;5;5" \
    -e MESSAGE_PERIODS="1;1;1" \
    -e FULL_PERIOD=10 \
    -e PART_PERIOD=4 \
    --network host \
    ghcr.io/open-digital-twin/ktwin-battery-device-publishers:0.1
```
